 PImage myImage;
 int level;
 int ko = 0;
 PrintWriter output;
void setup(){
  size(420, 490);
  level = 4;
  draw(level);
}
void draw(int Level){
    myImage = loadImage(Level+"-MAIN.png");
  output = createWriter(Level+"Tiles.txt"); 
    image(myImage, 0, 0);
    color c = get(204,233);
    println(red(c));
    println(green(c));
    println(blue(c));
    if(abs(red(c)-64) < 7 &&abs(green(c)-150) < 7&&abs(blue(c)-238) < 7){
        output.println("/");
        output.println("0");
        output.println("0");
        output.println(level);
        output.println("2");
      }else{
        output.println("/");
        output.println("0");
        output.println("0");
        output.println(level);
        output.println("1");
      }
    for (int i = 2; i < 9; i++){
    GenerateHexRing(204, 233,i,17);
    output.flush(); // Writes the remaining data to the file
    }
    output.println("/");
    output.flush();
    println(ko);
  output.close(); // Finishes the file
  exit();
}
void GenerateHexRing(int X, int Y,int I,int R){// I = iteration, R = radii of hexagon
  float CenterRadius = sqrt(pow(((1.5)*(I-1))*R,2)+pow(((I-1)*(sqrt(2)*R)),2));
  float[]Xval = new float[7];
  float[]Yval = new float[7];
  for (int j = 0; j <= 6 ; j++){
    Xval[j] = X+CenterRadius*sin(radians(60*j));
    Yval[j] = Y+CenterRadius*cos(radians(60*j));
  }
  float Z = 2*(I-1);
  for (int j = 1; j <= 6; j++){
    for (int k = I ; k >1; k--){
      ko++;
      float diff = ((2*k-2)/Z);
      float Xc = diff*Xval[j%6] + (1-diff)*Xval[(j+1)%6];
      float Yc = diff*Yval[j%6] + (1-diff)*Yval[(j+1)%6];
      Xc = round(Xc);
      Yc = round(Yc);
      int fx = int(Xc);
      int fy = int(Yc);
      color c = get(fx, fy);
      float r = red(c); //look okay im too lazy to bitshift
      float g = green(c); 
      float b = blue(c);
      //print("%"+r+"/");
      //print(g+"/");
      //print(b);
      if(abs(r-64) < 7 &&abs(g-150) < 7&&abs(b-238) < 7){
        output.println("/");
        output.println("0");
        output.println("0");
        output.println(level);
        output.println("2");
      }else{
        output.println("/");
        output.println("0");
        output.println("0");
        output.println(level);
        output.println("1");
      }
      //blank:255,255,255
      //CalcPlayer(int(Xc),int(Yc),6,1,15,3600,R+3,3,false,30,true,color(56, 201, 255),a);//body
  }
  }
}