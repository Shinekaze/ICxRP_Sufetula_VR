using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PannelActive : MonoBehaviour
{
   public GameObject Panel;
   public void OpenPanel ()
   {
    Panel.SetActive(true);
    
   }
}
