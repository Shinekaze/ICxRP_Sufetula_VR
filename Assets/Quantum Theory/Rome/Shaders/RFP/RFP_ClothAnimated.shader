// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Quantum Theory/RFP/PBR - Cloth Animated"
{
	Properties
	{
		_Cutoff( "Mask Clip Value", Float ) = 0.5
		_BaseColor("Base Color", 2D) = "white" {}
		_NormalMap("Normal Map", 2D) = "bump" {}
		_Material("Material", 2D) = "white" {}
		_Speed("Speed", Range( 0.01 , 1)) = 0.15
		_Intensity("Intensity", Range( 0 , 1)) = 0.05
		_OffsetMap("Offset Map", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "AlphaTest+0" }
		Cull Back
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _Intensity;
		uniform sampler2D _OffsetMap;
		uniform float _Speed;
		uniform sampler2D _NormalMap;
		uniform float4 _NormalMap_ST;
		uniform sampler2D _BaseColor;
		uniform float4 _BaseColor_ST;
		uniform sampler2D _Material;
		uniform float4 _Material_ST;
		uniform float _Cutoff = 0.5;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			v.vertex.xyz += ( ( v.color * _Intensity ) * (-1.0 + (tex2Dlod( _OffsetMap, float4( ( v.texcoord.xy + ( _Time.y * _Speed ) ), 0, 0.0) ).r - 0.0) * (1.0 - -1.0) / (1.0 - 0.0)) ).rgb;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_NormalMap = i.uv_texcoord * _NormalMap_ST.xy + _NormalMap_ST.zw;
			o.Normal = UnpackNormal( tex2D( _NormalMap, uv_NormalMap ) );
			float2 uv_BaseColor = i.uv_texcoord * _BaseColor_ST.xy + _BaseColor_ST.zw;
			float4 tex2DNode1 = tex2D( _BaseColor, uv_BaseColor );
			o.Albedo = tex2DNode1.rgb;
			float2 uv_Material = i.uv_texcoord * _Material_ST.xy + _Material_ST.zw;
			float4 tex2DNode3 = tex2D( _Material, uv_Material );
			o.Metallic = tex2DNode3.r;
			o.Smoothness = tex2DNode3.a;
			o.Occlusion = tex2DNode3.g;
			o.Alpha = 1;
			clip( tex2DNode1.a - _Cutoff );
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=17700
2250;109;1426;837;1589.753;772.8265;1.678272;True;False
Node;AmplifyShaderEditor.SimpleTimeNode;8;-2240.64,506.1966;Inherit;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;5;-2243.673,664.3563;Float;False;Property;_Speed;Speed;4;0;Create;True;0;0;False;0;0.15;0.15;0.01;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-1934.348,594.7407;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;10;-2075.268,335.2416;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;11;-1726.405,464.1319;Inherit;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-1454.772,866.686;Float;False;Property;_Intensity;Intensity;5;0;Create;True;0;0;False;0;0.05;0.05;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;4;-1564.894,444.2218;Inherit;True;Property;_OffsetMap;Offset Map;6;0;Create;True;0;0;False;0;-1;12f2a4a8e9b15984ab288134093daba0;12f2a4a8e9b15984ab288134093daba0;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.VertexColorNode;7;-1340.93,659.8616;Inherit;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TFHCRemapNode;12;-1230.109,465.6216;Inherit;False;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;-1;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-1089.627,770.3447;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;2;-673.7118,-58.56952;Inherit;True;Property;_NormalMap;Normal Map;2;0;Create;True;0;0;False;0;-1;None;None;True;0;False;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-856.347,664.6135;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;1;-707.3574,-428.6717;Inherit;True;Property;_BaseColor;Base Color;1;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;3;-700.1476,282.6936;Inherit;True;Property;_Material;Material;3;0;Create;True;0;0;False;0;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;22;0,0;Float;False;True;-1;2;ASEMaterialInspector;0;0;Standard;Quantum Theory/RFP/PBR - Cloth Animated;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;Opaque;;AlphaTest;All;14;all;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;9;0;8;0
WireConnection;9;1;5;0
WireConnection;11;0;10;0
WireConnection;11;1;9;0
WireConnection;4;1;11;0
WireConnection;12;0;4;1
WireConnection;13;0;7;0
WireConnection;13;1;6;0
WireConnection;14;0;13;0
WireConnection;14;1;12;0
WireConnection;22;0;1;0
WireConnection;22;1;2;0
WireConnection;22;3;3;1
WireConnection;22;4;3;4
WireConnection;22;5;3;2
WireConnection;22;10;1;4
WireConnection;22;11;14;0
ASEEND*/
//CHKSM=09F5B5D3FADCE3BE15A4C8B128DDAB40DBE8DB14