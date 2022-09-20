using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Localization.Settings;
//using UnityEngine.Purchasing;
// Arabic = 0
// English = 1
// French = 2
// German = 3
public class LocaleSelector : MonoBehaviour
{
    private bool active = false;
    
    public void ChangeLocale(int localeID)
    {
        if (active == true)
            return;
        StartCoroutine(SetLocale(localeID));
    }
    
    IEnumerator SetLocale(int localeID)
    {
        active = true;
        yield return LocalizationSettings.InitializationOperation;
        LocalizationSettings.SelectedLocale = LocalizationSettings.AvailableLocales.Locales[localeID];
        active = false;
    }
}