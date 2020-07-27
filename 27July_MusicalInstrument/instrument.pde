/*
 * This code produces a metronome/drum and a ultrasonic sensor piano
 */


#include <Servo.h>
Servo myservo;                 //servo
int pos = 0;                   //servo position
int increment = 1;             //angle increment
int updateInterval = 10;       //delay
unsigned long lastUpdate = 0;  

int button = 2;      //switch in pin 2         
int buttonState;  
int buttonR = 4;     //button in pin 4
int rState;

int speaker = 10;      //Speaker Pin
int trigger = 7;       //Trigger Pin
int echo = 8;          // Echo Pin


void setup() {
  myservo.attach(3);
  pinMode(speaker,OUTPUT);
  pinMode(trigger,OUTPUT);
  pinMode(echo,INPUT);
}


void loop() {  

  unsigned long currentMillis = millis();
  buttonState = digitalRead(button);
  rState = digitalRead(buttonR);
  long duration, distance;         

/*
*if the switch is on and the different of current millisecond and last update is more than updateInterval, motor position 
*will increaseuntil it reaches 90 degrees. If that happens, the direction will change the other way until it reaches 0 degrees
 */
  if(buttonState == HIGH){
    if((currentMillis - lastUpdate) > updateInterval){   
        lastUpdate = currentMillis;
        pos += increment;
        myservo.write(pos);
      if ((pos >= 90) || (pos <= 0)){
        increment = -increment;
      }
    }
  }

/*
 * if the button is pressed, distance from hand to the ultrasonic sensor will be measured and a tone will be 
 * produced according to the measured length. 
 */
  if (rState == HIGH) {
  digitalWrite(trigger,LOW);
  delayMicroseconds(2);         
  digitalWrite(trigger,HIGH);      //send out a pulse from the trigger
  delayMicroseconds(5);
  digitalWrite(trigger,LOW);   
                
  duration = pulseIn(echo, HIGH); //receive echo
  distance = (duration/2)/29.1;   //convert time into distance(cm)
  
  if(distance>4&&distance<42)
  {
    if(distance>4&&distance<7)      //middle c
      tone(speaker,262,100);
    else 
      if(distance>8&&distance<11)
        tone(speaker,294,100);      //d
    else
      if(distance>12&&distance<15)
        tone(speaker,330,100);      //e
    else
      if(distance>16&&distance<19)
        tone(speaker,349,100);      //plays f
    else
      if(distance>20&&distance<23)
        tone(speaker,392,100);      //plays g
    else
      if(distance>24&&distance<27)
        tone(speaker,440,100);      //plays a
    else
      if(distance>28&&distance<31)
        tone(speaker,494,100);      //plays b
    else
      if(distance>32&&distance<35)
        tone(speaker,523,100);      //plays c
    }
  }
}
