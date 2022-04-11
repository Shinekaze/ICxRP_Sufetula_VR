Shader "Quantum Theory/PBR - Decal Alpha" {
	Properties{
		_MainTex("Base Color (RGB) Alpha (A)", 2D) = "white" {}
	_BumpMap("Normal Map", 2D) = "bump" {}
	_MetallicGlossMap("Material", 2D) = "white" {}
	_NormalStrength("Normal Strength",Range(0,2)) = 1
		_AOStrength("AO Lighten",Range(0,1)) = 0
	_Cutoff("Alpha cutoff", Range(0,1)) = 0.5
	}
		SubShader{

		Tags{ "RenderType" = "Opaque" "Queue" = "Geometry+1" }//"ForceNoShadowCasting" = "True" }
		Offset -2,-2
		LOD 200

		CGPROGRAM

#pragma surface surf Standard alphatest:_Cutoff addshadow
#pragma target 3.0

		sampler2D _MainTex;
	sampler2D _BumpMap;
	sampler2D _MetallicGlossMap;
	float _NormalStrength;
	float _AOStrength;
	struct Input {
		float2 uv_MainTex;
		float2 uv_BumpMap;
		float2 uv_MetallicGlossMap;
		float4 color:Color;
	};

	void surf(Input IN, inout SurfaceOutputStandard o) {

		fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
		fixed4 m = tex2D(_MetallicGlossMap, IN.uv_MetallicGlossMap);
		
		o.Albedo = c;
		o.Metallic = m.r;
		o.Smoothness = m.a;		
		float3 newNormal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
		newNormal.r = newNormal.r * _NormalStrength;
		newNormal.g = newNormal.g * _NormalStrength;
		o.Normal = newNormal;

		o.Occlusion = saturate(m.g + _AOStrength);
		o.Alpha = c.a*IN.color.g;
	}
	ENDCG
	}
		FallBack "Diffuse"
}