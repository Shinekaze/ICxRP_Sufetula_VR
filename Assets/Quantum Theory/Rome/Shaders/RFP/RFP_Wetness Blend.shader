// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Quantum Theory/RFP/PBR - Wetness Blend"
{
	Properties
	{
		_MainTex("Base Color", 2D) = "white" {}
		_MetallicGlossMap("Material", 2D) = "white" {}
		_MainTexB("Base Color 2", 2D) = "white" {}
		_MetallicGlossMapB("Material 2", 2D) = "white" {}
		_Power("Stain Power", Range( 0 , 3)) = 2
		_SmoothnessModulation("Stain Smoothness Limit", Range( 0 , 1)) = 0
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

		uniform sampler2D _MainTexB;
		uniform float4 _MainTexB_ST;
		uniform sampler2D _MainTex;
		uniform float4 _MainTex_ST;
		uniform float _Power;
		uniform sampler2D _MetallicGlossMap;
		uniform float4 _MetallicGlossMap_ST;
		uniform sampler2D _MetallicGlossMapB;
		uniform float4 _MetallicGlossMapB_ST;
		uniform float _SmoothnessModulation;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_MainTexB = i.uv_texcoord * _MainTexB_ST.xy + _MainTexB_ST.zw;
			float2 uv_MainTex = i.uv_texcoord * _MainTex_ST.xy + _MainTex_ST.zw;
			float4 lerpResult8 = lerp( tex2D( _MainTexB, uv_MainTexB ) , tex2D( _MainTex, uv_MainTex ) , i.vertexColor.g);
			float4 temp_cast_0 = (( ( ( 1.0 - _Power ) * i.vertexColor.r ) + _Power )).xxxx;
			o.Albedo = pow( lerpResult8 , temp_cast_0 ).rgb;
			float2 uv_MetallicGlossMap = i.uv_texcoord * _MetallicGlossMap_ST.xy + _MetallicGlossMap_ST.zw;
			float4 tex2DNode2 = tex2D( _MetallicGlossMap, uv_MetallicGlossMap );
			o.Metallic = tex2DNode2.r;
			float2 uv_MetallicGlossMapB = i.uv_texcoord * _MetallicGlossMapB_ST.xy + _MetallicGlossMapB_ST.zw;
			float4 lerpResult14 = lerp( tex2D( _MetallicGlossMapB, uv_MetallicGlossMapB ) , tex2DNode2 , i.vertexColor.g);
			o.Smoothness = ( lerpResult14.a + ( _SmoothnessModulation * ( 1.0 - i.vertexColor.a ) ) );
			o.Occlusion = tex2DNode2.g;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17700
2250;109;1426;837;1589.262;244.5472;1.646639;True;False
Node;AmplifyShaderEditor.RangedFloatNode;9;-1026.263,454.9027;Inherit;False;Property;_Power;Stain Power;6;0;Create;False;0;0;False;0;2;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-1065.066,-175.9348;Inherit;True;Property;_MetallicGlossMap;Material;1;0;Create;False;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;17;-482.3595,995.4466;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;11;-744.6371,526.5064;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;5;-1241.248,762.9971;Inherit;True;Property;_MetallicGlossMapB;Material 2;4;0;Create;False;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;7;-877.4361,258.3091;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-574.2923,528.993;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;19;-279.3595,1023.447;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;21;-414.3595,882.4466;Inherit;False;Property;_SmoothnessModulation;Stain Smoothness Limit;7;0;Create;False;0;0;False;0;0;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;14;-638.9487,745.3431;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;4;-1239.993,564.4179;Inherit;True;Property;_MainTexB;Base Color 2;3;0;Create;False;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;1;-1061.295,-373.8842;Inherit;True;Property;_MainTex;Base Color;0;0;Create;False;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.BreakToComponentsNode;15;-479.3769,724.1488;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.LerpOp;8;-592.4081,255.6142;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;20;-108.3595,973.4466;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;13;-430.0587,403.4107;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;10;-308.977,300.8516;Inherit;False;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;16;-102.3595,784.4466;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;6;-1235.377,958.3899;Inherit;True;Property;_BumpMapB;Normal Map 2;5;0;Create;False;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-1065.967,21.94659;Inherit;True;Property;_BumpMap;Normal Map;2;0;Create;False;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;22;-736.3032,926.1912;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;30;0,0;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Quantum Theory/RFP/PBR - Wetness Blend;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;11;0;9;0
WireConnection;12;0;11;0
WireConnection;12;1;7;1
WireConnection;19;0;17;4
WireConnection;14;0;5;0
WireConnection;14;1;2;0
WireConnection;14;2;7;2
WireConnection;15;0;14;0
WireConnection;8;0;4;0
WireConnection;8;1;1;0
WireConnection;8;2;7;2
WireConnection;20;0;21;0
WireConnection;20;1;19;0
WireConnection;13;0;12;0
WireConnection;13;1;9;0
WireConnection;10;0;8;0
WireConnection;10;1;13;0
WireConnection;16;0;15;3
WireConnection;16;1;20;0
WireConnection;22;0;6;0
WireConnection;22;1;3;0
WireConnection;22;2;7;2
WireConnection;30;0;10;0
WireConnection;30;3;2;1
WireConnection;30;4;16;0
WireConnection;30;5;2;2
ASEEND*/
//CHKSM=4DFD94685384BDE66F332212C7071135EEEC7DF5