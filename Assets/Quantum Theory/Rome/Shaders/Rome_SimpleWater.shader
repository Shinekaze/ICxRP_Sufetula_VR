// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Quantum Theory/Simple Water"
{
	Properties
	{
		_Color("Color", Color) = (0,0,0,0)
		_Normal("Normal", 2D) = "bump" {}
		_NormalScale("Normal Scale", Range( 0 , 1)) = 0
		_Smoothness("Smoothness", Range( 0 , 1)) = 0
		_Tiling("Tiling", Range( 0.001 , 2)) = 0
		_YSpeed("Y Speed", Range( -2 , 2)) = 0
		_XSpeed("X Speed", Range( -2 , 2)) = 0
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha , SrcAlpha OneMinusSrcAlpha
		BlendOp Add , Add
		GrabPass{ "GrabScreen1" }
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#pragma target 4.6
		#pragma surface surf Standard keepalpha exclude_path:deferred 
		struct Input
		{
			float2 uv_texcoord;
			float4 screenPos;
		};

		uniform float _NormalScale;
		uniform sampler2D _Normal;
		uniform float _XSpeed;
		uniform float _YSpeed;
		uniform float4 _Normal_ST;
		uniform float _Tiling;
		uniform float4 _Color;
		uniform sampler2D GrabScreen1;
		uniform float _Smoothness;


		inline float4 ASE_ComputeGrabScreenPos( float4 pos )
		{
			#if UNITY_UV_STARTS_AT_TOP
			float scale = -1.0;
			#else
			float scale = 1.0;
			#endif
			float4 o = pos;
			o.y = pos.w * 0.5f;
			o.y = ( pos.y - o.y ) * _ProjectionParams.x * scale + o.y;
			return o;
		}


		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 appendResult28 = (float2(( _Time.x * _XSpeed ) , ( _Time.x * _YSpeed )));
			float2 uv_Normal = i.uv_texcoord * _Normal_ST.xy + _Normal_ST.zw;
			float3 tex2DNode2 = UnpackScaleNormal( tex2D( _Normal, ( appendResult28 + ( uv_Normal * _Tiling ) ) ) ,_NormalScale );
			o.Normal = tex2DNode2;
			o.Albedo = _Color.rgb;
			float4 ase_screenPos = float4( i.screenPos.xyz , i.screenPos.w + 0.00000000001 );
			float4 ase_grabScreenPos = ASE_ComputeGrabScreenPos( ase_screenPos );
			float4 screenColor34 = tex2Dproj( GrabScreen1, UNITY_PROJ_COORD( ( ase_grabScreenPos + float4( tex2DNode2 , 0.0 ) ) ) );
			o.Emission = saturate( screenColor34 ).rgb;
			o.Smoothness = _Smoothness;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=14201
2364;106;1398;819;2976.557;349.718;1.675909;True;False
Node;AmplifyShaderEditor.RangedFloatNode;19;-2275.201,224.9998;Float;False;Property;_YSpeed;Y Speed;6;0;Create;0;0.25;-2;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;18;-2331.902,60.89983;Float;False;Property;_XSpeed;X Speed;7;0;Create;0;0.5;-2;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;17;-2365.202,-140.4002;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;-1982.302,5.100042;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;23;-2063.401,469.1;Float;False;0;2;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;30;-2262.301,366.6999;Float;False;Property;_Tiling;Tiling;5;0;Create;0;0.44;0.001;2;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;27;-1980.701,184.3002;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-1761.5,333.0999;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.DynamicAppendNode;28;-1737.501,115.5001;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-1615.101,444.1998;Float;False;Property;_NormalScale;Normal Scale;3;0;Create;0;0.094;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;25;-1585.101,286.9999;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0,0,0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.CommentaryNode;31;-1223.6,496.5253;Float;False;681.9003;359.4998;Simple Refraction with normal perturbance;3;34;33;32;;1,1,1,1;0;0
Node;AmplifyShaderEditor.GrabScreenPosition;32;-1213.663,656.5535;Float;False;1;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;2;-1272.7,235.1001;Float;True;Property;_Normal;Normal;2;0;Create;None;677106cc3baaef84faf10cb4822c4dd0;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;33;-946.1006,672.1251;Float;False;2;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0.0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ScreenColorNode;34;-758.7,644.025;Float;False;Global;GrabScreen1;Grab Screen 1;1;0;Create;Object;-1;True;True;1;0;FLOAT4;0,0,0,0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenPosInputsNode;7;-1793.588,974.827;Float;False;1;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScreenDepthNode;8;-1594.792,948.1864;Float;False;0;True;1;0;FLOAT4;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-884.4011,111.7999;Float;False;Property;_Smoothness;Smoothness;4;0;Create;0;0.947;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;10;-1082.198,1048.396;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;37;-341.5001,563.9999;Float;False;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;9;-1370.391,1044.487;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-407.6645,924.0238;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PowerNode;12;-834.2407,908.7239;Float;False;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-1014.779,903.2814;Float;False;Constant;_Float2;Float 2;10;0;Create;2;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;1;-530.1,-158.8;Float;False;Property;_Color;Color;1;0;Create;0,0,0,0;0.3308823,0.3308823,0.3308823,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;13;-609.8988,1036.566;Float;False;Constant;_Float4;Float 4;9;0;Create;25;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;6;-101.5824,857.3256;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;6;Float;ASEMaterialInspector;0;0;Standard;Quantum Theory/Simple Water;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;2;0;False;0;0;Custom;0.5;True;False;0;True;Transparent;Geometry;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;0;4;10;25;False;0.5;True;2;SrcAlpha;OneMinusSrcAlpha;2;SrcAlpha;OneMinusSrcAlpha;Add;Add;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;0;0;False;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;26;0;17;1
WireConnection;26;1;18;0
WireConnection;27;0;17;1
WireConnection;27;1;19;0
WireConnection;29;0;23;0
WireConnection;29;1;30;0
WireConnection;28;0;26;0
WireConnection;28;1;27;0
WireConnection;25;0;28;0
WireConnection;25;1;29;0
WireConnection;2;1;25;0
WireConnection;2;5;15;0
WireConnection;33;0;32;0
WireConnection;33;1;2;0
WireConnection;34;0;33;0
WireConnection;8;0;7;0
WireConnection;10;0;9;0
WireConnection;37;0;34;0
WireConnection;9;0;8;0
WireConnection;9;1;7;4
WireConnection;14;0;12;0
WireConnection;14;1;13;0
WireConnection;12;0;10;0
WireConnection;12;1;11;0
WireConnection;6;0;10;0
WireConnection;0;0;1;0
WireConnection;0;1;2;0
WireConnection;0;2;37;0
WireConnection;0;4;16;0
ASEEND*/
//CHKSM=058AFFD9204701112CAB47328C2EFE166725CC61