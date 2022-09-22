using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WorldTransformer : MonoBehaviour
{
    // Start is called before the first frame update
    
    [SerializeField]
    public GameObject WorldToTransform;
    
    [SerializeField]
    public Vector3 GoalPosition;  // TODO: get position from QR Code

    public Camera ARCam;
    
    void WorldTransform()
    {
        Vector3 ARcamPos = ARCam.transform.position;
        float ARcamRotY = ARCam.transform.rotation.eulerAngles.y;
        float GoalXRotated = GoalPosition.x * Mathf.Cos(ARcamRotY) + GoalPosition.z * Mathf.Sin(ARcamRotY);
        float GoalZRotated = GoalPosition.z * Mathf.Cos(ARcamRotY) - GoalPosition.x * Mathf.Sin(ARcamRotY);
        float OffsetX = -(GoalXRotated - ARcamPos.x);
        float OffsetY = -(GoalPosition.z + ARcamPos.z);
        float OffsetZ = -(GoalZRotated - ARcamPos.z);
        WorldToTransform.transform.position = new Vector3(OffsetX, OffsetY, OffsetZ);
        WorldToTransform.transform.rotation = Quaternion.Euler(0, ARcamRotY, 0);
    }
}
