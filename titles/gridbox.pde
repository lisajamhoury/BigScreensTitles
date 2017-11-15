class GridBox {
  PVector location; //top left corner of rect
  color boxClr; 
  float distToLtr;
  float acceptableDist = 0.002 * width; // acceptable distance from letters

  GridBox(PVector iLoc) {
    location = iLoc;

    distToLtr = distToLtr();

    boxClr = color(0); // change this to random
  }

  // Get distance of box to letters
  float distToLtr() {
    float tempDist = width;  

    // for ( RPoint point : fontPoints ) {
    //   float diff = dist(location.x, location.y, point.x, point.y);
    //   if (diff < tempDist) tempDist = diff;
    // }  

    return tempDist;
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