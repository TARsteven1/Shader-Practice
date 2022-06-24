// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "TAR/First Shader"//路径/名字，名字可以与文件名不一样
{
    Properties//属性
    {
        _Color ("Color", Color) = (1,1,1,1)
        _Vector("Vector",Vector)=(2,3,1,1)
        _Int("Int",Int)=123
        _Float("Float",Float)=1.2
        _MainTex ("Albedo (RGB)", 2D) = "white" {}//2D纹理，默认白色
        _Glossiness ("Smoothness", Range(0,1)) = 0.5//数字范围
        _Cube("Cube",Cube)= "white" {}//立方体纹理
        _MainTex2 ("Albedo (RGB3D)", 3D) = "black" {}//3D的纹理，默认黑色
        //_Metallic ("Metallic", Range(0,1)) = 0.0
    }
    SubShader//子着色器， 可以有很多个；显卡按照自身能力依次运行
    {
        //至少有一个pass，相当于方法
        Pass{
            //标记开头，使用的是CG语言
        CGPROGRAM
        //顶点函数:完成顶点坐标从模型空间到建材空间的转换（从游戏环境到视野相机的屏幕上）
        #pragma vertex vert
           //片元函数：返回模型对应的屏幕上每个像素的颜色值
        #pragma fragment frag
        //定义结构体用来传参
                struct a2f{
        float4 vertex:POSITION;//告诉unity把模型空间下的顶点坐标填充给vertex
        float3 normal:NORMAL;//告诉unity把模型空间下的法线方向(向量)填充给normal
        float4 texcoord:TEXCOORD0;//告诉unity把把第一套纹理坐标填充给texcoord
        };
        struct v2f{
        float4 position:POSITION;
        float3 temp:COLOR0;//COLOR0自定义语义,一般按用于存储颜色等f4
        };

        //float4 vert (float4 v:POSITION) : SV_POSITION{//通过语义告诉系统参数的作用；POSITION代表需要顶点坐标作为函数的传入参数v；SV_POSITION代表函数返回值是裁剪空间下的顶点坐标
        //return UnityObjectToClipPos(v);
        //}
        v2f vert(a2f v){
            v2f f;
            f.position=UnityObjectToClipPos(v.vertex);
            f.temp=v.normal;
            return f;
        }

        // fixed4 frag () : SV_Target{
        //return fixed4(0.5,1,1,1);
       // }       
         fixed4 frag (v2f f) : SV_Target{
        return fixed4(f.temp,1);
        }

        //   #pragma surface surf Standard fullforwardshadows

        //// Use shader model 3.0 target, to get nicer looking lighting
        //#pragma target 3.0

        ////属性中定义好的字段，如需在此使用需要重新生命
        //sampler2D _MainTex;
        //sampler3D _MainTex2;
        //samplerCube _Cube;

        //struct Input
        //{
        //    float2 uv_MainTex;
        //};

        //half _Glossiness;//half代替float fixed
        //half _Metallic;
        //fixed4 _Color;

        //// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        //// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        //// #pragma instancing_options assumeuniformscaling
        //UNITY_INSTANCING_BUFFER_START(Props)
        //    // put more per-instance properties here
        //UNITY_INSTANCING_BUFFER_END(Props)

        //void surf (Input IN, inout SurfaceOutputStandard o)
        //{
        //    // Albedo comes from a texture tinted by color
        //    fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
        //    o.Albedo = c.rgb;
        //    // Metallic and smoothness come from slider variables
        //    o.Metallic = _Metallic;
        //    o.Smoothness = _Glossiness;
        //    o.Alpha = c.a;
        //}
       //标记结束，使用的是CG语言
        ENDCG
       }
    }
    FallBack "Diffuse"//子着色器都不能适配后的备用方案
}
