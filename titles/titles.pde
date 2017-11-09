void setup() {
  //size(11520, 1080, P3D);
  //size(5000, 469, P3D); // my display
  //fullScreen(P3D);
  //size(2880, 270, P3D);
  //size(3840,360, P3D);
  //size(1920, 180, P3D); //Aaron's projector 
  size(1440, 135, P3D);
  //surface.setLocation(0,0);
  
  setupGrid(); 
  
  background(0);
  smooth(4);
  noCursor();
}

void draw() {
  for (int i = 1; i <= VERTICALDIV+2; i++) {
    fill(255);
    stroke(255);
    line(i*COLUMNWIDTH, 0, i*COLUMNWIDTH, height); 
  } 
  
  for (int i = 1; i <= HORIZONTALDIV+2; i++) {
    fill(255);
    stroke(255);
    line(0, i*ROWHEIGHT, width, i*ROWHEIGHT); 
  } 
  

}