// Unity Game Engine Script to visualize acceleromater data of the LIVE payload
// Written by Ruben Turner for the University of Maryland Balloon Payload Program

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using System;
using System.IO;
using System.Threading;
using System.Globalization;
using System.Linq;

public class CubeMotion : MonoBehaviour
{
    private static int counter;

    private Vector3[] coordinates;
    
    private float rotationSpeed = 45;

    private Vector3 currentEulerAngles;

    private Vector3 newEulerAngles;

    private Vector3 offsetCoords;

    private Vector3 increments;
    
    // Start is called once before the first frame loads
    void Start()
    {
        string[] lines = System.IO.File.ReadAllLines("sample_output.csv");
        lines = lines.Skip(1).ToArray();

        foreach (string line in lines)
        {
            counter++;
        }

        transform.eulerAngles = new Vector3(0.0f, 0.0f, 0.0f);
        

        coordinates = new Vector3[counter];
        
        int g = 0;

        char[] delimiterChars = {' ', ',', 'Y', '\t', 'X', 'Z'};

        while (g < counter) 
        {

            foreach (string line in lines)
            {
                string[] valueArray = line.Split(delimiterChars);

                coordinates[g].x = float.Parse(valueArray[0], CultureInfo.InvariantCulture);
                coordinates[g].y = float.Parse(valueArray[1], CultureInfo.InvariantCulture);
                coordinates[g].z = float.Parse(valueArray[2], CultureInfo.InvariantCulture);
                
                g += 1;
            }

        }

        StartCoroutine("AngleTransform");
    }

    // Update is called every frame
    void Update() 
    {

    }

    // Coroutine used to execute Euler Angle transformations independent of frame rendering
    IEnumerator AngleTransform() 
    {

        for (int k = 0; k < counter; k++) 
        {
            
            int steps = 100000;
            newEulerAngles = coordinates[k] * Time.deltaTime * rotationSpeed;
            offsetCoords = newEulerAngles - transform.eulerAngles; 
            currentEulerAngles = transform.eulerAngles;

            for (int n = 0; n <= steps; n++)
            {
                increments = offsetCoords/steps;
                transform.eulerAngles = currentEulerAngles + increments;
                currentEulerAngles = transform.eulerAngles;
            }
            

            // Sets a delay between the Euler Angle tranformations
            yield return new WaitForSeconds(0.1f); 
        }

    }
}
