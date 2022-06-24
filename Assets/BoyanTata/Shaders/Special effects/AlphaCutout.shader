Shader "Unlit/AlphaCutout"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Cutout("透明阈值",range(0,1))=0
    }
    SubShader
    {
        Tags { "RenderType"="TransparentCutout"// 对应改为Cutout
        "ForceNoShadowCasting"="True"// 关闭阴影投射
        "IgnoreProjector"="True"// 不响应投射器
    }
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"
            uniform sampler2D _MainTex;
            uniform float4 _MainTex_ST;
            uniform half _Cutout;

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 val_MainTex = tex2D(_MainTex, i.uv);
                clip(val_MainTex.a-_Cutout);
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                return val_MainTex;
            }
            ENDCG
        }
    }
}
