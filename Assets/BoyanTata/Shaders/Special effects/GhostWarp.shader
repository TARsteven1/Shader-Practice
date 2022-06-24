Shader "Unlit/GhostWarp"
{
    Properties
    {
        _MainTex ("RGB：颜色 A：透贴", 2d) = "gray"{}
        _Opacity ("透明度", range(0, 1)) = 0.5
        _WarpTex ("扭曲图", 2d) = "gray"{}
        _WarpInt ("扭曲强度", range(0, 1)) = 0.5
        _NoiseInt ("噪声强度", range(0, 5)) = 0.5
        _FlowSpeed ("流动速度", range(0, 10)) = 5
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
            Blend One OneMinusSrcAlpha// 修改混合方式
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"
            uniform sampler2D _MainTex;
            uniform half _Opacity;
            uniform sampler2D _WarpTex;uniform float4 _WarpTex_ST;
            uniform half _WarpInt;
            uniform half _NoiseInt;
            uniform half _FlowSpeed;
            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv0 : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
                float2 uv1 : TEXCOORD1;// UV 采样NoiseTex用
            };


            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv0 =v.uv;
                UNITY_TRANSFER_FOG(o,o.vertex);
                o.uv1 = TRANSFORM_TEX(v.uv, _WarpTex);// UV1支持TilingOffset
               // o.uv1.y = o.uv1.y + frac(-_Time.x * _FlowSpeed);// UV1 V轴流动
                o.uv1.x = o.uv1.x - frac(-_Time.x * _FlowSpeed);// UV1 V轴流动
                return o;
            }

            half4 frag (v2f i) : SV_Target
            {
                half3 var_WarpTex = tex2D(_WarpTex, i.uv1).rgb;// 噪声图
                float2 uvBias = (var_WarpTex - 0.5) * _WarpInt;// 计算UV偏移值
                float2 uv0 = i.uv0 + uvBias;// 应用UV偏移量
                half4 var_MainTex = tex2D(_MainTex, uv0);// 偏移后UV采样MainTex
                half3 finalRGB = var_MainTex.rgb;
                half noise = lerp(1.0, var_WarpTex.b * 2.0, _NoiseInt); // Remap噪声
                noise = max(0.0, noise);// 截去负值
                half opacity = var_MainTex.a * _Opacity * noise;
                return half4(finalRGB * opacity, opacity);// 返回值
            }
            ENDCG
        }
    }
}
