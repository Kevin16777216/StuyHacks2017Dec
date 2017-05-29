public class Projectile{
int movX;
int movY;
int x= width/2;
int y = height/2;
PImage ProjectileImg;
public Projectile(int movX, int movY){
  this.movX = movX/10;
  this.movY = movY/10;
  ProjectileImg = loadImage("play_buttonk.png");
}
void render(){
  
   x+=movX;
 y+=movY;
 println(movX);
 movX*=1.000000000001;
 movY*=1.000000000001;
 image(ProjectileImg, x,y,30,30);
}
}
