int Val;
int PreVal = 0;
int Sensor = 8;
int TimeArray[20];
int TimeDiffArray[19];
int m = 5;
int n = 0;
int sum = 0;
float avg;
float rps1, rps3;

void setup() {
  // put your setup code here, to run once:
Serial.begin(9600);
pinMode(Sensor,INPUT);
}

void loop() {
  
   
  Val = digitalRead(Sensor);
 // Serial.println(Val);
  if(Val == 1 && PreVal == 0){
    TimeArray[n] = millis();
    Serial.println(TimeArray[n]);
    n += 1;
    PreVal = 1;
  }
  else if(Val == 1 && PreVal == 1){
    PreVal = 1;
  }
  else{
    PreVal = 0;
  }

  if(n == m)
  {
    Serial.println("");
    for(int i = 0;  i < m-1; i++){
      TimeDiffArray[i] = TimeArray[i+1] - TimeArray[i]; 
      Serial.println(TimeDiffArray[i]);   
    }
    for(int j =0; j < m-1; j++){
      sum += TimeDiffArray[j];
    }
    avg = sum/m-1;
    rps1 = ((18*1000)/(360*avg));
    rps3 = rps1*2.5;
    float time3 = 1/(4*rps3);

    Serial.println("");
    Serial.println(avg);
    Serial.println(sum);
    Serial.print("Speed in revolutions per second is: ");
    Serial.println(rps1);
    Serial.print("Time for servo action: ");
    Serial.println(time3);
    delay(5000);
    n=0;
  sum = 0;
  avg = 0;
   
  }

}
