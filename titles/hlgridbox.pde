class HlGridBox extends GridBox {
  PVector destination;
  float distLerpAmt = 0.1;

  color destClr = color(0);
  float clrLerpAmt = 0.025;

  // check if box is close to it's placement on screen
  float inPlace = 0.001 * width;

  // check if colors are close
  float clrReached = 25;
  

  HlGridBox(PVector iLoc, color iClr, int iGBDiv, PVector iDest) {
    super(iLoc, iClr, iGBDiv);

    destination = iDest.copy();

  }

  void lerpBoxClr(color clr1, color clr2) {
    boxClr = lerpColor(clr1, clr2, clrLerpAmt);      
  }

  boolean clrStateComplete(color clr1, color clr2) {
    boolean complete = false;

    // compare red values 
    float clrValB = red(clr1);
    float clrValD = red(clr2);
    float clrDist = abs(clrValB - clrValD);

    if (clrDist < clrReached) complete = true;

    return complete;

  }

  void lerpBoxLoc(PVector dest) {
    location.x = lerp(location.x, dest.x, distLerpAmt);
    location.y = lerp(location.y, dest.y, distLerpAmt);
  }

  boolean locStateComplete(PVector dest) {
    boolean complete = false;

    float locDist = abs(location.dist(dest));

    if (locDist < inPlace) complete = true;

    return complete;

  }
}