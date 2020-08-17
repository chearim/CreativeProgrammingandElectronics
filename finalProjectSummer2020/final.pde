/*****************************************************************************************/
//Chearim Park                                                                           //
//Final_Project (8/10/20)                                                                //
//In this project, I create a smart planter using a soil moisture sensor, temperature    // 
//sensor, and oled display. Users will be signaled to either give the plant more water or//
//sunlight based on an animated face shown on the screen.                                //
/*****************************************************************************************/

//libraries
#include <SPI.h>
#include <Wire.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>
#include <Fonts/FreeSans9pt7b.h>
#include <Fonts/FreeSans18pt7b.h>
#include <Fonts/FreeSans12pt7b.h>

//define oled display
#define OLED_RESET 0
Adafruit_SSD1306 display(OLED_RESET);

//define pins
int soilPin = A0; 
int tempPin = A1;

//define soil moisutre and temperature values 
float soilValue;
float tempValue;

//timed event varibales 
const unsigned long eventTime_soil = 3000;
const unsigned long eventTime_temp = 3000;
unsigned long previousTime_soil = 0;
unsigned long previousTime_temp = 0;
unsigned long previousTime_1 = 0;

//base variables
int pos_y = 20;
int pos_y2 = 29;
int pos_y3 = 26;
int pos_x1 = 25;
int pos_x2 = 105;
int pos_x3 = 65;
float Y = 2;
float X = 3;
int r = 5;
int R = 1;

//thirsty variables
int tongue_y = 35;
int tongue_height = 1;

//sick variables
int cheek_pos_x = 47;
int cheek_pos_x2 = 45;
int cheek_pos_x3 = 83;
int cheek_pos_x4 = 85;
int cheek_x = 1;

//hot variables
int sweat_pos_y = 10;
int sweat_pos_y2 = 5;
int mouth_pos_y = 47;
int sweat_y = 1;
int mouth_y = 2;

//cold variables
int teeth_width = 1;
int teeth_pos_y = 36;
int teeth_x = 2;
int teeth_y = 1;


/*****************************************************************************************/

void setup() {

  Serial.begin(9600);  //initiate serial communication  
  display.begin(SSD1306_SWITCHCAPVCC, 0x3C);  //begin oled display
  display.display();
  display.clearDisplay();
  display.setFont(&FreeSans9pt7b); //set font
  display.setTextColor(WHITE);  //set color to white
  display.setCursor(0,0);  //set cursor to lop left corner
}

/******************************************************************************************/

void loop() {

  unsigned long currentTime = millis();  

  if(currentTime - previousTime_soil >= eventTime_soil){//get soil moisture without delay
    Serial.print("Soil Moisture: ");
    soilValue = analogRead(soilPin);
    Serial.println(soilValue);

    //update timing for the next event
    previousTime_soil = currentTime;
  }
  
  if(currentTime - previousTime_temp >= eventTime_temp){ //get temperature  without delay
    Serial.print("Temperature: ");
    tempValue = analogRead(tempPin) * 0.48828125;
    Serial.println(tempValue);

    //update timing for the next event
    previousTime_temp = currentTime;
  }
  
  if (soilValue > 900){//if the soil is dry then make face express thirst
    thirsty();
    thirsty_move();
  }
  else if (soilValue < 300){//if the soil is too damp then make face express sickness
    sick();
    sick_move();
  }
  else if (400<soilValue<900 && tempValue > 70){ //if the soil is at a good moisutre level and the temperature is over 80 f then make face sweat
    hot();
    hot_move();
  }
  else if (400 < soilValue < 900 && tempValue < 60){//if the soil is at a good moisutre level and the temperature is less than 60 f then make face shiver
    cold();
    cold_move();
  }
  else if (400 < soilValue < 900 && 60 < tempValue < 80){ //else, the face is happy
    base();
    base_move();
  }
}

/******************************************************************************************/
void thirsty() {//face when thirsty
  display.clearDisplay();
  display.drawLine(16,17,24,9, WHITE); //left brow
  display.fillCircle(25, 20, 5, WHITE); //left eye
  display.drawLine(105,9,113,16, WHITE); //right brow
  display.fillCircle(105, 20, 5, WHITE); //right eye
  display.fillRoundRect(53,25,27,20, 7, WHITE); //mouth
  display.fillRoundRect(58,tongue_y,17,25, 8, WHITE); //tongue
  display.display();
}

void thirsty_move() {//tongue moves up and down to resemble panting
  const unsigned long eventTime = 150;
  unsigned long currentTime = millis();
  if(currentTime - previousTime_1 >= eventTime){
    tongue_y = tongue_y - tongue_height;

    if (tongue_y < 30){
      tongue_height = -1;
    }
    if (tongue_y > 35){
      tongue_height = 1;
    }
    previousTime_1 = currentTime;
  }
}

void base() {//happy face
  display.clearDisplay();
  display.fillCircle(pos_x3,pos_y2,14, WHITE); //mouth
  display.fillCircle(pos_x3,pos_y3,15, BLACK); //background
  display.fillCircle(pos_x1, pos_y, r, WHITE); //left eye
  display.fillCircle(pos_x2, pos_y, r, WHITE); //right eye
  display.display();
}

