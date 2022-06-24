// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33108,y:32960,varname:node_3138,prsc:2|emission-6407-RGB,olwid-9099-OUT,olcol-313-RGB;n:type:ShaderForge.SFN_Dot,id:712,x:32249,y:32634,varname:node_712,prsc:2,dt:0|A-5388-OUT,B-2290-OUT;n:type:ShaderForge.SFN_NormalVector,id:5388,x:32056,y:32581,prsc:2,pt:False;n:type:ShaderForge.SFN_LightVector,id:2290,x:32056,y:32787,varname:node_2290,prsc:2;n:type:ShaderForge.SFN_Clamp01,id:7383,x:32408,y:32667,varname:node_7383,prsc:2|IN-712-OUT;n:type:ShaderForge.SFN_Multiply,id:1177,x:32371,y:32883,varname:node_1177,prsc:2|A-7383-OUT,B-1095-OUT;n:type:ShaderForge.SFN_Vector1,id:1095,x:31995,y:33142,varname:node_1095,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Add,id:621,x:32311,y:33155,varname:node_621,prsc:2|A-1177-OUT,B-1095-OUT;n:type:ShaderForge.SFN_Vector1,id:6537,x:32024,y:33336,varname:node_6537,prsc:2,v1:0.2;n:type:ShaderForge.SFN_Append,id:4311,x:32332,y:33425,varname:node_4311,prsc:2|A-621-OUT,B-6537-OUT;n:type:ShaderForge.SFN_Tex2d,id:6407,x:32716,y:33397,ptovrint:False,ptlb:node_6407,ptin:_node_6407,varname:node_6407,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:610a0f8d3e1ee8d41b404a06ef81265b,ntxv:0,isnm:False|UVIN-4311-OUT;n:type:ShaderForge.SFN_Vector1,id:9099,x:32535,y:33081,varname:node_9099,prsc:2,v1:0.015;n:type:ShaderForge.SFN_Color,id:313,x:32535,y:33178,ptovrint:False,ptlb:node_313,ptin:_node_313,varname:node_313,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.3018868,c2:0.243503,c3:0.243503,c4:1;proporder:6407-313;pass:END;sub:END;*/

Shader "Shader Forge/FirstLove" {
    Properties {
        _node_6407 ("node_6407", 2D) = "white" {}
        _node_313 ("node_313", Color) = (0.3018868,0.243503,0.243503,1)
    }
    SubShader {
        Tags {
            "RenderType"="Opaque"
        }
        Pass {
            Name "Outline"
            Tags {
            }
            Cull Front
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_shadowcaster
            #pragma target 3.0
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _node_313)
            UNITY_INSTANCING_BUFFER_END( Props )
            struct VertexInput {
                UNITY_VERTEX_INPUT_INSTANCE_ID
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                UNITY_VERTEX_INPUT_INSTANCE_ID
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.pos = UnityObjectToClipPos( float4(v.vertex.xyz + v.normal*0.015,1) );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                float4 _node_313_var = UNITY_ACCESS_INSTANCED_PROP( Props, _node_313 );
                return fixed4(_node_313_var.rgb,0);
            }
            ENDCG
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
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform sampler2D _node_6407; uniform float4 _node_6407_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                LIGHTING_COORDS(2,3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
////// Lighting:
////// Emissive:
                float node_1095 = 0.5;
                float2 node_4311 = float2(((saturate(dot(i.normalDir,lightDirection))*node_1095)+node_1095),0.2);
                float4 _node_6407_var = tex2D(_node_6407,TRANSFORM_TEX(node_4311, _node_6407));
                float3 emissive = _node_6407_var.rgb;
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
        Pass {
            Name "FORWARD_DELTA"
            Tags {
                "LightMode"="ForwardAdd"
            }
            Blend One One
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma target 3.0
            uniform sampler2D _node_6407; uniform float4 _node_6407_ST;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
                LIGHTING_COORDS(2,3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(lerp(_WorldSpaceLightPos0.xyz, _WorldSpaceLightPos0.xyz - i.posWorld.xyz,_WorldSpaceLightPos0.w));
////// Lighting:
                float3 finalColor = 0;
                return fixed4(finalColor * 1,0);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
