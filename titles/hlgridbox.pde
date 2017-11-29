class HlGridBox extends GridBox {
  PVector destination;
  float lerpAmount = 0.1;

  color destClr = color(0);
  float lerpClrAmt = 0.025;
  

  HlGridBox(PVector iLoc, color iClr, int iGBDiv, PVector iDest) {
    super(iLoc, iClr, iGBDiv);

    destination = iDest.copy();

  }

  void enter() {
    boxClr = lerpColor(boxClr, destClr, lerpClrAmt);
  }

  void toDest() {
    location.x = lerp(location.x, destination.x, lerpAmount);
    location.y = lerp(location.y, destination.y, lerpAmount);
  }

  void toInitLoc() {
    location.x = lerp(location.x, initLoc.x, lerpAmount);
    location.y = lerp(location.y, initLoc.y, lerpAmount);
  }

  void exit() {
    boxClr = lerpColor(boxClr, initClr, lerpClrAmt);
  }


}