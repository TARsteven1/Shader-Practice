Shader "Unlit/Fire"
{
    Properties
    {
       _Mask ("R:外焰 G:内焰 B：透贴", 2d) = "blue"{}
       _Noise("R:噪声1 G:噪声2", 2d) = "gray"{}
       _Noise1Params("噪声1 x大小 y流速 z强度",vector)=(1.0,0.2,0.2,1.0)
       _Noise2Params("噪声2 x大小 y流速 z强度",vector)=(1.0,0.2,0.2,1.0)
       [HDR] _FireCol1("外焰色",color)=(0,0,0,0)
       [HDR] _FireCol2("内焰色",color)=(0,0,0,0)
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

            sampler2D _Mask;
            sampler2D _Noise;
            half3 _Noise1Params;
            uniform half3 _Noise2Params;
            uniform half3 _FireCol1;
            uniform half3 _FireCol2;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv0 =v.uv;
                o.uv1=v.uv*_Noise1Params.x-float2(0.0,frac(_Time.x * _Noise1Params.y));
                o.uv2=v.uv*_Noise2Params.x-float2(0.0,frac(_Time.x * _Noise2Params.y));
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // 扰动遮罩
                half warpMask = tex2D(_Mask, i.uv0).b;
                // 噪声1
                half var_Noise1 = tex2D(_Noise, i.uv1).r;
                // 噪声2
                half var_Noise2 = tex2D(_Noise, i.uv2).g;
                // 噪声混合
                half noise = var_Noise1*_Noise1Params.z + var_Noise2* _Noise2Params.z;
                //扰动UV
                float2 warpUV=i.uv0-float2(0.0,noise)* warpMask;
                //采样Mask
                fixed3 var_Mask =  tex2D(_Mask, warpUV);
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, _Mask);

                fixed3 finalRGB = _FireCol1*var_Mask.r+var_Mask.g*_FireCol2;
                //不透明度
                half opacity=var_Mask.r+var_Mask.g;

                return fixed4(finalRGB ,opacity);

            }
            ENDCG
        }
    }
}
