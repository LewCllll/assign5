Ball ball;
Bar bar;
Brick[] bList;
int life = 3;
int ballStat = 0;
int status = 0;
int count = 0;

/*
0 = game start
1 = game run
2 = game win
3 = game lose
*/

void setup(){
  size(640, 480);
  ball = new Ball(16);
  bar = new Bar(100);
  bList = new Brick[40];
  brickMaker(40, 10);
}

void draw(){
  switch(status) {

  case 0:
  background(150);
  textAlign(CENTER);
  textSize(80);
  text("GAME START!", width/2, height/2);
  break;

  case 1:
  background(150);
  drawLife();
  checkLife();
  
  drawBrick();
  checkBrick();
  
  bar.display();
  bar.move();
  
  ball.display();
  ballStatus();
  
  break;

  case 2:
  background(150);
  textAlign(CENTER);
  textSize(80);
  text("YOU WIN!", width/2, height/2);  
  break;

  case 3:
  background(150);
  textAlign(CENTER);
  textSize(80);
  text("YOU LOSE!", width/2, height/2);
  break;

  }
  
}

// Bricks

void drawBrick(){
  for(int i = 0; i < bList.length; i++){
    Brick brick = bList[i];
    if(brick != null && !brick.die){
      brick.display();
    }
  }
}

void brickMaker(int bNum, int bCol){
  for(int i = 0; i < bNum; i++){
    for(int j = 0; j < bCol; j++){
      float x = 50 + i % bCol * 55;
      float y = 50 + i / bCol * 55;        
      bList[i] = new Brick(x, y);
    }
  }
}


void killBrick(Brick obj){
  obj.die = true;
  obj.kx = 2000;
  obj.ky = 2000;
}
  
void checkBrick(){
  for(int i = 0; i<bList.length; i++){
    Brick brick = bList[i];
    
    boolean collisionDetected = isCollidingCircleRectangle(ball.bx, ball.by,
      ball.bSize/2, brick.kx, brick.ky, brick.kWidth, brick.kHeight);
    
    if(collisionDetected == true){
         killBrick(brick);
         count += 1;  
    }
  }     
  
  
  if(count == 40){
    status = 2;
  }
}

//Life

void drawLife() {
  fill(230, 74, 96);
  textSize(18);
  text("LIFE:", 42, 465);

  switch(life){
  case 3:
  ellipse(78, 459, 15, 15);
  ellipse(103, 459, 15, 15);
  ellipse(128, 459, 15, 15);
  break;
  
  case 2:
  ellipse(78, 459, 15, 15);
  ellipse(103, 459, 15, 15);
  break;
  
  case 1:
  ellipse(78, 459, 15, 15);
  break;
  
  case 0:
  status = 3;
  break;
  }
  
}

void checkLife(){
  if(ball.by > height - 10){
    life -= 1;
    ballStat = 0;
  }
  
}
         
void ballStatus(){
  switch(ballStat){
    case 0:
    ball.bx = mouseX;
    ball.by = height - 37;
    break;
    
    case 1:
    ball.move();
    break;
  }
}

void statusCtrl() {
  
  if (key == ENTER) {
    
    switch(status) {   
    case 0:
    status = 1;
    break;
    case 2:
    status = 1;
    reset();
    break;
    case 3:
    status = 1;
    reset();
    break;
    }
  }  
  
}

// Reset Game

void reset(){
  life = 3;
  ballStat = 0;
  count = 0;
  
  drawBrick();
  brickMaker(40, 10);
}

// Mouse & Key

void mouseClicked(){
  if(mouseButton == RIGHT){
    if(status == 1 && ballStat == 0){
    ballStat = 1;
    ball.bxSpeed = random(-5, 5);
    }
  }
}

void keyPressed(){
  statusCtrl();
}

boolean isCollidingCircleRectangle(
      float circleX,
      float circleY,
      float radius,
      float rectangleX,
      float rectangleY,
      float rectangleWidth,
      float rectangleHeight)
{
    float circleDistanceX = abs(circleX - rectangleX - rectangleWidth/2);
    float circleDistanceY = abs(circleY - rectangleY - rectangleHeight/2);
    float cornerDistance_sq = pow(circleDistanceX - rectangleWidth/2, 2) +
                              pow(circleDistanceY - rectangleHeight/2, 2);
 
    if (circleDistanceX > (rectangleWidth/2 + radius)) { return false; }
    if (circleDistanceY > (rectangleHeight/2 + radius)) { return false; }
 
    if (circleDistanceX <= (rectangleWidth/2)) { ball.bySpeed *= -1; return true; }
    else if (circleDistanceY <= (rectangleHeight/2) ) { ball.bxSpeed *= -1; return true; }
    else if ( cornerDistance_sq <= pow(radius,2) ) { ball.bxSpeed *= -1; }
 
    
    
    return (cornerDistance_sq <= pow(radius,2));
}
