using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using UnityEditor;
using System.IO;

public class QT_RFP2_FrescoColorizer : EditorWindow {

[MenuItem("Window/Quantum Theory/Rome - Fresco Colorizer")]
static void Init()
{
        QT_RFP2_FrescoColorizer window = (QT_RFP2_FrescoColorizer)EditorWindow.GetWindow(typeof(QT_RFP2_FrescoColorizer));
    window.titleContent.text = "Fresco Colorizer";
    window.maxSize = new Vector2(300, 175);
    window.minSize = window.maxSize;
    window.Show();
}

    private Color[] colorPalettes = new Color[] { new Color(0.5f, 0.5f, 0.5f), new Color(0.5f, 0.5f, 0.5f), new Color(0.5f, 0.5f, 0.5f) }; //final array that holds the color palettes. Divide by 3 to get the groups.
    //indices: red is 0,3,6..green is 1,4,7,blue is 2,5,8 etc etc..
    private Color[] currentPalette = new Color[] { new Color(0.5f, 0.5f, 0.5f), new Color(0.5f, 0.5f, 0.5f), new Color(0.5f, 0.5f, 0.5f) };
    private List<string> colorPaletteNames = new List<string> { "None" };//string[] colorPalettesNames = new string[] { "None" };
    private int currentIndex = 0, previousIndex = 0;
    private bool autoApply = false;
    private string currentPaletteName = "None";
    public void OnGUI()
    {
        if (Selection.gameObjects.Length == 0)
            GUILayout.Label("Select objects using the Rome Fresco shaders.");
        else
        {
            previousIndex = currentIndex;
            currentIndex = EditorGUILayout.Popup("Current Palette: ", currentIndex, colorPaletteNames.ToArray());

            //if we haven't populated the colors or if we chose one from the dropdown, apply those colors to the 
            //colors in the ui.
            currentPaletteName = EditorGUILayout.TextField("New Palette Name: ", currentPaletteName);
            if (previousIndex != currentIndex)
                GetPalette();


            currentPalette[0] = EditorGUILayout.ColorField("Fresco Motifs A: ", currentPalette[0]);
            currentPalette[1] = EditorGUILayout.ColorField("Fresco Motifs B: ", currentPalette[1]);
            currentPalette[2] = EditorGUILayout.ColorField("Fresco Motifs C: ", currentPalette[2]);
            EditorGUILayout.BeginHorizontal();

            autoApply = EditorGUILayout.Toggle("Auto Apply", autoApply);
            if (GUILayout.Button("Swap Colors"))
            {
                Color temp = currentPalette[0];
                currentPalette[0] = currentPalette[2];
                currentPalette[2] = temp;
                Repaint();
            }
            EditorGUILayout.EndHorizontal();
            if (autoApply)
                ApplytoSelection();
            else
            {
                if (GUILayout.Button("Apply to Selection"))
                    ApplytoSelection();
            }
            if (GUILayout.Button("Save Palette to List"))
            {
                if (currentPaletteName.Contains("None") || currentPaletteName.Contains("none"))
                    EditorUtility.DisplayDialog("Bad Name", "Please pick another name for your palette.", "ok");
                else
                {
                    //put all the current array values into a list, then append the list with the new palette
                    List<Color> tempcolors = new List<Color>();

                    foreach (Color c in colorPalettes)
                        tempcolors.Add(c);

                    tempcolors.Add(currentPalette[0]);
                    tempcolors.Add(currentPalette[1]);
                    tempcolors.Add(currentPalette[2]);

                    colorPalettes = tempcolors.ToArray();
                    colorPaletteNames.Add(currentPaletteName);
                }

            }
            EditorGUILayout.BeginHorizontal();
            if (GUILayout.Button("Load Palette File"))
                LoadPaletteFromFile();
            if (GUILayout.Button("Save Palette File"))
                SavePaletteFile();
            EditorGUILayout.EndHorizontal();

        }
    }

