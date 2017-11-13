class GridLine {
  PVector startPoint;
  PVector endPoint;
  String direction;

  GridLine(PVector iSP, String iDir) {
    startPoint = iSP;
    endPoint = startPoint.copy();
    direction = iDir;
  }

  void update() {

    if (direction.equals("horizontal")) {
      endPoint.x += 0.0035*width;
    } 

    if (direction.equals("vertical")) {
      endPoint.y += 0.0035*height;
    }
    
  }

  void run() {
    
    strokeWeight(0.001*width);
    stroke(255);

    line(startPoint.x, startPoint.y, endPoint.x, endPoint.y);

    // create lines coming in opposite direction
    if (direction.equals("horizontal")) {      
      line(width, startPoint.y, width-endPoint.x, endPoint.y); 
    }
    
    // create lines coming in opposite direction
    if (direction.equals("vertical")) {
      line(startPoint.x, height, endPoint.x, height-endPoint.y);
    }
  }
  
}