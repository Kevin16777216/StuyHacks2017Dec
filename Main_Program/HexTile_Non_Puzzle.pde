
public class HexTile_Non_Puzzle{
  
   float X;//X value in px 
   int Y;//Y Value in px
   int RoomID;//ID for the room that it is in
   int IsSolid;//Is the tile a wall?
   boolean IsShowing;//Is the tile on the front layer?
   
   //NOTE: anything with "0" means its blank.
   public HexTile_Non_Puzzle(int n[]){//main constructor
     this.X = n[0];
     this.Y = n[1];
     this.RoomID = n[2];
     this.IsSolid = n[3];//1= true, 2=false
     CheckSpawn();
   }
   public void CheckSpawn(){
     if((CurrentRoomID != RoomID) ||(IsTitleScreen || IsPassword || IsReadingSign || (IsCutscene == 2))){
       IsShowing = false;
     }else{
       IsShowing = true;
     }
   
   }

}
