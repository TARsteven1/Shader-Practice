Shader "Unlit/Sequence"
{
    Properties
    {
       _MainTex ("RGB：颜色 A：透贴", 2d) = "gray"{}
       _Sequence ("序列帧", 2d) = "gray"{}
       _Opacity ("透明度", range(0, 1)) = 0.5
       _RowCount("行数",int)=1
       _ColCount("列数",int)=1
      // _SequId("列数",int)=1
       _Sped("播放速度",range(-10, 10))=1


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
            uniform half _Opacity;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
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
         Pass
        {
            Blend One One // 修改混合方式
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float3 normal:NORMAL;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

           // sampler2D _MainTex;
           // float4 _MainTex_ST;
            //uniform half _Opacity;
            sampler2D _Sequence;
            float4 _Sequence_ST;
            uniform half _RowCount;
            uniform half _ColCount;
            uniform half _Sped;

            v2f vert (appdata v)
            {
                v2f o;
                v.vertex.xyz+=v.normal*0.01;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _Sequence);
                UNITY_TRANSFER_FOG(o,o.vertex);
                //跑马灯逻辑
                float id = floor(frac(_Time.z * _Sped) * _RowCount * _ColCount);
               // float id = floor(_Time.z*_Sped);
                float idv=floor(id/_ColCount);
                float idu=id-idv*_ColCount;
                float stepU=1.0/_ColCount;
                float stepV=1.0/_RowCount;
                float2 initUV=o.uv*float2(stepU,stepV)+float2(0.0,stepV * (_RowCount-1));
                o.uv=initUV+float2(idu*stepU,-idv*stepV);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 col = tex2D(_Sequence, i.uv);
                // apply fog
                UNITY_APPLY_FOG(i.fogCoord, col);
                half3 finalRGB = col.rgb;
                half opacity = col.a ;
                return fixed4(finalRGB * opacity, opacity);
            }
            ENDCG
            }
    }
}
