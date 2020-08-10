// Unity Game Engine Script to change camera position and orientation for ideal view of the Payload model
// Written by Ruben Turner for the University of Maryland Balloon Payload Program

using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraSetup : MonoBehaviour
{
    
    private Vector3 cameraCoords;

    // Start is called before the first frame update
    void Start()
    {
        cameraCoords = new Vector3(3.0f, 3.0f, -12.0f);
        transform.position = cameraCoords;
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
