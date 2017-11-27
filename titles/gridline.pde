class GridLine {
  PVector startPoint;
  PVector endPoint;
  PVector destination;
  String direction;
  float lerpAmt = random(0.01, 0.05);
  color stkClr = color(0);
  float touching = 0.001 * width;

  GridLine(PVector iSP, String iDir) {
    startPoint = iSP.copy();
    endPoint = startPoint.copy();
    direction = iDir;
    destination = findDest();
  }

  PVector findDest() {
    PVector dest = new PVector();

    // check rows 
    if (direction == "horizontal") {
      dest.x = VISUALCTR.x;
      dest.y = startPoint.y;
    } else if (direction == "vertical") {
      dest.x = startPoint.x;
      dest.y = VISUALCTR.y;
    }

    return dest;
  }

  void update() {

    if (direction.equals("horizontal")) {
      endPoint.x = lerp(endPoint.x, destination.x, lerpAmt);
    } 

    if (direction.equals("vertical")) {
      endPoint.y = lerp(endPoint.y, destination.y, lerpAmt);

    }

  }

  boolean endState() {
    boolean complete = false; 
    float dist = 0.0;
    
    //check if endpoint has crossed the middle 

    if (direction.equals("horizontal")) {
      dist = abs(endPoint.x - destination.x);  
    } else if (direction.equals("vertical")) {
      dist = abs(endPoint.y - destination.y);
    }
    
    if (dist < touching) {
      //stkClr = color(255,0,0);
      complete = true;
    }

    return complete;

  }

  void run() {
    
    strokeWeight(0.001*width);
    stroke(stkClr);

    line(startPoint.x, startPoint.y, endPoint.x, endPoint.y);

  }
  
}