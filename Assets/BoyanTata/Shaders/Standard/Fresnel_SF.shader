// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33328,y:32928,varname:node_3138,prsc:2|emission-9320-OUT;n:type:ShaderForge.SFN_NormalVector,id:1706,x:32430,y:32949,prsc:2,pt:False;n:type:ShaderForge.SFN_ViewVector,id:5879,x:32430,y:33100,varname:node_5879,prsc:2;n:type:ShaderForge.SFN_Dot,id:6485,x:32700,y:33000,varname:node_6485,prsc:2,dt:0|A-1706-OUT,B-5879-OUT;n:type:ShaderForge.SFN_OneMinus,id:8435,x:32893,y:33029,varname:node_8435,prsc:2|IN-6485-OUT;n:type:ShaderForge.SFN_Slider,id:9040,x:32553,y:33277,ptovrint:False,ptlb:FresnelPow,ptin:_FresnelPow,varname:node_9040,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1.304348,max:5;n:type:ShaderForge.SFN_Multiply,id:4255,x:33073,y:33029,varname:node_4255,prsc:2|A-8435-OUT,B-9040-OUT;n:type:ShaderForge.SFN_Fresnel,id:9320,x:33073,y:32849,varname:node_9320,prsc:2|EXP-4028-OUT;n:type:ShaderForge.SFN_Slider,id:4028,x:32711,y:32895,ptovrint:False,ptlb:FresnelPow_copy,ptin:_FresnelPow_copy,varname:_FresnelPow_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1.304348,max:5;n:type:ShaderForge.SFN_Code,id:8872,x:32968,y:33531,varname:node_8872,prsc:2,code:ZgBsAG8AYQB0ADMAIABuAEQAaQByAFQAUwA9ACAAVQBuAHAAYQBjAGsATgBvAHIAbQBhAGwAKAB0AGUAeAAyAEQAKAApACkA,output:2,fname:NormalMapSampler,width:457,height:148,input:2,input:2,input:2,input:1,input:12,input_1_label:tDir,input_2_label:bDir,input_3_label:nDir,input_4_label:UV,input_5_label:normalmap;n:type:ShaderForge.SFN_Code,id:1516,x:33032,y:33595,varname:node_1516,prsc:2,code:ZgBsAG8AYQB0ADMAIABuAEQAaQByAFQAUwA9ACAAVQBuAHAAYQBjAGsATgBvAHIAbQBhAGwAKAB0AGUAeAAyAEQAKAApACkA,output:2,fname:NormalMapSampler,width:457,height:148,input:2,input:2,input:2,input:1,input:12,input_1_label:tDir,input_2_label:bDir,input_3_label:nDir,input_4_label:UV,input_5_label:normalmap;proporder:9040-4028;pass:END;sub:END;*/

Shader "Shader Forge/Fresnel_SF" {
    Properties {
        _FresnelPow ("FresnelPow", Range(0, 5)) = 1.304348
        _FresnelPow_copy ("FresnelPow_copy", Range(0, 5)) = 1.304348
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
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _FresnelPow_copy)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
////// Lighting:
////// Emissive:
                float _FresnelPow_copy_var = UNITY_ACCESS_INSTANCED_PROP( Props, _FresnelPow_copy );
                float node_9320 = pow(1.0-max(0,dot(normalDirection, viewDirection)),_FresnelPow_copy_var);
                float3 emissive = float3(node_9320,node_9320,node_9320);
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
