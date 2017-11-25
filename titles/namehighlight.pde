class NameHighlight {
 ArrayList<GridBox> gridBoxes = new ArrayList<GridBox>();
 PVector destination;

 NameHighlight(PVector iDest, float limitL, float limitR, int gridBoxDiv, float acceptableDist, int numOfBoxes) {

  for (int i = 0; i < numOfBoxes; i++) {
    int randX = int(random(limitL, limitR));
    int randY = int(random(height));

    PVector initLoc = new PVector(randX*(COLUMNWIDTH/gridBoxDiv), randY*(ROWHEIGHT/gridBoxDiv));
    color initClr = color(255, 0, 0);

    GridBox gbox = new GridBox(initLoc, initClr, gridBoxDiv, acceptableDist);

    gridBoxes.add(gbox);
  }
}

 void drawBoxes() {
    for (GridBox box : gridBoxes) {
      box.run();
    }
  }

}