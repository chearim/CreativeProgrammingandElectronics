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
