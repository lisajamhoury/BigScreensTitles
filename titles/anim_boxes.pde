ArrayList<GridBox> gridBoxes;
float probability = 0.5;
float probInc = 0.005;

void setupAnimBoxes() {
  gridBoxes = new ArrayList<GridBox>();

  // Go through olumns
  for (int i = 0; i <= VERTICALDIV*GRIDBOXDIV; i++) {
    // Go through rows
    for (int j = 0; j <= HORIZONTALDIV*GRIDBOXDIV; j++) {
      PVector initLoc = new PVector(i*(COLUMNWIDTH/GRIDBOXDIV), j*(ROWHEIGHT/GRIDBOXDIV));
      GridBox gbox = new GridBox(initLoc);

      gridBoxes.add(gbox);
    }
  }

}


void animBoxes() {
  if (probability < 1.0) {
    probability += probInc;
  }
  
  for (GridBox box : gridBoxes) {
    box.update(probability);
    box.run();  
  }

}