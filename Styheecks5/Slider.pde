public class Slider{
  private int x;
  private int y;
  private double Max;
  private double Min;
  private double cVal = (Max + Min) / 2;
  public Slider(int x, int y, double Max, double Min){
    this.Max = Max;
    this.Min = Min;
    this.x = x;
    this.y = y;
  }
  public void render(){
    rect(x,y,50,40,7);
  }

}