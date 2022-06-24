// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:34621,y:32755,varname:node_3138,prsc:2|emission-1136-OUT;n:type:ShaderForge.SFN_Color,id:7241,x:32241,y:33051,ptovrint:False,ptlb:Color_main,ptin:_Color_main,varname:node_7241,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0,c2:0.7830189,c3:0.4827943,c4:1;n:type:ShaderForge.SFN_UVTile,id:4876,x:32765,y:33369,varname:node_4876,prsc:2|UVIN-2494-UVOUT,WDT-2940-OUT,HGT-2940-OUT,TILE-6102-OUT;n:type:ShaderForge.SFN_TexCoord,id:2494,x:32159,y:33369,varname:node_2494,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_Vector1,id:6102,x:32330,y:33592,varname:node_6102,prsc:2,v1:1;n:type:ShaderForge.SFN_Slider,id:2940,x:32288,y:33484,ptovrint:False,ptlb:Mask Tite,ptin:_MaskTite,varname:node_2940,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.32,max:1;n:type:ShaderForge.SFN_Tex2d,id:8282,x:32974,y:33284,ptovrint:False,ptlb:Mask Map,ptin:_MaskMap,varname:node_8282,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:22fdd3b60618f5342baa3f6b861997a4,ntxv:0,isnm:False|UVIN-4876-UVOUT;n:type:ShaderForge.SFN_Step,id:2262,x:33179,y:33323,varname:node_2262,prsc:2|A-8282-RGB,B-3269-OUT;n:type:ShaderForge.SFN_Slider,id:3269,x:32484,y:33652,ptovrint:False,ptlb:Mask Range,ptin:_MaskRange,varname:_node_2940_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:0.1545729,max:1;n:type:ShaderForge.SFN_Desaturate,id:7132,x:33400,y:33335,varname:node_7132,prsc:2|COL-2262-OUT;n:type:ShaderForge.SFN_LightVector,id:2200,x:32194,y:32397,varname:node_2200,prsc:2;n:type:ShaderForge.SFN_ViewVector,id:8662,x:32562,y:32560,varname:node_8662,prsc:2;n:type:ShaderForge.SFN_NormalVector,id:2816,x:32369,y:32508,prsc:2,pt:False;n:type:ShaderForge.SFN_Vector1,id:23,x:32194,y:32332,varname:node_23,prsc:2,v1:-1;n:type:ShaderForge.SFN_Multiply,id:7617,x:32369,y:32351,varname:node_7617,prsc:2|A-23-OUT,B-2200-OUT;n:type:ShaderForge.SFN_Reflect,id:552,x:32562,y:32376,varname:node_552,prsc:2|A-7617-OUT,B-2816-OUT;n:type:ShaderForge.SFN_Dot,id:1999,x:32783,y:32433,varname:node_1999,prsc:2,dt:0|A-552-OUT,B-8662-OUT;n:type:ShaderForge.SFN_Vector1,id:1788,x:32783,y:32604,varname:node_1788,prsc:2,v1:0;n:type:ShaderForge.SFN_Max,id:7736,x:33031,y:32471,varname:node_7736,prsc:2|A-1999-OUT,B-1788-OUT;n:type:ShaderForge.SFN_Slider,id:9598,x:32577,y:32722,ptovrint:False,ptlb:SpecPow,ptin:_SpecPow,varname:_node_2940_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:5,max:20;n:type:ShaderForge.SFN_Exp,id:1491,x:32996,y:32639,varname:node_1491,prsc:2,et:0|IN-9598-OUT;n:type:ShaderForge.SFN_Power,id:444,x:33302,y:32354,varname:node_444,prsc:2|VAL-7736-OUT,EXP-1491-OUT;n:type:ShaderForge.SFN_Slider,id:5009,x:32542,y:32840,ptovrint:False,ptlb:Fresnal Range,ptin:_FresnalRange,varname:_node_2940_copy_copy_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1.5,max:10;n:type:ShaderForge.SFN_Exp,id:5834,x:32982,y:32784,varname:node_5834,prsc:2,et:0|IN-5009-OUT;n:type:ShaderForge.SFN_Fresnel,id:1083,x:33266,y:32535,varname:node_1083,prsc:2;n:type:ShaderForge.SFN_Power,id:3723,x:33544,y:32531,varname:node_3723,prsc:2|VAL-1083-OUT,EXP-5834-OUT;n:type:ShaderForge.SFN_Vector1,id:1753,x:32734,y:32920,varname:node_1753,prsc:2,v1:0.5;n:type:ShaderForge.SFN_Multiply,id:285,x:33352,y:32871,varname:node_285,prsc:2|A-1753-OUT,B-7241-RGB;n:type:ShaderForge.SFN_Dot,id:3150,x:32126,y:32768,varname:node_3150,prsc:2,dt:0|A-2816-OUT,B-2200-OUT;n:type:ShaderForge.SFN_Vector1,id:2011,x:32051,y:32955,varname:node_2011,prsc:2,v1:0;n:type:ShaderForge.SFN_Max,id:1935,x:32278,y:32864,varname:node_1935,prsc:2|A-3150-OUT,B-2011-OUT;n:type:ShaderForge.SFN_Color,id:8350,x:32344,y:33211,ptovrint:False,ptlb:Color_copy,ptin:_Color_copy,varname:_Color_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.6886792,c2:0.2555237,c3:0,c4:1;n:type:ShaderForge.SFN_Multiply,id:5736,x:32580,y:33099,varname:node_5736,prsc:2|A-1935-OUT,B-7241-RGB;n:type:ShaderForge.SFN_Multiply,id:2271,x:32744,y:33184,varname:node_2271,prsc:2|A-1935-OUT,B-8350-RGB;n:type:ShaderForge.SFN_Add,id:7805,x:33952,y:32968,varname:node_7805,prsc:2|A-5359-OUT,B-5736-OUT;n:type:ShaderForge.SFN_Lerp,id:1136,x:34232,y:33089,varname:node_1136,prsc:2|A-7805-OUT,B-2271-OUT,T-7132-OUT;n:type:ShaderForge.SFN_Multiply,id:6338,x:33590,y:32686,varname:node_6338,prsc:2|A-3723-OUT,B-285-OUT;n:type:ShaderForge.SFN_Add,id:5359,x:33931,y:32660,varname:node_5359,prsc:2|A-444-OUT,B-6338-OUT;proporder:7241-8350-9598-5009-2940-8282-3269;pass:END;sub:END;*/

