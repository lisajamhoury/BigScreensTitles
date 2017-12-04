class BoxGrid {
  ArrayList<TitleGridBox> gridBoxes = new ArrayList<TitleGridBox>();

  // For creating letters 
  float probability = 0.5;
  float probInc = 0.005;

  // For grid to random
  float initRandProp = 0.000001;
  float initPropInc = 1.1;
  float randPropLimit = 0.9;

  // For holding title on screen
  int now = 0;
  //int holdTime = 3000; // 3 seconds
  boolean timing = false;

  // For revealing boxes from center
  float revealDist = 0.0;
  float revealLerp = 0.003;

  BoxGrid(int gridBoxDiv, float acceptableDist) {
    // Go through columns
    for (int i = 0; i <= VERTICALDIV*gridBoxDiv; i++) {
      // Go through rows

      int c = int(i/gridBoxDiv);
      for (int j = 0; j <= HORIZONTALDIV*gridBoxDiv; j++) {
        PVector initLoc = new PVector(i*(COLUMNWIDTH/gridBoxDiv), j*(ROWHEIGHT/gridBoxDiv));

        color initClr = color(0);
        boolean initDraw = true;

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

  void drawBoxes() {
    for (TitleGridBox box : gridBoxes) {
      if (box.draw) box.run();
    }
  }

  void fadeToBlack(float iInc) {
    if (probability > -0.1) {
      probability -= iInc;
    } 

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