Shader "Unlit/ScreenUV"
{
    Properties
    {
       _MainTex ("RGB：颜色 A：透贴", 2d) = "gray"{}
       _ScreenTex ("屏幕纹理", 2d) = "gray"{}
       _Opacity ("透明度", range(0, 1)) = 0.5
    }
    SubShader
    {
        Tags { "Queue"="Transparent"// 调整渲染顺序
                "RenderType"="Transparent"// 对应改为Cutout
                "ForceNoShadowCasting"="True"// 关闭阴影投射
                "IgnoreProjector"="True"// 不响应投射器
}
        LOD 100

        Pass
        {
            Blend One OneMinusSrcAlpha // 修改混合方式One/SrcAlpha OneMinusSrcAlpha


            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float2 screenUV : TEXCOORD1;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            sampler2D _ScreenTex;
            float4 _ScreenTex_ST;
            uniform half _Opacity;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv =v.uv;
                UNITY_TRANSFER_FOG(o,o.vertex);
                float3 posVS=UnityObjectToViewPos(v.vertex).xyz;
                o.screenUV=posVS.xy/posVS.z;
                float originDist=UnityObjectToViewPos(float3(0.0,0.0,0.0)).z;
                 o.screenUV *= originDist;
                 o.screenUV = TRANSFORM_TEX(o.screenUV, _ScreenTex);       // UV信息 支持TilingOffset
                 o.screenUV = o.screenUV* _ScreenTex_ST.xy+frac(_Time.x*_ScreenTex_ST.zw);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                fixed4 var_ScreenTex = tex2D(_ScreenTex, i.screenUV);
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                fixed3 finalRGB = col.rgb;
                half opacity = col.a * _Opacity*var_ScreenTex;
                return fixed4(finalRGB * opacity, opacity);

            }
            ENDCG
        }
    }
}
