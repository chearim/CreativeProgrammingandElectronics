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
    x2 = x2 - .4;
    
    if (x2 < 1){
      x2 = width;
    }
  }
}
