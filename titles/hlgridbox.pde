class HlGridBox extends GridBox {
  PVector destination;
  float lerpAmount = 0.1;

  HlGridBox(PVector iLoc, color iClr, int iGBDiv, PVector iDest) {
    super(iLoc, iClr, iGBDiv);

    destination = iDest.copy();

  }

  void update() {
    location.x = lerp(location.x, destination.x, lerpAmount);
    location.y = lerp(location.y, destination.y, lerpAmount);
  }

}