class GridBox {
  PVector location; //top left corner of rect
  color initClr;
  color boxClr; 
  float distToLtr;
  float acceptableDist = 0.002 * width; // acceptable distance from letters

  GridBox(PVector iLoc, color iClr) {
    location = iLoc;

    initClr = iClr;
    boxClr = initClr; 
  }

  // Get distance of box to letters
  float distToLtr(RPoint[] fontPoints) {
    float tempDist = width;  

    for ( RPoint point : fontPoints ) {
      float diff = dist(location.x, location.y, point.x, point.y);
      if (diff < tempDist) tempDist = diff;
    }  

    return tempDist;
  }

  // Get distance of box to letters
  float distToLtrPVect(ArrayList<PVector> fPoints) {
    float tempDist = width;  

    for ( PVector point : fPoints ) {
      float diff = dist(location.x, location.y, point.x, point.y);
      if (diff < tempDist) tempDist = diff;
    }  

    return tempDist;
  }

  void fadeToBlack(float prob) {
    //Make random colors 
    float num = random(1);

    if (num >= prob) {
      boxClr = color(0);
    } else {
      boxClr = color (255);
    }
    
  }

  void update(float prob) {

    //Make random colors 
    float num = random(1);

    // if the box is on letter, 
    // probability increases over time that it is black
    if (distToLtr < acceptableDist) {
      if (num < prob) {
        boxClr = color(0);
      } else {
        boxClr = color (255);
      }
    // if the box is not on letter, 
    // probability increases over time that it is white
    } else {      
      if (num >= prob) {
        boxClr = color(0);
      } else {
        boxClr = color (255);
      }
    }
  }

  void run() {
    fill(boxClr);
    stroke(boxClr);
    rect(location.x, location.y, COLUMNWIDTH/GRIDBOXDIV, ROWHEIGHT/GRIDBOXDIV);
  }
}