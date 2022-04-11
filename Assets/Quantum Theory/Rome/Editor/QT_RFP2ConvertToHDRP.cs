using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public class QT_RFP2ConvertToHDRP : EditorWindow
{

    [MenuItem("Window/Quantum Theory/Rome Pack II - Convert to SRP")]
    static void Init()
    {
        GUIContent gc = new GUIContent("Converter");
        QT_RFP2ConvertToHDRP window = (QT_RFP2ConvertToHDRP)EditorWindow.GetWindow(typeof(QT_RFP2ConvertToHDRP));
        window.Show();
        //window.title = "Combiner";
        window.titleContent = gc;
        window.maxSize = new Vector2(160, 45);
        window.minSize = window.maxSize;

    }

    List<Shader> HDRP = new List<Shader>();
    List<Shader> Normal = new List<Shader>();
    List<Shader> URP = new List<Shader>();

    private void OnGUI()
    {
        ShaderArraySetup();

        if(GUILayout.Button("Convert RFP2 to HDRP"))
        {
            if(EditorUtility.DisplayDialog("Convert RFP2 Materials","This will convert all materials using RFP2 shaders to use RFP2 HDRP shaders. To reverse the process, reimport the project from the asset store.\n\nAre you sure?","Yes","No"))
            {
                // EditorUtility.DisplayDialog("Place Selection On Surface?","Are you sure you want to place " + transforms.Length                + " on the surface?", "Place", "Do Not Place"))
                string[] s = new string[1];
                s[0] = "Assets";
                var guids = AssetDatabase.FindAssets("t:Material", s);
                foreach (var g in guids)
                {
                    Material m = (Material)AssetDatabase.LoadAssetAtPath(AssetDatabase.GUIDToAssetPath(g), typeof(Material));
                    Shader shader = m.shader;
                    for (int x = 0; x < HDRP.Count; x++)
                    {
                        if (shader.Equals(Normal[x]))
                            m.shader = HDRP[x];
                    }
                }
                EditorUtility.DisplayDialog("Standard Materials","Now, convert Standard Materials in the project by going to\n\nEdit->Render Pipeline->Upgrade Project Materials to HDRP", "OK");
            }
            

        }

        if (GUILayout.Button("Convert RFP2 to URP"))
        {
            if (EditorUtility.DisplayDialog("Convert RFP2 Materials", "This will convert all materials using RFP2 shaders to use RFP2 URP shaders. To reverse the process, reimport the project from the asset store.\n\nAre you sure?", "Yes", "No"))
            {
                // EditorUtility.DisplayDialog("Place Selection On Surface?","Are you sure you want to place " + transforms.Length                + " on the surface?", "Place", "Do Not Place"))
                string[] s = new string[1];
                s[0] = "Assets";
                var guids = AssetDatabase.FindAssets("t:Material", s);
                foreach (var g in guids)
                {
                    Material m = (Material)AssetDatabase.LoadAssetAtPath(AssetDatabase.GUIDToAssetPath(g), typeof(Material));
                    Shader shader = m.shader;
                    for (int x = 0; x < URP.Count; x++)
                    {
                        if (shader.Equals(Normal[x]))
                            m.shader = URP[x];
                    }
                }
                EditorUtility.DisplayDialog("Standard Materials", "Now, convert Standard Materials in the project by going to\n\nEdit->Render Pipeline->Upgrade Project Materials to HDRP", "OK");
            }


        }
        //if (GUILayout.Button("Convert to Standard"))
        //{
        //    string[] s = new string[1];
        //    s[0] = "Assets/Quantum Theory";
        //    var guids = AssetDatabase.FindAssets("t:Material", s);
        //    foreach (var g in guids)
        //    {
        //        //Material m = (Material)AssetDatabase.LoadAllAssetsAtPath(AssetDatabase.GUIDToAssetPath(g));
        //        Material m = (Material)AssetDatabase.LoadAssetAtPath(AssetDatabase.GUIDToAssetPath(g), typeof(Material));
        //        Shader shader = m.shader;
        //        for (int x = 0; x < HDRP.Count; x++)
        //        {
        //            if (shader.Equals(HDRP[x]))
        //                m.shader = Normal[x];
        //        }
        //    }

        //}
    }

    private void ShaderArraySetup()
    {
        HDRP.Add(Shader.Find("Quantum Theory/HDRP/PBR - Cloth Animated"));
        HDRP.Add(Shader.Find("Quantum Theory/HDRP/PBR - Decor Decal"));
        HDRP.Add(Shader.Find("Quantum Theory/HDRP/PBR - Rome Standard Lerp Color"));
        HDRP.Add(Shader.Find("Quantum Theory/HDRP/PBR - Parallax Mapping"));
        HDRP.Add(Shader.Find("Quantum Theory/HDRP/PBR - Parallax Mapping Detail"));        
        HDRP.Add(Shader.Find("Quantum Theory/HDRP/PBR - Parallax Mapping Puddle Decal"));
        HDRP.Add(Shader.Find("Quantum Theory/HDRP/PBR - Rome Wall Multicolored Parallax"));
        HDRP.Add(Shader.Find("Quantum Theory/HDRP/PBR - Puddle"));
        HDRP.Add(Shader.Find("Quantum Theory/HDRP/PBR - Puddle Decal"));
        HDRP.Add(Shader.Find("Quantum Theory/HDRP/PBR - Rome RGB Colorize"));
        HDRP.Add(Shader.Find("Quantum Theory/HDRP/PBR - Rome Wall Multicolored"));
        HDRP.Add(Shader.Find("Quantum Theory/HDRP/PBR - Rome Wall Decal Multicolored"));
        HDRP.Add(Shader.Find("Quantum Theory/HDRP/PBR - Rome Multicolored Fresco Decal"));
        HDRP.Add(Shader.Find("Quantum Theory/HDRP/PBR - Rome Multicolored Fresco Decal Layer 2"));
        HDRP.Add(Shader.Find("Quantum Theory/HDRP/PBR - Cloth Animated"));
        HDRP.Add(Shader.Find("Quantum Theory/HDRP/PBR - Cloth Curtain Animated"));
        HDRP.Add(Shader.Find("Quantum Theory/HDRP/PBR - Decal Alpha"));
        HDRP.Add(Shader.Find("Quantum Theory/HDRP/Simple Water"));
        HDRP.Add(Shader.Find("Quantum Theory/HDRP/Hedges"));
        HDRP.Add(Shader.Find("Quantum Theory/HDRP/PBR - Wetness Blend"));

        Normal.Add(Shader.Find("Quantum Theory/PBR - Cloth Animated"));
        Normal.Add(Shader.Find("Quantum Theory/PBR - Decor Decal"));
        Normal.Add(Shader.Find("Quantum Theory/PBR - Rome Standard Lerp Color"));
        Normal.Add(Shader.Find("Quantum Theory/PBR - Parallax Mapping"));
        Normal.Add(Shader.Find("Quantum Theory/PBR - Parallax Mapping Detail"));
        Normal.Add(Shader.Find("Quantum Theory/PBR - Parallax Mapping Puddle Decal"));
        Normal.Add(Shader.Find("Quantum Theory/PBR - Rome Wall Multicolored Parallax"));
        Normal.Add(Shader.Find("Quantum Theory/PBR - Puddle"));
        Normal.Add(Shader.Find("Quantum Theory/PBR - Puddle Decal"));
        Normal.Add(Shader.Find("Quantum Theory/PBR - Rome RGB Colorize"));
        Normal.Add(Shader.Find("Quantum Theory/PBR - Rome Wall Multicolored"));
        Normal.Add(Shader.Find("Quantum Theory/PBR - Rome Wall Decal Multicolored"));
        Normal.Add(Shader.Find("Quantum Theory/PBR - Rome Multicolored Fresco Decal"));
        Normal.Add(Shader.Find("Quantum Theory/PBR - Rome Multicolored Fresco Decal Layer 2"));
        Normal.Add(Shader.Find("Quantum Theory/PBR - Cloth Animated"));
        Normal.Add(Shader.Find("Quantum Theory/PBR - Cloth Curtain Animated"));
        Normal.Add(Shader.Find("Quantum Theory/PBR - Decal Alpha"));
        Normal.Add(Shader.Find("Quantum Theory/Simple Water"));
        Normal.Add(Shader.Find("Quantum Theory/Hedges"));
        Normal.Add(Shader.Find("Quantum Theory/PBR - Wetness Blend"));

        URP.Add(Shader.Find("Quantum Theory/URP/PBR - Cloth Animated"));
        URP.Add(Shader.Find("Quantum Theory/URP/PBR - Decor Decal"));
        URP.Add(Shader.Find("Quantum Theory/URP/PBR - Rome Standard Lerp Color"));
        URP.Add(Shader.Find("Quantum Theory/URP/PBR - Parallax Mapping"));
        URP.Add(Shader.Find("Quantum Theory/URP/PBR - Parallax Mapping Detail"));
        URP.Add(Shader.Find("Quantum Theory/URP/PBR - Parallax Mapping Puddle Decal"));
        URP.Add(Shader.Find("Quantum Theory/URP/PBR - Rome Wall Multicolored Parallax"));
        URP.Add(Shader.Find("Quantum Theory/URP/PBR - Puddle"));
        URP.Add(Shader.Find("Quantum Theory/URP/PBR - Puddle Decal"));
        URP.Add(Shader.Find("Quantum Theory/URP/PBR - Rome RGB Colorize"));
        URP.Add(Shader.Find("Quantum Theory/URP/PBR - Rome Wall Multicolored"));
        URP.Add(Shader.Find("Quantum Theory/URP/PBR - Rome Wall Decal Multicolored"));
        URP.Add(Shader.Find("Quantum Theory/URP/PBR - Rome Multicolored Fresco Decal"));
        URP.Add(Shader.Find("Quantum Theory/URP/PBR - Rome Multicolored Fresco Decal Layer 2"));
        URP.Add(Shader.Find("Quantum Theory/URP/PBR - Cloth Animated"));
        URP.Add(Shader.Find("Quantum Theory/URP/PBR - Cloth Curtain Animated"));
        URP.Add(Shader.Find("Quantum Theory/URP/PBR - Decal Alpha"));
        URP.Add(Shader.Find("Quantum Theory/URP/Simple Water"));
        URP.Add(Shader.Find("Quantum Theory/URP/Hedges"));
        URP.Add(Shader.Find("Quantum Theory/URP/PBR - Wetness Blend"));

    }


}
