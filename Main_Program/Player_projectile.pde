public class Projectile{
int movX;
int movY;

int type;
int x= width/2;
int y = height/2;
int damage;
PImage ProjectileImg;
public Projectile(int movX, int movY,int type,int damage){
  this.movX = movX/10;
  this.movY = movY/10;
  this.damage = damage;
  this.type = type;//0=player, 1 = enemy;
  ProjectileImg = loadImage("play_buttonk.png");
}
void render(){
  x-=Xvel;
  y-=Yvel;
   x+=movX;
 y+=movY;
 println(movX);
 movX*=1.000000000001;
 movY*=1.000000000001;
 image(ProjectileImg, x,y,30,30);
}
}