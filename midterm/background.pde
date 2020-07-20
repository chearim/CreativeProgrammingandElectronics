/*
Drawn background during game play
*/


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
