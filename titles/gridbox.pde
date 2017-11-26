class GridBox {
  PVector initLoc;
  PVector location; //top left corner of rect
  color initClr;
  color boxClr; 

  int gridBoxDiv;

  GridBox(PVector iLoc, color iClr, int iGBDiv) {
    initLoc = iLoc.copy();
    location = iLoc.copy();
    initClr = iClr;
    boxClr = initClr; 

    gridBoxDiv = iGBDiv; 
  }

  void run() {
    noStroke();
    fill(boxClr);
    rect(location.x, location.y, COLUMNWIDTH/gridBoxDiv, ROWHEIGHT/gridBoxDiv);
  }
}