#include <Wire.h>
#include <Adafruit_Sensor.h>
#include <Adafruit_BNO055.h>
#include <utility/imumaths.h>
#include <Servo.h>
#include <PID_v1.h>
#include <SPI.h>
#include <SdFat.h>


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

// defines relevant architecture required for sd file writing
const byte chipSelect = 10;
SdFat sd;
SdFile dataFile;

char filename[16]; // make it long enough to hold your longest file name, plus a null terminator
char foldername[16]; // make it long enough to hold your longest file name, plus a null terminator


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
  dataFile.print(system, DEC);
  dataFile.print("\t");
  dataFile.print(gyro, DEC);
  dataFile.print("\t");
  dataFile.print(accel, DEC);
  dataFile.print("\t");
  dataFile.print(mag, DEC);

}


/* Configures File for Data Logging */
void fileConfig(void)
{
  int n = 0;
  snprintf(filename, sizeof(filename), "data%03d.csv", n); // includes a three-digit sequence number in the file name
  while(sd.exists(filename)) {
    n++;
    snprintf(filename, sizeof(filename), "data%03d.csv", n);
  }
  dataFile.open(filename, O_RDWR | O_CREAT | O_AT_END);
  dataFile.print("X");
  dataFile.print("\tY");
  dataFile.print("\tZ_PID_Input");
  dataFile.print("\tSetpoint_PID");
  dataFile.print("\tServo_PID_Output");
  dataFile.print("\tTemp_degC");
  dataFile.print("\tSys_cal");
  dataFile.print("\tG_cal");
  dataFile.print("\tA_cal");
  dataFile.print("\tM_cal");
  dataFile.println(""); // new line for subsequent data output

  dataFile.close();
}


/* Function that runs before everything else and initializes system */
void setup(void)
{
  Serial.begin(115200);
  while (!Serial) {}

  Serial.print("Initializing SD card...");
  
  pinMode(10, OUTPUT);

  if (!sd.begin(10)) {
    Serial.println("Initialization failed!");
    return;
  }

  myservo.attach(SERVO_PIN);
  myservo.write(90); // starts servo at home position of 90deg

  Input = 90; // initial "home" servo position
  Setpoint = 90; // resting point in z plane of my current setup (NOTE: subject to change once mounted on actual payload)
  myPID.SetMode(AUTOMATIC); // activate PID

  int g = 0;
  snprintf(foldername, sizeof(foldername), "bootsequence%03d", g); // includes a three-digit sequence number in the file name
  while(sd.exists(foldername)) {
    g++;
    snprintf(foldername, sizeof(foldername), "bootsequence%03d", g);
  }

  sd.mkdir(foldername);
  sd.chdir(foldername);
  
  // initialize the sensor
  if (!bno.begin())
  {
    Serial.print("Ooops, no BNO055 detected ... Check your wiring or I2C ADDR!");
    while (1);
  }

  delay(1000);

  bno.setExtCrystalUse(true);

}


/* Function responsible for collecting and logging data */
void loop(void)
{

  fileConfig();

  for (int counter = 0; counter < 200; counter++)
  {
    dataFile.open(filename, O_RDWR | O_CREAT | O_AT_END);
    
    sensors_event_t event;
    bno.getEvent(&event);

    Input = event.orientation.z; // BNO055 pitch input
    myPID.Compute(); // process with PID library
    myservo.write(Output); // servo outputs PID corrected values

    uint8_t temp = bno.getTemp(); // gets current temperature
  
    // prints all desired column headers to serial monitor
    dataFile.print(event.orientation.x, 3);
    dataFile.print("\t");
    dataFile.print(event.orientation.y, 3);
    dataFile.print("\t");
    dataFile.print(event.orientation.z, 3);
    dataFile.print("\t");
    dataFile.print(Setpoint, 4);
    dataFile.print("\t");
    dataFile.print(Output, 3);
    dataFile.print("\t");
    dataFile.print(temp);
    dataFile.print("\t");

    displayCalStatus(); // display calibration status for each sensor event

    dataFile.println(""); // new line for next event

    dataFile.close();
  
    delay(BNO055_SAMPLERATE_DELAY_MS); // delay between data requests for sensor
  }
}
