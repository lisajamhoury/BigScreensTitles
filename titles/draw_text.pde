import geomerative.*;

// Declare the objects we are going to use, so that they are accesible from setup() and from draw()
RFont f;
RShape grp;
RPoint[] fontPoints;

void setupText() {
  // VERY IMPORTANT: Allways initialize the library in the setup
  RG.init(this);

  int fontSize = floor(0.05 * width);
  float fontOffsetX = width/2;
  float fontOffsetY = height/2; 

  //  Load the font file we want to use (the file must be in the data folder in the sketch floder), with the size 60 and the alignment CENTER
  grp = RG.getText("BIG SCREENS 2017", "Whitney-Light.ttf", fontSize, CENTER);
  fontPoints = grp.getPoints();
  
  // Position text in 
  for (RPoint point : fontPoints) {
    point.x += fontOffsetX;
    point.y += fontOffsetY;
  }

}

void drawText() {

  fill(0);
  stroke(0);
  
  // If there are any points
  if(fontPoints != null){

    //int inc = int(random(4)); // WHY DOES ADDING THIS CRASH PROGRAM? 
    
    for(int i=0; i<fontPoints.length; i+=1){
      rect(fontPoints[i].x, fontPoints[i].y,5,5);  
    }
  }
  translate(0,0);
}