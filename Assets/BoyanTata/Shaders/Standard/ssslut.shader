// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:0,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:0,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33285,y:32830,varname:node_3138,prsc:2|emission-2334-RGB;n:type:ShaderForge.SFN_Dot,id:8617,x:32478,y:32927,varname:node_8617,prsc:2,dt:0|A-4556-OUT,B-682-OUT;n:type:ShaderForge.SFN_NormalVector,id:4556,x:32210,y:32866,prsc:2,pt:False;n:type:ShaderForge.SFN_LightVector,id:682,x:32210,y:33027,varname:node_682,prsc:2;n:type:ShaderForge.SFN_RemapRange,id:1859,x:32664,y:32940,varname:node_1859,prsc:2,frmn:-1,frmx:1,tomn:0,tomx:1|IN-8617-OUT;n:type:ShaderForge.SFN_Slider,id:563,x:32282,y:33213,ptovrint:False,ptlb:ssspower,ptin:_ssspower,varname:node_563,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.008695634,max:1;n:type:ShaderForge.SFN_Append,id:1806,x:32834,y:33143,varname:node_1806,prsc:2|A-1859-OUT,B-563-OUT;n:type:ShaderForge.SFN_Tex2d,id:2334,x:32978,y:33194,ptovrint:False,ptlb:lut,ptin:_lut,varname:node_2334,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:398f9f597977e694789dd741bd36f389,ntxv:0,isnm:False|UVIN-1806-OUT;proporder:563-2334;pass:END;sub:END;*/

Shader "Shader Forge/ssslut" {
    Properties {
        _ssspower ("ssspower", Range(0, 1)) = 0.008695634
        _lut ("lut", 2D) = "white" {}
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
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform sampler2D _lut; uniform float4 _lut_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float, _ssspower)
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
                LIGHTING_COORDS(2,3)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
////// Lighting:
////// Emissive:
                float _ssspower_var = UNITY_ACCESS_INSTANCED_PROP( Props, _ssspower );
                float2 node_1806 = float2((dot(i.normalDir,lightDirection)*0.5+0.5),_ssspower_var);
                float4 _lut_var = tex2D(_lut,TRANSFORM_TEX(node_1806, _lut));
                float3 emissive = _lut_var.rgb;
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
