class NameHighlight {
 ArrayList<HlGridBox> gridBoxes = new ArrayList<HlGridBox>();
 PVector destination;

  NameHighlight(PVector iDest, float limitL, float limitR, int gridBoxDiv, int numOfBoxes) {

    for (int i = 0; i < numOfBoxes; i++) {

      // Create initial location 
      //int randX = int(random(limitL, limitR));
      // int randX = int(random(width));
      // int randY = int(random(height));
      // float initX = randX*(COLUMNWIDTH/gridBoxDiv);
      // float initY = randY*(ROWHEIGHT/gridBoxDiv);
      // PVector initLoc = new PVector(initX, initY);
      PVector initLoc = new PVector(-5,-5);

      // Create final location on gaussian curve for x and y
      float randXRange = 0.07 * width;
      float randYRange = 0.09 * height;
      
      float yOffset = 0.2 * height;

      float destX = gaussianCoord(randXRange, iDest.x);
      float destY = gaussianCoord(randYRange, iDest.y + yOffset);

      PVector destLoc = new PVector(destX, destY);

      // Initialize all at same color
      color initClr = color(5,5,5);

      // Create new box
      HlGridBox gbox = new HlGridBox(initLoc, initClr, gridBoxDiv, destLoc);

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

  void enterBoxes() {
    for (HlGridBox box : gridBoxes) {
      box.enter();
      box.run();
    }
  }

  void exitBoxes() {
   for (HlGridBox box : gridBoxes) {
     box.exit();
     box.run();
   } 
  }

}