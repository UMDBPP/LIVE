#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_BNO055.h>
#include <utility/imumaths.h>
#include <Servo.h>
#include <PID_v1.h>

/*
   Connections - Teensy 3.5
   ===========
   Connect SCL to analog 5 (Pin 19 - SCL0)
   Connect SDA to analog 4 (Pin 18 - SDA0)
   Connect VDD to 3-5V DC (3.3V Pin)
   Connect GROUND to common ground
   Connect Pin 9 to Servo Signal Line
*/

Servo myservo; //creates servo object to control servo

#define SERVO_PIN 9 //use pin 9 for servo control
#define BNO055_SAMPLERATE_DELAY_MS (100) //set the delay between fresh samples

Adafruit_BNO055 bno = Adafruit_BNO055(55);

double heading;
double Setpoint; //desired value
double Input; //accelerometer
double Output; //servo
PID myPID(&Input, &Output, &Setpoint, 1.05, 0, 0, DIRECT); //create PID instance with Kp, Ki, Kd

/* Displays Calibration Status */
void displayCalStatus(void)
{
  // Get the four calibration values (0..3)
  // Any sensor data reporting 0 should be ignored, 3 means 'fully calibrated"
  
  uint8_t system, gyro, accel, mag;
  system = gyro = accel = mag = 0;
  bno.getCalibration(&system, &gyro, &accel, &mag);

  // ! shows the data should be ignored until the system calibration is > 0
  Serial.print("\t");
  if (!system)
  {
    Serial.print("! ");
  }

  // Displays the individual calibration values
  Serial.print("Sys:");
  Serial.print(system, DEC);
  Serial.print(" G:");
  Serial.print(gyro, DEC);
  Serial.print(" A:");
  Serial.print(accel, DEC);
  Serial.print(" M:");
  Serial.print(mag, DEC);
}

void setup(void)
{
  Serial.begin(9600);
  
  myservo.attach(SERVO_PIN);  
  myservo.write(90); 

  Input = 90; //initial "home" servo position
  Setpoint = 90; //90 for other servo, desired value - resting point in z plane of my current setup - subject to change once mounted on actual payload
  myPID.SetMode(AUTOMATIC); //turn PID on
  //myPID.SetOutputLimits(0,180);

  // Initialize the sensor
  if(!bno.begin())
  {
    Serial.print("Ooops, no BNO055 detected ... Check your wiring or I2C ADDR!");
    while(1);
  }

  delay(1000);

  bno.setExtCrystalUse(true);
}

void loop(void)
{
  //get new sensor event
  sensors_event_t event;
  bno.getEvent(&event);
  
  /* Display the floating point data
  Serial.print("X: ");
  Serial.print(event.orientation.x, 4);
  Serial.print("\tY: ");
  Serial.print(event.orientation.y, 4);
  Serial.print("\tZ: ");
  Serial.print(event.orientation.z, 4); */
  Input = event.orientation.z; //input from -90 to 90 degrees from accelerometer object event.orientation.z; map to a value from 0 to 180 degrees for our PWM function
  myPID.Compute(); //run through PID library
  myservo.write(Output); // servo outputs PID corrected values

  Serial.print("Z: ");
  Serial.print(event.orientation.z, 3);
  Serial.print("\tInput: ");
  Serial.print(Input, 3);
  Serial.print("\tOutput: ");
  Serial.print(Output, 3);
  Serial.print("\tSetpoint: ");
  Serial.print(Setpoint, 4);
  Serial.print("\tHeading: ");
  Serial.print(heading, 4);

  //displayCalStatus(); //display calibration status for each sensor event

  Serial.println(""); //new line for next event
  
  delay(BNO055_SAMPLERATE_DELAY_MS); //delay between data requests for sensor
}
