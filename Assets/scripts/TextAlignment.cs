using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class TextAlignment : MonoBehaviour
{
    public Text TextComponent;

    private string TextAlign;
    /*
     * case TextAnchor.LowerLeft:    return new Vector2(0, 0);
                case TextAnchor.LowerCenter:  return new Vector2(0.5f, 0);
                case TextAnchor.LowerRight:   return new Vector2(1, 0);
                case TextAnchor.MiddleLeft:   return new Vector2(0, 0.5f);
                case TextAnchor.MiddleCenter: return new Vector2(0.5f, 0.5f);
                case TextAnchor.MiddleRight:  return new Vector2(1, 0.5f);
                case TextAnchor.UpperLeft:    return new Vector2(0, 1);
                case TextAnchor.UpperCenter:  return new Vector2(0.5f, 1);
                case TextAnchor.UpperRight:   return new Vector2(1, 1);
     */
    void Start()
    {
        TextAlign = "MiddleLeft";
    }

    // Update is called once per frame
    public void setAlignment(string align)
    {
        switch (align)
        {
            case "LowerLeft":
                TextComponent.alignment = TextAnchor.LowerLeft;
                break;
            case "LowerCenter":
                TextComponent.alignment = TextAnchor.LowerCenter;
                break;
            case "LowerRight":
                TextComponent.alignment = TextAnchor.LowerRight;
                break;
            case "MiddleLeft":
                TextComponent.alignment = TextAnchor.MiddleLeft;
                break;
            case "MiddleCenter":
                TextComponent.alignment = TextAnchor.MiddleCenter;
                break;
            case "MiddleRight":
                TextComponent.alignment = TextAnchor.MiddleRight;
                break;
            case "UpperLeft":
                TextComponent.alignment = TextAnchor.UpperLeft;
                break;
            case "UpperCenter":
                TextComponent.alignment = TextAnchor.UpperCenter;
                break;
            case "UpperRight":
                TextComponent.alignment = TextAnchor.UpperRight;
                break;
        }
    }
}
