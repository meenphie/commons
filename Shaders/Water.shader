// Made with Amplify Shader Editor v1.9.1.8
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Fairplex/Water"
{
	Properties
	{
		_Color("Color", Color) = (0,0,0,0)
		[NoScaleOffset][Normal]_Normalmap("Normalmap", 2D) = "bump" {}
		_Scale("Scale", Float) = 0
		_NormalStrenght("Normal Strenght", Range( 0 , 1)) = 1
		_Speed("Speed", Range( 0 , 5)) = 0.1
		_Metalness("Metalness", Range( 0 , 1)) = 0
		_Smoothness("Smoothness", Range( 0 , 1)) = 0
		[HideInInspector] __dirty( "", Int ) = 1
		[Header(Forward Rendering Options)]
		[ToggleOff] _SpecularHighlights("Specular Highlights", Float) = 1.0
		[ToggleOff] _GlossyReflections("Reflections", Float) = 1.0
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 4.6
		#pragma shader_feature _SPECULARHIGHLIGHTS_OFF
		#pragma shader_feature _GLOSSYREFLECTIONS_OFF
		#pragma surface surf Standard keepalpha noshadow exclude_path:deferred nolightmap  nodynlightmap nodirlightmap nofog nometa noforwardadd  
		struct Input
		{
			float3 worldPos;
			float3 worldNormal;
			INTERNAL_DATA
		};

		uniform sampler2D _Normalmap;
		uniform float _Speed;
		uniform float _Scale;
		uniform float _NormalStrenght;
		uniform float4 _Color;
		uniform float _Metalness;
		uniform float _Smoothness;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float mulTime134 = _Time.y * 0.1;
			float2 temp_cast_0 = (_Speed).xx;
			float3 ase_worldPos = i.worldPos;
			float2 appendResult527 = (float2(ase_worldPos.x , ase_worldPos.z));
			float2 _worldUV528 = ( appendResult527 / _Scale );
			float2 panner138 = ( mulTime134 * temp_cast_0 + _worldUV528);
			float3 ase_worldViewDir = normalize( UnityWorldSpaceViewDir( ase_worldPos ) );
			float3 ase_worldNormal = WorldNormalVector( i, float3( 0, 0, 1 ) );
			float fresnelNdotV486 = dot( ase_worldNormal, ase_worldViewDir );
			float fresnelNode486 = ( 0.1 + 3.0 * pow( 1.0 - fresnelNdotV486, 6.0 ) );
			float clampResult521 = clamp( fresnelNode486 , 0.0 , 1.0 );
			float Fresnel487 = clampResult521;
			float temp_output_519_0 = ( Fresnel487 * _NormalStrenght );
			float2 temp_cast_1 = (_Speed).xx;
			float cos132 = cos( (float)radians( 170 ) );
			float sin132 = sin( (float)radians( 170 ) );
			float2 rotator132 = mul( _worldUV528 - float2( 1,1 ) , float2x2( cos132 , -sin132 , sin132 , cos132 )) + float2( 1,1 );
			float2 panner137 = ( mulTime134 * temp_cast_1 + rotator132);
			float3 Normals145 = BlendNormals( UnpackScaleNormal( tex2D( _Normalmap, panner138 ), temp_output_519_0 ) , UnpackScaleNormal( tex2D( _Normalmap, -( panner137 * float2( 1.5,1 ) ) ), temp_output_519_0 ) );
			o.Normal = Normals145;
			o.Albedo = _Color.rgb;
			o.Metallic = _Metalness;
			o.Smoothness = _Smoothness;
			o.Alpha = 1;
		}

		ENDCG
	}
}
/*ASEBEGIN
Version=19108
Node;AmplifyShaderEditor.CommentaryNode;530;-3440,-1936;Inherit;False;834;294;;5;524;525;526;527;528;World UV;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;128;-3456,-1504;Inherit;False;2155.463;943.6183;;17;145;144;142;141;138;137;132;133;134;130;129;517;518;519;520;522;529;Normals;0,0.289319,1,1;0;0
Node;AmplifyShaderEditor.SimpleTimeNode;134;-3024,-1232;Inherit;False;1;0;FLOAT;0.1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;133;-3088,-1424;Inherit;False;Property;_Speed;Speed;4;0;Create;True;0;0;0;False;0;False;0.1;0.5;0;5;0;1;FLOAT;0
Node;AmplifyShaderEditor.BlendNormalsNode;144;-2016,-1264;Inherit;True;0;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.CommentaryNode;482;-3456,-432;Inherit;False;946.8096;475.3102;;6;487;521;502;501;485;486;Fresnel;0,0.8587363,1,1;0;0
Node;AmplifyShaderEditor.FresnelNode;486;-3216,-288;Inherit;False;Standard;WorldNormal;ViewDir;False;False;5;0;FLOAT3;0,0,1;False;4;FLOAT3;0,0,0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;640,-160;Float;False;True;-1;6;;0;0;Standard;Fairplex/Water;False;False;False;False;False;False;True;True;True;True;True;True;False;False;False;False;False;False;True;True;False;Back;0;False;;0;False;;False;0;False;;0;False;;False;7;Opaque;0.5;True;False;0;False;Opaque;;Geometry;ForwardOnly;12;all;True;True;True;True;0;False;;False;0;False;;255;False;;255;False;;2;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;0;False;;False;2;15;10;25;False;0.5;False;0;5;False;;10;False;;0;1;False;;2;False;;0;False;;0;False;;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;;-1;0;False;;0;1;;0;False;0.1;False;;0;False;;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
Node;AmplifyShaderEditor.RangedFloatNode;511;128,64;Inherit;False;Property;_Metalness;Metalness;5;0;Create;True;0;0;0;False;0;False;0;0.75;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;500;128,144;Inherit;False;Property;_Smoothness;Smoothness;6;0;Create;True;0;0;0;False;0;False;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;469;272,-112;Inherit;False;145;Normals;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ColorNode;516;224,-353;Inherit;False;Property;_Color;Color;0;0;Create;True;0;0;0;False;0;False;0,0,0,0;0.07499955,0.1137091,0.1499994,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;145;-1648,-1171.491;Inherit;False;Normals;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PannerNode;138;-2752,-1376;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.GetLocalVarNode;517;-2742.715,-1209.286;Inherit;False;487;Fresnel;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;518;-2816,-896;Inherit;False;Property;_NormalStrenght;Normal Strenght;3;0;Create;True;0;0;0;False;0;False;1;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;129;-3424,-1024;Inherit;False;Constant;_Int0;Int 0;7;0;Create;True;0;0;0;False;0;False;170;175;False;0;1;INT;0
Node;AmplifyShaderEditor.RadiansOpNode;130;-3264,-1024;Inherit;False;1;0;INT;0;False;1;INT;0
Node;AmplifyShaderEditor.SamplerNode;141;-2384,-1184;Inherit;True;Property;_TextureSample3;Texture Sample 3;1;1;[HideInInspector];Create;True;0;0;0;False;0;False;-1;None;None;True;0;True;bump;Auto;True;Instance;142;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;0.5;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;487;-2736,-256;Inherit;False;Fresnel;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;521;-2944,-256;Inherit;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RotatorNode;132;-3072,-1121;Inherit;False;3;0;FLOAT2;10,0;False;1;FLOAT2;1,1;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.PannerNode;137;-2752,-1104;Inherit;False;3;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;1;FLOAT;1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;519;-2543.844,-1210.148;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;520;-2544,-1088;Inherit;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;522;-2544,-1024;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;1.5,1;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;501;-3424,-256;Inherit;False;Constant;_Float2;Float 2;12;0;Create;True;0;0;0;False;0;False;3;3;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;485;-3424,-336;Inherit;False;Constant;_Float1;Float 1;11;0;Create;True;0;0;0;False;0;False;0.1;0.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;502;-3424,-160;Inherit;False;Constant;_Float3;Float 3;13;0;Create;True;0;0;0;False;0;False;6;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;529;-3328,-1280;Inherit;False;528;_worldUV;1;0;OBJECT;;False;1;FLOAT2;0
Node;AmplifyShaderEditor.WorldPosInputsNode;524;-3392,-1888;Inherit;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleDivideOpNode;525;-3008,-1888;Inherit;False;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;527;-3184,-1888;Inherit;False;FLOAT2;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;528;-2832,-1888;Inherit;False;_worldUV;-1;True;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;142;-2384,-1376;Inherit;True;Property;_Normalmap;Normalmap;1;2;[NoScaleOffset];[Normal];Create;False;0;0;0;False;0;False;-1;None;5cb9eae924c3a9c4a835886067ad65cb;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;526;-3184,-1760;Inherit;False;Property;_Scale;Scale;2;0;Create;True;0;0;0;False;0;False;0;4;0;0;0;1;FLOAT;0
WireConnection;144;0;142;0
WireConnection;144;1;141;0
WireConnection;486;1;485;0
WireConnection;486;2;501;0
WireConnection;486;3;502;0
WireConnection;0;0;516;0
WireConnection;0;1;469;0
WireConnection;0;3;511;0
WireConnection;0;4;500;0
WireConnection;145;0;144;0
WireConnection;138;0;529;0
WireConnection;138;2;133;0
WireConnection;138;1;134;0
WireConnection;130;0;129;0
WireConnection;141;1;520;0
WireConnection;141;5;519;0
WireConnection;487;0;521;0
WireConnection;521;0;486;0
WireConnection;132;0;529;0
WireConnection;132;2;130;0
WireConnection;137;0;132;0
WireConnection;137;2;133;0
WireConnection;137;1;134;0
WireConnection;519;0;517;0
WireConnection;519;1;518;0
WireConnection;520;0;522;0
WireConnection;522;0;137;0
WireConnection;525;0;527;0
WireConnection;525;1;526;0
WireConnection;527;0;524;1
WireConnection;527;1;524;3
WireConnection;528;0;525;0
WireConnection;142;1;138;0
WireConnection;142;5;519;0
ASEEND*/
//CHKSM=6675E793E8A61C16829709F5878A980FCA9F12B6