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
  fullScreen(P2D, SPAN);
  // size(11520, 1080, P2D);
  // size(7680, 720, P2D);
  //size(5000, 469, P3D); // my display
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
  
  if (debugBoxes) sketchState = 2;

  smooth(4);
  noCursor();
}


void draw() {
  
  if (debugBoxes) background(255);
  else background(bgColor);

  if (changeSketchState) {
    changeSketchState();
  }

  if (sketchState == 0) {
    changeSketchState = fadeUpBackground();
  }

  if (sketchState == 1) {
    changeSketchState = animGrid();
  }

  if (sketchState == 2) {
    changeSketchState = boxGridBS.revealBoxes();
  }

  if (sketchState == 3) {
    animText();  
  }

  if (debugGrid) drawGrid();
  if (debugText) drawText();

}

boolean fadeUpBackground() {
  boolean stateComplete = false;
  
  if (bgValue < 255) {
    bgValue++; 
    bgColor = color(bgValue);
  } else {
    stateComplete = true;
  } 

  return stateComplete;
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