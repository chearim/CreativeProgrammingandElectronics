class Stars{
  float[] x = new float[100];
  float[] y = new float[100];
  float[] speed = new float[100];

  Stars(){
    
    // randomize star locations
    for(int i =0; i<100; i = i +2){
      x[i] = random(0,width + 400);
      y[i] = random(0,130);
      speed[i] = random(.2,1);
    }
  }
  
  //draw stars and move them to the left at varying speeds
  void display(){
    stroke(#FFFFFF);
    strokeWeight(5);
    
    int i = 0;
    while(i<100){
      point(x[i]-150,y[i]);
    
      x[i] = x[i] - speed[i];
      if(x[i]<0){
        x[i] = width;
      } 
      i++;
    }
  }
}