Shader "Shader Forge/rustshader" {
    Properties {
        _Color_main ("Color_main", Color) = (0,0.7830189,0.4827943,1)
        _Color_copy ("Color_copy", Color) = (0.6886792,0.2555237,0,1)
        _SpecPow ("SpecPow", Range(0, 20)) = 5
        _FresnalRange ("Fresnal Range", Range(0, 10)) = 1.5
        _MaskTite ("Mask Tite", Range(0, 1)) = 0.32
        _MaskMap ("Mask Map", 2D) = "white" {}
        _MaskRange ("Mask Range", Range(0, 1)) = 0.1545729
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
            uniform sampler2D _MaskMap; uniform float4 _MaskMap_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _Color_main)
                UNITY_DEFINE_INSTANCED_PROP( float, _MaskTite)
                UNITY_DEFINE_INSTANCED_PROP( float, _MaskRange)
                UNITY_DEFINE_INSTANCED_PROP( float, _SpecPow)
                UNITY_DEFINE_INSTANCED_PROP( float, _FresnalRange)
                UNITY_DEFINE_INSTANCED_PROP( float4, _Color_copy)
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
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                LIGHTING_COORDS(3,4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 lightDirection = normalize(_WorldSpaceLightPos0.xyz);
////// Lighting:
////// Emissive:
                float _SpecPow_var = UNITY_ACCESS_INSTANCED_PROP( Props, _SpecPow );
                float _FresnalRange_var = UNITY_ACCESS_INSTANCED_PROP( Props, _FresnalRange );
                float4 _Color_main_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Color_main );
                float node_1935 = max(dot(i.normalDir,lightDirection),0.0);
                float4 _Color_copy_var = UNITY_ACCESS_INSTANCED_PROP( Props, _Color_copy );
                float _MaskTite_var = UNITY_ACCESS_INSTANCED_PROP( Props, _MaskTite );
                float node_6102 = 1.0;
                float2 node_4876_tc_rcp = float2(1.0,1.0)/float2( _MaskTite_var, _MaskTite_var );
                float node_4876_ty = floor(node_6102 * node_4876_tc_rcp.x);
                float node_4876_tx = node_6102 - _MaskTite_var * node_4876_ty;
                float2 node_4876 = (i.uv0 + float2(node_4876_tx, node_4876_ty)) * node_4876_tc_rcp;
                float4 _MaskMap_var = tex2D(_MaskMap,TRANSFORM_TEX(node_4876, _MaskMap));
                float _MaskRange_var = UNITY_ACCESS_INSTANCED_PROP( Props, _MaskRange );
                float3 emissive = lerp(((pow(max(dot(reflect(((-1.0)*lightDirection),i.normalDir),viewDirection),0.0),exp(_SpecPow_var))+(pow((1.0-max(0,dot(normalDirection, viewDirection))),exp(_FresnalRange_var))*(0.5*_Color_main_var.rgb)))+(node_1935*_Color_main_var.rgb)),(node_1935*_Color_copy_var.rgb),dot(step(_MaskMap_var.rgb,_MaskRange_var),float3(0.3,0.59,0.11)));
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
            #pragma multi_compile_instancing
            #include "UnityCG.cginc"
            #include "AutoLight.cginc"
            #pragma multi_compile_fwdadd_fullshadows
            #pragma target 3.0
            uniform sampler2D _MaskMap; uniform float4 _MaskMap_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, _Color_main)
                UNITY_DEFINE_INSTANCED_PROP( float, _MaskTite)
                UNITY_DEFINE_INSTANCED_PROP( float, _MaskRange)
                UNITY_DEFINE_INSTANCED_PROP( float, _SpecPow)
                UNITY_DEFINE_INSTANCED_PROP( float, _FresnalRange)
                UNITY_DEFINE_INSTANCED_PROP( float4, _Color_copy)
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
                float4 posWorld : TEXCOORD1;
                float3 normalDir : TEXCOORD2;
                LIGHTING_COORDS(3,4)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                UNITY_SETUP_INSTANCE_ID( v );
                UNITY_TRANSFER_INSTANCE_ID( v, o );
                o.uv0 = v.texcoord0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                TRANSFER_VERTEX_TO_FRAGMENT(o)
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                UNITY_SETUP_INSTANCE_ID( i );
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
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
