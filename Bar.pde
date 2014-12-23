class Bar {
  float rx = width / 2;
  float ry = height - 30;
  float rSide = 15;
  float rLength;
  
  Bar(float leng){
    rLength = leng;
  }
  
  void display(){
    noStroke();
    rect(rx - rLength / 2, ry, rLength, rSide);
  }
  
  void move(){
    rx = mouseX;
  }
  
}
