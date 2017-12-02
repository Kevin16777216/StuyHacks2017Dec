import beads.*;
import java.util.Arrays;
float volume = 1.0;
ArrayList<boolean[]> data = new ArrayList<boolean[]>();
public char[] keyBinds = new char[] {'a','s','d','f','g','h','j','k','l','z','x','c','v','b','n','m'};
public ArrayList<Instrument> chord = new ArrayList<Instrument>();
Instrument slideR;
String mainSong = "/";
PrintWriter output;
Slider slide;
void setup()
{
 size(800, 600);
 output = createWriter("data.txt");
 for (int i = 0; i < keyBinds.length; i++){
   chord.add(new Instrument(200 + i * 40));
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
  boolean[] frame = new boolean[chord.size() + 1];
  for (int i = 0; i < chord.size(); i ++){
    frame[i] = chord.get(i).isPlaying;
    if (chord.get(i).isPlaying){
     chord.get(i).gainGlide.setValue(volume + 1);
    }else{
      chord.get(i).gainGlide.setValue(0);
    }
     chord.get(i).frequencyGlide.setValue(chord.get(i).frequency + 300);
  }
  frame[chord.size()] = slide.getState();
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
  for(int i = 0; i < chord.size(); i++){
    if(key == keyBinds[i]){
      chord.get(i).isPlaying = true;
    }
  }
}
void keyReleased(){
  for(int i = 0; i < chord.size(); i++){
    if(key == keyBinds[i]){
      chord.get(i).isPlaying = false;
    }
  }
  if (key == '1'){
    saveData();
  }
  if (key == '2'){
    slide.turnOff();
  }
}