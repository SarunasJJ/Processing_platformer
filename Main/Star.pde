public class Star{
  float position_x, position_y;
  PImage image = loadImage("coin.png");
  Star(float position_x, float position_y){
    this.position_x = position_x;
    this.position_y = position_y;
    display();
  }
  
  public void display(){
    image(image , position_x, position_y);
  }
     public float getLeft(){
      return position_x - 37;
   }
   public float getRight(){
      return position_x + 37;
   }
   public float getTop(){
      return position_y - 49;
   }
   public float getBottom(){
      return position_y + 49;
   }
   public void setLeft(float x){
      position_x = x + 37;
   }
   public void setRight(float x){
      position_x = x - 37;
   }
   public void setTop(float y){
      position_y = y + 49;
   }
   public void setBottom(float y){
      position_y = y - 49;
   }
   
}
