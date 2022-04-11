// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Quantum Theory/PBR - Rome Wall Multicolored"
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
Version=14301
108;150;1398;819;3970.166;1567.682;2.901039;True;False
Node;AmplifyShaderEditor.VertexColorNode;10;-3712.042,-669.4631;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;6;-3300.97,-1750.947;Float;False;Property;_ColorA;Color A;4;0;Create;True;1,0,0,0;1,1,1,0.484;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;11;-3298.932,-1588.717;Float;False;Property;_ColorB;Color B;5;0;Create;True;0,1,0,0;0.5073529,0.26052,0.07088017,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;14;-3295.735,-1413.051;Float;False;Property;_ColorC;Color C;6;0;Create;True;0,0,1,0;1,1,1,0.472;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-2848.856,-1514.112;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-2842.045,-1629.342;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-4079.592,-9.996277;Float;False;Property;_AgeMapContrast;Age Map Contrast;7;0;Create;True;0;0.095;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;35;-3914.536,73.74438;Float;False;Constant;_Float3;Float 3;7;0;Create;True;5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;30;-4327.819,-293.2986;Float;True;Property;_GreyscaleAgeMap;Greyscale Age Map;3;0;Create;True;None;d53a1745260bd0e448df9907dac1f929;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-2854.467,-1403.2;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;13;-2657.87,-1550.246;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;29;-3924.777,-186.1086;Float;False;Constant;_Float1;Float 1;5;0;Create;True;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;28;-3767.095,-105.5309;Float;False;2;0;FLOAT;0,0,0,0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;-3766.232,3.098202;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;16;-2506.087,-1407.879;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-3603.01,-36.28038;Float;False;2;2;0;FLOAT;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ComponentMaskNode;77;-2454.325,-760.5648;Float;False;False;False;False;True;1;0;COLOR;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;93;-3479.232,-404.9762;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;5.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;36;-3439.341,-154.6082;Float;False;2;2;0;FLOAT;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;94;-3237.263,-157.0829;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;91;-3049.129,-139.9823;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;72;-2865.476,-155.7041;Float;False;219;183;AO multiply;1;43;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;38;-3153.113,164.1122;Float;True;Property;_Material;Material;2;0;Create;True;None;9fbea323e2eb20e40b95831fdb3b09eb;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-1918.974,-1337.494;Float;True;Property;_BaseColor;Base Color;0;0;Create;True;None;5cae5750e8f66a241b4e18efdac488e1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-2815.476,-105.7042;Float;False;2;2;0;FLOAT;0,0,0,0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;23;-3126.207,-577.0586;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-1565.68,-1425.454;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;46;-1528.385,-323.9191;Float;False;Property;_PaintGlossiness;Paint Glossiness;8;0;Create;True;0;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;45;-2463.496,-294.11;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;50;-1322.21,324.4493;Float;True;Property;_NormalMap;Normal Map;1;0;Create;True;None;168f53c08f490184ea53c01672f45521;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;54;-1369.731,-1320.891;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;76;-1226.55,-222.5484;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-789.0698,-208.0267;Float;False;True;2;Float;;0;0;Standard;Quantum Theory/PBR - Rome Wall Multicolored;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;False;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;12;0;11;0
WireConnection;12;1;10;2
WireConnection;9;0;6;0
WireConnection;9;1;10;1
WireConnection;15;0;14;0
WireConnection;15;1;10;3
WireConnection;13;0;9;0
WireConnection;13;1;12;0
WireConnection;28;0;30;2
WireConnection;28;1;29;0
WireConnection;34;0;33;0
WireConnection;34;1;35;0
WireConnection;16;0;13;0
WireConnection;16;1;15;0
WireConnection;31;0;28;0
WireConnection;31;1;34;0
WireConnection;77;0;16;0
WireConnection;93;0;77;0
WireConnection;36;0;31;0
WireConnection;36;1;29;0
WireConnection;94;0;36;0
WireConnection;94;1;93;0
WireConnection;91;0;94;0
WireConnection;43;0;91;0
WireConnection;43;1;38;2
WireConnection;23;0;10;4
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
//CHKSM=AC35061515224C7E7C0E8CA1695C82E1CE92E8FC