import java.io.*;
public class Map{
   
  PImage map;
  PImage[] mapTiles;
  String [][] mapGrid = new  String[50][50];
  public ArrayList<Blocks> tiles = new ArrayList();
  public ArrayList<Star> coins = new ArrayList();
  Map(){
    
    splitMap();
  }
  
  void splitMap(){
    map = loadImage("maptilesclear.png");
    mapTiles = new PImage[16];
    int index=0;
    for(int r=0; r<3; r++){
       for(int c=0; c<5; c++){
         mapTiles[index] = map.get(162*c, 162*r, 162, 162);
         index++;
       }
    }
  }
  void loadCSV(String filename){
    String[] lines = loadStrings(filename);
    for(int r=0; r<lines.length; r++){
       String[] blocks = split(lines[r], ";");
       for(int c=0; c<blocks.length; c++){
         mapGrid[r][c] = blocks[c];
         System.out.println(mapGrid[r][c]);
       }
    }
  }
  void saveCSV() throws IOException{
    StringBuilder builder = new StringBuilder();
    for(int r=0; r<10; r++){
      for(int c=0; c<10; c++){
         builder.append(mapGrid[r][c]+"");
         if(c<9)
           builder.append(";");
      }
      builder.append("\n");
    }
    BufferedWriter writer = new BufferedWriter(new FileWriter("map.csv"));
    writer.write(builder.toString());
    writer.close();
    System.out.println("hello");
  }
  void loadMap(){
  String[] lines = loadStrings("map.csv");
  for(int r=0; r<lines.length; r++){
     String[] blocks = split(lines[r], ";");
     for(int c=0; c<blocks.length; c++){
         if(mapGrid[r][c].equals("0")){
           tiles.add(new Blocks(81 + c * 162, 81 + r * 162, mapTiles[0]));
         }
         if(mapGrid[r][c].equals("1")){
            tiles.add(new Blocks(81 + c * 162, 81 + r * 162, mapTiles[1]));
         }
         if(mapGrid[r][c].equals("2")){
           tiles.add(new Blocks(81 + c * 162, 81 + r * 162, mapTiles[2]));
         }
         if(mapGrid[r][c].equals("3")){
           tiles.add(new Blocks(81 + c * 162, 81 + r * 162, mapTiles[3]));
         }
         if(mapGrid[r][c].equals("4")){
           tiles.add(new Blocks(81 + c * 162, 81 + r * 162, mapTiles[4]));
         }
         if(mapGrid[r][c].equals("5")){
           tiles.add(new Blocks(81 + c * 162, 81 + r * 162, mapTiles[5]));
         }
         if(mapGrid[r][c].equals("6")){
           tiles.add(new Blocks(81 + c * 162, 81 + r * 162, mapTiles[6]));
         }
         if(mapGrid[r][c].equals("7")){
           tiles.add(new Blocks(81 + c * 162, 81 + r * 162, mapTiles[7]));
         }
         if(mapGrid[r][c].equals("8")){
           tiles.add(new Blocks(81 + c * 162, 81 + r * 162, mapTiles[8]));
         }
         if(mapGrid[r][c].equals("9")){
           tiles.add(new Blocks(81 + c * 162, 81 + r * 162, mapTiles[9]));
         }
         if(mapGrid[r][c].equals("10")){
           tiles.add(new Blocks(81 + c * 162, 81 + r * 162, mapTiles[10]));
         }
         if(mapGrid[r][c].equals("11")){
           tiles.add(new Blocks(81 + c * 162, 81 + r * 162, mapTiles[11]));
         }
         if(mapGrid[r][c].equals("12")){
           tiles.add(new Blocks(81 + c * 162, 81 + r * 162, mapTiles[12]));
         }
         if(mapGrid[r][c].equals("13")){
           tiles.add(new Blocks(81 + c * 162, 81 + r * 162, mapTiles[13]));
         }
         if(mapGrid[r][c].equals("14")){
           tiles.add(new Blocks(81 + c * 162, 81 + r * 162, mapTiles[14]));
         }
         if(mapGrid[r][c].equals("15")){
           mapTiles[15] = loadImage("coin.png");
           coins.add(new Star(37 + c * 74, 49 + r * 98));
         }
     }
   }
  }
  public void displayMap(){
    for(Blocks b: tiles){
      b.display();
    }
    for(Star c: coins){
      c.display();
    }
  }
}
