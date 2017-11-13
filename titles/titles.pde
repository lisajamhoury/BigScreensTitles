boolean debug = false;

ArrayList<GridBox> gridBoxes;

void setup() {
  //size(11520, 1080, P3D);
  //fullScreen(P2D, SPAN);
  //size(5000, 469, P3D); // my display
  //fullScreen(P3D);
  //size(2880, 270, P3D);
  //size(3840,360, P3D);
  //size(1920, 180, P3D); //Aaron's projector 
  size(1440, 135, P3D);
  //surface.setLocation(0,0);

  setupGrid(); 
  setupAnimGrid();

  gridBoxes = new ArrayList<GridBox>();

  background(0);
  smooth(4);
  noCursor();


  // Create Columns
  for (int i = 0; i <= VERTICALDIV; i++) {
    for (int j = 0; j <= HORIZONTALDIV; j++) {
      PVector initLoc = new PVector(i*COLUMNWIDTH, j* ROWHEIGHT);
      GridBox gbox = new GridBox(initLoc);

      gridBoxes.add(gbox);
    }
  }
}

void draw() {
  background(0);
  
  for (GridBox box : gridBoxes) {
    box.update();
    box.run();  
  }

  //animGrid();

  

  if (debug) drawGrid();
}