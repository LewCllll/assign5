class Ball {
  float bx = width/2;
  float by = height - 37;
  float bxSpeed;
  float bySpeed = -3;
  float bSize;
  
  Ball(float size){
    bSize = size;
  }
  
  void display(){
    noStroke();
    ellipse(bx, by, bSize, bSize);
  }
  
  void move(){
    
    bx += bxSpeed;
    by += bySpeed;
    
    if(bx < 0 || bx > width){
      bxSpeed *= -1;
    }
    
    if(by < 0 || by > height - 10){
      bySpeed *= -1;
    }
    
    if(by > bar.ry && 
       bx < ( bar.rx + bar.rLength/2 ) && 
       bx > ( bar.rx - bar.rLength/2) ){
      bySpeed *= -1;
    }
    
  }
  
}
