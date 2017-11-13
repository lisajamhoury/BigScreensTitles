class GridBox {
  PVector location; //top left corner of rect
  color boxClr; 

  GridBox(PVector iLoc) {
    location = iLoc;
    
    int temp = floor(random(2));
    
    if (temp == 0) {
      boxClr = color(0);
    } else {
      boxClr = color (255);
    }
  }

  void update() {
    int temp = floor(random(2));
    
    if (temp == 0) {
      boxClr = color(0);
    } else {
      boxClr = color (255);
    }
  }

  void run() {
    
    
    fill(boxClr);
    rect(location.x, location.y, COLUMNWIDTH, ROWHEIGHT);
    
  }
  
}