// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:0,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:0,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32719,y:32712,varname:node_3138,prsc:2|emission-3424-OUT;n:type:ShaderForge.SFN_Vector3,id:3424,x:32413,y:32817,varname:node_3424,prsc:2,v1:0,v2:0,v3:0;pass:END;sub:END;*/

Shader "Shader Forge/3ColAmbient" {
    Properties {
        _Occlusion("换进遮挡图",2d)="white"{}
        _EnvUpCol("向上环境色",color)=(1,1,1,1)
        _EnvSideCol("侧面环境色",color)=(0.4,0.4,0.4,1)
        _EnvDownCol("向下环境色",color)=(0,0,0,0)
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
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0
            uniform float3  _EnvUpCol   ;
            uniform float3  _EnvSideCol ;
            uniform float3  _EnvDownCol ;
            uniform sampler2D  _Occlusion ;
            //输入结构
            struct VertexInput {
                float4 vertex : POSITION;//将模型顶点信息输入进来
                float4 normal : NORMAL;//将模型法线信息输入进来
                float2 uv0 : TEXCOORD0;// 将模型UV信息输入进来 0通道 共4通道

            };
            //输出结构
            struct VertexOutput {
                float4 pos : SV_POSITION;// 由模型顶点信息换算而来的顶点屏幕位置
                float3 normalDirWS : TEXCOORD0; // 由模型法线信息换算来的世界空间法线信息
                float2 uv : TEXCOORD1;// 追加UV信息用语像素Shader采样贴图
            };
            // 输入结构>>>顶点Shader>>>输出结构
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;// 新建一个输出结构
                o.pos = UnityObjectToClipPos( v.vertex );// 变换顶点信息 并将其塞给输出结构
                o.normalDirWS=UnityObjectToWorldNormal(v.normal); // 变换法线信息 并将其塞给输出结构
                o.uv=v.uv0;// 图森破
                return o;// 将输出结构 输出
            }
            // 输出结构>>>像素
            float4 frag(VertexOutput i) : COLOR {
                // 准备向量
                float3 normalDir=i.normalDirWS;// 获取nDir    
                // 计算各部位遮罩
                float upMask=max(0.0,normalDir.g);// 获取朝上部分遮罩
                float downMask=max(0.0,-normalDir.g);// 获取朝下部分遮罩
                float sideMask=1.0-upMask-downMask;// 获取侧面部分遮罩
                // 混合环境色
                float3 envCol=_EnvUpCol*upMask + _EnvSideCol*sideMask + _EnvDownCol*downMask;
                // 采样Occlusion贴图(采样OA纹理)
                float occlusion=tex2D(_Occlusion,i.uv);
                // 计算环境光照
                float3 envLight=envCol*occlusion;
                // 返回最终颜色
                return fixed4(envLight,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
