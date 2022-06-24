// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:0,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:0,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:36410,y:33785,varname:node_3138,prsc:2|emission-1069-OUT;n:type:ShaderForge.SFN_LightVector,id:9148,x:31903,y:32880,varname:node_9148,prsc:2;n:type:ShaderForge.SFN_NormalVector,id:213,x:31903,y:32699,prsc:2,pt:False;n:type:ShaderForge.SFN_Dot,id:8805,x:32210,y:32768,varname:node_8805,prsc:2,dt:0|A-213-OUT,B-9148-OUT;n:type:ShaderForge.SFN_Vector1,id:5773,x:32245,y:33057,varname:node_5773,prsc:2,v1:0;n:type:ShaderForge.SFN_Max,id:672,x:32432,y:32808,varname:node_672,prsc:2|A-8805-OUT,B-5773-OUT;n:type:ShaderForge.SFN_Color,id:6266,x:32880,y:32995,ptovrint:False,ptlb:BaseCol,ptin:_BaseCol,varname:node_6266,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_Multiply,id:6152,x:33062,y:32809,varname:node_6152,prsc:2|A-6266-RGB,B-672-OUT;n:type:ShaderForge.SFN_Add,id:3250,x:33280,y:33084,varname:node_3250,prsc:2|A-6152-OUT,B-6069-OUT;n:type:ShaderForge.SFN_Multiply,id:2719,x:32145,y:33150,varname:node_2719,prsc:2|A-9148-OUT,B-6206-OUT;n:type:ShaderForge.SFN_Vector1,id:6206,x:31876,y:33184,varname:node_6206,prsc:2,v1:-1;n:type:ShaderForge.SFN_Reflect,id:8106,x:32386,y:33166,varname:node_8106,prsc:2|A-2719-OUT,B-213-OUT;n:type:ShaderForge.SFN_ViewVector,id:7084,x:32328,y:33334,varname:node_7084,prsc:2;n:type:ShaderForge.SFN_Dot,id:4097,x:32637,y:33252,varname:node_4097,prsc:2,dt:0|A-8106-OUT,B-7084-OUT;n:type:ShaderForge.SFN_Max,id:7296,x:32815,y:33216,varname:node_7296,prsc:2|A-5773-OUT,B-4097-OUT;n:type:ShaderForge.SFN_Slider,id:9661,x:32480,y:33508,ptovrint:False,ptlb:SpecPow,ptin:_SpecPow,varname:node_9661,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:30,max:90;n:type:ShaderForge.SFN_Power,id:6069,x:33014,y:33324,varname:node_6069,prsc:2|VAL-7296-OUT,EXP-9661-OUT;n:type:ShaderForge.SFN_Multiply,id:1908,x:33532,y:33057,varname:node_1908,prsc:2|A-1724-RGB,B-3250-OUT;n:type:ShaderForge.SFN_Color,id:1724,x:33425,y:33369,ptovrint:False,ptlb:LightCol,ptin:_LightCol,varname:_BaseCol_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Multiply,id:4467,x:33744,y:33002,varname:node_4467,prsc:2|A-2325-OUT,B-1908-OUT;n:type:ShaderForge.SFN_LightAttenuation,id:2325,x:33587,y:32845,varname:node_2325,prsc:2;n:type:ShaderForge.SFN_Add,id:8913,x:35042,y:33844,varname:node_8913,prsc:2|A-4467-OUT,B-9552-OUT;n:type:ShaderForge.SFN_ComponentMask,id:8335,x:32344,y:33588,varname:node_8335,prsc:2,cc1:1,cc2:-1,cc3:-1,cc4:-1|IN-213-OUT;n:type:ShaderForge.SFN_Max,id:7664,x:32652,y:33730,varname:node_7664,prsc:2|A-8335-OUT,B-5773-OUT;n:type:ShaderForge.SFN_Subtract,id:1623,x:32903,y:33756,varname:node_1623,prsc:2|A-8479-OUT,B-7664-OUT;n:type:ShaderForge.SFN_Vector1,id:8479,x:32513,y:33920,varname:node_8479,prsc:2,v1:1;n:type:ShaderForge.SFN_Multiply,id:7948,x:32459,y:34041,varname:node_7948,prsc:2|A-8335-OUT,B-6206-OUT;n:type:ShaderForge.SFN_Max,id:2492,x:32732,y:34037,varname:node_2492,prsc:2|A-7948-OUT,B-5773-OUT;n:type:ShaderForge.SFN_Subtract,id:5435,x:33149,y:34008,varname:node_5435,prsc:2|A-1623-OUT,B-2492-OUT;n:type:ShaderForge.SFN_Color,id:3779,x:33160,y:33464,ptovrint:False,ptlb:EnvUpCol,ptin:_EnvUpCol,varname:_LightCol_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Color,id:7286,x:33160,y:33622,ptovrint:False,ptlb:EnvSideCol,ptin:_EnvSideCol,varname:_LightCol_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.4,c2:0.4,c3:0.4,c4:1;n:type:ShaderForge.SFN_Color,id:9432,x:33160,y:33790,ptovrint:False,ptlb:EnvDownCol,ptin:_EnvDownCol,varname:_LightCol_copy_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:0,c3:0,c4:1;n:type:ShaderForge.SFN_Multiply,id:8043,x:33459,y:33794,varname:node_8043,prsc:2|A-3779-RGB,B-7664-OUT;n:type:ShaderForge.SFN_Multiply,id:4363,x:33459,y:33982,varname:node_4363,prsc:2|A-7286-RGB,B-5435-OUT;n:type:ShaderForge.SFN_Multiply,id:3366,x:33459,y:34149,varname:node_3366,prsc:2|A-9432-RGB,B-2492-OUT;n:type:ShaderForge.SFN_Add,id:333,x:33752,y:33935,varname:node_333,prsc:2|A-8043-OUT,B-3366-OUT;n:type:ShaderForge.SFN_Add,id:3710,x:33936,y:34141,varname:node_3710,prsc:2|A-333-OUT,B-4363-OUT;n:type:ShaderForge.SFN_Multiply,id:1819,x:34093,y:34248,varname:node_1819,prsc:2|A-3710-OUT,B-6465-OUT;n:type:ShaderForge.SFN_Multiply,id:3509,x:34296,y:34183,varname:node_3509,prsc:2|A-1819-OUT,B-6266-RGB;n:type:ShaderForge.SFN_Multiply,id:9552,x:34570,y:34001,varname:node_9552,prsc:2|A-2047-RGB,B-3509-OUT;n:type:ShaderForge.SFN_Tex2d,id:2047,x:34097,y:33884,ptovrint:False,ptlb:Occlusion,ptin:_Occlusion,varname:node_2047,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Slider,id:6465,x:33532,y:34429,ptovrint:False,ptlb:EnvVal,ptin:_EnvVal,varname:node_6465,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.11,max:1;n:type:ShaderForge.SFN_Tex2d,id:1115,x:34508,y:34494,ptovrint:False,ptlb:NormalMap,ptin:_NormalMap,varname:node_1115,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Transform,id:9735,x:34757,y:34494,varname:node_9735,prsc:2,tffrom:2,tfto:0|IN-1115-RGB;n:type:ShaderForge.SFN_Add,id:1069,x:36002,y:34131,varname:node_1069,prsc:2|A-8913-OUT,B-3805-OUT;n:type:ShaderForge.SFN_ViewVector,id:3487,x:34584,y:34177,varname:node_3487,prsc:2;n:type:ShaderForge.SFN_Vector1,id:3057,x:34584,y:34339,varname:node_3057,prsc:2,v1:-1;n:type:ShaderForge.SFN_Multiply,id:438,x:34758,y:34214,varname:node_438,prsc:2|A-3487-OUT,B-3057-OUT;n:type:ShaderForge.SFN_Reflect,id:6914,x:34947,y:34214,varname:node_6914,prsc:2|A-438-OUT,B-9735-XYZ;n:type:ShaderForge.SFN_Cubemap,id:8131,x:35256,y:34268,ptovrint:False,ptlb:CubeMap,ptin:_CubeMap,varname:node_8131,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,pvfc:0|DIR-6914-OUT,MIP-4618-OUT;n:type:ShaderForge.SFN_Slider,id:4618,x:34926,y:34417,ptovrint:False,ptlb:CubeMapMid,ptin:_CubeMapMid,varname:node_4618,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0,max:7;n:type:ShaderForge.SFN_Fresnel,id:9129,x:35074,y:34567,varname:node_9129,prsc:2|NRM-9735-XYZ,EXP-7872-OUT;n:type:ShaderForge.SFN_Slider,id:7872,x:34650,y:34772,ptovrint:False,ptlb:FresnelPow,ptin:_FresnelPow,varname:node_7872,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:10;n:type:ShaderForge.SFN_Multiply,id:8431,x:35454,y:34479,varname:node_8431,prsc:2|A-8131-RGB,B-9129-OUT;n:type:ShaderForge.SFN_Multiply,id:3805,x:35782,y:34570,varname:node_3805,prsc:2|A-8431-OUT,B-1169-OUT;n:type:ShaderForge.SFN_Slider,id:1169,x:35326,y:34728,ptovrint:False,ptlb:EnvSpecInt,ptin:_EnvSpecInt,varname:node_1169,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.2,max:5;proporder:6266-9661-1724-2047-3779-7286-9432-6465-1115-8131-4618-7872-1169;pass:END;sub:END;*/

