ArrayList<GridBox> gridBoxes;

void setupAnimBoxes() {
  gridBoxes = new ArrayList<GridBox>();

  // Go through olumns
  for (int i = 0; i <= VERTICALDIV*4; i++) {
    // Go through rows
    for (int j = 0; j <= HORIZONTALDIV*4; j++) {
      PVector initLoc = new PVector(i*(COLUMNWIDTH/4), j*(ROWHEIGHT/4));
      GridBox gbox = new GridBox(initLoc);

      gridBoxes.add(gbox);
    }
  }

}


void animBoxes() {
  for (GridBox box : gridBoxes) {
    box.update();
    box.run();  
  }

}