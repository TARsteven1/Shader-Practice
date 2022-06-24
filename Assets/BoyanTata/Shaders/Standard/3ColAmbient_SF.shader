// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:0,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:0,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:34479,y:32790,varname:node_3138,prsc:2|emission-6054-OUT;n:type:ShaderForge.SFN_NormalVector,id:9726,x:32435,y:32901,prsc:2,pt:False;n:type:ShaderForge.SFN_ComponentMask,id:5035,x:32628,y:32925,varname:node_5035,prsc:2,cc1:1,cc2:-1,cc3:-1,cc4:-1|IN-9726-OUT;n:type:ShaderForge.SFN_Max,id:6960,x:32860,y:32945,varname:node_6960,prsc:2|A-5035-OUT,B-1594-OUT;n:type:ShaderForge.SFN_Vector1,id:1594,x:32550,y:33099,varname:node_1594,prsc:2,v1:0;n:type:ShaderForge.SFN_Vector1,id:7162,x:32843,y:33101,varname:node_7162,prsc:2,v1:1;n:type:ShaderForge.SFN_Vector1,id:8901,x:32526,y:33289,varname:node_8901,prsc:2,v1:-1;n:type:ShaderForge.SFN_Multiply,id:3378,x:32812,y:33169,varname:node_3378,prsc:2|A-5035-OUT,B-8901-OUT;n:type:ShaderForge.SFN_Max,id:9386,x:33043,y:33169,varname:node_9386,prsc:2|A-3378-OUT,B-1594-OUT;n:type:ShaderForge.SFN_Multiply,id:4900,x:33456,y:33173,varname:node_4900,prsc:2|A-2271-RGB,B-9386-OUT;n:type:ShaderForge.SFN_Subtract,id:8106,x:33031,y:32992,varname:node_8106,prsc:2|A-7162-OUT,B-6960-OUT;n:type:ShaderForge.SFN_Subtract,id:8833,x:33251,y:33019,varname:node_8833,prsc:2|A-8106-OUT,B-9386-OUT;n:type:ShaderForge.SFN_Multiply,id:4189,x:33456,y:33006,varname:node_4189,prsc:2|A-4532-RGB,B-8833-OUT;n:type:ShaderForge.SFN_Multiply,id:9015,x:33443,y:32815,varname:node_9015,prsc:2|A-9364-RGB,B-6960-OUT;n:type:ShaderForge.SFN_Add,id:2302,x:33650,y:33019,varname:node_2302,prsc:2|A-9015-OUT,B-4900-OUT;n:type:ShaderForge.SFN_Add,id:4663,x:33935,y:33135,varname:node_4663,prsc:2|A-2302-OUT,B-4189-OUT;n:type:ShaderForge.SFN_Tex2d,id:870,x:33943,y:32940,ptovrint:False,ptlb:Occlusion,ptin:_Occlusion,varname:node_870,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,ntxv:0,isnm:False;n:type:ShaderForge.SFN_Multiply,id:6054,x:34171,y:33064,varname:node_6054,prsc:2|A-870-RGB,B-4663-OUT;n:type:ShaderForge.SFN_Color,id:9364,x:33122,y:32543,ptovrint:False,ptlb:EnvUpCol,ptin:_EnvUpCol,varname:node_9364,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_Color,id:4532,x:33141,y:32705,ptovrint:False,ptlb:EnvSideCol,ptin:_EnvSideCol,varname:_node_9364_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.4,c2:0.4,c3:0.4,c4:1;n:type:ShaderForge.SFN_Color,id:2271,x:33154,y:32864,ptovrint:False,ptlb:EnvDownCol,ptin:_EnvDownCol,varname:_node_9364_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:0,c3:0,c4:1;proporder:870-9364-4532-2271;pass:END;sub:END;*/

Shader "Shader Forge/3ColAmbient_SF" {
    Properties {
        _Occlusion ("Occlusion", 2D) = "white" {}
        _EnvUpCol ("EnvUpCol", Color) = (1,1,1,1)
        _EnvSideCol ("EnvSideCol", Color) = (0.4,0.4,0.4,1)
        _EnvDownCol ("EnvDownCol", Color) = (0,0,0,1)
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
            uniform sampler2D _Occlusion; uniform float4 _Occlusion_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _EnvUpCol)
                UNITY_DEFINE_INSTANCED_PROP( float4, _EnvSideCol)
                UNITY_DEFINE_INSTANCED_PROP( float4, _EnvDownCol)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 texcoord0 : TEXCOORD0;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float2 uv0 : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                float3 normalDirection = i.normalDir;
////// Lighting:
////// Emissive:
                float4 _Occlusion_var = tex2D(_Occlusion,TRANSFORM_TEX(i.uv0, _Occlusion));
                float4 _EnvUpCol_var = UNITY_ACCESS_INSTANCED_PROP( Props, _EnvUpCol );
                float node_5035 = i.normalDir.g;
                float node_1594 = 0.0;
                float node_6960 = max(node_5035,node_1594);
                float4 _EnvDownCol_var = UNITY_ACCESS_INSTANCED_PROP( Props, _EnvDownCol );
                float node_9386 = max((node_5035*(-1.0)),node_1594);
                float4 _EnvSideCol_var = UNITY_ACCESS_INSTANCED_PROP( Props, _EnvSideCol );
                float3 emissive = (_Occlusion_var.rgb*(((_EnvUpCol_var.rgb*node_6960)+(_EnvDownCol_var.rgb*node_9386))+(_EnvSideCol_var.rgb*((1.0-node_6960)-node_9386))));
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
