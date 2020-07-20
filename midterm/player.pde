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
  
  //make player jump 
  void jump(){
    this.velocity = -15;
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
