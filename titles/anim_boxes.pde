ArrayList<GridBox> gridBoxes;
float probability = 0.5;
float probInc = 0.005;

int now = 0;
int holdTime = 500; // 3 seconds
boolean timing = false;

void setupAnimBoxes() {
  gridBoxes = new ArrayList<GridBox>();

  int horzCtr = 0;
  int vertCtr = 0;
  boolean rowFlipClr = true;
  boolean colStartBlk = false;
  color colStartClr = color(0);
  color colOppClr = color(255);
  
  // Go through columns
  for (int i = 0; i <= VERTICALDIV*GRIDBOXDIV; i++) {
    // Go through rows
    horzCtr = 0;

    // Create panel black and white checkers! OMG
    if (vertCtr < GRIDBOXDIV) {
      vertCtr++;  
    } else {
      vertCtr = 0;
      colStartBlk = !colStartBlk;
    }

    if (colStartBlk) {
      colStartClr = color(0);
      colOppClr = color(255);
    } else {
      colStartClr = color(255);
      colOppClr = color(0);
    }

    for (int j = 0; j <= HORIZONTALDIV*GRIDBOXDIV; j++) {
      PVector initLoc = new PVector(i*(COLUMNWIDTH/GRIDBOXDIV), j*(ROWHEIGHT/GRIDBOXDIV));
      
      color initClr = colStartClr;
      if (!rowFlipClr) initClr = colOppClr;

      GridBox gbox = new GridBox(initLoc, initClr);

      gridBoxes.add(gbox);

      if (horzCtr < GRIDBOXDIV) {
        horzCtr++;  
      } else {
        rowFlipClr = !rowFlipClr;
        horzCtr = 0;
      }
      
    }
  } 
}


// calculate boxes distance to text
void boxesToText(TextBlock tblock) {
  for (GridBox box : gridBoxes) {
    box.distToLtr = box.distToLtr(tblock.fontPoints);
  }

}

// calculate boxes distance to text
void boxesToTextPVect(ArrayList<PVector> textPoints) {
  for (GridBox box : gridBoxes) {
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
    print(timing);
  }

  if (millis() > now + holdTime) {
    holdOver = true;
    timing = false;
    print(timing);
  }

  return holdOver;
}

void drawBoxes() {
  for (GridBox box : gridBoxes) {
    box.run();  
  }

}

void fadeToBlack() {
  if (probability > -0.1) {
    probability -= probInc;
  } 
  // else {
  //   changeState = true;
  // }

  for (GridBox box : gridBoxes) {
    box.fadeToBlack(probability);
    box.run();  
  }
}


void animBoxes() {

  for (GridBox box : gridBoxes) {
    box.update(probability);
    box.run();  
  }

}