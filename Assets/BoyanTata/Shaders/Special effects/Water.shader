Shader "Unlit/Water"
{
    Properties
    {
        _MainTex        ("颜色贴图", 2d) = "white"{}
        _WarpTex        ("扰动图", 2d) = "gray"{}
        _Speed          ("X：流速X Y：流速Y", vector) = (1.0, 1.0, 0.5, 1.0)
        _Warp1Params    ("X：大小 Y：流速X Z：流速Y W：强度", vector) = (1.0, 1.0, 0.5, 1.0)
        _Warp2Params    ("X：大小 Y：流速X Z：流速Y W：强度", vector) = (2.0, 0.5, 0.5, 1.0)
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
                float2 uv0 : TEXCOORD0;
                float2 uv1 : TEXCOORD1;
                float2 uv2 : TEXCOORD2;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            // 输入参数
            uniform sampler2D _MainTex; uniform float4 _MainTex_ST;
            uniform sampler2D _WarpTex;
            uniform half2 _Speed;
            uniform half4 _Warp1Params;
            uniform half4 _Warp2Params;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv0 = v.uv - frac(_Time.x * _Speed);
                o.uv1 = v.uv * _Warp1Params.x - frac(_Time.x * _Warp1Params.yz);
                o.uv2 = v.uv * _Warp2Params.x - frac(_Time.x * _Warp2Params.yz);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            float4 frag (v2f i) : SV_Target
            {
                half3 var_Warp1 = tex2D(_WarpTex, i.uv1).rgb;      // 扰动1
                half3 var_Warp2 = tex2D(_WarpTex, i.uv2).rgb;      // 扰动2
                // 扰动混合
                half2 warp = (var_Warp1.xy - 0.5) * _Warp1Params.w +
                             (var_Warp2.xy - 0.5) * _Warp2Params.w;
                // 扰动UV
                float2 warpUV = i.uv0 + warp;
                // 采样MainTex
                half4 var_MainTex = tex2D(_MainTex, warpUV);

                return float4(var_MainTex.xyz, 1.0);

            }
            ENDCG
        }
    }
}
