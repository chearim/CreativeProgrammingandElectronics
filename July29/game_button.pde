import processing.serial.*;

Serial myPort;  // Create object from Serial class
int val;      // Data received from the serial port

//import video library
import processing.video.*;
Movie myMovie;

//import audio library
import ddf.minim.*;
Minim minim;
AudioPlayer player;
AudioPlayer jumps;

PImage start;
PFont title;
PFont sub;
int stage;
float score = 0;
float newScore;

Player p;
Cactus c;
Birds b;
Rocks r;
Stars s;
boolean gameOver = false;



  void setup() {
    //initialize stage
    stage = 1;
    //upload start video
    myMovie = new Movie(this, "start_video.mp4");
    
    //upload fonts for the title page 
    title = createFont("ferrum.otf",30);
    sub = createFont("invasion.TTF",30);
    
    size(1000, 700);
    p = new Player();
    c = new Cactus();
    b = new Birds();
    r = new Rocks();
    s = new Stars();
    
   //load background music
   minim = new Minim(this);
   player = minim.loadFile("background_music.mp3");
   
   //load jump sound
   minim = new Minim(this);
   jumps = minim.loadFile("jump.mp3");
   
   String portName = Serial.list()[0];
   myPort = new Serial(this, portName, 9600);
  }
  
  void draw(){
    if ( myPort.available() > 0) {  // If data is available,
      val = myPort.read();         // read it and store it in val
    }
    println(val);
    
    //title video page with starting instructions
    if (!gameOver && stage ==1){
      image(myMovie,0, 0, width, height);
      myMovie.play();
      textAlign(CENTER);
      textFont(title);
      textSize(70);
      fill(#1405A5);
      text("The Journey", width/2,150);
      textFont(sub);
      textSize(20);
      text("Jump to survive",width/2,195);
      fill(#FFFFFF);
      textSize(27);
      text("Press any key to start game",width/2,600);
      if(val == 1){
        button();
        stage = 2;
        player.play();
      }
    }
    //once started, game starts with score tracker
    else if (!gameOver && stage ==2){
      background();
      s.display();
      p.display();
      p.move();
      c.display();
      c.move();
      r.display();
      r.move();
      b.display();
      b.move();
      //score box 
      fill(#000000);
      stroke(#000000);
      rect(680, -140, 200,60);
      textAlign(RIGHT);
      textFont(sub);
      textSize(25);
      fill(#FFFFFF);
      //show score 
      text(score, width-150,-105);
      newScore = score;
      check();
      button();
    }
    //game over page with score and option to restart
    else if (gameOver){
      background();
      textAlign(CENTER);
      textFont(title);
      textSize(70);
      fill(#FFFFFF);
      text("Game Over", width/2,150);
      textFont(sub);
      textSize(20);
      //restart option
      text("Press any key to restart",width/2,220);
      textSize(27);
      //score
      text ("Score:", width/2 - 55,180);
      text (newScore, width/2 + 55,180);
      b.display();
      b.move();
      if(val == 1){
        button();
        gameOver = false;
        stage = 2;
      }
    }
  }
  
  //read start video
  void movieEvent (Movie m){
    m.read();
  }
  
  //player jumps when space bar is pressed, o quits game 
  void button(){
    if (val == 1){
      jumps.play();
      p.jump();
    }
  }
  
  //check if player collides with obstacles
  void check(){
    if(p.x+p.r > c.x1-25 && p.y+p.r > c.y1){
      gameOver = true;
      score = 0;
    }
    else if(p.x+p.r > r.x1 && p.y+p.r > r.y1){
      gameOver = true;
      score = 0;
    }
    else {
      score = score + .04;
    }
  }
