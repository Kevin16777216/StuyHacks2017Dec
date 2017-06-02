import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

/**
 * PROJECT 
 * by Kevin Cai
 * Last Updated: 5/30/17 6:51 PM
 * 
 */
  Minim minim;
  AudioPlayer player;
  boolean KeyUp = false;
  boolean KeyRight = false;       
  boolean KeyLeft = false;
  boolean KeyDown = false;
  int PlayerDamage;
  float CritChance = 0.8;
  float CritMultiplier = 1.2;
  int ko = 0;
  PImage ProjectileImg ;
  ArrayList<Projectile>Projectiles = new ArrayList<Projectile>();
  private ArrayList<Integer> IntersectingTileIDs = new ArrayList<Integer>();
  ArrayList<Integer> CurrentRoomData = new ArrayList<Integer>();//Main Data
  ArrayList<HexTile_Non_Puzzle> CurrentTileData = new ArrayList<HexTile_Non_Puzzle>();
  ArrayList<Teleporter> CurrentTeleData = new ArrayList<Teleporter>();
  ArrayList<Enemy> CurrentEnemyData = new ArrayList<Enemy>();
  boolean IsTitleScreen;//If the player is on the title screen
  boolean IsPassword;//If the main player is solving a passcode
  boolean IsReadingSign;//If the main player is reading a sign
  int PlayerX = width/2;
  int PlayerY = height/2;
  int PlayerHealth = 100;
  int realX = PlayerX-width/2;
  int realY = PlayerY-height/2;
  float Xvel = 0;
  float Yvel = 0;
  int IsCutscene; //If the player is in a cutscene 0 = no 1 = yes 2 = animated(notiles)
  //Room[] Rooms; //list of rooms
  int TileSize;
  PShape img;
  float XoffsetSpawn = 0;
  float YoffsetSpawn = 0;
  private HealthBar health;
  int K = 80; //PlayerSize same as how big the room is
  int CurrentRoomID = 1;
  int Realframes;
  PImage TeleImg;
void setup() {
  size(820, 820, P2D);
  noStroke();
  minim = new Minim(this);
  TeleImg = loadImage("bitmap.png");
  ProjectileImg= loadImage("play_buttonk.png");
  health = new HealthBar(200,width/2,height/2);
  LoadLevels(CurrentRoomID);
  player = minim.loadFile("main.mp3");
  player.loop();
  
}
void Teleport(float A, float S,int RM){
  CurrentRoomID = RM;
  XoffsetSpawn = S;
  YoffsetSpawn = -A;
  LoadLevels(RM);
}
void LoadEnemies(){
  String[] EnemyData = loadStrings(CurrentRoomID +"EDATA"+".txt");
    CurrentEnemyData.clear();
    int counit = 0;
    int []n = new int[90];
    for (int l=0; l< EnemyData.length; l++) {
      if(EnemyData[l].equals( "/") && l !=0){
         while (counit < 90){
           n[counit] = 0;
           counit++;
         }
         counit = 0;
         CurrentEnemyData.add(new Enemy(n));
         n = new int[90];
      }else{
        n[counit] = int(EnemyData[l]);
        counit++;
      }
    }
}
void LoadTeleporters(){
  String[] TeloData = loadStrings(CurrentRoomID +"TileTeleporters"+".txt");
    CurrentTeleData.clear();
    int counit = 0;
    float []n = new float[90];
    for (int l=0; l< TeloData.length; l++) {
      if(TeloData[l].equals( "/") && l !=0){
         while (counit < 90){
           n[counit] = 0;
           counit++;
         }
         counit = 0;
         CurrentTeleData.add(new Teleporter(n));
         n = new float[90];
      }else{
        n[counit] = float(TeloData[l]);
        counit++;
      }
    }
}
void LoadLevels (int RoomID){
  LoadTeleporters();
  LoadEnemies();
  PlayerX = width/2;
  PlayerY = height/2;
  float A =((K*2+3)*(sqrt(3)/2));
  float S = (K*2+3); 
  PlayerX += XoffsetSpawn*S;//half sides
  PlayerY += YoffsetSpawn*A;//Yoffset spawn is the number of HALF hexagon apothems
  Xvel = 0;
  Yvel = 0;
    String[] RawData = loadStrings(RoomID +"Tiles"+".txt");
    CurrentTileData.clear();
    int count = 0;
    int []n = new int[90];
    for (int i=0; i< RawData.length; i++) {
      if(RawData[i].equals( "/") && i !=0){
         while (count < 90){
           n[count] = 0;
           count++;
         }
         count = 0;
         CurrentTileData.add(new HexTile_Non_Puzzle(n));
         n = new int[90];
      }else{
        n[count] = int(RawData[i]);
        count++;
      }
    }
}
void UpdatePlayer() {
  if(KeyUp){           
    Yvel -= 0.1;
    if(Yvel > 0){
      Yvel *= -0.8333333;
    }else{
      Yvel *= 1.2;
    }
  }
  if(KeyDown){
    Yvel+=0.1;
    if(Yvel > 0){
      Yvel *= 1.2;
    }else{
      Yvel *= -0.8333333;
    }
  }
  Yvel *= 0.95;
  if (abs(Yvel) < 0.05){
    Yvel = 0;
  }
  if(abs(Yvel) > 8){
    if(Yvel > 7){
      Yvel = 8;
    }else{
      Yvel = -8;
    }
  }
  if(KeyLeft){
    Xvel -= 0.1;
    if(Xvel > 0){
      Xvel *= -0.8;
    }else{
      Xvel *= 1.2;
    }
  }
  if(KeyRight){
    Xvel += 0.1;
    if(Xvel > 0){
      Xvel *= 1.2;
    }else{
      Xvel *= -0.8;
    }
  }
  Xvel *= 0.95;
  if (abs(Xvel) < 0.01){
    Xvel = 0;
  }
  if(abs(Xvel) > 8){
    if(Xvel > 0){
      Xvel =8;
    }else{
      Xvel = -8;
    }
  }
  CheckHitbox();
}
void CheckHitbox(){
  CheckTileData();
}
void RenderEnemies(){
}

