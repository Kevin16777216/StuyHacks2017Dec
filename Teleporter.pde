public class Teleporter{
  public float X;
  public float Y;
  public float RoomID;
  public float R;//side
  public float N;//Apothem
  public float S;
  public float A;
  public float FutureRoomID;
  public boolean IsShowing;
  float Ab =((80*2+3)*(sqrt(3)/2));//80 is  K
  float Sb = (80*2+3);
  public Teleporter(float[]m){
    R = m[1];
    N = m[2];
    println(R);
    println(N);
    RoomID = m[3];
    S = m[4];
    A = m[5];
    FutureRoomID = m[6];
}
public void CheckSpawn(){
     if((CurrentRoomID != RoomID) ||(IsTitleScreen || IsPassword || IsReadingSign || (IsCutscene == 2))){
       IsShowing = false;
     }else{
       IsShowing = true;
     }
   
   }
}