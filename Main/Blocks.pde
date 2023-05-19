

public class Blocks{
  float position_x, position_y;
  PImage block;
  
  Blocks(float position_x, float position_y, PImage image){
    this.position_x = position_x;
    this.position_y = position_y;
    this.block = image;
    display();
  }
  
  public void display(){
    image(block, position_x, position_y); 
  }
  
   public float getLeft(){
      return position_x - 81;
   }
   public float getRight(){
      return position_x + 81;
   }
   public float getTop(){
      return position_y - 81;
   }
   public float getBottom(){
      return position_y + 81;
   }
   public void setLeft(float x){
      position_x = x + 81;
   }
   public void setRight(float x){
      position_x = x - 81;
   }
   public void setTop(float y){
      position_y = y + 81;
   }
   public void setBottom(float y){
      position_y = y - 81;
   }
   
  
}
