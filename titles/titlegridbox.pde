class TitleGridBox extends GridBox {
  float distToLtr;
  float startDist;
  float acceptableDist;
  float distToClose;

  boolean initDrawState = true;
  boolean draw = true;
  
  // for fading up box color
  float alpha = 0;
  float alphaInc = 10;
  boolean fadeComplete = false;



  TitleGridBox(PVector iLoc, color iClr, int iGBDiv, float iAD, float iSD, boolean iDraw) {
    super(iLoc, iClr, iGBDiv);

    acceptableDist = iAD;
    startDist = iSD;

    initDrawState = iDraw; // use to redraw grid
    draw = iDraw;

    // if we're not initially drawing, override fade
    if (!draw) {
      alpha = 255;
      fadeComplete = true;
    }

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

  void fadeUpClr() {
    
    if (alpha < 255) {
      alpha+=alphaInc; 
    } else {
      fadeComplete = true;
    } 

  }

  void fadeToBlack(float prob) {

    //Make random number
    float num = random(1);

    if (num >= prob) {
      draw = true;
    } else {
      draw = false;
    }
    
  }

  void updateCalculated(float closeNess, boolean dissolve) {

    float acceptDistTemp = startDist - (closeNess * startDist) + acceptableDist;

    // if the box is within the visible range
    if (distToLtr < acceptDistTemp) {

      // set probability to 1.0
      float prob = closeNess;

      // map it's probability to it's distance from the letter
      if (acceptDistTemp != acceptableDist) { 
        prob = map(distToLtr, acceptDistTemp, acceptableDist, 0.0, closeNess);

        if (dissolve) prob = prob * prob;
    
      } 
      
      // create a random number
      float num = random(1);

      // draw the box if the random number is within the probability 
      if (num < prob) {
        draw = true;
      
      } else {
        draw = false;
      
      }

      // if the box is not within the visible range, don't draw it
    } else {
      draw = false;
    }

 }

  void updateRandom(float prob) {

    //Make random colors 
    float num = random(1);

    // if the box is on letter, 
    // probability increases over time that it is black
    if (distToLtr < acceptableDist) {
      if (num < prob) {
        draw = true;
        //boxClr = color(0);
      } else {
        draw = false;
        //boxClr = color (255);
      }
    // if the box is not on letter, 
    // probability increases over time that it is white
    } else {      
      if (num >= prob) {
        //boxClr = color(0);
        draw = true;
      } else {
        draw = false;
        //boxClr = color (255);
      }
    }
  }


  // this run uses alpha
  void run() {
    noStroke();

    fill(boxClr, alpha);
    rect(location.x, location.y, COLUMNWIDTH/gridBoxDiv, ROWHEIGHT/gridBoxDiv);      
  }

}