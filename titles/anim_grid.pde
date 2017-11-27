ArrayList<GridLine> rowLines;
ArrayList<GridLine> colLines;
ArrayList<GridLine> opRowLines;
ArrayList<GridLine> opColLines;

void setupAnimGrid() {

  rowLines = new ArrayList<GridLine>();
  colLines = new ArrayList<GridLine>();
  opRowLines = new ArrayList<GridLine>();
  opColLines = new ArrayList<GridLine>();

  // Create Rows
  for (int i = 0; i <= HORIZONTALDIV; i++) {
    PVector initLoc = new PVector(0, i * ROWHEIGHT); 
    String initDir = "horizontal";
    GridLine rowLine = new GridLine(initLoc, initDir);
    rowLines.add(rowLine);

    // Create opposing row
    initLoc.x = width;
    GridLine opRowLine = new GridLine(initLoc, initDir);
    opRowLines.add(opRowLine);

  } 
 
  // Create Columns
  for (int i = 0; i <= VERTICALDIV; i++) {
    PVector initLoc = new PVector(i* COLUMNWIDTH, 0); 
    String initDir = "vertical";
    GridLine colLine = new GridLine(initLoc, initDir);

    colLines.add(colLine); 

    // Create opposing columns
    initLoc.y = height;
    GridLine opColLine = new GridLine(initLoc, initDir);
    opColLines.add(opColLine);
  } 
}

boolean animGrid() {
  boolean stateComplete = true;

  // draw each line and check each line to see if completed
  for (GridLine line : rowLines) {
    line.update();
    if (stateComplete) stateComplete = line.endState();
    line.run();
  }

  for (GridLine line : opRowLines) {
    line.update();
    if (stateComplete) stateComplete = line.endState();
    line.run();
  }
  
  for (GridLine line : colLines) {
    line.update();
    if (stateComplete) stateComplete = line.endState();
    line.run();
  }

  for (GridLine line : opColLines) {
    line.update();
    if (stateComplete) stateComplete = line.endState();
    line.run();
  }

  // returns true only when all lines are finished drawing
  return stateComplete;
  
}