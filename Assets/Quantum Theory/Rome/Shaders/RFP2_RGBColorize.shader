// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Quantum Theory/PBR - Rome RGB Colorize"
{
	Properties
	{
		_BaseColor("Base Color", 2D) = "white" {}
		_NormalMap("Normal Map", 2D) = "bump" {}
		_Material("Material", 2D) = "black" {}
		_ColorA("Color A", Color) = (1,0,0,0)
		_ColorB("Color B", Color) = (0,1,0,0)
		_ColorC("Color C", Color) = (0,0,1,0)
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
		};

		uniform sampler2D _NormalMap;
		uniform float4 _NormalMap_ST;
		uniform float4 _ColorA;
		uniform sampler2D _BaseColor;
		uniform float4 _BaseColor_ST;
		uniform float4 _ColorB;
		uniform float4 _ColorC;
		uniform sampler2D _Material;
		uniform float4 _Material_ST;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			o.Normal = UnpackNormal( tex2D( _NormalMap, uv_NormalMap ) );
			float2 uv_BaseColor = i.uv_texcoord * _BaseColor_ST.xy + _BaseColor_ST.zw;
			float4 tex2DNode3 = tex2D( _BaseColor, uv_BaseColor );
			o.Albedo = ( ( ( _ColorA * tex2DNode3.r ) + ( _ColorB * tex2DNode3.g ) ) + ( _ColorC * tex2DNode3.b ) ).rgb;
			float2 uv_Material = i.uv_texcoord * _Material_ST.xy + _Material_ST.zw;
			float4 tex2DNode38 = tex2D( _Material, uv_Material );
			o.Metallic = tex2DNode38.r;
			o.Smoothness = tex2DNode38.a;
			o.Occlusion = tex2DNode38.g;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=14301
108;150;1398;819;3109.506;1410.282;1.749769;True;False
Node;AmplifyShaderEditor.CommentaryNode;51;-2176.219,-996.7921;Float;False;1065.626;797.6904;Base Color texture is authored in Red, Green, and Blue. Those colors determine the Material Color distribution.;9;11;6;3;9;12;14;13;15;16;RGBA Colorization;1,1,1,1;0;0
Node;AmplifyShaderEditor.SamplerNode;3;-2126.219,-429.1017;Float;True;Property;_BaseColor;Base Color;0;0;Create;True;None;5cae5750e8f66a241b4e18efdac488e1;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;6;-2096.311,-946.7921;Float;False;Property;_ColorA;Color A;3;0;Create;True;1,0,0,0;1,1,1,0.484;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;11;-2091.428,-786.9314;Float;False;Property;_ColorB;Color B;4;0;Create;True;0,1,0,0;0.5073529,0.26052,0.07088017,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;14;-2096.984,-615.3832;Float;False;Property;_ColorC;Color C;5;0;Create;True;0,0,1,0;1,1,1,0.472;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-1651.515,-725.9049;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-1657.212,-838.3333;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-1655.716,-605.5322;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;13;-1413.79,-806.2732;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;50;-1341.457,40.98678;Float;True;Property;_NormalMap;Normal Map;1;0;Create;True;None;168f53c08f490184ea53c01672f45521;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;38;-1338.722,-166.6138;Float;True;Property;_Material;Material;2;0;Create;True;None;9fbea323e2eb20e40b95831fdb3b09eb;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;16;-1264.593,-639.4553;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-789.0698,-208.0267;Float;False;True;2;Float;;0;0;Standard;Quantum Theory/PBR - Rome RGB Colorize;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;False;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;12;0;11;0
WireConnection;12;1;3;2
WireConnection;9;0;6;0
WireConnection;9;1;3;1
WireConnection;15;0;14;0
WireConnection;15;1;3;3
WireConnection;13;0;9;0
WireConnection;13;1;12;0
WireConnection;16;0;13;0
WireConnection;16;1;15;0
WireConnection;0;0;16;0
WireConnection;0;1;50;0
WireConnection;0;3;38;1
WireConnection;0;4;38;4
WireConnection;0;5;38;2
ASEEND*/
//CHKSM=F929200EE1B31EEFF0DBF7A90DF0CEF224C54BB7