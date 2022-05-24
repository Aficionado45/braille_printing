#include<Servo.h>     // Including Servo library
#include<SoftwareSerial.h>
#define TxD 4
#define RxD 2

SoftwareSerial bluetoothSerial(TxD, RxD);

// For Speed Sensor:
int Val;
int PreVal = 0;
int Sensor = 8;
int n = 0;
const int m = 2;
int TimeArray[m] ;
int TimeDiffArray[(m-1)] ;
int sum = 0;
float avg;
float rps1, rps3;
float time3 = 0;

// For Servos:
int Servo_1_Pin = 9;
int Servo_2_Pin = 10;
int Servo_3_Pin = 11;
int DefaultAngle = 90;
int Angle1 = 45;
int Angle2 = 135;
int Angle3 = 135;
int ServoTime = 100;        // Servo delay time

char C;
String Code = "";          // Recieved Code
int x = 0;                  // Length of Recieved Code

String CodeServo_1 = "";
String CodeServo_2 = "";
String CodeServo_3 = "";

Servo Servo_1;      //Declaring Servo name as 'Servo_1'
Servo Servo_2;      //Declaring Servo name as 'Servo_2'
Servo Servo_3;      //Declaring Servo name as 'Servo_3'



void setup() {

  // Enabling Serial Monitor:
  Serial.begin(9600);

  // Enabling Bluetooth module:
  bluetoothSerial.begin(9600);

  pinMode(Sensor,INPUT);
  
  // Defining Servo Pins
  Servo_1.attach(Servo_1_Pin);
  Servo_2.attach(Servo_2_Pin);
  Servo_3.attach(Servo_3_Pin);
}




void loop() {

  int a = 1;
  while (a == 1) {
    if (bluetoothSerial.available()) {
      C = bluetoothSerial.read();
      if (C == '9') {
        a = 0;
      }

      //Serial.print(C);
      if (C == '0' || C == '1') {
        Code += C;
      }
    }
  }
  
  Serial.println("");
  Serial.print("Recieved Code is: ");
  Serial.println(Code);
  x = Code.length();
  
  // Splitting the recieved code in to 3 arrays for 3 servos:
  for (int i = 0; i < x; i++) {
    if (i % 3 == 0) {
      CodeServo_1 = CodeServo_1 + Code[i];
    }
    else if (i % 3 == 1) {
      CodeServo_2 = CodeServo_2 + Code[i];
    }
    else {
      CodeServo_3 = CodeServo_3 + Code[i];
    }
  }
  
  //Printing Codes for all servos:
  Serial.print("Code for Servo_1 is: ");
  Serial.println(CodeServo_1);

  Serial.print("Code for Servo_2 is: ");
  Serial.println(CodeServo_2);

  Serial.print("Code for Servo_3 is: ");
  Serial.println(CodeServo_3);


  // Converting to integer
  int IntServo_1 = CodeServo_1.toInt();
  int IntServo_2 = CodeServo_2.toInt();
  int IntServo_3 = CodeServo_3.toInt();

  Serial.println("CheckPoint1 Reached");
  //delay(100);

  for (int j = 0; j < int(x / 3); j++) {
    int b = 1;
    while(b == 1){  
      
      // Speed Sensor  
      Val = digitalRead(Sensor);
      //Serial.println(Val);
      if(Val == 1 && PreVal == 0){
        TimeArray[n] = millis();
        //Serial.println(TimeArray[n]);
        n += 1;
        Serial.print("Value of n: ");
        Serial.println(n);
        PreVal = 1;
      }
      else if(Val == 1 && PreVal == 1){
        PreVal = 1;
      }
      else{
        PreVal = 0;
      }
      
      if(n == m){
        for(int i = 0;  i < m-1; i++){
          TimeDiffArray[i] = TimeArray[i+1] - TimeArray[i]; 
          //Serial.println(TimeDiffArray[i]);   
        }
        
        for(int j =0; j < m-1; j++){
          sum += TimeDiffArray[j];
        }
        
        avg = sum/(m-1);
        rps1 = ((18*1000)/(360*avg));
        rps3 = rps1*2.5;
        time3 = 1000/(4*rps3);
      
        //Serial.println("");
        //Serial.println(avg);
        //Serial.println(sum);
        //Serial.print("Speed in revolutions per second is: ");
        //Serial.println(rps1);
        
        Serial.print("Time for servo action: ");
        Serial.print(time3);
        Serial.println(" ms");
        n=0;
        sum = 0;
        avg = 0;
      }
      
      //Serial.print("TIME:");
      //Serial.println(time3);
      
         
      if(time3 > 0){
        // x = Code.length()
        //Serial.print("Value of x: ");
        //Serial.println(x);
        Serial.println("CheckPoint2");
        
        if (CodeServo_1[j] == '1') {
          Servo_1.write(Angle1);
          //delay(ServoTime);
          //Servo_1.write(DefaultAngle);
          //Serial.println(CodeServo_1[j]);
        }
        else {
          Servo_1.write(DefaultAngle);
          //Serial.println(CodeServo_1[j]);
        }
      
        if (CodeServo_2[j] == '1') {
          Servo_2.write(Angle2);
          //delay(ServoTime);
          //Servo_2.write(DefaultAngle);
          //Serial.println(CodeServo_2[j]);
        }
        else {
          Servo_2.write(DefaultAngle);
          //Serial.println(CodeServo_2[j]);
        }
      
        if (CodeServo_3[j] == '1') {
          Servo_3.write(Angle3);
          //delay(ServoTime);
          //Servo_3.write(DefaultAngle);
          //Serial.println(CodeServo_3[j]);
        }
        else {
          Servo_3.write(DefaultAngle);
          //Serial.println(CodeServo_3[j]);
        }
        
        delay(time3);
        b = 0;
        time3 = 0;
      }
    }
  }
  delay(2000);  // Another code will be printed after 2 seconds
  Code = "";// Recieved Code
  x = 0;                  // Length of Recieved Code
  CodeServo_1 = "";
  CodeServo_2 = "";
  CodeServo_3 = "";
  Serial.println("Cleared. Ready for next command");
}
