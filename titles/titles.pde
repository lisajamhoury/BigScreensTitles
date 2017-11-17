boolean debugGrid = false;
boolean debugText = false;

int sketchState = 0;
boolean changeSketchState = false;

void setup() {
  //size(11520, 1080, P3D);
  //fullScreen(P2D, SPAN);
  //size(5000, 469, P3D); // my display
  //fullScreen(P3D);
  //size(2880, 270, P3D);
  //size(3840,360, P3D);
  //size(1920, 180, P3D); //Aaron's projector 
  size(1440, 135, P2D);
  //surface.setLocation(0,0);

  setupGrid(); 
  setupText();
  setupAnimGrid();
  setupAnimBoxes();

  //background(0);
  smooth(4);
  noCursor();
}

void changeSketchState() {
  sketchState++;
  changeSketchState = false;
}

void draw() {
  background(255);

  if (changeSketchState) {
    changeSketchState();
  }

  if (sketchState == 0) {
    changeSketchState = animGrid();
  }

  if (sketchState == 1) {
    changeSketchState = holdBoxesState();
    drawBoxes();
  }

  if (sketchState == 2) {
    animText();  
  }


  



  if (debugGrid) drawGrid();
  if (debugText) drawText();
}