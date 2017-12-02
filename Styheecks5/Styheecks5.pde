import beads.*;
import java.util.Arrays;
float volume = 1.0;
ArrayList<boolean[]> data = new ArrayList<boolean[]>();
public char[] keyBinds = new char[] {'a','s','d','f','g','h','j'};
public Instrument[] chord = new Instrument[7];
String mainSong = "/";
PrintWriter output;
void setup()
{
 size(800, 600);
 output = createWriter("data.txt");
 for (int i = 0; i < 7; i++){
   chord[i] = new Instrument(200 + i * 20);
 }
 background(255);
}
void draw()
{
  boolean[] frame = new boolean[7];
  for (int i = 0; i < 7; i ++){
    frame[i] = chord[i].isPlaying;
    if (chord[i].isPlaying){
     chord[i].gainGlide.setValue(volume + 1);
    }else{
      chord[i].gainGlide.setValue(0);
    }
     chord[i].frequencyGlide.setValue(chord[i].frequency + 300);
  }
  mainSong += Arrays.toString(frame);
  data.add(frame);
}
void saveData(){
  mainSong += "/";
  output.flush();
  output.close();
  exit();
}
void keyPressed(){
  for(int i = 0; i < 7; i++){
    if(key == keyBinds[i]){
      chord[i].isPlaying = true;
    }
  }
}
void keyReleased(){
  for(int i = 0; i < 7; i++){
    if(key == keyBinds[i]){
      chord[i].isPlaying = false;
    }
  }
}