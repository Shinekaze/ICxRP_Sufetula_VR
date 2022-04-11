Shader "Quantum Theory/Hedges" {
	Properties {

		_MainTex ("Albedo (RGB)", 2D) = "white" {}
	_BumpMap("Normal Map", 2D) = "bump" {}
	_MetallicGlossmap("Material", 2D) = "black"{}
	_Cutoff("Cutoff", Range(0, 1)) = 0.6
		//[HideInInspector]_Cutoff("Alpha cutoff", Range(0,1)) = 0.5
	}
	SubShader {
		Tags { "Queue" = "AlphaTest"
		"RenderType" = "TransparentCutout" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Standard fullforwardshadows alphatest:_Cutoff

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _MainTex;
		sampler2D _BumpMap;
		sampler2D _MetallicGlossmap;
		//float _Cutoff;
		struct Input {
			float2 uv_MainTex;
			float2 uv_BumpMap;
			float4 color : COLOR;
		};
				
		

		void surf (Input IN, inout SurfaceOutputStandard o) {
			// Albedo comes from a texture tinted by color
		//	fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
			fixed4 m = tex2D(_MetallicGlossmap, IN.uv_MainTex);
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb * IN.color.r;
			// Metallic and smoothness come from slider variables
			o.Metallic = m.r;
			o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
			//o.Smoothness = _Glossiness;
			o.Smoothness = m.a;
			o.Alpha = (c.a + IN.color.a);
			
		}
		ENDCG
	}
	FallBack "Diffuse"
}