Shader "Shader Forge/OldSchoolPlus_SF" {
    Properties {
        _BaseCol ("BaseCol", Color) = (0.5,0.5,0.5,1)
        _SpecPow ("SpecPow", Range(0, 90)) = 30
        _LightCol ("LightCol", Color) = (1,1,1,1)
        _Occlusion ("Occlusion", 2D) = "white" {}
        _EnvUpCol ("EnvUpCol", Color) = (1,1,1,1)
        _EnvSideCol ("EnvSideCol", Color) = (0.4,0.4,0.4,1)
        _EnvDownCol ("EnvDownCol", Color) = (0,0,0,1)
        _EnvVal ("EnvVal", Range(0, 1)) = 0.11
        _NormalMap ("NormalMap", 2D) = "bump" {}
        _CubeMap ("CubeMap", Cube) = "_Skybox" {}
        _CubeMapMid ("CubeMapMid", Range(0, 7)) = 0
        _FresnelPow ("FresnelPow", Range(0, 10)) = 1
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
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform sampler2D _Occlusion; uniform float4 _Occlusion_ST;
            uniform sampler2D _NormalMap; uniform float4 _NormalMap_ST;
            uniform samplerCUBE _CubeMap;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _BaseCol)
                UNITY_DEFINE_INSTANCED_PROP( float, _SpecPow)
                UNITY_DEFINE_INSTANCED_PROP( float4, _LightCol)
                UNITY_DEFINE_INSTANCED_PROP( float4, _EnvUpCol)
                UNITY_DEFINE_INSTANCED_PROP( float4, _EnvSideCol)
                UNITY_DEFINE_INSTANCED_PROP( float4, _EnvDownCol)
                UNITY_DEFINE_INSTANCED_PROP( float, _EnvVal)
                UNITY_DEFINE_INSTANCED_PROP( float, _CubeMapMid)
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
                LIGHTING_COORDS(5,6)
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
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                float3x3 tangentTransform = float3x3( i.tangentDir, i.bitangentDir, i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
////// Lighting:
                float attenuation = LIGHT_ATTENUATION(i);
////// Emissive:
                float4 _LightCol_var = UNITY_ACCESS_INSTANCED_PROP( Props, _LightCol );
                float4 _BaseCol_var = UNITY_ACCESS_INSTANCED_PROP( Props, _BaseCol );
                float node_5773 = 0.0;
                float node_6206 = (-1.0);
                float _SpecPow_var = UNITY_ACCESS_INSTANCED_PROP( Props, _SpecPow );
                float4 _Occlusion_var = tex2D(_Occlusion,TRANSFORM_TEX(i.uv0, _Occlusion));
                float4 _EnvUpCol_var = UNITY_ACCESS_INSTANCED_PROP( Props, _EnvUpCol );
                float node_8335 = i.normalDir.g;
                float node_7664 = max(node_8335,node_5773);
                float4 _EnvDownCol_var = UNITY_ACCESS_INSTANCED_PROP( Props, _EnvDownCol );
                float node_2492 = max((node_8335*node_6206),node_5773);
                float4 _EnvSideCol_var = UNITY_ACCESS_INSTANCED_PROP( Props, _EnvSideCol );
                float _EnvVal_var = UNITY_ACCESS_INSTANCED_PROP( Props, _EnvVal );
                float3 _NormalMap_var = UnpackNormal(tex2D(_NormalMap,TRANSFORM_TEX(i.uv0, _NormalMap)));
                float3 node_9735 = mul( _NormalMap_var.rgb, tangentTransform ).xyz;
                float _CubeMapMid_var = UNITY_ACCESS_INSTANCED_PROP( Props, _CubeMapMid );
                float _FresnelPow_var = UNITY_ACCESS_INSTANCED_PROP( Props, _FresnelPow );
                float _EnvSpecInt_var = UNITY_ACCESS_INSTANCED_PROP( Props, _EnvSpecInt );
                float3 emissive = (((attenuation*(_LightCol_var.rgb*((_BaseCol_var.rgb*max(dot(i.normalDir,lightDirection),node_5773))+pow(max(node_5773,dot(reflect((lightDirection*node_6206),i.normalDir),viewDirection)),_SpecPow_var))))+(_Occlusion_var.rgb*(((((_EnvUpCol_var.rgb*node_7664)+(_EnvDownCol_var.rgb*node_2492))+(_EnvSideCol_var.rgb*((1.0-node_7664)-node_2492)))*_EnvVal_var)*_BaseCol_var.rgb)))+((texCUBElod(_CubeMap,float4(reflect((viewDirection*(-1.0)),node_9735.rgb),_CubeMapMid_var)).rgb*pow(1.0-max(0,dot(node_9735.rgb, viewDirection)),_FresnelPow_var))*_EnvSpecInt_var));
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
