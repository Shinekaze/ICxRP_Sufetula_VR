using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public class QT_RFP1ConvertToHDRP : EditorWindow
{

    [MenuItem("Window/Quantum Theory/Rome Pack I - Convert to SRP")]
    static void Init()
    {
        GUIContent gc = new GUIContent("RFP1 Converter");
        QT_RFP1ConvertToHDRP window = (QT_RFP1ConvertToHDRP)EditorWindow.GetWindow(typeof(QT_RFP1ConvertToHDRP));
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

        if (GUILayout.Button("Convert RFP1 to HDRP"))
        {
            if (EditorUtility.DisplayDialog("Convert RFP1 Materials", "This will convert all materials using RFP1 shaders to use RFP1 HDRP shaders. To reverse the process, reimport the project from the asset store.\n\nAre you sure?", "Yes", "No"))
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
                EditorUtility.DisplayDialog("Standard Materials", "Now, convert Standard Materials in the project by going to\n\nEdit->Render Pipeline->Upgrade Project Materials to HDRP", "OK");
            }


        }
        if (GUILayout.Button("Convert RFP1 to URP"))
        {
            if (EditorUtility.DisplayDialog("Convert RFP1 Materials", "This will convert all materials using RFP1 shaders to use RFP1 URP shaders. To reverse the process, reimport the project from the asset store.\n\nAre you sure?", "Yes", "No"))
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
        //    s[0] = "Assets";
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
        HDRP.Add(Shader.Find("Quantum Theory/RFP/HDRP/PBR - Cloth Animated"));
        HDRP.Add(Shader.Find("Quantum Theory/RFP/HDRP/PBR - Decor Decal"));        
        HDRP.Add(Shader.Find("Quantum Theory/RFP/HDRP/PBR - Parallax Mapping"));
        HDRP.Add(Shader.Find("Quantum Theory/RFP/HDRP/PBR - Parallax Mapping Detail"));        
        HDRP.Add(Shader.Find("Quantum Theory/RFP/HDRP/PBR - Parallax Mapping Puddle Decal"));        
        HDRP.Add(Shader.Find("Quantum Theory/RFP/HDRP/PBR - Puddle"));
        HDRP.Add(Shader.Find("Quantum Theory/RFP/HDRP/PBR - Puddle Decal"));        
        HDRP.Add(Shader.Find("Quantum Theory/RFP/HDRP/PBR - Cloth Curtain Animated"));
        HDRP.Add(Shader.Find("Quantum Theory/RFP/HDRP/PBR - Decal Alpha"));        
        HDRP.Add(Shader.Find("Quantum Theory/RFP/HDRP/PBR - Wetness Blend"));
        
        Normal.Add(Shader.Find("Quantum Theory/RFP/PBR - Cloth Animated"));
        Normal.Add(Shader.Find("Quantum Theory/RFP/PBR - Decor Decal"));       
        Normal.Add(Shader.Find("Quantum Theory/RFP/PBR - Parallax Mapping"));
        Normal.Add(Shader.Find("Quantum Theory/RFP/PBR - Parallax Mapping Detail"));
        Normal.Add(Shader.Find("Quantum Theory/RFP/PBR - Parallax Mapping Puddle Decal"));        
        Normal.Add(Shader.Find("Quantum Theory/RFP/PBR - Puddle"));
        Normal.Add(Shader.Find("Quantum Theory/RFP/PBR - Puddle Decal"));        
        Normal.Add(Shader.Find("Quantum Theory/RFP/PBR - Cloth Curtain Animated"));
        Normal.Add(Shader.Find("Quantum Theory/RFP/PBR - Decal Alpha"));
        Normal.Add(Shader.Find("Quantum Theory/RFP/PBR - Wetness Blend"));

        URP.Add(Shader.Find("Quantum Theory/RFP/URP/PBR - Cloth Animated"));
        URP.Add(Shader.Find("Quantum Theory/RFP/URP/PBR - Decor Decal"));
        URP.Add(Shader.Find("Quantum Theory/RFP/URP/PBR - Parallax Mapping"));
        URP.Add(Shader.Find("Quantum Theory/RFP/URP/PBR - Parallax Mapping Detail"));
        URP.Add(Shader.Find("Quantum Theory/RFP/URP/PBR - Parallax Mapping Puddle Decal"));
        URP.Add(Shader.Find("Quantum Theory/RFP/URP/PBR - Puddle"));
        URP.Add(Shader.Find("Quantum Theory/RFP/URP/PBR - Puddle Decal"));
        URP.Add(Shader.Find("Quantum Theory/RFP/URP/PBR - Cloth Curtain Animated"));
        URP.Add(Shader.Find("Quantum Theory/RFP/URP/PBR - Decal Alpha"));
        URP.Add(Shader.Find("Quantum Theory/RFP/URP/PBR - Wetness Blend"));

    }


}
