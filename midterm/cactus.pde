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
