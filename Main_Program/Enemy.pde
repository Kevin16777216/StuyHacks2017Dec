public class Enemy{
  int health = 100;
  int power = 30;
  int SpawnRing;
  int SpawnNumber;
  int X;
  int m;
  int Y;
  ArrayList<Projectile> p = new ArrayList<Projectile>();
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
    m++;
    if(InRange() && m% 60 == 0){
    shoot();
    m = 0;
    }
  }
  void ChangePos(){
    X -= Xvel;
    Y -= Yvel;
    X += int(-width/(2*X))/int(-height/(2*Y));
    Y += int(-height/(2*Y))/int(-width/(2*X));
  }
  void shoot(){
    Projectile Eprojectile = new Projectile(int(-width/(2*X)), int(-height/(2*Y)),1);
  }
}