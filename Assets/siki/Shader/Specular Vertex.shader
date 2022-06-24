// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'


Shader "TAR/Specular Vertex"
{
        Properties//属性
    {
        _DiffuseColor ("Diffuse Color", Color) = (1,1,1,1)
        _SpecularColor ("Specular Color", Color) = (1,1,1,1)
        _Gloss("Gloss",Range(8,200))=10

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

        struct a2f{
        float4 vertex:POSITION;//告诉unity把模型空间下的顶点坐标填充给vertex
        float3 normal:NORMAL;//告诉unity把模型空间下的法线方向(向量)填充给normal
        //float4 texcoord:TEXCOORD0;//告诉unity把把第一套纹理坐标填充给texcoord
        };
        struct v2f{
        float4 position:POSITION;
        float3 temp:COLOR0;//COLOR0自定义语义,一般按用于存储颜色等f4
        };
         v2f vert(a2f v){
            v2f f;
            f.position=UnityObjectToClipPos(v.vertex);
            //f.temp=v.normal;
            fixed3 ambient=UNITY_LIGHTMODEL_AMBIENT.rgb;
            fixed3 normalDir=normalize(mul(v.normal,(float3x3) unity_WorldToObject));
            fixed3 lightDir=normalize(_WorldSpaceLightPos0.xyz);//对于每个顶点来说,管的位置就是就是方向,因为光是平行光
            fixed3 diffuse= _LightColor0.rgb * max(0,dot(normalDir,lightDir))*_DiffuseColor.rgb;


            fixed3 reflectDir=normalize(reflect(-lightDir,normalDir));
            fixed3 viewDir=normalize(_WorldSpaceCameraPos.xyz-mul(v.vertex,unity_WorldToObject).xyz);
            fixed3 specular=_LightColor0.rgb*_SpecularColor.rgb *pow(max(dot(reflectDir,viewDir),0),_Gloss);
            f.temp=diffuse+ambient+specular;
            return f;
        }
      
         fixed4 frag (v2f f) : SV_Target{
        return fixed4(f.temp,1);
        }
   
        ENDCG
        }
    }
    FallBack "Diffuse"
}
