class TitleGridBox extends GridBox {
  float distToLtr;
  float acceptableDist;

  boolean initDrawState = true;
  boolean draw = true;
  
  // for fading up box color
  float alpha = 0;
  float alphaInc = 10;
  boolean fadeComplete = false;

  TitleGridBox(PVector iLoc, color iClr, int iGBDiv, float iAD, boolean iDraw) {
    super(iLoc, iClr, iGBDiv);

    acceptableDist = iAD;

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
    //Make random colors 
    float num = random(1);

    if (num >= prob) {
      //boxClr = color(0);
      draw = true;
    } else {
      draw = false;
      //boxClr = color (255);
    }
    
  }

  void update(float prob) {

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