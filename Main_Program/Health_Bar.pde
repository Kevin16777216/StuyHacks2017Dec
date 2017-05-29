class HealthBar{
float Max;
float current;
float X;
float Y;
public HealthBar(float Max,float Y,float X){
this.Max = Max;
this.X = X;
this.Y = Y+100;
this.current = Max;
}
void Hit(float m){
  if(current >0){
    current-=m;
  }
  if (current < 0){
  current = 0;
  }
}
void RenderBar(){
strokeWeight(15);
stroke(100,100,100);
line(X-Max/2,Y,X+Max/2,Y);
strokeWeight(5);
stroke(255,100,100);
line(X-(Max/2)+5,Y,(X+(Max/2)-5),Y);
stroke(100,255,100);
line(X-(Max/2)+5,Y,(X-(Max/2)+(current/Max)*(Max-10)+5),Y);
}
}
