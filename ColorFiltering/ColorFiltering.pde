import gab.opencv.*;
import processing.video.*;
ArrayList<Contour> contours;
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
  opencv.inRange(53 , 65);
  opencv.erode();
  opencv.erode();
  //opencv.erode();
  opencv.erode();
    opencv.erode();
  opencv.erode();
  colorFilteredImage = opencv.getSnapshot();
  image(colorFilteredImage,0,0);
  double avgX = 0;
  double avgY= 0;
  int k = 0;
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
  // The following does the same, and is faster when just drawing the image
  // without any additional resizing, transformations, or tint.
  //set(0, 0, cam);
}