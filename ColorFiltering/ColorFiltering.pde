import gab.opencv.*;
import processing.video.*;

Capture cam;
PGraphics m;
PImage src;
PImage colorFilteredImage;
OpenCV opencv;
void setup() {
  size(1800, 900);
    
    cam = new Capture(this, 640,480);
    cam.start();
    opencv = new OpenCV(this, cam.width,cam.height);
}

void draw() {
  if (cam.available() == true) {
    cam.read();
  }
  opencv.loadImage(cam);
  image(cam,640,0);
  src = opencv.getSnapshot();
  opencv.useColor(HSB);
  opencv.setGray(opencv.getH().clone());
  opencv.inRange(50 , 70);
  opencv.erode();
  opencv.erode();
  opencv.erode();
  opencv.erode();
  colorFilteredImage = opencv.getSnapshot();
  image(colorFilteredImage,0,0);
  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  //set(0, 0, cam);
}