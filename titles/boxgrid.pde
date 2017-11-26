class BoxGrid {
  ArrayList<TitleGridBox> gridBoxes = new ArrayList<TitleGridBox>();
  float probability = 0.5;
  float probInc = 0.005;

  int now = 0;
  int holdTime = 3000; // 3 seconds
  boolean timing = false;

  BoxGrid(int gridBoxDiv, float acceptableDist) {
    
    // Assign initial colors based on grid 
    boolean rowFlipClr = true;

    // Go through columns
    for (int i = 0; i <= VERTICALDIV*gridBoxDiv; i++) {
      // Go through rows

      // STUFF MIMI ADDED
      // Need to reset rowFlipClr to true at the beginning of every loop down each row
      // Otherwise, the logic to set colStartBlk could get reversed in line 50 below
      // depending on the state of rowFlipClr at the end of the row.
      rowFlipClr = true;

      int c = int(i/gridBoxDiv);
      for (int j = 0; j <= HORIZONTALDIV*gridBoxDiv; j++) {
        PVector initLoc = new PVector(i*(COLUMNWIDTH/gridBoxDiv), j*(ROWHEIGHT/gridBoxDiv));

        color initClr = color(0);
        boolean initDraw = true;

        // Only r++ for ever 3x j++
        int r = int(j/gridBoxDiv);
        // Fill white for even cols + even rows
        // Fill white for odd cols + odd rows
        if ((c%2 == 0 && r%2 == 0) || (c%2 == 1 && r%2 == 1)) {
          initDraw = false;

        }
        // Fill black for odd cols + even rows
        // Fill black for even cols + odd rows
        else if ((c%2 == 1 && r%2 == 0) || (c%2 == 0 && r%2 == 1)) {
          initDraw = true;
        }

        TitleGridBox gbox = new TitleGridBox(initLoc, initClr, gridBoxDiv, acceptableDist, initDraw);

        gridBoxes.add(gbox);

      }
    }

  }

  // calculate boxes distance to text
  void boxesToText(TextBlock tblock) {
    for (TitleGridBox box : gridBoxes) {
      box.distToLtr = box.distToLtr(tblock.fontPoints);
    }
  }

  // calculate boxes distance to text
  void boxesToTextPVect(ArrayList<PVector> textPoints) {
    for (TitleGridBox box : gridBoxes) {
      box.distToLtr = box.distToLtrPVect(textPoints);
    }
  }

  // change from random boxes to text
  void resolveBoxes() {

    if (probability < 1.0) {
      probability += probInc;
    } else {
      changeState = true;
    }
  }

  // change from text to random boxes
  void unresolveBoxes() {

    if (probability > 0.5) {
      probability -= probInc;
    } else {
      changeState = true;
    }
  } 

  // keep boxes as they are
  boolean holdBoxesState() {
    boolean holdOver = false;

    if (!timing) {
      now = millis(); 
      timing = true;  
    }

    if (millis() > now + holdTime) {
      holdOver = true;
      timing = false;
    }

    return holdOver;
  }

  void drawBoxes() {
    for (TitleGridBox box : gridBoxes) {
      if (box.draw) box.run();
    }
  }

  void fadeToBlack() {
    if (probability > -0.1) {
      probability -= probInc;
    } 
    // else {
    //   changeState = true;
    // }

    for (TitleGridBox box : gridBoxes) {
      box.fadeToBlack(probability);
      if (box.draw) box.run();
    }
  }


  void animBoxes() {

    for (TitleGridBox box : gridBoxes) {
      box.update(probability);
      if (box.draw) box.run();
    }
  }
}

