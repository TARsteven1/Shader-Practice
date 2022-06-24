// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33802,y:32756,varname:node_3138,prsc:2|emission-6854-OUT;n:type:ShaderForge.SFN_ViewVector,id:9375,x:32384,y:32762,varname:node_9375,prsc:2;n:type:ShaderForge.SFN_Vector1,id:7958,x:32384,y:32932,varname:node_7958,prsc:2,v1:-1;n:type:ShaderForge.SFN_Multiply,id:6621,x:32587,y:32809,varname:node_6621,prsc:2|A-9375-OUT,B-7958-OUT;n:type:ShaderForge.SFN_Reflect,id:2917,x:32916,y:32842,varname:node_2917,prsc:2|A-6621-OUT,B-7231-XYZ;n:type:ShaderForge.SFN_Transform,id:7231,x:32524,y:33020,varname:node_7231,prsc:2,tffrom:2,tfto:0|IN-6485-RGB;n:type:ShaderForge.SFN_Tex2d,id:6485,x:32312,y:33020,ptovrint:False,ptlb:NormalMap,ptin:_NormalMap,varname:node_6485,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Slider,id:493,x:32765,y:33039,ptovrint:False,ptlb:CubeMapMip,ptin:_CubeMapMip,varname:node_493,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:7;n:type:ShaderForge.SFN_Slider,id:3976,x:32765,y:33252,ptovrint:False,ptlb:FresnelPow,ptin:_FresnelPow,varname:_node_493_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:10;n:type:ShaderForge.SFN_Slider,id:2182,x:33026,y:33425,ptovrint:False,ptlb:EnvSpecInt,ptin:_EnvSpecInt,varname:_node_493_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.2,max:5;n:type:ShaderForge.SFN_Cubemap,id:1356,x:33111,y:32951,ptovrint:False,ptlb:CubeMap,ptin:_CubeMap,varname:node_1356,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,pvfc:0|DIR-2917-OUT,MIP-493-OUT;n:type:ShaderForge.SFN_Fresnel,id:3797,x:33111,y:33191,varname:node_3797,prsc:2|NRM-7231-XYZ,EXP-3976-OUT;n:type:ShaderForge.SFN_Multiply,id:1666,x:33394,y:33066,varname:node_1666,prsc:2|A-1356-RGB,B-3797-OUT;n:type:ShaderForge.SFN_Multiply,id:6854,x:33585,y:33157,varname:node_6854,prsc:2|A-1666-OUT,B-2182-OUT;proporder:6485-493-3976-2182-1356;pass:END;sub:END;*/

Shader "Shader Forge/Cubemap_SF" {
    Properties {
        _NormalMap ("NormalMap", 2D) = "bump" {}
        _CubeMapMip ("CubeMapMip", Range(0, 7)) = 0
        _FresnelPow ("FresnelPow", Range(0, 10)) = 1
        _EnvSpecInt ("EnvSpecInt", Range(0, 5)) = 0.2
        _CubeMap ("CubeMap", Cube) = "_Skybox" {}
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
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform sampler2D _NormalMap; uniform float4 _NormalMap_ST;
            uniform samplerCUBE _CubeMap;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _CubeMapMip)
                UNITY_DEFINE_INSTANCED_PROP( float, _FresnelPow)
                UNITY_DEFINE_INSTANCED_PROP( float, _EnvSpecInt)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float4 tangent : TANGENT;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float2 uv0 : TEXCOORD0;
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                float3 tangentDir : TEXCOORD3;
                float3 bitangentDir : TEXCOORD4;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.tangentDir = normalize( mul( unity_ObjectToWorld, float4( v.tangent.xyz, 0.0 ) ).xyz );
                o.bitangentDir = normalize(cross(o.normalDir, o.tangentDir) * v.tangent.w);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
////// Lighting:
////// Emissive:
                float3 _NormalMap_var = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(i.uv0, _NormalMap)));
                float3 node_7231 = mul( _NormalMap_var.rgb, tangentTransform ).xyz;
                float _CubeMapMip_var = UNITY_ACCESS_INSTANCED_PROP( Props, _CubeMapMip );
                float _FresnelPow_var = UNITY_ACCESS_INSTANCED_PROP( Props, _FresnelPow );
                float _EnvSpecInt_var = UNITY_ACCESS_INSTANCED_PROP( Props, _EnvSpecInt );
                float3 emissive = ((texCUBElod(_CubeMap,float4(reflect((viewDirection*(-1.0)),node_7231.rgb),_CubeMapMip_var)).rgb*pow(1.0-max(0,dot(node_7231.rgb, viewDirection)),_FresnelPow_var))*_EnvSpecInt_var);
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
