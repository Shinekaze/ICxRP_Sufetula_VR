// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Quantum Theory/URP/PBR - Wetness Blend"
{
	Properties
	{
		_MainTex1("Base Color", 2D) = "white" {}
		_MetallicGlossMap1("Material", 2D) = "white" {}
		_BumpMap1("Normal Map", 2D) = "white" {}
		_MainTexB1("Base Color 2", 2D) = "white" {}
		_MetallicGlossMapB1("Material 2", 2D) = "white" {}
		_BumpMapB1("Normal Map 2", 2D) = "white" {}
		_Power1("Stain Power", Range( 0 , 3)) = 2
		_SmoothnessModulation1("Stain Smoothness Limit", Range( 0 , 1)) = 0
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

		uniform sampler2D _BumpMapB1;
		uniform float4 _BumpMapB1_ST;
		uniform sampler2D _BumpMap1;
		uniform float4 _BumpMap1_ST;
		uniform sampler2D _MainTexB1;
		uniform float4 _MainTexB1_ST;
		uniform sampler2D _MainTex1;
		uniform float4 _MainTex1_ST;
		uniform float _Power1;
		uniform sampler2D _MetallicGlossMapB1;
		uniform float4 _MetallicGlossMapB1_ST;
		uniform sampler2D _MetallicGlossMap1;
		uniform float4 _MetallicGlossMap1_ST;
		uniform float _SmoothnessModulation1;

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_BumpMapB1 = i.uv_texcoord * _BumpMapB1_ST.xy + _BumpMapB1_ST.zw;
			float2 uv_BumpMap1 = i.uv_texcoord * _BumpMap1_ST.xy + _BumpMap1_ST.zw;
			float4 lerpResult20 = lerp( tex2D( _BumpMapB1, uv_BumpMapB1 ) , tex2D( _BumpMap1, uv_BumpMap1 ) , i.vertexColor.g);
			o.Normal = lerpResult20.rgb;
			float2 uv_MainTexB1 = i.uv_texcoord * _MainTexB1_ST.xy + _MainTexB1_ST.zw;
			float2 uv_MainTex1 = i.uv_texcoord * _MainTex1_ST.xy + _MainTex1_ST.zw;
			float4 lerpResult13 = lerp( tex2D( _MainTexB1, uv_MainTexB1 ) , tex2D( _MainTex1, uv_MainTex1 ) , i.vertexColor.g);
			float4 temp_cast_1 = (( ( ( 1.0 - _Power1 ) * i.vertexColor.r ) + _Power1 )).xxxx;
			o.Albedo = pow( lerpResult13 , temp_cast_1 ).rgb;
			float2 uv_MetallicGlossMapB1 = i.uv_texcoord * _MetallicGlossMapB1_ST.xy + _MetallicGlossMapB1_ST.zw;
			float2 uv_MetallicGlossMap1 = i.uv_texcoord * _MetallicGlossMap1_ST.xy + _MetallicGlossMap1_ST.zw;
			float4 lerpResult10 = lerp( tex2D( _MetallicGlossMapB1, uv_MetallicGlossMapB1 ) , tex2D( _MetallicGlossMap1, uv_MetallicGlossMap1 ) , i.vertexColor.g);
			float4 break16 = lerpResult10;
			o.Metallic = break16;
			o.Smoothness = ( break16.a + ( _SmoothnessModulation1 * ( 1.0 - i.vertexColor.a ) ) );
			o.Occlusion = break16.g;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
//	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18400
2116;84;1426;819;2297.823;998.9651;2.064917;True;False
Node;AmplifyShaderEditor.RangedFloatNode;1;-1560,-56.07307;Inherit;False;Property;_Power1;Stain Power;6;0;Create;False;0;0;False;0;False;2;0;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;2;-1418.856,-632.0697;Inherit;True;Property;_MetallicGlossMap1;Material;1;0;Create;False;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;3;-836.1498,539.3117;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;4;-1098.427,70.37152;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;5;-1595.038,306.8622;Inherit;True;Property;_MetallicGlossMapB1;Material 2;4;0;Create;False;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;6;-1376.13,-220.8787;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;11;-1415.085,-830.019;Inherit;True;Property;_MainTex1;Base Color;0;0;Create;False;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;12;-1593.783,108.283;Inherit;True;Property;_MainTexB1;Base Color 2;3;0;Create;False;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;10;-992.739,289.2082;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.OneMinusNode;8;-633.1498,567.3121;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-768.1498,426.3117;Inherit;False;Property;_SmoothnessModulation1;Stain Smoothness Limit;7;0;Create;False;0;0;False;0;False;0;0.5;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-928.0826,72.85809;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;18;-1419.757,-434.1883;Inherit;True;Property;_BumpMap1;Normal Map;2;0;Create;False;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;13;-941.2586,-439.2834;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-462.1498,517.3117;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;15;-783.849,-52.72418;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.BreakToComponentsNode;16;-833.1672,268.0139;Inherit;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.SamplerNode;17;-1589.167,502.255;Inherit;True;Property;_BumpMapB1;Normal Map 2;5;0;Create;False;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.PowerNode;19;-619.9897,-253.5409;Inherit;False;False;2;0;COLOR;0,0,0,0;False;1;FLOAT;1;False;1;COLOR;0
Node;AmplifyShaderEditor.LerpOp;20;-1108.424,514.8315;Inherit;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;21;-456.1498,328.3117;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Quantum Theory/URP/PBR - Wetness Blend;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;True;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;4;0;1;0
WireConnection;10;0;5;0
WireConnection;10;1;2;0
WireConnection;10;2;6;2
WireConnection;8;0;3;4
WireConnection;9;0;4;0
WireConnection;9;1;6;1
WireConnection;13;0;12;0
WireConnection;13;1;11;0
WireConnection;13;2;6;2
WireConnection;14;0;7;0
WireConnection;14;1;8;0
WireConnection;15;0;9;0
WireConnection;15;1;1;0
WireConnection;16;0;10;0
WireConnection;19;0;13;0
WireConnection;19;1;15;0
WireConnection;20;0;17;0
WireConnection;20;1;18;0
WireConnection;20;2;6;2
WireConnection;21;0;16;3
WireConnection;21;1;14;0
WireConnection;0;0;19;0
WireConnection;0;1;20;0
WireConnection;0;3;16;0
WireConnection;0;4;21;0
WireConnection;0;5;16;1
ASEEND*/
//CHKSM=2BDDE9E007D67BD33FDBD684A80C8A9658169CEE