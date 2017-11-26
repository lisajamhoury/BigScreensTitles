class HlGridBox extends GridBox {
  PVector destination;
  float lerpAmount = 0.1;

  HlGridBox(PVector iLoc, color iClr, int iGBDiv, PVector iDest) {
    super(iLoc, iClr, iGBDiv);

    destination = iDest.copy();

  }

  void enter() {
    location.x = lerp(location.x, destination.x, lerpAmount);
    location.y = lerp(location.y, destination.y, lerpAmount);
  }

  void exit() {
    //lerpAmount = -0.1;

    location.x = lerp(location.x, initLoc.x, lerpAmount);
    location.y = lerp(location.y, initLoc.y, lerpAmount);
  }

}