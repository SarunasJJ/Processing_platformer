public class Player{
  
  float position_x, position_y;
  float change_x = 0, change_y = 0;
  PImage spriteSheet;
  PImage[][] movementSheet;
  boolean inMotion;
  int currentDirection;
  float currentFrame;
  final int LEFT = 3, RIGHT = 2;
  int lives = 3;
  Player(){
    inMotion = false;
    currentDirection = RIGHT;
    currentFrame = 0;
    position_x = 100;
    position_y = 300;
    setupSprites();
  }
  void setupSprites(){
    //image 64x90 tarpai 24x90
    movementSheet = new PImage[4][4];
    spriteSheet = loadImage("character.png");
    for(int i=0; i<4; i++){
      for(int j=0; j<4; j++){
         movementSheet[i][j] = spriteSheet.get(64*j + 24*j, 90*i, 64, 82); 
      }
    }
  }
  
  void drawPlayer(){
     if(inMotion){
        image(movementSheet[currentDirection][int(currentFrame)],position_x,position_y);  
     } else {
        image(movementSheet[currentDirection][0], position_x, position_y); 
     }
  }
  
  void updatePlayer(int xDelta){
     currentFrame = (currentFrame + 0.15) % 4;
     inMotion = true;
     if(xDelta == 0){
       inMotion = false;
     } else if(xDelta == -8){
       currentDirection = LEFT;
     } else if(xDelta == 8){
       currentDirection = RIGHT;
     }
     
     change_x = xDelta;
   }
   
   public float getLeft(){
      return position_x - 32;
   }
   public float getRight(){
      return position_x + 32;
   }
   public float getTop(){
      return position_y - 45;
   }
   public float getBottom(){
      return position_y + 45;
   }
   public void setLeft(float x){
      position_x = x + 32;
   }
   public void setRight(float x){
      position_x = x - 32;
   }
   public void setTop(float y){
      position_y = y + 45;
   }
   public void setBottom(float y){
      position_y = y - 45;
   }
   

}
