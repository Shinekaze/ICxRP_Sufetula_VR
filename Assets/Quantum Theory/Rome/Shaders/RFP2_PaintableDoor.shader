// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Quantum Theory/PBR - Rome Standard Lerp Color"
{
	Properties
	{
		_BaseColor("Base Color", 2D) = "white" {}
		_NormalMap("Normal Map", 2D) = "bump" {}
		_Material("Material", 2D) = "black" {}
		_ColorA("Color A", Color) = (1,0,0,0)
		_ColorB("Color B", Color) = (0,1,0,0)
		_ColorC("Color C", Color) = (0,0,1,0)
		_ColorSmoothness("Color Smoothness", Range( 0 , 1)) = 0
		_ColorFade("Color Fade", Range( 0 , 10)) = 0
		_ColorContrast("Color Contrast", Range( 0 , 10)) = 0
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
		uniform sampler2D _Material;
		uniform float4 _Material_ST;
		uniform float _ColorContrast;
		uniform float _ColorFade;
		uniform float _ColorSmoothness;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			o.Normal = UnpackNormal( tex2D( _NormalMap, uv_NormalMap ) );
			float2 uv_BaseColor = i.uv_texcoord * _BaseColor_ST.xy + _BaseColor_ST.zw;
			float temp_output_78_0 = ( 1.0 - i.vertexColor.a );
			float2 uv_Material = i.uv_texcoord * _Material_ST.xy + _Material_ST.zw;
			float4 tex2DNode38 = tex2D( _Material, uv_Material );
			float temp_output_59_0 = saturate( ( ( ( ( tex2DNode38.a - 0.5 ) * _ColorContrast ) + 0.5 ) * _ColorFade ) );
			float4 lerpResult54 = lerp( tex2D( _BaseColor, uv_BaseColor ) , ( ( ( _ColorA * i.vertexColor.r ) + ( _ColorB * i.vertexColor.g ) ) + ( _ColorC * i.vertexColor.b ) ) , ( temp_output_78_0 * ( 1.0 - temp_output_59_0 ) ));
			o.Albedo = lerpResult54.rgb;
			o.Metallic = tex2DNode38.r;
			float lerpResult87 = lerp( ( temp_output_78_0 * _ColorSmoothness ) , tex2DNode38.a , temp_output_59_0);
			o.Smoothness = lerpResult87;
			o.Occlusion = tex2DNode38.g;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
}
/*ASEBEGIN
Version=14301
108;150;1398;819;4113.328;2131.147;2.422523;True;False
Node;AmplifyShaderEditor.SamplerNode;38;-2969.341,-177.2055;Float;True;Property;_Material;Material;2;0;Create;True;None;None;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleSubtractOpNode;67;-2597.897,195.134;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;56;-2701.236,296.5606;Float;False;Property;_ColorContrast;Color Contrast;8;0;Create;True;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;68;-2397.376,213.6989;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;71;-2344.295,313.1194;Float;False;Property;_ColorFade;Color Fade;7;0;Create;True;0;0;0;10;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;69;-2228.376,209.699;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;70;-2025.206,220.0523;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;11;-3202.148,-1339.615;Float;False;Property;_ColorB;Color B;4;0;Create;True;0,1,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;6;-3208.223,-1552.57;Float;False;Property;_ColorA;Color A;3;0;Create;True;1,0,0,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;10;-3138.167,-943.4205;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-2853.463,-1335.071;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.ColorNode;14;-3205.469,-1159.229;Float;False;Property;_ColorC;Color C;5;0;Create;True;0,0,1,0;0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SaturateNode;59;-1870.13,218.5142;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-2861.041,-1532.377;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;46;-2939.284,-553.5058;Float;False;Property;_ColorSmoothness;Color Smoothness;6;0;Create;True;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;13;-2686.091,-1431.017;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;78;-2920.086,-791.568;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;86;-1686.144,-667.6631;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-2858.786,-1121.702;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;77;-1518.356,-789.1164;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;47;-2650.456,-638.1015;Float;False;2;2;0;FLOAT;0,0,0,0;False;1;FLOAT;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;16;-2527.202,-1143.229;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;3;-1597.657,-1329.927;Float;True;Property;_BaseColor;Base Color;0;0;Create;True;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;50;-1169.374,255.7739;Float;True;Property;_NormalMap;Normal Map;1;0;Create;True;None;None;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;54;-1272.05,-1157.337;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;87;-1225.821,-348.2373;Float;False;3;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-789.0698,-208.0267;Float;False;True;2;Float;;0;0;Standard;Quantum Theory/PBR - Rome Standard Lerp Color;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;False;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;0;4;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;Add;Add;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;67;0;38;4
WireConnection;68;0;67;0
WireConnection;68;1;56;0
WireConnection;69;0;68;0
WireConnection;70;0;69;0
WireConnection;70;1;71;0
WireConnection;12;0;11;0
WireConnection;12;1;10;2
WireConnection;59;0;70;0
WireConnection;9;0;6;0
WireConnection;9;1;10;1
WireConnection;13;0;9;0
WireConnection;13;1;12;0
WireConnection;78;0;10;4
WireConnection;86;0;59;0
WireConnection;15;0;14;0
WireConnection;15;1;10;3
WireConnection;77;0;78;0
WireConnection;77;1;86;0
WireConnection;47;0;78;0
WireConnection;47;1;46;0
WireConnection;16;0;13;0
WireConnection;16;1;15;0
WireConnection;54;0;3;0
WireConnection;54;1;16;0
WireConnection;54;2;77;0
WireConnection;87;0;47;0
WireConnection;87;1;38;4
WireConnection;87;2;59;0
WireConnection;0;0;54;0
WireConnection;0;1;50;0
WireConnection;0;3;38;1
WireConnection;0;4;87;0
WireConnection;0;5;38;2
ASEEND*/
//CHKSM=6BFFC7A57EFF610B71457B67E83B45CBE4B1D07D