void RenderPlayer(int X, int Y){
  //img = loadShape("Play_shell_"+millis()%41 +".svg");
  CalcPlayer(X,Y,6,0.5,15,3600,K,4,true,30,true,color(56, 201, 255),color(255, 255, 255));//body
    CalcPlayer(X-K/3,Y,9,0.3,6,1800,K/5,3,true,30,false,color(56, 201, 255),color(56, 201, 255));//eye2
  CalcPlayer(X+K/3,Y,9,0.3,6,1800,K/5,3,true,30,false,color(56, 201, 255),color(56, 201, 255));//eye1
  
}
void CalcPlayer(int X, int Y,int sides, float frac, int segments, int frames,int size,int pressure,boolean animated,float offset,boolean fill,color StrokeColor,color FillColor){
  float[] PX = new float[sides+1];
  float[] PY = new float[sides+1];
  int t = 1;
  PX[0] = X+size*sin(radians((360/sides)*sides+offset));
  PY[0] = Y+size*cos(radians((360/sides)*sides+offset));
  while(t <= sides){
    PX[t] = X+size*sin(radians((360/sides)*t+offset));
    PY[t] = Y+size*cos(radians((360/sides)*t+offset));
    t++;
  }
  strokeWeight(pressure);
  float SideLength = LineLength(PX[1],PY[1],PX[2],PY[2]);
  float Perimeter = SideLength*sides;
  if(fill == true){
    noStroke();
    fill(FillColor); 
    beginShape(); 
     for (int i = 1; i <= sides; i++){
        vertex(PX[i%sides],PY[i%sides]);
     } 
    endShape(); 
  }
  stroke(StrokeColor);
  if(animated){
  //--Everything beyond here can be used for only enclosed shape
  float SegmentLength = Perimeter*frac/segments;
  float SpaceLength = Perimeter*(1-frac)/segments;
  float fraction = (millis()%frames);
  fraction /= frames;
  float Adjust = fraction*sides;
  float TrueAdjust = Adjust-floor(Adjust);
  int a = floor(Adjust);
  int b = ceil(Adjust)%sides;
  float StartX = (1-TrueAdjust)*PX[a]+(TrueAdjust)*PX[b];
  float StartY = (1-TrueAdjust)*PY[a]+(TrueAdjust)*PY[b];
  float CDraw = 0;
  float LDraw;
  float fx;
  float fy;
  int nextPoint = a;
  int k = 0 ;
  while(k <= segments*2){
    CDraw = LineLength(StartX,StartY,PX[nextPoint%sides+1],PY[nextPoint%sides+1]);
    if (k%2 == 0){
       LDraw = SegmentLength;
       stroke(StrokeColor);
    }else{
      LDraw = SpaceLength;
      stroke(0,0,0,0);
    }
    while(CDraw < LDraw){
      line(round(StartX),round(StartY),round(PX[(nextPoint%sides)+1]),round(PY[(nextPoint%sides)+1]));
      LDraw -= CDraw;
      StartX = PX[nextPoint%sides+1];
      StartY = PY[nextPoint%sides+1];
      nextPoint++;
      CDraw = LineLength(round(StartX),round(StartY),round(PX[nextPoint%sides+1]),round(PY[nextPoint%sides+1]));
    }
    float i = LDraw/CDraw;
    fx = i*PX[nextPoint%sides+1] + (1-i)*StartX;
    fy = i*PY[nextPoint%sides+1] + (1-i)*StartY;
    line(round(StartX),round(StartY),round(fx),round(fy));
    StartX = fx;
    StartY = fy;
    k++;
    
  }
  }else{
  for (int i = 1; i <= sides; i++){
    line(PX[i%sides],PY[i%sides],PX[(i+1)%sides],PY[(i+1)%sides]);
  }
  }
}
float LineSlope(int x1, int y1, int x2, int y2){
  return (y2-y1)/(x2-x1);
}
float LineLength(float x1, float y1, float x2, float y2){
  return sqrt(pow((x1-x2),2) +pow((y1-y2),2));
}
void ModifyPosition(){
  while(SiftTileData().size() >0){
    if(SiftTileData().size() <2){
      if(!(abs(Xvel) > 60) && !(abs(Yvel) >60)){
      for (int i =0; i < SiftTileData().size() ; i++){
    if(CurrentTileData.get(IntersectingTileIDs.get(i)).X < width/2){
   Xvel += 0.01;
    }else{
    Xvel -= 0.01;
    }
    if(CurrentTileData.get(IntersectingTileIDs.get(i)).Y < height/2){
    Yvel+=0.01;
    }else{
    Yvel -= 0.01;
    }
      }
      }
    }else{
      Xvel=0;
      Yvel = 0;
    }
  }
  /*int[] FuturePos = new int[2];
  boolean IsCollided = false;
  IsCollided = false;
  if (IsCollided){
   FuturePos = new int[5];
  }*/
}

