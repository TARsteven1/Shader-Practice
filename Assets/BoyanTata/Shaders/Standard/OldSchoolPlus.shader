// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:0,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:0,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32719,y:32712,varname:node_3138,prsc:2|emission-3424-OUT;n:type:ShaderForge.SFN_Vector3,id:3424,x:32413,y:32817,varname:node_3424,prsc:2,v1:0,v2:0,v3:0;pass:END;sub:END;*/

Shader "Shader Forge/OldSchoolPlus" {
    Properties {
        [Header(Texture)]
        _CubeMap("CubeMap",Cube)="_Skybox"{}
        _NormalMap("NormalMap",2D)="bump"{}
        _Occlusion("换进遮挡图",2D)="white"{}
        _EmitTex("环境贴图",2D)="black"{}
        _SpecTex("高光颜色",2D)="gray"{}
        [Header(Diffuse)]
        _BaseCol("基础色",color)=(0.5,0.5,0.5,1)
        _EnvVal ("环境镜面反射强度", Range(0, 1)) = 0.11
        _EnvUpCol("向上环境色",color)=(1,1,1,1)
        _EnvSideCol("侧面环境色",color)=(0.4,0.4,0.4,1)
        _EnvDownCol("向下环境色",color)=(0,0,0,0)
        [Header(Specular)]
        _SpecPow ("高光次幂", Range(0, 90)) = 30
        _FresnelPow ("菲尼尔次幂", Range(0, 5)) = 1
        _EnvSpecInt ("环境镜面反射强度", Range(0, 5)) = 0.2
        _CubeMapMid ("环境球Mid", Range(0, 7)) = 0

        _LightCol("环境光颜色",color)=(1,1,1,1)
        [Header(Emission)]
        _EmitInt("自发光强度",Range(1, 10)) = 1
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0

            uniform sampler2D  _Occlusion ;
            uniform sampler2D  _NormalMap ;
            uniform sampler2D  _EmitTex ;
            uniform samplerCUBE  _CubeMap ;
            uniform sampler2D _SpecTex;

            uniform float3  _BaseCol   ;
            uniform float  _SpecPow   ;
            uniform float  _EnvVal   ;
            uniform float  _EmitInt   ;
            uniform float3  _EnvUpCol   ;
            uniform float3  _EnvSideCol ;
            uniform float3  _EnvDownCol ;

            uniform float3  _LightCol ;

            uniform float  _CubeMapMid   ;
            uniform float  _FresnelPow   ;
            uniform float  _EnvSpecInt   ;

            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv0 : TEXCOORD3;// 将模型UV信息输入进来 0通道 共4通道
                float4 tangent : TANGENT;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float3 normalDir_WorldSpace : TEXCOORD0;
                float3 light:TEXCOORD1;
                float4 posWorld : TEXCOORD2;
                float3 bDirWS:TEXCOORD3;
                //float3 nDirWS:TEXCOORD4;
                float3 tDirWS:TEXCOORD4;

                float2 uv : TEXCOORD5;// 追加UV信息用语像素Shader采样贴图

                LIGHTING_COORDS(6,7)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.normalDir_WorldSpace=UnityObjectToWorldNormal(v.normal);//法线方向 OS>>WS
                o.light= UnityObjectToWorldNormal(v.vertex);
                o.uv=v.uv0;// 传递UV信息
                TRANSFER_VERTEX_TO_FRAGMENT(o)

                o.tDirWS=normalize(mul(unity_ObjectToWorld,float4(v.tangent.xyz,0.0)).xyz);//切线方向 OS>>WS
                o.bDirWS=normalize(cross(o.normalDir_WorldSpace,o.tDirWS)*v.tangent.w);//根据nDirWS,tDirWS求bDirWS
                
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                 //准备向量
                fixed3 nDirTS=UnpackNormal(tex2D(_NormalMap,i.uv)).rgb;
                float3x3 TBN=float3x3(i.tDirWS,i.bDirWS,i.normalDir_WorldSpace);
                float3 nDirWS= normalize(mul(nDirTS,TBN));//计算Fresnel 计算vrDirWS
               // float3 vDirWS=normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);//计算Fresnel
                float3 viewDir = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 vrDirWS=reflect(-viewDir,nDirWS);

                fixed3 normalDir=normalize( i.normalDir_WorldSpace);
                fixed3 lightDir=normalize(WorldSpaceLightDir(fixed4( i.light,0)).xyz);

                float3 lambert=max(0,dot(i.normalDir_WorldSpace,normalize(_WorldSpaceLightPos0.xyz)))*_BaseCol;
                float phong=pow(max(0,dot(reflect(-lightDir,normalDir),viewDir)),_SpecPow);

                //计算阴影
                float attenuation = LIGHT_ATTENUATION(i);
                float3 shadow=(lambert+phong)*_LightCol*attenuation;

                                // 计算各部位遮罩
                float upMask=max(0.0,normalDir.g);// 获取朝上部分遮罩
                float downMask=max(0.0,-normalDir.g);// 获取朝下部分遮罩
                float sideMask=1.0-upMask-downMask;// 获取侧面部分遮罩
                // 混合环境色
                float3 envCol=_EnvUpCol*upMask + _EnvSideCol*sideMask + _EnvDownCol*downMask;
                // 采样Occlusion贴图(采样OA纹理)
                float occlusion=tex2D(_Occlusion,i.uv).a;
                //采样环境贴图纹理
                float var_EmitTex=tex2D(_EmitTex,i.uv);

                float var_SpecTex=tex2D(_SpecTex,i.uv).a;

                float3 var_Cubemap=texCUBElod(_CubeMap,float4(vrDirWS,_CubeMapMid)).rgb;

                float fresnel = pow(max(0.0,1.0-dot(viewDir,nDirWS)),_FresnelPow);
                float3 cubemapCol =var_Cubemap*fresnel*_EnvSpecInt*var_SpecTex;
                // 计算环境光照
                float3 envLight=(envCol*_EnvVal*_BaseCol+cubemapCol)*occlusion;
                //环境模型(自发光部分)
                float3 emission=_EmitInt*var_EmitTex;

                float3 finalColor =shadow+ envLight+emission;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
