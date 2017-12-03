import beads.*;
import java.util.Arrays;
import gab.opencv.*;
import processing.video.*;
public int avgX;
public int avgY;
//______________________________________
Capture cam;
PImage src,colorFilteredImage;
OpenCV opencv;
float bX = 0;
float bY = 0;
ArrayList<Contour> contours;
//______________________________________
float volume = 1.0;
public ArrayList<Instrument> chord = new ArrayList<Instrument>();
Instrument slideR;
Slider slide;
//______________________________________
ArrayList<boolean[]> data = new ArrayList<boolean[]>();
public char[] keyBinds = new char[] {'q','w','e','r','t','y','u','i','o','p','a','s','d','f','g','h','j','k','l','z','x','c','v','b','n','m'};
String mainSong = "/";
PrintWriter output;
//______________________________________
void setup()
{
 size(1800, 900);
 cam = new Capture(this, 640,480);
 cam.start();
 opencv = new OpenCV(this, cam.width,cam.height);
 //______________________________________
 output = createWriter("data.txt");
 for (int i = 0; i < keyBinds.length; i++){
   chord.add(new Instrument(200 + i * 40));
 }
 background(255);
 slide = new Slider(100,700,420,1020);
 slideR = new Instrument(450);
 slideR.isPlaying = true;
}
void draw()
{
  bX = avgX;
  bY = avgY;
  slide.render();
  slide.update();
  if (slide.On){
    slideR.gainGlide.setValue(volume + 1);
  }else{
  }
  slideR.gainGlide.setValue(volume + 1);
  slideR.editFrequency(avgY + 300);
  slideR.frequencyGlide.setValue(avgY + 300);
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
  doCam();
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
void doCam(){
  if (cam.available() == true) {
    cam.read();
  }
  opencv.loadImage(cam);
  //image(cam,640,0);
  src = opencv.getSnapshot();
  opencv.useColor(HSB);
  opencv.setGray(opencv.getH().clone());
  opencv.inRange(50 , 80);
  opencv.erode();
  opencv.erode();
  opencv.erode();
  colorFilteredImage = opencv.getSnapshot();
  avgX = 0;
  avgY= 0;
  int k = 0;
  image(colorFilteredImage,0,0);
  src.resize(900,900);
  image(src,640,0);
 contours = opencv.findContours();
  for (Contour contour : contours) {
    stroke(0, 255, 0);
    contour.draw();
    
    stroke(255, 0, 0);
    beginShape();
    for (PVector point : contour.getPolygonApproximation().getPoints()) {
      vertex(point.x, point.y);
      avgX += point.x;
      avgY += point.y;
      k++;
    }
    avgX /= k;
    avgY /= k;
    println(avgX + "/" + avgY);
    endShape();
  }
}