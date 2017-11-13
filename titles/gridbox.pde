class GridBox {
  PVector location; //top left corner of rect
  color boxClr; 
  //boolean onLetter = false;
  float distToLtr;
  //float acceptableDist = width/4;
  float acceptableDist = width/4;

  GridBox(PVector iLoc) {
    location = iLoc;

    distToLtr = distToLtr();

    boxClr = color(0);
  }

  // Get distance of box to letters
  float distToLtr() {
    float tempDist = width;  

    for ( RPoint point : fontPoints ) {
      float diff = dist(location.x, location.y, point.x, point.y);
      if (diff < tempDist) tempDist = diff;
    }  

    return tempDist;
  }

  void update() {
    
    if (acceptableDist >= 0.002 * width) {
      acceptableDist -= 0.0005 * width;
    }
    
    //Make random colors 
    //int temp = floor(random(2));

    //if (temp == 0) {
    //  boxClr = color(0);
    //} else {
    //  boxClr = color (255);
    //}
  }

  void run() {

    if (distToLtr < acceptableDist ) {
      fill(boxClr);
      stroke(boxClr);
      rect(location.x, location.y, COLUMNWIDTH/4, ROWHEIGHT/4);
    }
  }
}