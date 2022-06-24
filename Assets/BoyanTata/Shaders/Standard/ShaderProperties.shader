// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:1,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:33709,y:32934,varname:node_3138,prsc:2|emission-2015-OUT;n:type:ShaderForge.SFN_Normalize,id:6561,x:32696,y:32832,varname:node_6561,prsc:2|IN-415-XYZ;n:type:ShaderForge.SFN_NormalVector,id:1104,x:32454,y:32969,prsc:2,pt:False;n:type:ShaderForge.SFN_Dot,id:3044,x:32920,y:32832,varname:node_3044,prsc:2,dt:0|A-6561-OUT,B-1104-OUT;n:type:ShaderForge.SFN_RemapRange,id:9088,x:33130,y:32832,varname:node_9088,prsc:2,frmn:-1,frmx:1,tomn:0,tomx:1|IN-3044-OUT;n:type:ShaderForge.SFN_Multiply,id:6786,x:32811,y:33157,varname:node_6786,prsc:2|A-9088-OUT,B-5011-RGB;n:type:ShaderForge.SFN_Color,id:5011,x:32501,y:33221,ptovrint:False,ptlb:_Color伪造光颜色,ptin:__Color,varname:__Vert_copy,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.3366411,c2:0.543417,c3:0.8018868,c4:1;n:type:ShaderForge.SFN_Slider,id:6046,x:32522,y:33415,ptovrint:False,ptlb:_PowerSlider伪造光强度,ptin:__PowerSlider,varname:node_6046,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1.245547,max:2;n:type:ShaderForge.SFN_Multiply,id:2366,x:32975,y:33254,varname:node_2366,prsc:2|A-6786-OUT,B-6046-OUT;n:type:ShaderForge.SFN_Multiply,id:6175,x:33165,y:33400,varname:node_6175,prsc:2|A-2366-OUT,B-3042-RGB;n:type:ShaderForge.SFN_Tex2d,id:3042,x:32865,y:33559,ptovrint:False,ptlb:node_3042,ptin:_node_3042,varname:node_3042,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,tex:45427cb91451c6049bc58e48c4e07e84,ntxv:0,isnm:False|UVIN-1041-UVOUT;n:type:ShaderForge.SFN_TexCoord,id:1041,x:32612,y:33559,varname:node_1041,prsc:2,uv:0,uaff:False;n:type:ShaderForge.SFN_SwitchProperty,id:2015,x:33365,y:33543,ptovrint:False,ptlb:_LightSwitch光照开关,ptin:__LightSwitch,varname:node_2015,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-3042-RGB,B-6175-OUT;n:type:ShaderForge.SFN_Vector4Property,id:415,x:32425,y:32796,ptovrint:False,ptlb:_Vert伪造光方向,ptin:__Vert,varname:node_415,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,v1:0,v2:1,v3:0,v4:0;proporder:5011-6046-3042-2015-415;pass:END;sub:END;*/

Shader "Shader Forge/ShaderProperties" {
    Properties {
        __Color ("_Color伪造光颜色", Color) = (0.3366411,0.543417,0.8018868,1)
        __PowerSlider ("_PowerSlider伪造光强度", Range(0, 2)) = 1.245547
        _node_3042 ("node_3042", 2D) = "white" {}
        [MaterialToggle] __LightSwitch ("_LightSwitch光照开关", Float ) = 0
        __Vert ("_Vert伪造光方向", Vector) = (0,1,0,0)
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
            uniform sampler2D _node_3042; uniform float4 _node_3042_ST;
            UNITY_INSTANCING_BUFFER_START( Props )
                UNITY_DEFINE_INSTANCED_PROP( float4, __Color)
                UNITY_DEFINE_INSTANCED_PROP( float, __PowerSlider)
                UNITY_DEFINE_INSTANCED_PROP( fixed, __LightSwitch)
                UNITY_DEFINE_INSTANCED_PROP( float4, __Vert)
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
                i.normalDir = normalize(i.normalDir);
                float3 normalDirection = i.normalDir;
////// Lighting:
////// Emissive:
                float4 _node_3042_var = tex2D(_node_3042,TRANSFORM_TEX(i.uv0, _node_3042));
                float4 __Vert_var = UNITY_ACCESS_INSTANCED_PROP( Props, __Vert );
                float4 __Color_var = UNITY_ACCESS_INSTANCED_PROP( Props, __Color );
                float __PowerSlider_var = UNITY_ACCESS_INSTANCED_PROP( Props, __PowerSlider );
                float3 __LightSwitch_var = lerp( _node_3042_var.rgb, ((((dot(normalize(__Vert_var.rgb),i.normalDir)*0.5+0.5)*__Color_var.rgb)*__PowerSlider_var)*_node_3042_var.rgb), UNITY_ACCESS_INSTANCED_PROP( Props, __LightSwitch ) );
                float3 emissive = __LightSwitch_var;
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
