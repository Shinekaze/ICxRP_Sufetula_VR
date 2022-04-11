// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Quantum Theory/PBR - Rome Wall Decal Multicolored"
{
	Properties
	{
		_BaseColor("Base Color", 2D) = "white" {}
		_NormalMap("Normal Map", 2D) = "bump" {}
		_Material("Material", 2D) = "black" {}
		_GreyscaleAgeMap("Greyscale Age Map", 2D) = "white" {}
		_ColorA("Color A", Color) = (1,0,0,0)
		_ColorB("Color B", Color) = (0,1,0,0)
		_ColorC("Color C", Color) = (0,0,1,0)
		_AgeMapContrast("Age Map Contrast", Range( 0 , 1)) = 0
		_PaintGlossiness("Paint Glossiness", Range( 0 , 1)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" }
		Cull Back
		Offset  -1 , -2
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
			float4 vertexColor : COLOR;
		};

		uniform sampler2D _NormalMap;
		uniform float4 _NormalMap_ST;
		uniform sampler2D _BaseColor;
		uniform float4 _BaseColor_ST;
		uniform float4 _ColorA;
		uniform float4 _ColorB;
		uniform float4 _ColorC;
		uniform sampler2D _GreyscaleAgeMap;
		uniform float4 _GreyscaleAgeMap_ST;
		uniform float _AgeMapContrast;
		uniform sampler2D _Material;
		uniform float4 _Material_ST;
		uniform float _PaintGlossiness;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			o.Normal = UnpackNormal( tex2D( _NormalMap, uv_NormalMap ) );
			float2 uv_BaseColor = i.uv_texcoord * _BaseColor_ST.xy + _BaseColor_ST.zw;
			float4 tex2DNode3 = tex2D( _BaseColor, uv_BaseColor );
			float4 temp_output_16_0 = ( ( ( _ColorA * i.vertexColor.r ) + ( _ColorB * i.vertexColor.g ) ) + ( _ColorC * i.vertexColor.b ) );
			float2 uv_GreyscaleAgeMap = i.uv_texcoord * _GreyscaleAgeMap_ST.xy + _GreyscaleAgeMap_ST.zw;
			float2 uv_Material = i.uv_texcoord * _Material_ST.xy + _Material_ST.zw;
			float4 tex2DNode38 = tex2D( _Material, uv_Material );
			float temp_output_45_0 = ( ( 1.0 - i.vertexColor.a ) * ( saturate( ( ( ( ( tex2D( _GreyscaleAgeMap, uv_GreyscaleAgeMap ).g - 0.5 ) * ( _AgeMapContrast * 5.0 ) ) + 0.5 ) * ( (temp_output_16_0).a * 5.0 ) ) ) * tex2DNode38.g ) );
			float4 lerpResult54 = lerp( tex2DNode3 , ( tex2DNode3 * temp_output_16_0 ) , temp_output_45_0);
			o.Albedo = lerpResult54.rgb;
			o.Metallic = tex2DNode38.r;
			float lerpResult76 = lerp( tex2DNode38.a , _PaintGlossiness , temp_output_45_0);
			o.Smoothness = lerpResult76;
			o.Occlusion = tex2DNode38.g;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=16301
2330;38;1503;1115;4119.714;2691.296;2.279229;True;True
Node;AmplifyShaderEditor.ColorNode;6;-3333.265,-1729.482;Float;False;Property;_ColorA;Color A;4;0;Create;True;0;0;False;0;1,0,0,0;0.7867647,0.5499714,0.3933823,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;11;-3289.668,-1584.867;Float;False;Property;_ColorB;Color B;5;0;Create;True;0;0;False;0;0,1,0,0;0.9632353,0.9373235,0.7861702,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;10;-3712.042,-669.4631;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-2878.161,-1535.066;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-2883.042,-1643.337;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;14;-3295.735,-1413.051;Float;False;Property;_ColorC;Color C;6;0;Create;True;0;0;False;0;0,0,1,0;0.6911764,0.6251082,0.6671517,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;13;-2694.694,-1579.339;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-4225.579,56.37645;Float;False;Constant;_Float3;Float 3;7;0;Create;True;0;0;False;0;5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-4002.144,-127.6892;Float;False;Constant;_Float1;Float 1;5;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;30;-4327.819,-293.2986;Float;True;Property;_GreyscaleAgeMap;Greyscale Age Map;3;0;Create;True;0;0;False;0;None;d53a1745260bd0e448df9907dac1f929;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;33;-4313.269,-46.31102;Float;False;Property;_AgeMapContrast;Age Map Contrast;7;0;Create;True;0;0;False;0;0;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-2854.467,-1403.2;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;16;-2561.351,-1423.448;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;-3913.069,45.72855;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;28;-3772.177,-159.9519;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-3603.01,-36.28038;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;77;-2454.325,-760.5648;Float;False;False;False;False;True;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;93;-3465.556,-261.3848;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;36;-3411.965,-112.5506;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;94;-3251.983,-217.5389;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;72;-2847.23,-208.9924;Float;False;219;183;AO multiply;1;43;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;38;-3153.113,164.1122;Float;True;Property;_Material;Material;2;0;Create;True;0;0;False;0;None;f9016f14b7eec314d8b23421a730250d;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;91;-3038.077,-181.0338;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;23;-3126.207,-577.0586;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;3;-1918.974,-1337.494;Float;True;Property;_BaseColor;Base Color;0;0;Create;True;0;0;False;0;None;542058ef3a133d9429018a5de9243a8d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-2797.23,-158.9924;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-1552.182,-1470.446;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;46;-1528.385,-323.9191;Float;False;Property;_PaintGlossiness;Paint Glossiness;8;0;Create;True;0;0;False;0;0;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;-2463.496,-294.11;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;54;-1369.731,-1320.891;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;50;-1322.21,324.4493;Float;True;Property;_NormalMap;Normal Map;1;0;Create;True;0;0;False;0;None;20685e092f7090641b057aab4ff6b4bc;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;76;-1226.55,-222.5484;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-789.0698,-208.0267;Float;False;True;2;Float;;0;0;Standard;Quantum Theory/PBR - Rome Wall Decal Multicolored;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;True;-1;False;-1;-2;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;0;4;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;1;False;-1;1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;12;0;11;0
WireConnection;12;1;10;2
WireConnection;9;0;6;0
WireConnection;9;1;10;1
WireConnection;13;0;9;0
WireConnection;13;1;12;0
WireConnection;15;0;14;0
WireConnection;15;1;10;3
WireConnection;16;0;13;0
WireConnection;16;1;15;0
WireConnection;34;0;33;0
WireConnection;34;1;35;0
WireConnection;28;0;30;2
WireConnection;28;1;29;0
WireConnection;31;0;28;0
WireConnection;31;1;34;0
WireConnection;77;0;16;0
WireConnection;93;0;77;0
WireConnection;36;0;31;0
WireConnection;36;1;29;0
WireConnection;94;0;36;0
WireConnection;94;1;93;0
WireConnection;91;0;94;0
WireConnection;23;0;10;4
WireConnection;43;0;91;0
WireConnection;43;1;38;2
WireConnection;22;0;3;0
WireConnection;22;1;16;0
WireConnection;45;0;23;0
WireConnection;45;1;43;0
WireConnection;54;0;3;0
WireConnection;54;1;22;0
WireConnection;54;2;45;0
WireConnection;76;0;38;4
WireConnection;76;1;46;0
WireConnection;76;2;45;0
WireConnection;0;0;54;0
WireConnection;0;1;50;0
WireConnection;0;3;38;1
WireConnection;0;4;76;0
WireConnection;0;5;38;2
ASEEND*/
//CHKSM=E8928D41D856A9D189F7BC5E60AB2A327EAC884A