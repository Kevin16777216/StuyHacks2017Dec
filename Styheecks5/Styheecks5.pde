import beads.*;
import java.util.Arrays;
float volume = 1.0;
ArrayList<boolean[]> data = new ArrayList<boolean[]>();
public char[] keyBinds = new char[] {'a','s','d','f','g','h','j'};
public Instrument[] chord = new Instrument[7];
Instrument slideR;
String mainSong = "/";
PrintWriter output;
Slider slide;
void setup()
{
 size(800, 600);
 output = createWriter("data.txt");
 for (int i = 0; i < 7; i++){
   chord[i] = new Instrument(200 + i * 40);
 }
 background(255);
 slide = new Slider(100,100,420,1020);
 slideR = new Instrument(450);
 slideR.isPlaying = true;
}
void draw()
{
  slide.render();
  slide.update();
  if (slide.On){
    slideR.gainGlide.setValue(volume + 1);
  }else{
    slideR.gainGlide.setValue(0);
  }
  slideR.editFrequency(slide.getCval());
  slideR.frequencyGlide.setValue(slideR.frequency);
  boolean[] frame = new boolean[8];
  for (int i = 0; i < 7; i ++){
    frame[i] = chord[i].isPlaying;
    if (chord[i].isPlaying){
     chord[i].gainGlide.setValue(volume + 1);
    }else{
      chord[i].gainGlide.setValue(0);
    }
     chord[i].frequencyGlide.setValue(chord[i].frequency + 300);
  }
  frame[7] = slide.getState();
  mainSong += Arrays.toString(frame);
  data.add(frame);
}
void saveData(){
  mainSong += "/";
  output.println(mainSong);
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
  if (key == '1'){
    saveData();
  }
  if (key == '2'){
    slide.turnOff();
  }
}