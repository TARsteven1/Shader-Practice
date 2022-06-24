// Shader created with Shader Forge v1.40 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.40;sub:START;pass:START;ps:flbk:,iptp:0,cusa:False,bamd:0,cgin:,cpap:True,lico:0,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:0,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:True,igpj:False,qofs:0,qpre:1,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:False,fnfb:False,fsmp:False;n:type:ShaderForge.SFN_Final,id:3138,x:32719,y:32712,varname:node_3138,prsc:2|emission-3424-OUT;n:type:ShaderForge.SFN_Vector3,id:3424,x:32413,y:32817,varname:node_3424,prsc:2,v1:0,v2:0,v3:0;pass:END;sub:END;*/

Shader "Shader Forge/OldSchoolPlus" {
    Properties {
        [Header(Texture)]
        _CubeMap("CubeMap",Cube)="_Skybox"{}
        _NormalMap("NormalMap",2D)="bump"{}
        _Occlusion("�����ڵ�ͼ",2D)="white"{}
        _EmitTex("������ͼ",2D)="black"{}
        _SpecTex("�߹���ɫ",2D)="gray"{}
        [Header(Diffuse)]
        _BaseCol("����ɫ",color)=(0.5,0.5,0.5,1)
        _EnvVal ("�������淴��ǿ��", Range(0, 1)) = 0.11
        _EnvUpCol("���ϻ���ɫ",color)=(1,1,1,1)
        _EnvSideCol("���滷��ɫ",color)=(0.4,0.4,0.4,1)
        _EnvDownCol("���»���ɫ",color)=(0,0,0,0)
        [Header(Specular)]
        _SpecPow ("�߹����", Range(0, 90)) = 30
        _FresnelPow ("���������", Range(0, 5)) = 1
        _EnvSpecInt ("�������淴��ǿ��", Range(0, 5)) = 0.2
        _CubeMapMid ("������Mid", Range(0, 7)) = 0

        _LightCol("��������ɫ",color)=(1,1,1,1)
        [Header(Emission)]
        _EmitInt("�Է���ǿ��",Range(1, 10)) = 1
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
            #include "AutoLight.cginc"
            #include "Lighting.cginc"
            #pragma multi_compile_fwdbase_fullshadows
            #pragma target 3.0

            uniform sampler2D  _Occlusion ;
            uniform sampler2D  _NormalMap ;
            uniform sampler2D  _EmitTex ;
            uniform samplerCUBE  _CubeMap ;
            uniform sampler2D _SpecTex;

            uniform float3  _BaseCol   ;
            uniform float  _SpecPow   ;
            uniform float  _EnvVal   ;
            uniform float  _EmitInt   ;
            uniform float3  _EnvUpCol   ;
            uniform float3  _EnvSideCol ;
            uniform float3  _EnvDownCol ;

            uniform float3  _LightCol ;

            uniform float  _CubeMapMid   ;
            uniform float  _FresnelPow   ;
            uniform float  _EnvSpecInt   ;

            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
                float2 uv0 : TEXCOORD3;// ��ģ��UV��Ϣ������� 0ͨ�� ��4ͨ��
                float4 tangent : TANGENT;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float3 normalDir_WorldSpace : TEXCOORD0;
                float3 light:TEXCOORD1;
                float4 posWorld : TEXCOORD2;
                float3 bDirWS:TEXCOORD3;
                //float3 nDirWS:TEXCOORD4;
                float3 tDirWS:TEXCOORD4;

                float2 uv : TEXCOORD5;// ׷��UV��Ϣ��������Shader������ͼ

                LIGHTING_COORDS(6,7)
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.pos = UnityObjectToClipPos( v.vertex );
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.normalDir_WorldSpace=UnityObjectToWorldNormal(v.normal);//���߷��� OS>>WS
                o.light= UnityObjectToWorldNormal(v.vertex);
                o.uv=v.uv0;// ����UV��Ϣ
                TRANSFER_VERTEX_TO_FRAGMENT(o)

                o.tDirWS=normalize(mul(unity_ObjectToWorld,float4(v.tangent.xyz,0.0)).xyz);//���߷��� OS>>WS
                o.bDirWS=normalize(cross(o.normalDir_WorldSpace,o.tDirWS)*v.tangent.w);//����nDirWS,tDirWS��bDirWS
                
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                 //׼������
                fixed3 nDirTS=UnpackNormal(tex2D(_NormalMap,i.uv)).rgb;
                float3x3 TBN=float3x3(i.tDirWS,i.bDirWS,i.normalDir_WorldSpace);
                float3 nDirWS= normalize(mul(nDirTS,TBN));//����Fresnel ����vrDirWS
               // float3 vDirWS=normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);//����Fresnel
                float3 viewDir = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 vrDirWS=reflect(-viewDir,nDirWS);

                fixed3 normalDir=normalize( i.normalDir_WorldSpace);
                fixed3 lightDir=normalize(WorldSpaceLightDir(fixed4( i.light,0)).xyz);

                float3 lambert=max(0,dot(i.normalDir_WorldSpace,normalize(_WorldSpaceLightPos0.xyz)))*_BaseCol;
                float phong=pow(max(0,dot(reflect(-lightDir,normalDir),viewDir)),_SpecPow);

                //������Ӱ
                float attenuation = LIGHT_ATTENUATION(i);
                float3 shadow=(lambert+phong)*_LightCol*attenuation;

                                // �������λ����
                float upMask=max(0.0,normalDir.g);// ��ȡ���ϲ�������
                float downMask=max(0.0,-normalDir.g);// ��ȡ���²�������
                float sideMask=1.0-upMask-downMask;// ��ȡ���沿������
                // ��ϻ���ɫ
                float3 envCol=_EnvUpCol*upMask + _EnvSideCol*sideMask + _EnvDownCol*downMask;
                // ����Occlusion��ͼ(����OA����)
                float occlusion=tex2D(_Occlusion,i.uv).a;
                //����������ͼ����
                float var_EmitTex=tex2D(_EmitTex,i.uv);

                float var_SpecTex=tex2D(_SpecTex,i.uv).a;

                float3 var_Cubemap=texCUBElod(_CubeMap,float4(vrDirWS,_CubeMapMid)).rgb;

                float fresnel = pow(max(0.0,1.0-dot(viewDir,nDirWS)),_FresnelPow);
                float3 cubemapCol =var_Cubemap*fresnel*_EnvSpecInt*var_SpecTex;
                // ���㻷������
                float3 envLight=(envCol*_EnvVal*_BaseCol+cubemapCol)*occlusion;
                //����ģ��(�Է��ⲿ��)
                float3 emission=_EmitInt*var_EmitTex;

                float3 finalColor =shadow+ envLight+emission;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
    CustomEditor "ShaderForgeMaterialInspector"
}
