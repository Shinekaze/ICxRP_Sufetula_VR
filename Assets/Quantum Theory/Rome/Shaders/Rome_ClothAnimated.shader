// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Quantum Theory/PBR - Cloth Curtain Animated"
{
	Properties
	{
		_RGBMap("RGB Map", 2D) = "white" {}
		_ColorA("Color A", Color) = (1,0,0,0)
		_ColorB("Color B", Color) = (0,1,0,0)
		_ColorC("Color C", Color) = (0,0,1,0)
		_Normal("Normal", 2D) = "bump" {}
		_OffsetMap("Offset Map", 2D) = "white" {}
		_ClothSpeed("Cloth Speed", Vector) = (0,0,0,0)
		_ClothIntensity("Cloth Intensity", Range( 0 , 1)) = 0
		_TransmissionStatic("Transmission Static", Range( 0 , 1)) = 0
		_TransmissionAnimated("Transmission Animated", Range( 0 , 1)) = 0
		_NormalScale("Normal Scale", Range( 0 , 3)) = 1
		[HideInInspector] _texcoord2( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IgnoreProjector" = "True" }
		Cull Back
		CGPROGRAM
		#include "UnityStandardUtils.cginc"
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#pragma target 3.0
		#pragma surface surf StandardCustom keepalpha addshadow fullforwardshadows exclude_path:deferred vertex:vertexDataFunc 
		struct Input
		{
			float2 uv2_texcoord2;
			float4 vertexColor : COLOR;
			float2 uv_texcoord;
		};

		struct SurfaceOutputStandardCustom
		{
			fixed3 Albedo;
			fixed3 Normal;
			half3 Emission;
			half Metallic;
			half Smoothness;
			half Occlusion;
			fixed Alpha;
			fixed3 Transmission;
		};

		uniform float _NormalScale;
		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform sampler2D _OffsetMap;
		uniform float4 _OffsetMap_ST;
		uniform float2 _ClothSpeed;
		uniform sampler2D _RGBMap;
		uniform float4 _RGBMap_ST;
		uniform float4 _ColorA;
		uniform float4 _ColorB;
		uniform float4 _ColorC;
		uniform float _TransmissionAnimated;
		uniform float _TransmissionStatic;
		uniform float _ClothIntensity;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float2 uv_OffsetMap = v.texcoord1.xy * _OffsetMap_ST.xy + _OffsetMap_ST.zw;
			float4 transform57 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float2 appendResult61 = (float2(frac( transform57.x ) , frac( transform57.z )));
			float4 tex2DNode16 = tex2Dlod( _OffsetMap, float4( ( ( uv_OffsetMap + appendResult61 ) + ( _Time.y * _ClothSpeed ) ), 0, 1.0) );
			float4 temp_cast_0 = (0.0).xxxx;
			float4 temp_cast_1 = (1.0).xxxx;
			float4 temp_cast_2 = (-1.0).xxxx;
			float4 temp_cast_3 = (1.0).xxxx;
			v.vertex.xyz += ( (temp_cast_2 + (tex2DNode16 - temp_cast_0) * (temp_cast_3 - temp_cast_2) / (temp_cast_1 - temp_cast_0)) * ( v.color * _ClothIntensity ) ).rgb;
		}

		inline half4 LightingStandardCustom(SurfaceOutputStandardCustom s, half3 viewDir, UnityGI gi )
		{
			half3 transmission = max(0 , -dot(s.Normal, gi.light.dir)) * gi.light.color * s.Transmission;
			half4 d = half4(s.Albedo * transmission , 0);

			SurfaceOutputStandard r;
			r.Albedo = s.Albedo;
			r.Normal = s.Normal;
			r.Emission = s.Emission;
			r.Metallic = s.Metallic;
			r.Smoothness = s.Smoothness;
			r.Occlusion = s.Occlusion;
			r.Alpha = s.Alpha;
			return LightingStandard (r, viewDir, gi) + d;
		}

		inline void LightingStandardCustom_GI(SurfaceOutputStandardCustom s, UnityGIInput data, inout UnityGI gi )
		{
			#if defined(UNITY_PASS_DEFERRED) && UNITY_ENABLE_REFLECTION_BUFFERS
				gi = UnityGlobalIllumination(data, s.Occlusion, s.Normal);
			#else
				UNITY_GLOSSY_ENV_FROM_SURFACE( g, s, data );
				gi = UnityGlobalIllumination( data, s.Occlusion, s.Normal, g );
			#endif
		}

		void surf( Input i , inout SurfaceOutputStandardCustom o )
		{
			float2 uv2_Normal = i.uv2_texcoord2 * _Normal_ST.xy + _Normal_ST.zw;
			float2 uv_OffsetMap = i.uv2_texcoord2 * _OffsetMap_ST.xy + _OffsetMap_ST.zw;
			float4 transform57 = mul(unity_ObjectToWorld,float4( 0,0,0,1 ));
			float2 appendResult61 = (float2(frac( transform57.x ) , frac( transform57.z )));
			float4 tex2DNode16 = tex2D( _OffsetMap, ( ( uv_OffsetMap + appendResult61 ) + ( _Time.y * _ClothSpeed ) ) );
			float3 lerpResult75 = lerp( float3( 0,0,1 ) , UnpackScaleNormal( tex2D( _Normal, uv2_Normal ) ,_NormalScale ) , saturate( ( i.vertexColor.g * ( tex2DNode16.r * 5.0 ) ) ));
			float3 normalizeResult79 = normalize( lerpResult75 );
			o.Normal = normalizeResult79;
			float2 uv_RGBMap = i.uv_texcoord * _RGBMap_ST.xy + _RGBMap_ST.zw;
			float4 tex2DNode3 = tex2D( _RGBMap, uv_RGBMap );
			float4 temp_output_39_0 = ( ( tex2DNode3.r * _ColorA ) + ( tex2DNode3.g * _ColorB ) + ( tex2DNode3.b * _ColorC ) );
			o.Albedo = ( temp_output_39_0 * saturate( ( ( 1.0 - i.vertexColor.g ) + (lerpResult75).z ) ) ).rgb;
			o.Metallic = tex2DNode3.g;
			o.Smoothness = temp_output_39_0.a;
			float3 temp_cast_1 = (( ( ( _TransmissionAnimated * tex2DNode16.r ) + _TransmissionStatic ) * i.vertexColor.a )).xxx;
			o.Transmission = temp_cast_1;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=14201
2248;38;1196;780;3143.725;996.9827;2.036669;True;False
Node;AmplifyShaderEditor.CommentaryNode;95;-2922.695,259.8546;Float;False;991.2252;604.9141;UVs scroll and have a unique offset per world space position of object;10;57;60;58;61;11;12;14;8;62;9;Scrolling UVs;1,1,1,1;0;0
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;57;-2872.695,349.2785;Float;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FractNode;58;-2648.154,327.3764;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FractNode;60;-2650.132,405.4828;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TimeNode;11;-2854.74,555.0492;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.Vector2Node;14;-2847.604,703.7686;Float;False;Property;_ClothSpeed;Cloth Speed;6;0;Create;0,0;0,0.25;0;3;FLOAT2;0;FLOAT;1;FLOAT;2
Node;AmplifyShaderEditor.DynamicAppendNode;61;-2512.443,361.5136;Float;False;FLOAT2;4;0;FLOAT;0.0;False;1;FLOAT;0.0;False;2;FLOAT;0.0;False;3;FLOAT;0.0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;8;-2464.756,483.0921;Float;False;1;16;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;62;-2221.624,387.2053;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0.0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-2597.675,580.0092;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT2;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SimpleAddOpNode;9;-2085.47,556.7649;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;0.0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;16;-1860.335,519.9164;Float;True;Property;_OffsetMap;Offset Map;5;0;Create;None;6a769775355a78a438efd9e7b084cac8;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;94;-953.8469,34.16389;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;5.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;21;-1613.436,216.1533;Float;False;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;91;-781.1621,-129.3419;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;78;-1901.233,-344.5158;Float;False;Property;_NormalScale;Normal Scale;10;0;Create;1;0.75;0;3;0;1;FLOAT;0
Node;AmplifyShaderEditor.SaturateNode;88;-702.5596,-243.0649;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;74;-1594.435,-395.1957;Float;True;Property;_Normal;Normal;4;0;Create;None;c1f64e1631f1d1d458877ab5bb78a726;True;1;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;75;-510.3377,-420.9717;Float;False;3;0;FLOAT3;0,0,1;False;1;FLOAT3;0.5,0.5,1;False;2;FLOAT;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.ComponentMaskNode;90;-165.2783,-466.9656;Float;False;False;False;True;True;1;0;FLOAT3;0,0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;3;-1828.117,-844.871;Float;True;Property;_RGBMap;RGB Map;0;0;Create;None;0303e4bccffcc694094f6603485dc167;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;1.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;35;-1810.952,-1047.132;Float;False;Property;_ColorC;Color C;3;0;Create;0,0,1,0;1,1,1,0.528;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;83;-934.185,-874.4907;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;34;-1769.373,-1267.065;Float;False;Property;_ColorB;Color B;2;0;Create;0,1,0,0;1,0.6651115,0.06617643,0.622;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;1;-1663.599,-1474.458;Float;False;Property;_ColorA;Color A;1;0;Create;1,0,0,0;0.6544117,0.1154843,0.1154843,0.541;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;44;-509.2497,67.39491;Float;False;Property;_TransmissionAnimated;Transmission Animated;9;0;Create;0;0.109;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;-1366.774,-1415.122;Float;False;2;2;0;FLOAT;0.0;False;1;COLOR;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;47;-459.6257,1147.713;Float;False;Constant;_Float3;Float 3;10;0;Create;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;84;-327.3344,-945.2449;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;38;-1366.513,-1018.774;Float;False;2;2;0;FLOAT;0.0;False;1;COLOR;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;45;-463.9971,926.2402;Float;False;Constant;_Float1;Float 1;10;0;Create;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;55;-262.0146,130.3485;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;65;-786.0592,197.6754;Float;False;Property;_TransmissionStatic;Transmission Static;8;0;Create;0;0.502;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;22;-1097.993,880.0181;Float;False;Property;_ClothIntensity;Cloth Intensity;7;0;Create;0;0.25;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;37;-1378.129,-1226.275;Float;False;2;2;0;FLOAT;0.0;False;1;COLOR;0;False;1;COLOR;0
Node;AmplifyShaderEditor.RangedFloatNode;46;-458.1688,1028.234;Float;False;Constant;_Float2;Float 2;10;0;Create;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;64;-90.21615,147.2118;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;39;-1156.713,-1231.153;Float;False;3;3;0;COLOR;0,0,0,0;False;1;COLOR;0.0,0,0,0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TFHCRemapNode;32;-69.2016,572.3123;Float;False;5;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;3;COLOR;-1,0,0,0;False;4;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;-704.3824,758.4343;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SaturateNode;85;-131.7247,-998.0472;Float;False;1;0;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;24;147.0765,725.0761;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;81;76.50516,-1237.445;Float;False;2;2;0;COLOR;0.0;False;1;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.BreakToComponentsNode;68;-1024.347,-1066.499;Float;False;COLOR;1;0;COLOR;0,0,0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.NormalizeNode;79;-92.83449,73.72596;Float;False;1;0;FLOAT3;0,0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;56;137.8974,169.4254;Float;False;2;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;331.9735,-22.7639;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Quantum Theory/PBR - Cloth Curtain Animated;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;Back;0;0;False;0;0;Opaque;0.15;True;True;0;False;Opaque;Geometry;ForwardOnly;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;0;4;10;25;False;0.5;True;0;SrcAlpha;OneMinusSrcAlpha;0;SrcAlpha;OneMinusSrcAlpha;Add;Add;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0.0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;58;0;57;1
WireConnection;60;0;57;3
WireConnection;61;0;58;0
WireConnection;61;1;60;0
WireConnection;62;0;8;0
WireConnection;62;1;61;0
WireConnection;12;0;11;2
WireConnection;12;1;14;0
WireConnection;9;0;62;0
WireConnection;9;1;12;0
WireConnection;16;1;9;0
WireConnection;94;0;16;1
WireConnection;91;0;21;2
WireConnection;91;1;94;0
WireConnection;88;0;91;0
WireConnection;74;5;78;0
WireConnection;75;1;74;0
WireConnection;75;2;88;0
WireConnection;90;0;75;0
WireConnection;83;0;21;2
WireConnection;36;0;3;1
WireConnection;36;1;1;0
WireConnection;84;0;83;0
WireConnection;84;1;90;0
WireConnection;38;0;3;3
WireConnection;38;1;35;0
WireConnection;55;0;44;0
WireConnection;55;1;16;1
WireConnection;37;0;3;2
WireConnection;37;1;34;0
WireConnection;64;0;55;0
WireConnection;64;1;65;0
WireConnection;39;0;36;0
WireConnection;39;1;37;0
WireConnection;39;2;38;0
WireConnection;32;0;16;0
WireConnection;32;1;45;0
WireConnection;32;2;46;0
WireConnection;32;3;47;0
WireConnection;32;4;46;0
WireConnection;23;0;21;0
WireConnection;23;1;22;0
WireConnection;85;0;84;0
WireConnection;24;0;32;0
WireConnection;24;1;23;0
WireConnection;81;0;39;0
WireConnection;81;1;85;0
WireConnection;68;0;39;0
WireConnection;79;0;75;0
WireConnection;56;0;64;0
WireConnection;56;1;21;4
WireConnection;0;0;81;0
WireConnection;0;1;79;0
WireConnection;0;3;3;2
WireConnection;0;4;68;3
WireConnection;0;6;56;0
WireConnection;0;11;24;0
ASEEND*/
//CHKSM=6FA118684F1893F4CACDF5AA29A9C86482EF3BF8