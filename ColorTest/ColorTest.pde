import gab.opencv.*;

PImage src,colorFilteredImage;
OpenCV opencv;

ArrayList<Contour> contours;
ArrayList<Contour> polygons;

int threshold = 100;

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
  
  //opencv.threshold(threshold);
  //dst = opencv.getOutput();

}

void draw() {
  scale (0.5);
  image(src, 0, 0);
  image(colorFilteredImage, src.width, 0);
  }
/*void draw() {
  scale(0.5);
  image(src, 0, 0);
  image(dst, src.width, 0);

  noFill();
  strokeWeight(3);
  
  for (Contour contour : contours) {
    stroke(0, 255, 0);
    contour.draw();
    
    stroke(255, 0, 0);
    beginShape();
    for (PVector point : contour.getPolygonApproximation().getPoints()) {
      vertex(point.x, point.y);
    }
    endShape();
  }
  */