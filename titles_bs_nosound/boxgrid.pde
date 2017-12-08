class BoxGrid {
  ArrayList<TitleGridBox> gridBoxes = new ArrayList<TitleGridBox>();

  // For creating letters 
  float probability = 0.5;
  float probInc = 0.005;

  // For grid to random
  float initRandProp = 0.0001;
  float initPropInc = 1.05;
  float randPropLimit = 0.9;

  // For holding title on screen
  int now = 0;
  //int holdTime = 3000; // 3 seconds
  boolean timing = false;

  // For revealing boxes from center
  float revealDist = 0.0;
  float revealLerp = 0.003;

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

  void resetGridBoxes() {
    revealDist = 0.0;
    initRandProp = 0.0001;
    initPropInc = 1.05;

    for (TitleGridBox box : gridBoxes) {
      box.draw = box.initDrawState;
      box.alpha = 0;
      box.fadeComplete = false;

      if (!box.draw) {
        box.alpha = 255;
        box.fadeComplete= true;
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

  // reset all boxes draw to true
  void resetAlpha() {
    for (TitleGridBox box : gridBoxes) {
      box.alpha = 255;
    }
  }

  boolean gridToRandom() {
    boolean stateComplete = false;

    for (TitleGridBox box : gridBoxes) {
      
      //Make random number 
      float num = random(1);

      if (num < initRandProp) {
        box.update(probability);
      }
      if (box.draw) box.run();  
    }    

    if (initRandProp < randPropLimit) {
      initRandProp*=initPropInc;
      
    } else {
      
      stateComplete = true;
    } 
    return stateComplete;
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
  void unresolveBoxes(float iInc) {

    if (probability > 0.5) {
      probability -= iInc;
    } else {
      changeState = true;
    }
  } 

  // keep boxes as they are
  boolean holdBoxesState(int holdTime) {
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

  boolean revealBoxes() {
    boolean stateComplete = true;

    for (TitleGridBox box : gridBoxes) {

      // If not drawing box default fadeup to true
      if (stateComplete) stateComplete = box.fadeComplete;  

      // find distance between box and center
      float vectDist = box.location.dist(VISUALCTR);

      // draw if it's within the acceptable distance
      if (vectDist < revealDist) {
        if (box.draw) {
          box.fadeUpClr();
          box.run();  
        }
      }
    }

    // Keep widening reveal distance
    revealDist = lerp(revealDist, width, revealLerp);

    return stateComplete;
  }

  void drawBoxes() {
    for (TitleGridBox box : gridBoxes) {
      if (box.draw) box.run();
    }
  }

  boolean fadeToBlack(float iInc) {
    boolean stateComplete = false;

    if (probability > -0.1) {
      probability -= iInc;
    } else {
      stateComplete = true;
    }

    for (TitleGridBox box : gridBoxes) {
      box.fadeToBlack(probability);
      if (box.draw) box.run();
    }

    return stateComplete;
  }


  void animBoxes() {

    for (TitleGridBox box : gridBoxes) {
      box.update(probability);
      if (box.draw) box.run();
    }
  }
}