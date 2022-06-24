// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:0,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:0,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32719,y:32712,varname:node_3138,prsc:2|emission-3424-OUT;n:type:ShaderForge.SFN_Vector3,id:3424,x:32413,y:32817,varname:node_3424,prsc:2,v1:0,v2:0,v3:0;pass:END;sub:END;*/

Shader "Shader Forge/Cubemap" {
    Properties {

        _CubeMapMid ("CubeMapMid", Range(0, 7)) = 0
        _FresnelPow ("FresnelPow", Range(0, 5)) = 1
        _CubeMap("CubeMap",Cube)="_Skybox"{}
        _NormalMap("NormalMap",2D)="bump"{}
        _EnvSpecInt ("EnvSpecInt", Range(0, 5)) = 0.2
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

            uniform float  _CubeMapMid   ;
            uniform float  _FresnelPow   ;
            uniform float  _EnvSpecInt   ;

            uniform sampler2D  _NormalMap ;
            uniform samplerCUBE  _CubeMap ;

            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv0 : TEXCOORD3;// 将模型UV信息输入进来 0通道 共4通道
                float4 tangent : TANGENT;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD1;
                float3 bDirWS:TEXCOORD0;
                float3 nDirWS:TEXCOORD2;
                float3 tDirWS:TEXCOORD3;
                float2 uv : TEXCOORD4;// 追加UV信息用语像素Shader采样贴图

            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);//顶点位置 OS>>WS
                o.nDirWS=UnityObjectToWorldNormal(v.normal);//法线方向 OS>>WS
                o.tDirWS=normalize(mul(unity_ObjectToWorld,float4(v.tangent.xyz,0.0)).xyz);//切线方向 OS>>WS
                o.bDirWS=normalize(cross(o.nDirWS,o.tDirWS)*v.tangent.w);//根据nDirWS,tDirWS求bDirWS
                o.uv=v.uv0;// 传递UV信息

                return o;
            }
            float4 frag(VertexOutput i) : COLOR {

                //准备向量
                fixed3 nDirTS=UnpackNormal(tex2D(_NormalMap,i.uv)).rgb;
                float3x3 TBN=float3x3(i.tDirWS,i.bDirWS,i.nDirWS);
                float3 nDirWS= normalize(mul(nDirTS,TBN));//计算Fresnel 计算vrDirWS
                float3 vDirWS=normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);//计算Fresnel
                float3 vrDirWS=reflect(-vDirWS,nDirWS);

                //光照模型
                float3 var_Cubemap=texCUBElod(_CubeMap,float4(vrDirWS,_CubeMapMid)).rgb;
                float fresnel = pow(max(0.0,1.0-dot(vDirWS,nDirWS)),_FresnelPow);
                float3 finalColor =var_Cubemap*fresnel*_EnvSpecInt;

                return fixed4(finalColor,1.0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
