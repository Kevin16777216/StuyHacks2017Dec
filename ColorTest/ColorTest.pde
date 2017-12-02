import gab.opencv.*;
PImage src,colorFilteredImage;
OpenCV opencv;
void setup() {
  src = loadImage("greenchalk.jpg");
  size(1920, 1080);
  opencv = new OpenCV(this, src);
  opencv.loadImage("greenchalk.jpg");
  opencv.useColor();
  src = opencv.getSnapshot();
  opencv.useColor(HSB);
  opencv.setGray(opencv.getH().clone());
  opencv.inRange(53, 65);
  opencv.erode();
  opencv.erode();
  colorFilteredImage = opencv.getSnapshot();


}

void draw() {
  scale (0.5);
  image(src, 0, 0);
  image(colorFilteredImage, src.width, 0);
  }