// Made with Amplify Shader Editor v1.9.1.7
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Fairplex/Standard Opaque + Lightmap"
{
	Properties
	{
		[HDR][SingleLineTexture]_Diffuse("Diffuse", 2D) = "black" {}
		[Toggle(_USINGCOLOR_ON)] _UsingColor("Using Color", Float) = 0
		_Color("Color", Color) = (0,0,0,0)
		[NoScaleOffset][Normal][SingleLineTexture]_Normal("Normal", 2D) = "bump" {}
		[Toggle(_EMISSIVE_ON)] _Emissive("Emissive", Float) = 0
		[HDR][SingleLineTexture]_Emission("Emission", 2D) = "black" {}
		_MetallicStrength("Metallic Strength", Range( 0 , 1)) = 0
		_SmoothnessStrength("Smoothness Strength", Range( 0 , 1)) = 0
		[Toggle(_USINGLIGHTMAP_ON)] _UsingLightmap("Using Lightmap", Float) = 0
		[HDR][NoScaleOffset][SingleLineTexture]_LightmapTexture("Lightmap Texture", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
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
		#pragma target 3.5
		#pragma shader_feature _SPECULARHIGHLIGHTS_OFF
		#pragma shader_feature _GLOSSYREFLECTIONS_OFF
		#pragma shader_feature_local _EMISSIVE_ON
		#pragma shader_feature_local _USINGLIGHTMAP_ON
		#pragma shader_feature_local _USINGCOLOR_ON
		#pragma surface surf Standard keepalpha noshadow nodynlightmap nodirlightmap nofog 
		struct Input
		{
			float2 uv_texcoord;
			float2 uv2_texcoord2;
		};

		uniform sampler2D _Normal;
		uniform sampler2D _Diffuse;
		uniform half4 _Diffuse_ST;
		uniform half4 _Color;
		uniform sampler2D _LightmapTexture;
		uniform sampler2D _Emission;
		uniform half4 _Emission_ST;
		uniform half _MetallicStrength;
		uniform half _SmoothnessStrength;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_Normal605 = i.uv_texcoord;
			o.Normal = UnpackNormal( tex2D( _Normal, uv_Normal605 ) );
			float2 uv_Diffuse = i.uv_texcoord * _Diffuse_ST.xy + _Diffuse_ST.zw;
			#ifdef _USINGCOLOR_ON
				half4 staticSwitch629 = _Color;
			#else
				half4 staticSwitch629 = tex2D( _Diffuse, uv_Diffuse );
			#endif
			float2 uv1_LightmapTexture638 = i.uv2_texcoord2;
			#ifdef _USINGLIGHTMAP_ON
				half4 staticSwitch641 = ( staticSwitch629 * tex2D( _LightmapTexture, uv1_LightmapTexture638 ) );
			#else
				half4 staticSwitch641 = staticSwitch629;
			#endif
			float2 uv_Emission = i.uv_texcoord * _Emission_ST.xy + _Emission_ST.zw;
			#ifdef _EMISSIVE_ON
				half4 staticSwitch632 = ( staticSwitch641 + tex2D( _Emission, uv_Emission ) );
			#else
				half4 staticSwitch632 = staticSwitch641;
			#endif
			o.Albedo = staticSwitch632.rgb;
			o.Emission = staticSwitch632.rgb;
			o.Metallic = _MetallicStrength;
			o.Smoothness = _SmoothnessStrength;
			o.Alpha = 1;
		}

		ENDCG
	}
}
/*ASEBEGIN
Version=19107
Node;AmplifyShaderEditor.RangedFloatNode;618;-128,-128;Inherit;False;Property;_MetallicStrength;Metallic Strength;6;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;619;-128,-32;Inherit;False;Property;_SmoothnessStrength;Smoothness Strength;7;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;632;0,-512;Inherit;False;Property;_Emissive;Emissive;4;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;639;-1056,-833.8062;Inherit;True;Property;_Diffuse;Diffuse;0;2;[HDR];[SingleLineTexture];Create;True;0;0;0;False;0;False;-1;None;49b8f70b1cb8f5b4e951412ef88a1fb0;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;609;-1056,-609.8062;Inherit;False;Property;_Color;Color;2;0;Create;False;0;0;0;False;0;False;0,0,0,0;1,1,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;343;304,-512;Half;False;True;-1;3;;0;0;Standard;Fairplex/Standard Opaque + Lightmap;False;False;False;False;False;False;False;True;True;True;False;False;False;False;False;False;False;False;True;True;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;0;Opaque;0.5;True;False;0;False;Opaque;;Geometry;All;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;False;0;5;False;;10;False;;0;0;False;;0;False;;0;False;;0;False;;0;False;0.02;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;0;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.SamplerNode;638;-1024,-384;Inherit;True;Property;_LightmapTexture;Lightmap Texture;9;3;[HDR];[NoScaleOffset];[SingleLineTexture];Create;True;0;0;0;False;0;False;-1;None;a69e5eacdec84fb4aacaca3404c9c38d;True;1;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;0,0;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;631;-1024,-128;Inherit;True;Property;_Emission;Emission;5;2;[HDR];[SingleLineTexture];Create;True;0;0;0;False;0;False;-1;None;fb461a3260deb46438efcff9274cf04a;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;605;-32,-768;Inherit;True;Property;_Normal;Normal;3;3;[NoScaleOffset];[Normal];[SingleLineTexture];Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;641;-336,-640;Inherit;False;Property;_UsingLightmap;Using Lightmap;8;0;Create;True;0;0;0;False;0;False;0;0;1;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StaticSwitch;629;-704,-640;Inherit;False;Property;_UsingColor;Using Color;1;0;Create;True;0;0;0;False;0;False;0;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;COLOR;0,0,0,0;False;0;COLOR;0,0,0,0;False;2;COLOR;0,0,0,0;False;3;COLOR;0,0,0,0;False;4;COLOR;0,0,0,0;False;5;COLOR;0,0,0,0;False;6;COLOR;0,0,0,0;False;7;COLOR;0,0,0,0;False;8;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;640;-465.5003,-484.6996;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;635;-142.2,-396.9999;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
WireConnection;632;1;641;0
WireConnection;632;0;635;0
WireConnection;343;0;632;0
WireConnection;343;1;605;0
WireConnection;343;2;632;0
WireConnection;343;3;618;0
WireConnection;343;4;619;0
WireConnection;641;1;629;0
WireConnection;641;0;640;0
WireConnection;629;1;639;0
WireConnection;629;0;609;0
WireConnection;640;0;629;0
WireConnection;640;1;638;0
WireConnection;635;0;641;0
WireConnection;635;1;631;0
ASEEND*/
//CHKSM=480706582F2524E785DC6CF505E3779B174BF97D