Shader "Unlit/AnimGhost"
{
    Properties
    {
       _MainTex ("RGB：颜色 A：透贴", 2d) = "gray"{}
       _Opacity ("透明度", range(0, 1)) = 0.5
       _ScaleParams("天使圈缩放 X:强度 Y:速度 Z:校正", vector) = (0.2, 1.0, 4.5, 0.0)
        _SwingXParams("X轴扭动 X:强度 Y:速度 Z:波长", vector) = (1.0, 3.0, 1.0, 0.0)
        _SwingZParams("Z轴扭动 X:强度 Y:速度 Z:波长", vector) = (1.0, 3.0, 1.0, 0.0)
        _SwingYParams("Y轴起伏 X:强度 Y:速度 Z:滞后", vector) = (1.0, 3.0, 0.3, 0.0)
        _ShakeYParams("Y轴摇头 X:强度 Y:速度 Z:滞后", vector) = (20.0, 3.0, 0.3, 0.0)
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
                float4 color : COLOR;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
                float4 color : COLOR;
            };

            sampler2D _MainTex;
            float4 _MainTex_ST;
            uniform half _Opacity;
            uniform float4 _ScaleParams;
            uniform float3 _SwingXParams;
            uniform float3 _SwingZParams;
            uniform float3 _SwingYParams;
            uniform float3 _ShakeYParams;
            // 声明常量
            #define TWO_PI 6.283185
            // 顶点动画方法
            void AnimGhost (inout float3 vertex, inout float3 color) {
                // 缩放天使圈
                float scale = _ScaleParams.x * color.g * sin(frac(_Time.z * _ScaleParams.y) * TWO_PI);
                vertex.xyz *= 1.0 + scale;
                vertex.y -= _ScaleParams.z * scale;
                // 幽灵摆动
                float swingX = _SwingXParams.x * sin(frac(_Time.z * _SwingXParams.y + vertex.y * _SwingXParams.z) * TWO_PI);
                float swingZ = _SwingZParams.x * sin(frac(_Time.z * _SwingZParams.y + vertex.y * _SwingZParams.z) * TWO_PI);
                vertex.xz += float2(swingX, swingZ) * color.r;
                // 幽灵摇头
                float radY = radians(_ShakeYParams.x) * (1.0 - color.r)
                * sin(frac(_Time.z * _ShakeYParams.y - color.g * _ShakeYParams.z) * TWO_PI);
                float sinY, cosY = 0;
                sincos(radY, sinY, cosY);
                vertex.xz = float2(
                vertex.x * cosY - vertex.z * sinY,
                vertex.x * sinY + vertex.z * cosY
                );
                // 幽灵起伏
                float swingY = _SwingYParams.x * sin(frac(_Time.z * _SwingYParams.y - color.g * _SwingYParams.z) * TWO_PI);
                vertex.y += swingY;
                // 处理顶点色
                //float lightness = 1.0 + color.g * 1.0 + scale * 2.0;
                float lightness = 1.0 + color.g * 1.0 * scale * 2.0;
                color = float3(lightness, lightness, lightness);
                }
            /*
            1.天使圈：用顶点色遮罩缩放动画；校正放缩后的位置；
            2.摆动：用Y轴值偏移出正弦波摆动；用顶点色遮罩摆动；
            3.摇头：用顶点色遮罩头部实现摇头；用顶点色实现天使圈滞后；
            4.起伏：用顶点色实现天使圈滞后；
            5.顶点色：计算天使圈亮度值；*/

            // 输入结构>>>顶点Shader>>>输出结构
            v2f vert (appdata v)
            {
                v2f o;
                AnimGhost(v.vertex.xyz, v.color.rgb);
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                o.color = v.color;
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                half opacity = col.a * _Opacity;
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                fixed3 finalRGB = col.rgb * i.color.rgb;
                return fixed4(finalRGB * opacity, opacity);

            }
            ENDCG
        }
    }
}
