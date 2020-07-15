Cactus c;
Birds b;
Rocks r;
boolean gameOver = false;


  void setup() {
    size(1000, 700);
    p = new Player();
    c = new Cactus();
    b = new Birds();
    r = new Rocks();
  }
  
  void draw(){
    background();
    if (!gameOver){
      p.display();
      p.move();
      c.display();
      c.move();
      r.display();
      r.move();
      b.display();
      b.move();
      check();
    }
  }
  
  //player jumps when space bar is pressed, o quits game 
  void keyPressed(){
    if (key == ' '){
      p.jump();
    }
    if (key == 'o'){
      noLoop();
    }
  }
  
  //check if player collides with obstacles
  void check(){
    if(p.x+p.r > c.x1-25 && p.y+p.r > c.y1){
      gameOver = true;
    }
    else if(p.x+p.r > r.x1 && p.y+p.r > r.y1){
      gameOver = true;
    }
  }
  
  //background
  int Y_AXIS = 1;
color c1, c2;


void background() {
  //gradient
  setGradient(0, 0, width, 450, color(#1405A5), color(#FF791F), Y_AXIS);
  
  //sun
  push();
  translate(width/2, height/2);
  fill(#FCF512);
  circle(0,0,100);
  pop();
 
  
  //mountains
  push();
  fill(#EA782B);
  stroke(#EA782B);
  strokeWeight(20);
  strokeJoin(ROUND);
  rect(0, 440, width,200);
  triangle(2,500,100,280,400,500);
  triangle(800,320,400,620,1000,520);
  translate(width/2.7, height/2.2);
  triangle(100,30,1,170,250,170);
  triangle(200,50,30,120,300,120);
  pop();
  
  push();
  fill(#D16420);
  stroke(#D16420);
  strokeWeight(30);
  strokeJoin(ROUND);
  rect(0, 520, width,200);
  triangle(150,600,350,400,550,600);
  triangle(350,600,550,450,750,600);
  pop();
  
   push();
  fill(#A55B2D);
  stroke(#A55B2D);
  strokeWeight(30);
  strokeJoin(ROUND);
  rect(0, 580, width,200);
  triangle(10,420,0,600,350,650);
  triangle(1000,280,1000,600,700,650);
  triangle(1000,280,1000,600,550,650);
  triangle(850,650,650,400,450,650);
  pop();
  
  //ground
  fill(#2E1C03);
  stroke(#643D08);
  rect(0, 620, width,200);
  

  }

  //set gradient for the sky
  void setGradient(int x, int y, float w, float h, color c1, color c2, int axis ) {
    noFill();
    if (axis == Y_AXIS) {  // Top to bottom gradient
      for (int i = y; i <= y+h; i++) {
        float inter = map(i, y, y+h, 0, 1);
        color c = lerpColor(c1, c2, inter);
        stroke(c);
        line(x, i, x+w, i);
      }
    }  
}

//birds 
class Birds{
  float x2,y2;

  Birds(){
    x2 = 800;
    y2 = 200;
  }

  //draw birds
  void display(){
    noStroke();
    fill(#F2E6AB);
    translate(90,90);
    triangle(x2, y2, x2+20, y2-17, x2+15, y2-7);
    triangle(x2, y2, x2+8, y2-17, x2+7, y2-7);
    translate(50,50);
    triangle(x2, y2, x2+20, y2-17, x2+15, y2-7);
    triangle(x2, y2, x2+8, y2-17, x2+7, y2-7);
    
    
  }
  
  //move birds slowly to the left
  void move(){
    x2 = x2 - .5;
    if (x2 < 1){
      x2 = width;
    }
  }
}

//cactus
class Cactus{
  float x1,y1;

  Cactus(){
    x1 = width-100;
    y1 = 555;
  }

  //draw cactus
  void display(){
    frameRate(500);
    noStroke();
    fill(#ADA69D);
    rect(x1, y1, 15,80, 10,10, 0, 0);
    rect(x1-25, y1+10, 15,40, 10,10, 0, 0);
    rect(x1+20, y1+10, 15,20, 10,10, 0, 0);
    rect(x1-25, y1+40, 30,15, 0,0, 0, 10);
    rect(x1+10, y1+25, 25,15, 0,0, 10, 0);
    
  }
  
  //move cactus to the left
  void move(){
    x1=x1-4;
    if (x1 < 1){
      x1 = width;
    }
  }
}

//player
class Player{
  float x,y,r,gravity, velocity;
  PImage player;

  Player(){
    this.x = 60;
    this.y = 570;
    this.r=70;
    this.velocity = 0;
    this.gravity = .5;
    
    //load player image
    player = loadImage("character1.png");
  }
  
  //makes player jump 
  void jump(){
    this.velocity = -17;
  }
  
  //slowly drop player down when it reaches the top until it reaches the ground
  void move(){
    this.y += this.velocity;
    this.velocity += this.gravity;
    this.y = constrain(this.y, 0, 570);
  }
  
  //draw player
  void display(){
    fill(#FFFFFF);
    image(player,this.x, this.y, this.r-15, this.r);
  }
}

//rocks
class Rocks{
  float x1,y1;

  Rocks(){
    x1 = width+450;
    y1 = 635;
  }
  
  //draw rocks
  void display(){
    frameRate(500);
    noStroke();
    fill(#AAA194);
    arc(x1+35,y1-5,60,60,-PI, 0);
    fill(#A79E90);
    arc(x1,y1,40,30,-PI, 0);
  }
  
  //move rocks to the left
  void move(){
    x1=x1-4;
    if (x1 < 1){
      x1 = width;
    }
  }
}