boolean CheckCollision(){
  IntersectingTileIDs.clear();
  ArrayList<Integer> PotentialHexagons = SiftTileData();
  boolean bOolean = false;
  for(int i = 1; i < PotentialHexagons.size(); i++){
    if(CompareHexagon(PotentialHexagons.get(i)) == true){
     // IntersectingTileIDs.add(i);
      bOolean = true;
    }else{

    }
    
  }
  bOolean =IntersectingTileIDs.size() > 0 ? true:false;
  
return bOolean;
}
boolean CompareHexagon(int ID){
  float XID = CurrentTileData.get(ID).X;
  float YID = CurrentTileData.get(ID).Y;
  boolean IsColliding = false;
  float[] k = new float[20];
  for (int i = 0; i<=5; i++){
    k = CompareSingularLine(XID-Xvel+K*sin(radians(60*i)),YID-Yvel+K*cos(radians(60*i)),XID-Xvel+K*sin(radians(60*(i+1))),YID-Yvel+K*cos(radians(60*(i+1))),width/2+K*sin(radians(60*(i))),height/2+K*cos(radians(60*(i))),width/2+K*sin(radians(60*(i+1))),height/2+K*cos(radians(60*(i+1))));
    if(k[0] == 1){
      IsColliding = true;
    }else{
    }
  }
   return IsColliding;
}
float[] CompareSingularLine(float x, float y, float x2,float y2,float x3,float y3,float x4,float y4){
  float[] values = new float[7];
  boolean IsIntersecting = false;
  float Sn = (x-x2)/(y-y2);
  float offsetSn = y-(x*Sn);
  float Sm = (x3-x4)/(y3-y4);
  float offsetSm = y3-(x3*Sm);
  float diff = (Sn-Sm);
   float ddiff = -offsetSn+offsetSm;
   float Valx = ddiff/diff;
   float Valy = Valx*Sn;
  if (Sm == Sn){
    IsIntersecting = false;
  }else{
   if( (x <= Valx)&&(Valx <= x2)&&(y <= Valy)&&(Valy <= y2)){
     IsIntersecting = true;
   }
  }
  values[0] = IsIntersecting ? 1:2;
  values[1] = (Valx == x)? 0:1;
  values[2] = (Valx == x2)? 0:1;
  values[3] = (Valx == x3)? 0:1;
  values[4] = (Valx == x4)? 0:1;
  values[5] = Valx;
  values[6] = Valy;
  return values;
}
void CheckTileData(){
  if(CheckCollision()){
    ModifyPosition();
  }
  
}
ArrayList<Integer> SiftTileData(){
  ArrayList<Integer> m = new ArrayList<Integer>();
  for (int i = 1; i < CurrentTileData.size() ; i++){
    Integer a = CurrentTileData.get(i).IsSolid;
    if(a ==2 && LineLength(CurrentTileData.get(i).X-Xvel,CurrentTileData.get(i).Y-Yvel,width/2,height/2) < K*3){
      m.add(i);
      IntersectingTileIDs.add(i);
    }
  }
  return m;
}

