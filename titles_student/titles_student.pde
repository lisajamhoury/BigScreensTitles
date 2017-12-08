import java.util.Random;


boolean debugBoxes = false;
boolean debugGrid = false;
boolean debugText = false;
boolean looping = true;

int sketchState = 0;
boolean changeSketchState = false;

Random generator;

int bgValue = 0;
color bgColor = color(bgValue);


void setup() {
  //size(11520, 1080, P3D);
  fullScreen(P2D, SPAN);
  //size(5000, 469, P2D); // my display
  //fullScreen(P3D);
  //size(2880, 270, P2D);
  //size(3840,360, P3D);
  //size(1920, 180, P2D); //Aaron's projector 

  //size(1440, 135, P2D);
  //surface.setLocation(0,0);
  generator = new Random();

  setupGrid(); 
  setupText();
  setupAnimGrid();
  //setupAnimBoxes();

  if (debugBoxes) sketchState = 2;

  //background(0);
  smooth(4);
  noCursor();
}


void draw() {

  background(255);

  if (changeSketchState) {
    changeSketchState();
  }


  if (sketchState == 0) {
    animText();  
  }

  if (debugGrid) drawGrid();
  if (debugText) drawText();

}


void changeSketchState() {
  sketchState++;
  changeSketchState = false;
}

void keyPressed() {

  if (looping) noLoop();
  if (!looping) loop();

  looping = !looping;
}