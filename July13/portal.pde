float r = 20; 

//canvas size
void setup() {
  size(1500, 1500);
}

//draw background color, squares, and circles
void draw() {
  background(#0C2104);
  squares();
  circles();
}

//repeating squares from the center that grow in size 
void squares(){
  stroke(#FF93DB);
  strokeWeight(20);
  noFill();
  rectMode(CENTER);
  translate(width/2, height/2);
  rotate(PI/4);
  
  //repeat squares
  for(float i=3000; i > 5; i =i-80){
    square(0,0,r+i);
  }
  // Increase square size
  r++ ;

  // Start square over
  if (r > 5) {
    r++;
  } 
}

//repeating circles from the center that grow in size 
void circles(){
  stroke(#ED2D5A);
  strokeWeight(15);
  noFill();
  
  //repeat circles
  for(float i=2000; i > 1; i =i-60){
    circle(0,0,r+i);
  }
  // Increase circle size
  r=r+2 ;

  // Start circles over
  if (r > width/3) {
    r = 0;
  }
}
