using UnityEngine;
using System.Collections;

public class rotate : MonoBehaviour
{

//     float xRot, yRot, zRot;
//     public float rotSpeed = 5f;
//  
//     void Update ()
//     {
//         /*https://forum.unity.com/threads/rotating-camera-via-tablet-or-android-devices-rotation.283293/
//         https://docs.unity3d.com/Manual/MobileInput.html
//         */
//         // This tilts the axis of the camera like shaking a head yes
//         xRot = Input.acceleration.z * -180f;
//         
//         
//         // zRot = Input.acceleration.y * 360f;
//         
//         // This tilts like a driving wheel to make it like shaking head no
//         yRot = Input.acceleration.x * -180f;
//         transform.rotation = Quaternion.Lerp(transform.rotation, Quaternion.Euler(new Vector3(xRot, yRot, zRot)), Time.deltaTime * rotSpeed);
//     }
//  
// }

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
/*https://stackoverflow.com/questions/24501290/unity3d-android-accelerometer-and-gyroscope-controls
 
 to control your camera from the accelerometer you should use a lowpass filter because the raw accelerometer 
 data will have way to much noise resulting in jittery movement. using the method lowpass() instead of 
 Input.acceleration will make a smooth camera movements when applied to the cameras rotation,
 
 
public float AccelerometerUpdateInterval = 1.0f / 100.0f;
public float LowPassKernelWidthInSeconds = 0.001f;
public Vector3 lowPassValue = Vector3.zero;


Vector3 lowpass(){
        float LowPassFilterFactor = AccelerometerUpdateInterval / LowPassKernelWidthInSeconds; // tweakable
        lowPassValue = Vector3.Lerp(lowPassValue, Input.acceleration, LowPassFilterFactor);
        return lowPassValue;
    }
 
 */