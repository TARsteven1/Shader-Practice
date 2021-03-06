// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'


Shader "TAR/Rock"
{
        Properties//属性
    {
        //_DiffuseColor ("Diffuse Color", Color) = (1,1,1,1)
        _Tex("Tex",2D)="white"{}
         _Color ("Color", Color) = (1,1,1,1)

    }
    SubShader
    {
        Tags { "lightMode"="ForwardBase" }
        Pass{
        CGPROGRAM
       #include "Lighting.cginc"//取得第一个直射光的颜色_LightColor0  第一个直射光的位置_worldSpaceLightPos0
                //顶点函数:完成顶点坐标从模型空间到建材空间的转换（从游戏环境到视野相机的屏幕上）
        #pragma vertex vert
           //片元函数：返回模型对应的屏幕上每个像素的颜色值
        #pragma fragment frag
        //声明shader分支
        #pragma shader_feature __ _branch1 _branch2
        //#pragma shader_feature _branch1 _branch2

        uniform fixed4 _DiffuseColor;
        fixed4 _Color;
        sampler2D _Tex;
                float4 _Tex_ST;//图片的偏移值固定声明方式
        struct a2f{
        float4 vertex:POSITION;//告诉unity把模型空间下的顶点坐标填充给vertex
        float3 normal:NORMAL;//告诉unity把模型空间下的法线方向(向量)填充给normal
        float4 texcoord:TEXCOORD0;//告诉unity把把第一套纹理坐标填充给texcoord
        };
        struct v2f{
        float4 position:POSITION;
        float3 temp:COLOR0;//COLOR0自定义语义,一般按用于存储颜色等f4
        float3 view:COLOR1;
                float2 UV:TEXCOORD1;
        };
         v2f vert(a2f v){
            v2f f;
            f.position=UnityObjectToClipPos(v.vertex);
            //f.temp=v.normal;
            f.temp= mul(v.normal,(float3x3) unity_WorldToObject);
            f.view= mul(v.vertex,unity_WorldToObject).xyz;
             f.UV=v.texcoord.xy*_Tex_ST.xy+_Tex_ST.zw;//启用Tiling和Offset
            return f;
        }
      
         fixed4 frag (v2f f) : SV_Target{
              fixed3 ambient=UNITY_LIGHTMODEL_AMBIENT.rgb;
            fixed3 normalDir=normalize(f.temp);
            fixed3 lightDir=normalize(_WorldSpaceLightPos0.xyz);//对于每个顶点来说,管的位置就是就是方向,因为光是平行光
            // fixed3 texcolor=tex2D(_Tex,f.UV.xy)*_Color.rgb;
                 //_Color=fixed4(1,1,1,0);       

            #if defined (_branch1)
            _Color=fixed4(0,1,0,0);            
            #elif defined (_branch2)
            _Color=fixed4(1,0,0,0);
            //#elif defined (__)
            // _Color=fixed4(1,1,1,0);
            #endif
             

             fixed3 texcolor=tex2D(_Tex,f.UV.xy)*_DiffuseColor.rgb*_Color.rgb;
            fixed3 diffuse= _LightColor0.rgb*texcolor * max(dot(normalDir,lightDir),0);



            fixed3 TempColor=diffuse+ambient*texcolor .rgb;



        return fixed4(TempColor.rgb,1);
        }
   
        ENDCG
        }
    }
    FallBack "Diffuse"
}
