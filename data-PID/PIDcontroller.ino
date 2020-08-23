#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_BNO055.h>
#include <utility/imumaths.h>
#include <Servo.h>
#include <PID_v1.h>

/*
   For BNO055 Calibration, refer to wiki: https://github.com/UMDBPP/LIVE/wiki/BNO055-Calibration
   
   Connections - Teensy 3.5, BNO055, Servo
   ===========
   ***BNO055 + Teensy 3.5***
   Connect SCL to analog 5 (Pin 19 - SCL0)
   Connect SDA to analog 4 (Pin 18 - SDA0)
   Connect VDD to 3-5V DC (3.3V Pin)
   Connect GND to common ground
   ***Servo + Teensy 3.5***
   Connect Signal Line to Pin 9
   Connect GND to common ground
   Connect POWER to 3-5V DC (3.3V Pin)
*/

Servo myservo; // creates servo object

#define SERVO_PIN 9 // use pin 9 for servo control
#define BNO055_SAMPLERATE_DELAY_MS (100) // set the delay between fresh samples

Adafruit_BNO055 bno = Adafruit_BNO055(55);

double Setpoint; // desired servo value
double Input; // BNO055 pitch angle
double Output; // servo horn positioning
PID myPID(&Input, &Output, &Setpoint, 1.05, 0, 0, DIRECT); // create PID instance with Kp, Ki, Kd

/* Displays Calibration Status */
void displayCalStatus(void)
{
  // gets BNO055 calibration values
  uint8_t system, gyro, accel, mag;
  system = gyro = accel = mag = 0;
  bno.getCalibration(&system, &gyro, &accel, &mag);

  // displays individual calibration values
  Serial.print(system, DEC);
  Serial.print("\t");
  Serial.print(gyro, DEC);
  Serial.print("\t");
  Serial.print(accel, DEC);
  Serial.print("\t");
  Serial.print(mag, DEC);
 
}

void setup(void)
{
  Serial.begin(115200);
  while(!Serial){}
  
  myservo.attach(SERVO_PIN);  
  myservo.write(90); // starts servo at home position of 90deg

  Input = 90; // initial "home" servo position
  Setpoint = 90; // resting point in z plane of my current setup (NOTE: subject to change once mounted on actual payload)
  myPID.SetMode(AUTOMATIC); // activate PID

  // initialize the sensor
  if(!bno.begin())
  {
    Serial.print("Ooops, no BNO055 detected ... Check your wiring or I2C ADDR!");
    while(1);
  }

  delay(1000);

  bno.setExtCrystalUse(true);

  
  // prints all desired column headers to serial monitor
  Serial.print("X");
  Serial.print("\tY");
  Serial.print("\tZ_PID_Input");
  Serial.print("\tSetpoint_PID");
  Serial.print("\tServo_PID_Output");
  Serial.print("\tTemp_degC");
  Serial.print("\tSys_cal");
  Serial.print("\tG_cal");
  Serial.print("\tA_cal");
  Serial.print("\tM_cal");

  Serial.println(""); // new line for subsequent data output
}

void loop(void)
{
  // gets new sensor event
  sensors_event_t event;
  bno.getEvent(&event);
  
  Input = event.orientation.z; // BNO055 pitch input
  myPID.Compute(); // process with PID library
  myservo.write(Output); // servo outputs PID corrected values

  uint8_t temp = bno.getTemp(); // gets current temperature

  // prints all desired column headers to serial monitor
  Serial.print(event.orientation.x, 3);
  Serial.print("\t");
  Serial.print(event.orientation.y, 3);
  Serial.print("\t");
  Serial.print(event.orientation.z, 3);
  Serial.print("\t");
  Serial.print(Setpoint, 4);
  Serial.print("\t");
  Serial.print(Output, 3);
  Serial.print("\t");
  Serial.print(temp);
  Serial.print("\t");

  displayCalStatus(); // display calibration status for each sensor event

  Serial.println(""); // new line for next event 
  
  delay(BNO055_SAMPLERATE_DELAY_MS); // delay between data requests for sensor
}
