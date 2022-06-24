// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:35568,y:33808,varname:node_3138,prsc:2|emission-7021-OUT;n:type:ShaderForge.SFN_Tex2d,id:4564,x:33553,y:33139,ptovrint:False,ptlb:NormalMap2,ptin:_NormalMap2,varname:node_4564,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:c425f310f0f46794e9fa3ed135f9d4eb,ntxv:3,isnm:True;n:type:ShaderForge.SFN_Tex2dAsset,id:4269,x:32501,y:33280,ptovrint:False,ptlb:normalmap,ptin:_normalmap,varname:node_4269,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:a56745ba7ec728f41bc50587e0e6aad0,ntxv:3,isnm:True;n:type:ShaderForge.SFN_TexCoord,id:1976,x:32501,y:33468,varname:node_1976,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Bitangent,id:1718,x:32670,y:33128,varname:node_1718,prsc:2;n:type:ShaderForge.SFN_Tangent,id:6656,x:32501,y:33128,varname:node_6656,prsc:2;n:type:ShaderForge.SFN_NormalVector,id:5720,x:32804,y:33128,prsc:2,pt:False;n:type:ShaderForge.SFN_Code,id:4071,x:33016,y:33411,varname:node_4071,prsc:2,code:ZgBsAG8AYQB0ADMAIABuAEQAaQByAFQAUwA9ACAAVQBuAHAAYQBjAGsATgBvAHIAbQBhAGwAKAB0AGUAeAAyAEQAKABuAG8AcgBtAGEAbABtAGEAcAAsAFUAVgApACkAOwAKAGYAbABvAGEAdAAzAHgAMwAgAFQAQgBOAD0AZgBsAG8AYQB0ADMAeAAzACgAdABEAGkAcgAsAGIARABpAHIALABuAEQAaQByACkAOwAKAGYAbABvAGEAdAAzACAAbgBEAGkAcgBXAFMAPQAgAG4AbwByAG0AYQBsAGkAegBlACgAbQB1AGwAKABuAEQAaQByAFQAUwAsAFQAQgBOACkAKQA7AAoAcgBlAHQAdQByAG4AIABuAEQAaQByAFcAUwA7AA==,output:2,fname:NormalMapSampler,width:649,height:148,input:2,input:2,input:2,input:1,input:12,input_1_label:tDir,input_2_label:bDir,input_3_label:nDir,input_4_label:UV,input_5_label:normalmap|A-6656-OUT,B-1718-OUT,C-5720-OUT,D-1976-UVOUT,E-4269-TEX;n:type:ShaderForge.SFN_LightVector,id:6440,x:33293,y:33639,varname:node_6440,prsc:2;n:type:ShaderForge.SFN_Dot,id:433,x:33674,y:33544,varname:node_433,prsc:2,dt:0|A-4071-OUT,B-6440-OUT;n:type:ShaderForge.SFN_Max,id:7328,x:33914,y:33669,varname:node_7328,prsc:2|A-433-OUT,B-4250-OUT;n:type:ShaderForge.SFN_Vector1,id:4250,x:33640,y:33751,varname:node_4250,prsc:2,v1:0;n:type:ShaderForge.SFN_Transform,id:8122,x:33848,y:33204,varname:node_8122,prsc:2,tffrom:2,tfto:0|IN-4564-RGB;n:type:ShaderForge.SFN_Transform,id:5491,x:34087,y:33001,cmnt:nDirVS,varname:node_5491,prsc:2,tffrom:0,tfto:3|IN-8122-XYZ;n:type:ShaderForge.SFN_ComponentMask,id:8218,x:34270,y:33065,varname:node_8218,prsc:2,cc1:0,cc2:1,cc3:-1,cc4:-1|IN-5491-XYZ;n:type:ShaderForge.SFN_Tex2d,id:5410,x:34864,y:33281,ptovrint:False,ptlb:Matcap,ptin:_Matcap,varname:_NormalMap3,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:c425f310f0f46794e9fa3ed135f9d4eb,ntxv:1,isnm:False|UVIN-9670-OUT;n:type:ShaderForge.SFN_Multiply,id:5746,x:35124,y:33407,varname:node_5746,prsc:2|A-5410-RGB,B-7347-OUT;n:type:ShaderForge.SFN_Multiply,id:7021,x:35378,y:33553,varname:node_7021,prsc:2|A-5746-OUT,B-6818-OUT;n:type:ShaderForge.SFN_Slider,id:6818,x:34567,y:33729,ptovrint:False,ptlb:EnvSpecInt,ptin:_EnvSpecInt,varname:_node_2962_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:5;n:type:ShaderForge.SFN_Fresnel,id:7347,x:34653,y:33443,varname:node_7347,prsc:2|NRM-8122-XYZ,EXP-2200-OUT;n:type:ShaderForge.SFN_Slider,id:2200,x:34243,y:33555,ptovrint:False,ptlb:FresnelPow,ptin:_FresnelPow,varname:_node_2962_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:10;n:type:ShaderForge.SFN_RemapRange,id:9670,x:34479,y:33103,varname:node_9670,prsc:2,frmn:-1,frmx:1,tomn:0,tomx:1|IN-8218-OUT;proporder:4564-4269-5410-6818-2200;pass:END;sub:END;*/

Shader "Shader Forge/NormalMap_SF" {
    Properties {
        _NormalMap2 ("NormalMap2", 2D) = "bump" {}
        _normalmap ("normalmap", 2D) = "bump" {}
        _Matcap ("Matcap", 2D) = "gray" {}
        _EnvSpecInt ("EnvSpecInt", Range(0, 5)) = 1
        _FresnelPow ("FresnelPow", Range(0, 10)) = 1
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
            uniform sampler2D _NormalMap2; uniform float4 _NormalMap2_ST;
            uniform sampler2D _Matcap; uniform float4 _Matcap_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _EnvSpecInt)
                UNITY_DEFINE_INSTANCED_PROP( float, _FresnelPow)
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
                float3 _NormalMap2_var = UnpackNormal(tex2D(_NormalMap2,TRANSFORM_TEX(i.uv0, _NormalMap2)));
                float3 node_8122 = mul( _NormalMap2_var.rgb, tangentTransform ).xyz;
                float2 node_9670 = (mul( UNITY_MATRIX_V, float4(node_8122.rgb,0) ).xyz.rgb.rg*0.5+0.5);
                float4 _Matcap_var = tex2D(_Matcap,TRANSFORM_TEX(node_9670, _Matcap));
                float _FresnelPow_var = UNITY_ACCESS_INSTANCED_PROP( Props, _FresnelPow );
                float _EnvSpecInt_var = UNITY_ACCESS_INSTANCED_PROP( Props, _EnvSpecInt );
                float3 emissive = ((_Matcap_var.rgb*pow(1.0-max(0,dot(node_8122.rgb, viewDirection)),_FresnelPow_var))*_EnvSpecInt_var);
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
