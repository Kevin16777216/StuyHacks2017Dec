public class Enemy{
  int health = 100;
  int power = 30;
  int SpawnRing;
  int SpawnNumber;
  int X;
  int Y;
  public Enemy(int[]m){
    SpawnRing = m[1];
    SpawnNumber = m[2];
  }
  boolean InRange(){
    boolean j = false;
    j = (X > -90 &&X < width+90 && Y > -90 &&X < height+90)? true:false;
    return j;
  }
  void Update(){
    if(InRange()){
    shoot();
    }
  }
  void shoot(){
  
  }
}