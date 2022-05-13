using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TabletRotate : MonoBehaviour
{
    // Start is called before the first frame update
    void Start()
    {
        Input.compensateSensors = true;
        Input.gyro.enabled = true;
    }

    void FixedUpdate()
    {
        transform.Rotate(-Input.gyro.rotationRateUnbiased.x, -Input.gyro.rotationRateUnbiased.y,
            Input.gyro.rotationRateUnbiased.z);
    }
}
/*https://stackoverflow.com/questions/24501290/unity3d-android-accelerometer-and-gyroscope-controls*/