// Made with Amplify Shader Editor v1.9.1.8
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Fairplex/Mirror"
{
	Properties
	{
		[HideInInspector]_ReflectionTex0("_ReflectionTex0", 2D) = "white" {}
		[HideInInspector]_ReflectionTex1("_ReflectionTex1", 2D) = "white" {}
		_Metallic("Metallic", Range( 0 , 1)) = 0
		_Smoothness("Smoothness", Range( 0 , 1)) = 0
		[Toggle(_USECUSTOMNORMAL_ON)] _UseCustomNormal("Use Custom Normal", Float) = 0
		[NoScaleOffset][SingleLineTexture]_NormalMap1("Normal Map", 2D) = "bump" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
		[Header(Forward Rendering Options)]
		[ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		[ToggleOff] _GlossyReflections("Reflections", Float) = 1.0
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#include "UnityCG.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature _SPECULARHIGHLIGHTS_OFF
		#pragma shader_feature _GLOSSYREFLECTIONS_OFF
		#pragma shader_feature_local _USECUSTOMNORMAL_ON
		#pragma surface surf Standard keepalpha noshadow 
		#undef TRANSFORM_TEX
		#define TRANSFORM_TEX(tex,name) float4(tex.xy * name##_ST.xy + name##_ST.zw, tex.z, tex.w)
		struct Input
		{
			float3 worldPos;
			float2 uv_texcoord;
			float4 uv2_texcoord2;
		};

		uniform sampler2D _ReflectionTex1;
		uniform sampler2D _NormalMap1;
		uniform sampler2D _ReflectionTex0;
		uniform float _Metallic;
		uniform float _Smoothness;


		float StereoEyeIndex160(  )
		{
			 return unity_StereoEyeIndex;
		}


		float2 UnStereo( float2 UV )
		{
			#if UNITY_SINGLE_PASS_STEREO
			float4 scaleOffset = unity_StereoScaleOffset[ unity_StereoEyeIndex ];
			UV.xy = (UV.xy - scaleOffset.zw) / scaleOffset.xy;
			#endif
			return UV;
		}


		float4 ProjectionCoordinates152( float4 In )
		{
			 return UNITY_PROJ_COORD(In);
		}


		float4 Tex2DProjection159( sampler2D TD, float4 F4 )
		{
			 return tex2Dproj(TD, F4);
		}


		float4 Tex2DProjection158( sampler2D TD, float4 F4 )
		{
			 return tex2Dproj(TD, F4);
		}


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float localStereoEyeIndex160 = StereoEyeIndex160();
			sampler2D TD159 = _ReflectionTex1;
			float4 ase_vertex4Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float4 unityObjectToClipPos737 = UnityObjectToClipPos( ase_vertex4Pos.xyz );
			float4 computeScreenPos738 = ComputeScreenPos( unityObjectToClipPos737 );
			computeScreenPos738 = computeScreenPos738 / computeScreenPos738.w;
			computeScreenPos738.z = ( UNITY_NEAR_CLIP_VALUE >= 0 ) ? computeScreenPos738.z : computeScreenPos738.z* 0.5 + 0.5;
			float2 uv_NormalMap1806 = i.uv_texcoord;
			#ifdef _USECUSTOMNORMAL_ON
				float4 staticSwitch810 = ( computeScreenPos738 + float4( -UnpackNormal( tex2D( _NormalMap1, uv_NormalMap1806 ) ) , 0.0 ) );
			#else
				float4 staticSwitch810 = computeScreenPos738;
			#endif
			float2 UV22_g39 = staticSwitch810.xy;
			float2 localUnStereo22_g39 = UnStereo( UV22_g39 );
			float4 appendResult148 = (float4(localUnStereo22_g39 , i.uv2_texcoord2.z , i.uv2_texcoord2.w));
			float4 In152 = appendResult148;
			float4 localProjectionCoordinates152 = ProjectionCoordinates152( In152 );
			float4 F4159 = localProjectionCoordinates152;
			float4 localTex2DProjection159 = Tex2DProjection159( TD159 , F4159 );
			sampler2D TD158 = _ReflectionTex0;
			float4 F4158 = localProjectionCoordinates152;
			float4 localTex2DProjection158 = Tex2DProjection158( TD158 , F4158 );
			float4 ifLocalVar166 = 0;
			if( localStereoEyeIndex160 == 0.0 )
				ifLocalVar166 = localTex2DProjection158;
			else
				ifLocalVar166 = localTex2DProjection159;
			float4 Reflections171 = ifLocalVar166;
			o.Emission = Reflections171.xyz;
			o.Metallic = _Metallic;
			o.Smoothness = _Smoothness;
			o.Alpha = 1;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=19108
Node;AmplifyShaderEditor.CommentaryNode;743;-4274,-434;Inherit;False;3010;840;Comment;18;146;147;148;152;156;153;160;158;159;166;171;736;737;738;806;805;807;810;Reflection;0,0.5698133,1,1;0;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;566;640,-160;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Fairplex/Mirror;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;True;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;False;0;0;False;;0;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.GetLocalVarNode;369;192,-192;Inherit;False;171;Reflections;1;0;OBJECT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RangedFloatNode;568;192,-80;Inherit;False;Property;_Metallic;Metallic;2;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;569;192,0;Inherit;False;Property;_Smoothness;Smoothness;3;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;146;-3024,48;Inherit;False;1;-1;4;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DynamicAppendNode;148;-2640,-80;Inherit;False;FLOAT4;4;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TexturePropertyNode;153;-2384,176;Inherit;True;Property;_ReflectionTex1;_ReflectionTex1;1;1;[HideInInspector];Create;False;0;0;0;False;0;False;None;None;False;white;LockedToTexture2D;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.CustomExpressionNode;160;-2064,-208;Inherit;False; return unity_StereoEyeIndex@;1;Create;0;Stereo Eye Index;True;False;0;;False;0;1;FLOAT;0
Node;AmplifyShaderEditor.CustomExpressionNode;158;-2064,-80;Inherit;False; return tex2Dproj(TD, F4)@;4;Create;2;True;TD;SAMPLER2D;_Sampler0158;In;;Inherit;False;True;F4;FLOAT4;0,0,0,0;In;;Inherit;False;Tex2DProjection;True;False;0;;False;2;0;SAMPLER2D;_Sampler0158;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CustomExpressionNode;159;-2064,96;Inherit;False; return tex2Dproj(TD, F4)@;4;Create;2;True;TD;SAMPLER2D;_Sampler0159;In;;Inherit;False;True;F4;FLOAT4;0,0,0,0;In;;Inherit;False;Tex2DProjection;True;False;0;;False;2;0;SAMPLER2D;_Sampler0159;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ConditionalIfNode;166;-1808,-80;Inherit;False;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;171;-1488,-80;Inherit;False;Reflections;-1;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.PosVertexDataNode;736;-4224,-128;Inherit;True;1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.UnityObjToClipPosHlpNode;737;-3936,-128;Inherit;True;1;0;FLOAT3;0,0,0;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ComputeScreenPosHlpNode;738;-3648,-128;Inherit;True;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.FunctionNode;147;-2928,-80;Inherit;False;Non Stereo Screen Pos;-1;;39;1731ee083b93c104880efc701e11b49b;0;1;23;FLOAT4;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;807;-3396.051,59.51494;Inherit;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.NegateNode;805;-3584,160;Inherit;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SamplerNode;806;-4000.163,154.4901;Inherit;True;Property;_NormalMap1;Normal Map;5;2;[NoScaleOffset];[SingleLineTexture];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;810;-3228.834,-83.4171;Inherit;False;Property;_UseCustomNormal;Use Custom Normal;4;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.CustomExpressionNode;152;-2384,-80;Inherit;False; return UNITY_PROJ_COORD(In)@;4;Create;1;True;In;FLOAT4;0,0,0,0;In;;Inherit;False;Projection Coordinates;True;False;0;;False;1;0;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TexturePropertyNode;156;-2384,-336;Inherit;True;Property;_ReflectionTex0;_ReflectionTex0;0;1;[HideInInspector];Create;False;0;0;0;False;0;False;None;None;False;white;LockedToTexture2D;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
WireConnection;566;2;369;0
WireConnection;566;3;568;0
WireConnection;566;4;569;0
WireConnection;148;0;147;0
WireConnection;148;2;146;3
WireConnection;148;3;146;4
WireConnection;158;0;156;0
WireConnection;158;1;152;0
WireConnection;159;0;153;0
WireConnection;159;1;152;0
WireConnection;166;0;160;0
WireConnection;166;2;159;0
WireConnection;166;3;158;0
WireConnection;166;4;159;0
WireConnection;171;0;166;0
WireConnection;737;0;736;0
WireConnection;738;0;737;0
WireConnection;147;23;810;0
WireConnection;807;0;738;0
WireConnection;807;1;805;0
WireConnection;805;0;806;0
WireConnection;810;1;738;0
WireConnection;810;0;807;0
WireConnection;152;0;148;0
ASEEND*/
//CHKSM=BB862638F445196FA245C956A082C9286576CAA6