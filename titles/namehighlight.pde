class NameHighlight {
 ArrayList<HlGridBox> gridBoxes = new ArrayList<HlGridBox>();
 PVector destination;

  NameHighlight(PVector iDest, float limitL, float limitR, int gridBoxDiv, int numOfBoxes, color stuClr) {

    for (int i = 0; i < numOfBoxes; i++) {

       //Create initial location 
      int randX = int(random(limitL, limitR));
       int randY = int(random(height));
       float initX = randX*(COLUMNWIDTH/gridBoxDiv);
       float initY = randY*(ROWHEIGHT/gridBoxDiv);
       PVector initLoc = new PVector(initX, initY);

      // Create final location on gaussian curve for x and y
      float randXRange = 0.07 * width;
      float randYRange = 0.09 * height;
      
      float yOffset = 0.2 * height;

      float destX = gaussianCoord(randXRange, iDest.x);
      float destY = gaussianCoord(randYRange, iDest.y + yOffset);

      PVector destLoc = new PVector(destX, destY);

      // Initialize all at same color
      color initClr = color(255);

      // Create new box
      HlGridBox gbox = new HlGridBox(initLoc, initClr, stuClr, gridBoxDiv, destLoc);

      // Add all boxes to array
      gridBoxes.add(gbox);
    }
  }

  float gaussianCoord(float sd, float mean) {
    float coordinate; 
    float num = (float) generator.nextGaussian();

    coordinate = sd * num + mean;

    return coordinate;
  } 

  boolean enterBoxes() {
    boolean stateComplete = true;

    for (HlGridBox box : gridBoxes) {
      box.lerpBoxClr(box.boxClr, box.destClr);
      box.run();

      if (stateComplete) stateComplete = box.clrStateComplete(box.boxClr, box.destClr);
    }

    return stateComplete;
  }

  boolean boxesToDest() {
    boolean stateComplete = true;

    for (HlGridBox box : gridBoxes) {
      box.lerpBoxLoc(box.destination);  
      box.run();

      if (stateComplete) stateComplete = box.locStateComplete(box.destination);
    }

    return stateComplete;
  }

  void drawBoxes() {
    for (HlGridBox box : gridBoxes) {
      box.run();
    }     
  }

  boolean boxesToInit() {
    boolean stateComplete = true;

   for (HlGridBox box : gridBoxes) {
     box.lerpBoxLoc(box.initLoc);
     box.run();

     if (stateComplete) stateComplete = box.locStateComplete(box.initLoc);
   } 

   return stateComplete;
  }


  boolean exitBoxes() {
    boolean stateComplete = true;

   for (HlGridBox box : gridBoxes) {
    box.lerpBoxClr(box.boxClr, box.initClr);
    box.run();
  
    if (stateComplete) stateComplete = box.clrStateComplete(box.boxClr, box.initClr);
   } 

   return stateComplete;
  }

}