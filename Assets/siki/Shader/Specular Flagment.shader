// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'


Shader "TAR/Specular Flagment"
{
        Properties//属性
    {
        _DiffuseColor ("Diffuse Color", Color) = (1,1,1,1)
                _SpecularColor ("Specular Color", Color) = (1,1,1,1)
        _Gloss("Gloss",Range(8,200))=10
        _MainTex("Main Tex",2D)="white"{}
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

        fixed4 _DiffuseColor;
        fixed4 _SpecularColor;
        half _Gloss;
        sampler2D _MainTex;
        float4 _MainTex_ST;//图片的偏移值固定声明方式
                fixed4 _Color;
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
            //f.temp= mul(v.normal,(float3x3) unity_WorldToObject);//下一行使用cginc中的函数进行重构
            f.temp=UnityObjectToWorldNormal(v.normal);
           // f.view= mul(v.vertex,unity_WorldToObject);
            f.view= UnityObjectToWorldNormal(v.vertex);

            f.UV=v.texcoord.xy*_MainTex_ST.xy-_MainTex_ST.zw;//启用Tiling和Offset
            return f;
        }
      
         fixed4 frag (v2f f) : SV_Target{
              fixed3 ambient=UNITY_LIGHTMODEL_AMBIENT.rgb;
            fixed3 normalDir=normalize(f.temp);
           // fixed3 lightDir=normalize(_WorldSpaceLightPos0.xyz);//对于每个顶点来说,管的位置就是就是方向,因为光是平行光,下一行重构
          // float4 tempt=(f.view,0);
             fixed3 lightDir=normalize(WorldSpaceLightDir(fixed4(f.view,0)).xyz);
            fixed3 diffuse= _LightColor0.rgb * max(0,dot(normalDir,lightDir))*_DiffuseColor.rgb;
           // fixed3 reflectDir=normalize(reflect(-lightDir,normalDir));//弃用
            //fixed3 viewDir=normalize(_WorldSpaceCameraPos.xyz- f.view);//下一行重构
             fixed3 viewDir=normalize(fixed4(UnityWorldSpaceViewDir(f.view),0));
            fixed3 halfDir=normalize((viewDir+lightDir)/2);//求两条线的平分线
            fixed3 texcolor=tex2D(_MainTex,f.UV.xy)*_Color.rgb;
            //使用BP模型.光照反射面积更大,效果更明显,使用也更广泛
            //fixed3 specular=_LightColor0.rgb *_SpecularColor.rgb*pow(max(dot(normalDir,halfDir),0),_Gloss);
            fixed3 specular=_LightColor0.rgb *texcolor*pow(max(dot(normalDir,halfDir),0),_Gloss);

            fixed3 TempColor=diffuse+specular+ambient*texcolor .rgb;
            //fixed3 TempColor=specular;
        return fixed4(TempColor,1);
        }
   
        ENDCG
        }
    }
    FallBack "Diffuse"
}
