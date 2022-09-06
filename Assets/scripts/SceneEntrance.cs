using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SceneEntrance : MonoBehaviour
{
    // Start is called before the first frame update
    public string lastExitName;
    void Start()
    {
        if(PlayerPrefs.GetString("LastExitName") == lastExitName)
        {
            PlayerScript.instance.transform.position = transform.position;
            PlayerScript.instance.transform.eulerAngles = transform.eulerAngles;
        }
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
