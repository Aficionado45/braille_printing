#include<Servo.h>     // Including Servo library
#include<SoftwareSerial.h>
#define TxD 4
#define RxD 2

SoftwareSerial bluetoothSerial(TxD, RxD);


int Servo_1_Pin = 9;
int Servo_2_Pin = 10;
int Servo_3_Pin = 11;
int DefaultAngle = 90;
int Angle1 = 45;
int Angle2 = 135;
int Angle3 = 135;
int ServoTime = 100;     // Servo delay time

char C;
String Code = "";// Recieved Code
int n = 0;                  // Length of Recieved Code

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

  // Defining Servo Pins
  Servo_1.attach(Servo_1_Pin);
  Servo_2.attach(Servo_2_Pin);
  Servo_3.attach(Servo_3_Pin);


  // Lenght of Code:

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
    //delay(100);
  }
  Serial.println("");
  Serial.print("Recieved Code is: ");
  Serial.println(Code);
  n = Code.length();

  // Splitting the recieved code in to 3 arrays for 3 servos:
  for (int i = 0; i < n; i++) {
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


  int IntServo_1 = CodeServo_1.toInt();
  int IntServo_2 = CodeServo_2.toInt();
  int IntServo_3 = CodeServo_3.toInt();

  for (int j = 0; j < n / 3; j++) {
    if (CodeServo_1[j] == '1') {
      Servo_1.write(Angle1);
      //delay(ServoTime);
      //Servo_1.write(DefaultAngle);
      Serial.println(CodeServo_1[j]);
    }
    else {
      Servo_1.write(DefaultAngle);
      Serial.println(CodeServo_1[j]);
    }

    if (CodeServo_2[j] == '1') {
      Servo_2.write(Angle2);
      //delay(ServoTime);
      //Servo_2.write(DefaultAngle);
      Serial.println(CodeServo_2[j]);
    }
    else {
      Servo_2.write(DefaultAngle);
      Serial.println(CodeServo_2[j]);
    }

    if (CodeServo_3[j] == '1') {
      Servo_3.write(Angle3);
      //delay(ServoTime);
      //Servo_3.write(DefaultAngle);
      Serial.println(CodeServo_3[j]);
    }
    else {
      Servo_3.write(DefaultAngle);
      Serial.println(CodeServo_3[j]);
    }

    delay(500);
  }
  delay(2000);

  Code = "";// Recieved Code
  n = 0;                  // Length of Recieved Code

  CodeServo_1 = "";
  CodeServo_2 = "";
  CodeServo_3 = "";

}
