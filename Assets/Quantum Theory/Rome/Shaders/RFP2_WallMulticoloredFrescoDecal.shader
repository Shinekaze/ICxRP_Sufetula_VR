// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Quantum Theory/PBR - Rome Multicolored Fresco Decal"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.1
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
		uniform float _PaintGlossiness;
		uniform sampler2D _GreyscaleAgeMap;
		uniform float4 _GreyscaleAgeMap_ST;
		uniform float _AgeMapContrast;
		uniform float _Cutoff = 0.1;

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
			float temp_output_46_0 = _PaintGlossiness;
			o.Smoothness = temp_output_46_0;
			o.Occlusion = tex2DNode38.g;
			o.Alpha = 1;
			float2 uv_GreyscaleAgeMap = i.uv_texcoord * _GreyscaleAgeMap_ST.xy + _GreyscaleAgeMap_ST.zw;
			float temp_output_91_0 = saturate( ( ( ( ( tex2D( _GreyscaleAgeMap, uv_GreyscaleAgeMap ).g - 0.5 ) * ( _AgeMapContrast * 5.0 ) ) + 0.5 ) * tex2DNode3.a ) );
			clip( temp_output_91_0 - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=16301
2330;44;1503;1109;4035.771;1729.543;2.403811;True;True
Node;AmplifyShaderEditor.RangedFloatNode;29;-4002.144,-127.6892;Float;False;Constant;_Float1;Float 1;5;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;33;-4313.269,-46.31102;Float;False;Property;_AgeMapContrast;Age Map Contrast;8;0;Create;True;0;0;False;0;0;0.206;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;30;-4327.819,-293.2986;Float;True;Property;_GreyscaleAgeMap;Greyscale Age Map;4;0;Create;True;0;0;False;0;None;d53a1745260bd0e448df9907dac1f929;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;35;-4225.579,56.37645;Float;False;Constant;_Float3;Float 3;7;0;Create;True;0;0;False;0;5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;28;-3760.78,-219.2119;Float;False;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;34;-3913.069,45.72855;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;6;-3271.726,-1996.152;Float;False;Property;_ColorA;Color A;5;0;Create;True;0;0;False;0;1,0,0,0;0.7867647,0.5499714,0.3933822,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-3246.451,-1109.123;Float;True;Property;_BaseColor;Base Color;1;0;Create;True;0;0;False;0;None;d61a66822a299bf43b220127faa69e89;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;31;-3603.01,-36.28038;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;11;-3310.181,-1707.945;Float;False;Property;_ColorB;Color B;6;0;Create;True;0;0;False;0;0,1,0,0;0.9632353,0.9373235,0.7861702,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-2844.295,-1951.033;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;36;-3398.289,-187.7652;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-2873.602,-1653.586;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;14;-3295.735,-1413.051;Float;False;Property;_ColorC;Color C;7;0;Create;True;0;0;False;0;0,0,1,0;0.6911764,0.6251082,0.6671517,1;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;94;-3224.632,-390.7604;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;13;-2630.876,-1763.957;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-2854.467,-1403.2;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;50;-1322.21,324.4493;Float;True;Property;_NormalMap;Normal Map;2;0;Create;True;0;0;False;0;None;20685e092f7090641b057aab4ff6b4bc;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;76;-1651.228,-215.3134;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;46;-1922.678,-395.1461;Float;False;Property;_PaintGlossiness;Paint Glossiness;9;0;Create;True;0;0;False;0;0;0.2;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;38;-3153.113,164.1122;Float;True;Property;_Material;Material;3;0;Create;True;0;0;False;0;None;f9016f14b7eec314d8b23421a730250d;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;16;-2463.344,-1437.123;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;91;-3038.077,-181.0338;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-789.0698,-208.0267;Float;False;True;2;Float;;0;0;Standard;Quantum Theory/PBR - Rome Multicolored Fresco Decal;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;True;-1;False;-1;-2;False;-1;False;0;Custom;0.1;True;True;0;True;TransparentCutout;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;0;4;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;1;False;-1;1;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;28;0;30;2
WireConnection;28;1;29;0
WireConnection;34;0;33;0
WireConnection;34;1;35;0
WireConnection;31;0;28;0
WireConnection;31;1;34;0
WireConnection;9;0;6;0
WireConnection;9;1;3;1
WireConnection;36;0;31;0
WireConnection;36;1;29;0
WireConnection;12;0;11;0
WireConnection;12;1;3;2
WireConnection;94;0;36;0
WireConnection;94;1;3;4
WireConnection;13;0;9;0
WireConnection;13;1;12;0
WireConnection;15;0;14;0
WireConnection;15;1;3;3
WireConnection;76;0;38;4
WireConnection;76;1;46;0
WireConnection;76;2;91;0
WireConnection;16;0;13;0
WireConnection;16;1;15;0
WireConnection;91;0;94;0
WireConnection;0;0;16;0
WireConnection;0;1;50;0
WireConnection;0;3;38;1
WireConnection;0;4;46;0
WireConnection;0;5;38;2
WireConnection;0;10;91;0
ASEEND*/
//CHKSM=551C2146E5FA0AB61893023014F36BF40D680844