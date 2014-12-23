class Brick{
  float kWidth = 40;
  float kHeight = 40;
  float kx;
  float ky;
  boolean die = false;
  
  Brick(float x, float y){
    kx = x;
    ky = y;
  } 
  
  void display(){
    noStroke();
    fill(255);
    rect(kx, ky, kWidth, kHeight);
  }

}


