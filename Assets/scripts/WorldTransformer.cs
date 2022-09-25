using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.ARFoundation;

public class WorldTransformer : MonoBehaviour
{
    // Start is called before the first frame update
    
    // [SerializeField]
    // public GameObject WorldToTransform;
    
    //[SerializeField]
    //public Vector3 GoalPosition;
    
    // private Vector3 GoalPosition;  // TODO: get position from QR Code
    
    [SerializeField]
    public Camera ARCam;
    
    [SerializeField]
    public ARSessionOrigin ARSessionOrigin;
    
    [SerializeField]
    public float CameraYOffset;
    
    // public void WorldTransform(string QRContents)
    // {
    //     Vector3 WorldStartPos = transform.position;
    //     GoalPosition = StringToVector3(QRContents);
    //     // Vector3 ARcamPos = ARCam.transform.position;
    //     float ARcamRotY = ARCam.transform.rotation.eulerAngles.y;
    //     // float GoalXRotated = GoalPosition.x * Mathf.Cos(ARcamRotY) + GoalPosition.z * Mathf.Sin(ARcamRotY);
    //     // float GoalZRotated = GoalPosition.z * Mathf.Cos(ARcamRotY) - GoalPosition.x * Mathf.Sin(ARcamRotY);
    //     // float OffsetX = -(GoalXRotated - ARcamPos.x);
    //     // float OffsetY = -(GoalPosition.z + ARcamPos.z);
    //     // float OffsetZ = -(GoalZRotated - ARcamPos.z);
    //     float OffsetX = -20;
    //     float OffsetY = -20;
    //     float OffsetZ = -20;
    //     // WorldToTransform.transform.position = new Vector3(OffsetX, OffsetY, OffsetZ);
    //     // WorldToTransform.transform.rotation = Quaternion.Euler(0, ARcamRotY, 0);
    //     transform.position = new Vector3(OffsetX, OffsetY, OffsetZ);
    //     transform.rotation = Quaternion.Euler(0, ARcamRotY, 0);
    // }
    //
    // public void WorldTransformer2(string QRContent)
    // {
    //     float ARCamRotY = ARCam.transform.rotation.eulerAngles.y;
    //     Transform ARCamPos = ARCam.transform;
    //     Transform WorldPosTransform = transform;
    //     float x = -(WorldPosTransform.position.x);
    //     float y = -(ARCamPos.position.y - WorldPosTransform.position.y);
    //     float z = -(ARCamPos.position.z - WorldPosTransform.position.z);
    //     WorldPosTransform.position = new Vector3(x, y, z);
    //     Quaternion CamRot = Quaternion.Euler(0, ARCamRotY, 0);
    //     ARSessionOrigin.MakeContentAppearAt(WorldPosTransform, StringToVector3(QRContent), CamRot);
    // }

    public void WorldTransform(string QRContent)
    {
        // float ARSessionX = ARSessionOrigin.transform.position.x + ARCam.transform.position.x;
        // float ARSessionY = ARSessionOrigin.transform.position.y + ARCam.transform.position.y;
        // float ARSessionZ = ARSessionOrigin.transform.position.z + ARCam.transform.position.z;
        // Vector3 ARSessionPos = new Vector3(ARSessionX, ARSessionY, ARSessionZ);
        // float ARCamRotY = ARCam.transform.rotation.eulerAngles.y;
        // Quaternion CamRot = Quaternion.Euler(0, 0, 0);
        ARSessionOrigin.transform.position = StringToVector3(QRContent);
        // ARSessionOrigin.transform.rotation = Quaternion.Euler(0, -(0-ARCamRotY), 0);
        ARSessionOrigin.transform.rotation = Quaternion.Euler(0, 0, 0);

    }
    
    private Vector3 StringToVector3(string sVector)
    {
        // Remove the parentheses
        if (sVector.StartsWith("(") && sVector.EndsWith(")"))
        {
            sVector = sVector.Substring(1, sVector.Length - 2);
        }
    
        // split the items
        string[] sArray = sVector.Split(',');
    
        // store as a Vector3
        Vector3 result = new Vector3(
            float.Parse(sArray[0]),
            float.Parse(sArray[1]) + CameraYOffset,
            float.Parse(sArray[2]));
    
        return result;
    }
}
