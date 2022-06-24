// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'


Shader "TAR/Rock (NormalMap)"
{
        Properties//属性
    {
        _DiffuseColor ("Diffuse Color", Color) = (1,1,1,1)
        _Tex("Tex",2D)="white"{}
                _Color ("Color", Color) = (1,1,1,1)
                _NormalMap("NormalMap",2D)="bump"{}//使用模型顶戴自带的法线
                _BumpScale("BumpScale",Float)=1

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
        fixed4 _Color;
        sampler2D _Tex;
        float4 _Tex_ST;//图片的偏移值固定声明方式        
        sampler2D _NormalMap;
        float4 _NormalMap_ST;//图片的偏移值固定声明方式
        float _BumpScale;

        struct a2f{
        float4 vertex:POSITION;//告诉unity把模型空间下的顶点坐标填充给vertex
        //切线空间的确定是通过(存储在模型中的)法线&切线确定的
        float3 normal:NORMAL;//告诉unity把模型空间下的法线方向(向量)填充给normal
        float4 tangent:TANGENT;//定义切线;tangent.w是用来确定切线空间中坐标轴的方向的
        float4 texcoord:TEXCOORD0;//告诉unity把把第一套纹理坐标填充给texcoord
        };
        struct v2f{
        float4 position:POSITION;
        //float3 temp:COLOR0;//COLOR0自定义语义,一般按用于存储颜色等f4
        float3 view:COLOR1;
        float3 lightDir:TEXCOORD0;//切线空间下 平行光的方向
        float4 UV:TEXCOORD1;//xy存储主贴图TeX的纹理坐标,zw存储法线贴图纹理坐标
        };
         v2f vert(a2f v){
            v2f f;
            f.position=UnityObjectToClipPos(v.vertex);
            //f.temp=v.normal;
           // f.temp= mul(v.normal,(float3x3) unity_WorldToObject);
            f.view= mul(v.vertex,unity_WorldToObject).xyz;
             f.UV.xy=v.texcoord.xy*_Tex_ST.xy+_Tex_ST.zw;//启用主贴图Tiling和Offset(放缩/平移)
             f.UV.zw=v.texcoord.xy*_NormalMap_ST.xy+_NormalMap_ST.zw;//启用法线贴图Tiling和Offset(放缩/平移)

             TANGENT_SPACE_ROTATION;//调用后得到rotation矩阵,可以把模型空间下的方向转化成切线空间下的
             f.lightDir=mul(rotation,ObjSpaceLightDir(v.vertex));
            return f;
        }
      //把所有跟法线方向有关的计算都放在切线空间下
      //从法线贴图中取得的法线方向是在切线空间下的
         fixed4 frag (v2f f) : SV_Target{
              fixed3 ambient=UNITY_LIGHTMODEL_AMBIENT.rgb;
           // fixed3 normalDir=normalize(f.temp);
           fixed4 normalColor=tex2D(_NormalMap,f.UV.zw);
           //fixed3 tangentNormal=normalColor.xyz * 2 - 1;//得到切线空间下的法线
           fixed3 tangentNormal=UnpackNormal(normalColor);
            tangentNormal.xy *=_BumpScale;//实现凹凸参数
            tangentNormal=normalize(tangentNormal);

            fixed3 lightDir=normalize(f.lightDir);//对于每个顶点来说,管的位置就是就是方向,因为光是平行光
             fixed3 texcolor=tex2D(_Tex,f.UV.xy)*_Color.rgb;

            fixed3 diffuse= _LightColor0.rgb*texcolor * max(dot(tangentNormal,lightDir),0);



            fixed3 TempColor=diffuse+ambient*texcolor .rgb;
        return fixed4(TempColor,1);
        }
   
        ENDCG
        }
    }
    FallBack "Diffuse"
}