void draw(){//main loop (Michaels right parentheses-->)
   clear();
   background(205, 240, 244);
   UpdatePlayer();
   PlayerY += int(Yvel);
   PlayerX += int(Xvel);
   HoneyComb(K*2,-PlayerX+width,-PlayerY+height);
   RenderProjectiles();
   RenderPlayer(width/2,height/2);
   health.RenderBar();
   Realframes++;
}
void HoneyComb(int Radii,int CamX, int CamY){
  int a = 9;
  ko = 0;
  CurrentTileData.get(ko).X = CamX;
  CurrentTileData.get(ko).Y = CamY;
  CurrentTileData.get(ko).RoomID = CurrentRoomID;
  CalcPlayer(CamX,CamY,6,1,15,3600,Radii+3,3,false,30,true,color(56, 201, 255),color(221, 180, 31));//center
        for(int i = 0 ; i < CurrentTeleData.size(); i++){
      if(CurrentTeleData.get(i).R == 1 && CurrentTeleData.get(i).N == 1){
      image(TeleImg, CamX-K,CamY-K,220,220);
      if(LineLength(CamX,CamY,width/2,height/2)<K){
         Teleport(CurrentTeleData.get(i).A,CurrentTeleData.get(i).S,int(CurrentTeleData.get(i).FutureRoomID));
      }
    }
  }
  for (int j = 2; j < a; j++ ){
      GenerateHexRing(CamX,CamY,j,Radii);
  }
}
void GenerateHexRing(int X, int Y,int I,int R){// I = iteration, R = radii of hexagon
  float CenterRadius = sqrt(pow(((1.5)*(I-1))*R,2)+pow(((I-1)*(sqrt(2)*R)),2));
  float[]Xval = new float[7];
  float[]Yval = new float[7];
  for (int j = 0; j <= 6 ; j++){
    Xval[j] = X+CenterRadius*sin(radians(60*j));
    Yval[j] = Y+CenterRadius*cos(radians(60*j));
  }
  float Z = 2*(I-1);
  int m=1;
  for (int j = 1; j <= 6; j++){
    for (int k = I ; k >1; k--){
      ko++;
      float diff = ((2*k-2)/Z);
      float Xc = diff*Xval[j%6] + (1-diff)*Xval[(j+1)%6];
      float Yc = diff*Yval[j%6] + (1-diff)*Yval[(j+1)%6];
      Xc = round(Xc);
      Yc = round(Yc);  
      CurrentTileData.get(ko).X = int(Xc);
      CurrentTileData.get(ko).Y = int(Yc);
      color a;
      if(CurrentTileData.get(ko).IsSolid == 1){
        a = color(255,255,255);
      }else{
        a = color(0,0,0);
      }
      if(IntersectingTileIDs.contains(ko)){
        a = color(100,100,100);
        health.Hit(0.5);
      }
      if(CurrentTileData.get(ko).IsShowing){
      CalcPlayer(int(Xc),int(Yc),6,1,15,3600,R+3,3,false,30,true,color(56, 201, 255),a);//body
      m++;
      println(CurrentTeleData.size());
      for(int i = 0 ; i < CurrentTeleData.size(); i++){
      if(CurrentTeleData.get(i).R == I && CurrentTeleData.get(i).N == m){
      image(TeleImg, Xc-K,Yc-K,220,220);
      if(LineLength(Xc,Yc,width/2,height/2)<2*K){
         Teleport(CurrentTeleData.get(i).A,CurrentTeleData.get(i).S,int(CurrentTeleData.get(i).FutureRoomID));
      }
    }
}
    }
  }}
}

void mouseClicked() {
  Projectile n = new Projectile(mouseX-(width/2),mouseY-(height/2),0);
  Projectiles.add(n);
  
}
void RenderProjectiles(){
  for(int i =0; i < Projectiles.size(); i++){
    Projectiles.get(i).render();
  }
}
void keyPressed() {
   if(key == CODED)
  {
    if (keyCode == LEFT)
    {
      KeyLeft = true;
    }
    if(keyCode == RIGHT)
    {
      KeyRight = true; 
    }
    if (keyCode == UP)
    {
      KeyUp = true;
    }
    if(keyCode == DOWN)
    {
      KeyDown = true;
    }
    
  }
}
 
void keyReleased() {
   if(key == CODED)
  {
    if (keyCode == LEFT)
    {
      KeyLeft = false;
    }
    if(keyCode == RIGHT)
    {
      KeyRight = false; 
    }
    if (keyCode == UP)
    {
      KeyUp = false;
    }
    if(keyCode == DOWN)
    {
      KeyDown = false;
    }
    
  }
}