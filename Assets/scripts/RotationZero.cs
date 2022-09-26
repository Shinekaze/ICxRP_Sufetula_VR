using UnityEngine;
using UnityEngine.XR.ARFoundation;
public class RotationZero : MonoBehaviour
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

    public void CamRotate()
    {
        float ARSessionOriginRotY = ARSessionOrigin.transform.rotation.eulerAngles.y;
        float ARCamRotY = ARCam.transform.eulerAngles.y;
        ARSessionOrigin.transform.rotation = Quaternion.Euler(0, ARSessionOriginRotY-ARCamRotY+90, 0);

    }
}
