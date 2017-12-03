public class Slider{
  private int x;
  private int y;
  private float Max;
  private float Min;
  float sliderX;
  float sliderY;
  public boolean On = true;
  private float cVal = (Max + Min) / 2;
  public Slider(int x, int y, float Max, float Min){
    this.Max = Max;
    this.Min = Min;
    this.x = x;
    this.y = y;
    sliderX = x+12.5;
    sliderY = y+12.5;
    cVal = 0;
  }
  public void render(){
    fill(0);
    rect(x,y,300,40,7);
    fill(255);
    rect(x+12.5,y+12.5,275,15);
    fill(85);
    rect(sliderX,sliderY,30,15);
  }
  public void update(){
    if(mousePressed && (abs(mouseX - (x+131.5)) < 125) && (abs(mouseY - (y+20)) < 20)){
      sliderX = mouseX;
      cVal = Min + ((sliderX - (x + 12.5)) / (287.5))*(Max-Min);
      println(cVal);
    }
  }
  public float getCval(){
    return cVal;
  }
  public boolean getState(){
    return On;
  }
  public void turnOff(){
    On = !On;
  }
}