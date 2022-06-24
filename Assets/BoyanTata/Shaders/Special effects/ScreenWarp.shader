Shader "Unlit/ScreenWarp"
{
    Properties
    {
       _MainTex ("RGB：颜色 A：透贴", 2d) = "gray"{}
       _Opacity ("不透明度", range(0, 1)) = 0.5
       _WarpMidVal ("扭曲中值", range(0, 1)) = 0.5
       _WarpInt ("扭曲强度", range(0, 3)) = 0.2
    }
    SubShader
    {
        Tags { "Queue"="Transparent"// 调整渲染顺序
                "RenderType"="Transparent"// 对应改为Cutout
                "ForceNoShadowCasting"="True"// 关闭阴影投射
                "IgnoreProjector"="True"// 不响应投射器
}
        LOD 100
        //生成背景纹理
        GrabPass{
            "_BGTex"
        }
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
                float4 grabPos : TEXCOORD1;//背景采样纹理坐标
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            sampler2D _MainTex;
            //拿到背景纹理
            sampler2D _BGTex;
            //float4 _MainTex_ST;
            uniform half _Opacity;
            uniform half _WarpMidVal;
            uniform half _WarpInt;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                UNITY_TRANSFER_FOG(o,o.vertex);
                o.grabPos=ComputeGrabScreenPos(o.vertex);//背景纹理采样坐标
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_MainTex, i.uv);
                //用主贴图的蓝通道,扰动背景纹理采样坐标
                 i.grabPos.xy+=(col.b-_WarpMidVal)*_WarpInt * _Opacity ;
                //用扰动后的纹理坐标采样背景纹理
                fixed3 var_BGTex = tex2Dproj(_BGTex, i.grabPos);
                half opacity = col.a * _Opacity;
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                fixed3 finalRGB = col.rgb*var_BGTex;
                return fixed4(finalRGB * opacity, opacity);

            }
            ENDCG
        }
    }
}
