﻿Shader "Unlit/Scaling"
{
    Properties
    {
       _MainTex ("RGB：颜色 A：透贴", 2d) = "gray"{}
       _Opacity ("透明度", range(0, 1)) = 0.5
       _ScaleRange("缩放范围", range(0.0, 1.0)) = 0.5
       _ScaleSpeed("缩放速度", range(0.0, 3.0)) = 1.0
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
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            uniform half _Opacity;
            uniform float _ScaleRange;
            uniform float _ScaleSpeed;
            // 声明常量
            #define TWO_PI 6.283185
            // 顶点动画方法
            void  Scaling (inout float3 vertex) {
            /*1.  计算缩放比例，并乘到对应坐标轴，以实现缩放效果。*/
                vertex *=1.0+ _ScaleRange * sin(frac(_Time.z * _ScaleSpeed) * TWO_PI);
            }
            // 输入结构>>>顶点Shader>>>输出结构
            v2f vert (appdata v)
            {
                v2f o;
                 Scaling(v.vertex.xyz);
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                half opacity = col.a * _Opacity;
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                fixed3 finalRGB = col.rgb;
                return fixed4(finalRGB * opacity, opacity);

            }
            ENDCG
        }
    }
}
