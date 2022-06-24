// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:0,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:0,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32719,y:32712,varname:node_3138,prsc:2|emission-3424-OUT;n:type:ShaderForge.SFN_Vector3,id:3424,x:32413,y:32817,varname:node_3424,prsc:2,v1:0,v2:0,v3:0;pass:END;sub:END;*/

Shader "Shader Forge/3ColAmbient" {
    Properties {
        _Occlusion("�����ڵ�ͼ",2d)="white"{}
        _EnvUpCol("���ϻ���ɫ",color)=(1,1,1,1)
        _EnvSideCol("���滷��ɫ",color)=(0.4,0.4,0.4,1)
        _EnvDownCol("���»���ɫ",color)=(0,0,0,0)
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
            //����ṹ
            struct VertexInput {
                float4 vertex : POSITION;//��ģ�Ͷ�����Ϣ�������
                float4 normal : NORMAL;//��ģ�ͷ�����Ϣ�������
                float2 uv0 : TEXCOORD0;// ��ģ��UV��Ϣ������� 0ͨ�� ��4ͨ��

            };
            //����ṹ
            struct VertexOutput {
                float4 pos : SV_POSITION;// ��ģ�Ͷ�����Ϣ��������Ķ�����Ļλ��
                float3 normalDirWS : TEXCOORD0; // ��ģ�ͷ�����Ϣ������������ռ䷨����Ϣ
                float2 uv : TEXCOORD1;// ׷��UV��Ϣ��������Shader������ͼ
            };
            // ����ṹ>>>����Shader>>>����ṹ
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;// �½�һ������ṹ
                o.pos = UnityObjectToClipPos( v.vertex );// �任������Ϣ ��������������ṹ
                o.normalDirWS=UnityObjectToWorldNormal(v.normal); // �任������Ϣ ��������������ṹ
                o.uv=v.uv0;// ͼɭ��
                return o;// ������ṹ ���
            }
            // ����ṹ>>>����
            float4 frag(VertexOutput i) : COLOR {
                // ׼������
                float3 normalDir=i.normalDirWS;// ��ȡnDir    
                // �������λ����
                float upMask=max(0.0,normalDir.g);// ��ȡ���ϲ�������
                float downMask=max(0.0,-normalDir.g);// ��ȡ���²�������
                float sideMask=1.0-upMask-downMask;// ��ȡ���沿������
                // ��ϻ���ɫ
                float3 envCol=_EnvUpCol*upMask + _EnvSideCol*sideMask + _EnvDownCol*downMask;
                // ����Occlusion��ͼ(����OA����)
                float occlusion=tex2D(_Occlusion,i.uv);
                // ���㻷������
                float3 envLight=envCol*occlusion;
                // ����������ɫ
                return fixed4(envLight,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
