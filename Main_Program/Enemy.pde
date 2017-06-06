public class Enemy{
  int health = 100;
  int power = 30;
  int SpawnRing;
  int SpawnNumber;
  int X;
  int size = 30; //size of enemy in px
  int m;
  int damage; //TODO: Have some Tiers 
  int Y;
  HealthBar k;
  ArrayList<Projectile> MyProjectiles = new ArrayList<Projectile>();
  public Enemy(int[]m){
    SpawnRing = m[1];
    SpawnNumber = m[2];
    k = new HealthBar(health,X,Y);
  }
  boolean InRange(){
    boolean j = false;
    j = (X > -90 &&X < width+90 && Y > -90 &&X < height+90)? true:false;
    return j;
  }
  void Update(){
    m++;
    UpdateMovement();
    if(InRange() && m% 60 == 0){
    shoot();
    IsHit();
    m = 0;
    }
    k.RenderBar();
  }
  void ChangePos(){
    X -= Xvel;
    Y -= Yvel;
    X += int(-width/(2*X))/int(-height/(2*Y));
    Y += int(-height/(2*Y))/int(-width/(2*X));
  }
  void shoot(){
    Projectile Eprojectile = new Projectile(int(-width/(2*X)), int(-height/(2*Y)),1,10);
    Projectiles.add(Eprojectile);//putting onto masterList;
    MyProjectiles.add(Eprojectile);
  }
  ArrayList <Integer> IsHit(){
    ArrayList <Integer> data = new ArrayList <Integer>();
    boolean IsHit = false;
    boolean IsCritical = false;
    float tx;
    int numHits = 0;
    float CalculatedDamage = 0.0;
    float ty;
    data.add(0);
    for(int i = 0; i<Projectiles.size(); i++){
    if(Projectiles.get(i).type == 1){
      tx = Projectiles.get(i).x;
      ty = Projectiles.get(i).y;
      if(LineLength(X,Y,tx,ty) < this.size){
        IsHit = true;
        numHits++;
        data.get(0).equals(data.get(0)+1);
      }
    }
    }
    CalculatedDamage = numHits*damage;
    if(random(0,1) > CritChance){
    CalculatedDamage *= CritMultiplier;
    IsCritical = true;
    data.add(1);
    }else{
      data.add(0);
    }
    data.add(int(CalculatedDamage));
    LoseHealth(CalculatedDamage);
    return(data);
  }
  void LoseHealth(float Damage){
    k.Hit(Damage);
  }
  void UpdateMovement(){
    float Xchange = -(X-width/2)/5;
    float Ychange = -(Y-height/2)/5;
    X+= Xchange-Xvel;
    Y+= Ychange-Yvel;
  }
}