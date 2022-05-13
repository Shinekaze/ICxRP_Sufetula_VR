using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TabletMovement : MonoBehaviour
{
    // Start is called before the first frame update
    // public CharacterController controller;
    // public Animator animator;

    public float runSpeed = 40f;

    public Joystick joystick;
    float horizontalMove = 0f;
    float verticalMove = 0f;
    bool jump = false;
    bool crouch = false;
    
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
    horizontalMove = joystick.Horizontal * runSpeed;
    verticalMove = joystick.Vertical * runSpeed;
    
    
    // Animator.setFloat("Speed", Mathf.Abs(horizontalMove));
    //
    // if (Input.GetButtonDown("Jump"))
    // {
    //     jump = true;
    //     Animator.setBool("IsJumping", true);
    // }
    // if (Input.GetButtonDown("Crouch"))
    // {
    //     crouch = true;
    // }
    // else if (Input.GetButtonUp("Crouch"))
    // {
    //     crouch = false;
    // }
    }
}
