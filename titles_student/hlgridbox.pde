class HlGridBox extends GridBox {
  PVector destination;
  float distLerpAmt = 0.1;

  color destClr;
  float clrLerpAmt = 0.025;

  // check if box is close to it's placement on screen
  float inPlace = 0.005 * width;

  HlGridBox(PVector iLoc, color iClr, color iDClr, int iGBDiv, PVector iDest) {
    super(iLoc, iClr, iGBDiv);

    destination = iDest.copy();
    destClr = iDClr;

  }

  void lerpBoxClr(color clr1, color clr2) {
    boxClr = lerpColor(clr1, clr2, clrLerpAmt);      
  }

  boolean clrStateComplete(color clr1, color clr2, float clrLimit) {
    boolean complete = false;

    // keep track of distance btw clr channels
    float clrDist; 

    // compare red values 
    float clrValB = red(clr1);
    float clrValD = red(clr2);
    clrDist = abs(clrValB - clrValD);

    // compare green values
    clrValB = green(clr1);
    clrValD = green(clr2);
    float grnClrDist = abs(clrValB - clrValD);

    // raise clr dist if value is higher
    if (grnClrDist > clrDist) clrDist = grnClrDist;


    // compare blue values
    clrValB = blue(clr1);
    clrValD = blue(clr2);
    float blueClrDist = abs(clrValB - clrValD);
    
    // raise clr dist if value is higher
    if (blueClrDist > clrDist) clrDist = blueClrDist;

    // if all distances are lower than limit, we're done
    if (clrDist < clrLimit) complete = true;

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