using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class AR_SceneExit : MonoBehaviour
{
    public string sceneToLoad;
    // Start is called before the first frame update
    public void ChangeScene(string sceneToLoad)
    {
        SceneManager.LoadScene(sceneToLoad);
    }

}
