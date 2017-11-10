ArrayList<GridLine> rowLines;
ArrayList<GridLine> colLines;

void setupAnimGrid() {

  rowLines = new ArrayList<GridLine>();
  colLines = new ArrayList<GridLine>();
  
  // Create Rows
  for (int i = 0; i <= HORIZONTALDIV; i++) {
    PVector initLoc = new PVector(0, i* ROWHEIGHT); 
    String initDir = "horizontal";
    GridLine rowLine = new GridLine(initLoc, initDir);

    rowLines.add(rowLine);
  } 
 
  // Create Columns
  for (int i = 0; i <= VERTICALDIV; i++) {
    PVector initLoc = new PVector(i* COLUMNWIDTH, 0); 
    String initDir = "vertical";
    GridLine colLine = new GridLine(initLoc, initDir);

    colLines.add(colLine); 
  } 
  
}

void animGrid() {

  for (GridLine line : rowLines) {
    line.update();
    line.run();
  }
  
  for (GridLine line : colLines) {
    line.update();
    line.run();
  }
  
}