    public void OnSceneGUI()
    {
        Repaint();
    }
    private void GetPalette()
    {
        currentPalette[0] = colorPalettes[3 * currentIndex];
        currentPalette[1] = colorPalettes[(3 * currentIndex)+1];
        currentPalette[2] = colorPalettes[(3 * currentIndex) + 2];
    }

    private void ApplytoSelection()
    {
        
        List<Material> materials = new List<Material>();
        Material[] m = null;
        foreach (GameObject g in Selection.gameObjects)
        {
            
            if (g.transform.childCount > 0)
            {
                
                MeshRenderer[] mrs = g.transform.GetComponentsInChildren<MeshRenderer>();
                foreach (MeshRenderer mr in mrs)
                {
                    m = mr.sharedMaterials;
                    foreach (Material mat in m)
                        materials.Add(mat);
                }
            }
            else
            {
                m = g.GetComponent<MeshRenderer>().sharedMaterials;
                foreach (Material mat in m)
                    materials.Add(mat);
            }


            }
       
        foreach(Material mat in materials)
        {
            mat.SetColor("_ColorA", currentPalette[0]);   
            mat.SetColor("_ColorB", currentPalette[1]);
            mat.SetColor("_ColorC", currentPalette[2]);
        }
    }
    private void SavePaletteFile()
    {
        string savedFile = EditorUtility.SaveFilePanelInProject("Save Palette", "Palette", "txt", "Save Palette File to Disk");

        if (savedFile.Length > 0 && savedFile.Contains("Assets"))
        {
            StreamWriter writer = File.CreateText(savedFile);
           for(int x=0;x<colorPaletteNames.Count;x++)
            {
                string rgb1 = colorPalettes[(3 * x)].r * 255 + " " + colorPalettes[(3 * x)].g * 255 + " " + colorPalettes[(3 * x)].b * 255;
                string rgb2 = colorPalettes[(3 * x)+1].r * 255 + " " + colorPalettes[(3 * x)+1].g * 255 + " " + colorPalettes[(3 * x)+1].b * 255;
                string rgb3 = colorPalettes[(3 * x)+2].r * 255 + " " + colorPalettes[(3 * x)+2].g * 255 + " " + colorPalettes[(3 * x)+2].b * 255;
                writer.WriteLine(colorPaletteNames[x] + "," + rgb1 + "," + rgb2 + "," + rgb3);
            }
            AssetDatabase.Refresh();
            writer.Close();
        }
        else
            EditorUtility.DisplayDialog("Invalid Folder", "Invalid Folder.\n\nPlease specify a folder within your Project.", "OK");

    }

    private void LoadPaletteFromFile()
    {
        List<Color> tempColors = new List<Color>();
        colorPaletteNames.Clear();
        
        string loadedFile = EditorUtility.OpenFilePanel("Load Palette", Application.dataPath, "txt");
        if (loadedFile.Length > 0)
        {
            //FileStream stream = new FileStream(loadedFile, FileMode.Open);
            StreamReader reader = File.OpenText(loadedFile);//new StreamReader(loadedFile);
            string readme;

            int lineCounter = 0;

            while ((readme = reader.ReadLine()) != null)
            {
                string[] line = readme.Split(','); //always 0 to 3 indexed
                // format is name, rgb, rgb, rgb
                // Simple, 255 255 255,128 128 128,0 0 0
                // name=0, rgb1 = 1, rgb2 = 2, rgb3 = 3

                colorPaletteNames.Add(line[0]);
                for (int x = 0; x < 3; x++)
                {
                    //three rgb colors whose values are separated by spaces.
                    string vals = line[x + 1];
                    string[] rgb = vals.Split(' ');
                    float r = float.Parse(rgb[0]) / 255;
                    float g = float.Parse(rgb[1]) / 255;
                    float b = float.Parse(rgb[2]) / 255;
                    tempColors.Add(new Color(r, g, b));
                }
                lineCounter++;
            }
            reader.Close();           
            colorPalettes = tempColors.ToArray();
        }
        
    }
}

