boolean [] keys = new boolean[128];
Player player;
Map map;
Star stars;
float view_x;
float view_y;

final static float RIGHT_MARGIN = 600;
final static float LEFT_MARGIN = 200;
final static float VERTICAL_MARGIN = 50;
int editCol, editRow, editID;
int coinsCollected;
boolean isGameOver;
boolean editor;
int levelsBeat;
void setup(){
  size(1200,1000);
  imageMode(CENTER);
  player = new Player();
  map = new Map();
  map.loadCSV("map1.csv");
  map.loadMap();
  isGameOver = false;
  editor = false;
  view_x=0;
  view_y=0;
  coinsCollected = 0;
}

void draw(){
  if(isGameOver){
    text("Game over", view_x + width/2 - 200, view_y + height/2);
    if(player.lives == 0){
      text("You lost", view_x + width/2 - 200, view_y + height/2 + 100);
    }
    else{
      text("You won", view_x + width/2 - 200, view_y + height/2 + 100);
    }
    text("Press space to restart", view_x + width/2 - 200, view_y + height/2 + 200);
    if(keys[' '] && isGameOver){
    setup();
    }
  }
  else{
    background(11,16,69);
    textSize(48);
    text("Coins: " + coinsCollected , 40, 80);
    text("Lives: " + player.lives , 40, 160);
    if(editor){
      for(int i=0; i<3; i++){
        image(map.mapTiles[i], i*162, 0); 
      }
      PImage image = loadImage("coin.png");
      image(image, 3*162, 0);
      edit();
    }
    move();
    scroll();
    resolveCollision(player, map.tiles);
    coinCollision();
    map.displayMap();
    player.drawPlayer();
    checkDeath();
  }
}

void move(){
  int xDelta = 0;
  if(keys['a']){
    xDelta = xDelta - 8;
  }
  if(keys['d']){
    xDelta = xDelta + 8;
  }
  if(keys['w'] && isStanding(player, map.tiles)){
    player.change_y = -20;
  }
  player.updatePlayer(xDelta);
}
void edit(){
  if(mouseX<648 && mouseY<162 && mousePressed){
     editCol = int(mouseX/162);
     editRow = int(mouseY/162);
     editID = editRow *3 + editCol;
     if(editID == 3){
       editID=15;
     }
  }
  if(editID<3){
    image(map.mapTiles[editID], mouseX, mouseY, 162, 162);
  }
  if(editID == 15){
    image(map.mapTiles[editID], mouseX, mouseY, 162, 162);
  }
}

boolean checkCollision(Player p, Blocks b){
  boolean noXOverlap = p.getRight() <= b.getLeft() || p.getLeft() >= b.getRight();
  boolean noYOverlap = p.getBottom() <= b.getTop() || p.getTop() >= b.getBottom();
  if(noXOverlap || noYOverlap){
    return false;
  } else{
    return true;
  }
}

public ArrayList<Blocks> checkCollisionList(Player p, ArrayList<Blocks> blocks){
  ArrayList<Blocks> collisionList = new ArrayList<Blocks>();
  for (Blocks b: blocks){
    if(checkCollision(p, b)){
      collisionList.add(b);
    }
  }
  return collisionList;
}

public void coinCollision(){
  ArrayList<Star> coin_list = checkCoinCollisionList(player, map.coins);
  if(coin_list.size()>0){
    for(Star coin: coin_list){
      coinsCollected++;
      (map.coins).remove(coin);
    }
  }
  if((map.coins).size() == 0){
    isGameOver=true;  
  }
}
boolean checkCoinCollision(Player p, Star c){
  boolean noXOverlap = p.getRight() <= c.getLeft() || p.getLeft() >= c.getRight();
  boolean noYOverlap = p.getBottom() <= c.getTop() || p.getTop() >= c.getBottom();
  if(noXOverlap || noYOverlap){
    return false;
  } else{
    return true;
  }
}
public ArrayList<Star> checkCoinCollisionList(Player p, ArrayList<Star> coins){
  ArrayList<Star> collisionList = new ArrayList<>();
  for (Star c: coins){
    if(checkCoinCollision(p, c)){
      collisionList.add(c);
    }
  }
  return collisionList;
}
public void resolveCollision(Player p, ArrayList<Blocks> blocks){
  p.change_y += 0.6;
  p.position_y += p.change_y;
  
  ArrayList<Blocks> collisionList = checkCollisionList(p, blocks);
  if(collisionList.size() >0){
    Blocks block = collisionList.get(0);
    if(p.change_y > 0){
      p.setBottom(block.getTop());
    } else if(p.change_y < 0){
      p.setTop(block.getBottom()); 
    }
    p.change_y = 0;
  }
  p.position_x += p.change_x;
  collisionList = checkCollisionList(p, blocks);
  if(collisionList.size() >0){
    Blocks block = collisionList.get(0);
    if(p.change_x > 0){
      p.setRight(block.getLeft());
    } else if(p.change_x < 0){
      p.setLeft(block.getRight()); 
    }
    p.change_x = 0;
  }
}

public boolean isStanding(Player p, ArrayList<Blocks> b){
   p.position_y +=5;
   ArrayList<Blocks> collisionList = checkCollisionList(p, b);
   p.position_y -=5;
   if(collisionList.size() > 0){
     return true;
   } else{
     return false;
   }
}

public void scroll(){
  float rBoundary = view_x + width - RIGHT_MARGIN;
  if(player.getRight() > rBoundary){
    view_x += player.getRight() - rBoundary;
  }
  float lBoundary = view_x + LEFT_MARGIN;
  if(player.getLeft() < lBoundary){
    view_x -= lBoundary - player.getLeft();
  }
  float bBoundary = view_y + height - VERTICAL_MARGIN;
  if(player.getBottom() > bBoundary){
    view_y += player.getBottom() - bBoundary;
  }
  float tBoundary = view_x + VERTICAL_MARGIN;
  if(player.getTop() < tBoundary){
    view_y -= tBoundary - player.getTop();
  }
  translate(-view_x, -view_y);
}

void checkDeath(){
  if(player.getBottom() > 2000.00){
    player.lives--;
    if(player.lives==0){
      isGameOver=true;
      view_x = 0;
      view_y = 0;
    } else{
      player.position_x = 100;
      player.position_y = 300;
      view_x = 0;
      view_y = 0;
    }
  }
}

void keyPressed(){
  keys[key] = true;
  if(key=='e'){
      editor=!editor;
  }
}

void keyReleased(){
  keys[key] = false;
}

void mousePressed(){
  if(editor){
    if(mouseY>162){
      int row = mouseY/162;
      int col = mouseX/162;
      map.mapGrid[row][col] = String.valueOf(editID);
      map.loadMap();
      try{
        map.saveCSV();
      } catch(Exception e){
      }
    }
  }
}