void base_move() {//moving eyes and mouth 
  const unsigned long eventTime = 300;
  unsigned long currentTime = millis();
  if(currentTime - previousTime_1 >= eventTime){
    pos_x1 = pos_x1 + X;
    pos_y = pos_y - Y;
    pos_y2 = pos_y2 - Y;
    pos_y3 = pos_y3 - Y;
    pos_x2 = pos_x2 + X;
    pos_x3 = pos_x3 + X;
    
    if ( pos_y < 18){
      r = r - R;
    }
    if(pos_y <18 && r < 3){
      Y = 0;
      X = -2;
      r = 5;
    }
    if(pos_x1 < 20){
      Y = -2;
      X = 2;
    }
    if(pos_y>20){
      Y = 2;
      X = 2;
      r = 4;
    }
    previousTime_1 = currentTime;
  }
}

void sick() {//sick face
  display.clearDisplay();
  display.drawLine(16,17,24,9, WHITE); //left brow
  display.fillCircle(25, 20, 5, WHITE); //left eye
  display.drawLine(105,9,113,16, WHITE); //right brow
  display.fillCircle(105, 20, 5, WHITE); //right eye
  display.fillCircle(65,35,14, WHITE); //mouth
  display.fillCircle(65,37,15, BLACK); //background
  display.fillCircle(cheek_pos_x,27,8, WHITE); //left cheek
  display.fillCircle(cheek_pos_x2,27,9, BLACK); //left background
  display.fillCircle(cheek_pos_x3,27,8, WHITE); //right cheek
  display.fillCircle(cheek_pos_x4,27,9, BLACK); //right background
  display.display();
}

void sick_move() {//cheeks close in 
  const unsigned long eventTime = 250;
  unsigned long currentTime = millis();
  if(currentTime - previousTime_1 >= eventTime){
    cheek_pos_x = cheek_pos_x - cheek_x;
    cheek_pos_x2 = cheek_pos_x2 - cheek_x;
    cheek_pos_x3 = cheek_pos_x3 + cheek_x;
    cheek_pos_x4 = cheek_pos_x4 + cheek_x;

    if (cheek_pos_x < 47){
      cheek_x = -1;
    }
    if (cheek_pos_x3 < 82){
      cheek_x = 1;
    }
    previousTime_1 = currentTime;
  }
}

void hot() {//face when hot
  display.clearDisplay();
  display.drawLine(16,17,24,9, WHITE); //left brow
  display.fillCircle(25, 20,5, WHITE); //left eye
  display.drawLine(105,9,113,16, WHITE); //right brow
  display.fillCircle(105,20,5, WHITE); //right eye
  display.fillRoundRect(53,25,27,25,7, WHITE); //mouth
  display.fillRect(53,mouth_pos_y,30,20,BLACK); // decrease y value
  display.fillTriangle(118,sweat_pos_y,122,sweat_pos_y,120,sweat_pos_y2, WHITE); //sweat
  display.display();
}

void hot_move() {//sweating
  const unsigned long eventTime = 100;
  unsigned long currentTime = millis();
  if(currentTime - previousTime_1 >= eventTime){
    sweat_pos_y = sweat_pos_y + sweat_y;
    sweat_pos_y2 = sweat_pos_y2 + sweat_y;
    mouth_pos_y = mouth_pos_y - mouth_y;

    if ( sweat_pos_y > 20){
      sweat_y=0;
    }
    if (mouth_pos_y < 35){
      mouth_y = -2;
    }
    if (mouth_pos_y > 45){
      mouth_y = 2;
    }
    previousTime_1 = currentTime;
  }
}

void cold() {//face when cold
  display.clearDisplay();
  display.drawLine(16,17,24,9, WHITE); //left brow
  display.fillCircle(25, 20, 5, WHITE); //left eye
  display.drawLine(105,9,113,16, WHITE); //right brow
  display.fillCircle(105, 20, 5, WHITE); //right eye
  display.fillRoundRect(51,28,30,14, 7, WHITE); //mouth 
  display.drawLine(57,27,57,43, BLACK); //teeth vert1 line
  display.drawLine(65.5,27,65.5,43, BLACK); //teeth vert2 line
  display.drawLine(74,27,74,43, BLACK); //teeth vert1 line
  display.fillRect(50,teeth_pos_y,32,teeth_width, BLACK); //teeth horizontal line
  display.display();
}

void cold_move() { //shivering
  const unsigned long eventTime = 200;
  unsigned long currentTime = millis();
  if(currentTime - previousTime_1 >= eventTime){
    teeth_width = teeth_width + teeth_x;
    teeth_pos_y = teeth_pos_y - teeth_y;
    if (teeth_width > 2){
      teeth_x = -2;
      teeth_y = -1;
    }
    if (teeth_width < 1){
      teeth_x = 2;
      teeth_y = 1;
    }
    previousTime_1 = currentTime;
  }
}

void happy() {//face when happpy
  display.clearDisplay();
  display.fillCircle(25, 20, 5, WHITE); //left eye
  display.fillCircle(105, 20, 5, WHITE); //right eye
  display.fillRect(53,20,30,10,BLACK); // background
  display.fillRoundRect(53,25,27,25,7, WHITE); //mouth (decrease y value) 
  display.display();
}
