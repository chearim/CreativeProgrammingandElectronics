/*
the intensity of 3 LED lights are controlled by a photoresistor. Once at the brightest level, the built-in LED lights up. 
*/

int pResistor = A0;//initialize analog pin A0
int switchPos = A2;//initialize analog pin A2
int ledY = 11;// initialize digital pin 11, output regulating the brightness of Yellow LED
int ledR = 10;//initialize digital pin 10, output regulating the brightness of Red LED
int ledG = 9;//initialize digital pin 9, output regulating the brightness of Green LED
int light=0;// initialize variable light
int switchValue = 0; // initialize variable switchValue

  
void setup()
{
  Serial.begin(9600);
  pinMode(ledY,OUTPUT);
  pinMode(ledR,OUTPUT);
  pinMode(ledG,OUTPUT);
  pinMode(pResistor, INPUT);
  pinMode(switchPos, INPUT);
}


void loop(){
    light = analogRead(pResistor);
  Serial.println(light);//pring light values

  int switchVal = digitalRead(A2); 

  if (switchVal == HIGH) {//determines whether switch is on

    //if environment is dark, all lights are off
    if(light > 190){
      analogWrite(ledY, LOW); 
      analogWrite(ledR, LOW);
      analogWrite(ledG, LOW);
      digitalWrite(LED_BUILTIN, LOW);
    }
    //if environment is very bright, turn on built in LED
    else if ( light < 20){
      digitalWrite(LED_BUILTIN, HIGH); 
      delay(2);
    }
    else{
      analogWrite(ledY, 255-light);// gradually turn on yellow LED as brightness increases
      if( light < 100){
        analogWrite(ledR, 255-light);// gradually turn on red LED next as brightness increases
    }
      else {
        analogWrite(ledR, LOW);// turn off red LED when not in range
    }
      if( light < 60){
        analogWrite(ledG, 255-light);// gradually turn on green LED as brightness increases
      }
      else {
        analogWrite(ledG, LOW);// turn off green LED when not in range
      }
      delay(2);// 
    }
  }
  else {
    //if switch is off, all lights are off 
    analogWrite(ledY, LOW);
    analogWrite(ledR, LOW);
    analogWrite(ledG, LOW);
    digitalWrite(LED_BUILTIN, LOW);
  }
}
