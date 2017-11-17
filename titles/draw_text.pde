import geomerative.*;

String studentTitle = "My Title";

// Declare the objects we are going to use, so that they are accesible from setup() and from draw()
TextBlock bigScreens;
TextBlock titleL;
TextBlock titleC;
TextBlock titleR;

ArrayList<PVector> combTitlesPoints;

int textState = 0; 
boolean changeState = false;

void setupText() {
  // VERY IMPORTANT: Allways initialize the library in the setup
  RG.init(this);

  //  Load the font file we want to use (the file must be in the data folder in the sketch floder), with the size 60 and the alignment CENTER
  int fontSize = floor(0.105 * width);
  float bsOffsetX = width/2;
  float bsOffsetY = height*7/8; 
  bigScreens = new TextBlock(fontSize, bsOffsetX, bsOffsetY, "BIG SCREENS 2017", "Block-Berthold-Regular.ttf");

  int fontSizeStudent = floor(0.05 * width);
  titleL = new TextBlock(fontSizeStudent, VISUALLEFTCTR.x, VISUALLEFTCTR.y, studentTitle, "Block-Berthold-Regular.ttf");
  titleC = new TextBlock(fontSizeStudent, VISUALCTR.x, VISUALCTR.y, studentTitle, "Block-Berthold-Regular.ttf");
  titleR = new TextBlock(fontSizeStudent, VISUALRIGHTCTR.x, VISUALRIGHTCTR.y, studentTitle, "Block-Berthold-Regular.ttf");

  combTitlesPoints = new ArrayList<PVector>();

  combinePoints(titleL.fontPoints);
  combinePoints(titleC.fontPoints);
  combinePoints(titleR.fontPoints);
  
}

void combinePoints(RPoint[] fPoints) {
  for (int i = 0; i < fPoints.length; i++ ) {
    PVector newPt = new PVector(fPoints[i].x, fPoints[i].y);
    combTitlesPoints.add(newPt); 
  }
}

void drawText() {

  fill(0);
  stroke(0);

  bigScreens.display();
  titleL.display();
  titleC.display();
  titleR.display();

}

void advanceState() {
  textState++;
  changeState = false;

} 

void animText() {
  if (changeState) advanceState();


  //random boxes
  //animBoxes()

  //resolve to Big Screens  
  if (textState == 0) {
    boxesToText(bigScreens);
    animBoxes();
    changeState = true; 
  } 

  if (textState == 1) {
    resolveBoxes();  
    animBoxes();
  }

  if (textState == 2) {
    changeState = holdBoxesState();
    animBoxes();
  } 

  if (textState == 3) {
    unresolveBoxes();
    animBoxes();
  }

  if (textState == 4) {
    boxesToTextPVect(combTitlesPoints);
    animBoxes();
    changeState = true; 
  }

  if (textState == 5) {
    resolveBoxes();
    animBoxes();
  }

  if (textState == 6) {
    changeState = holdBoxesState();
    animBoxes();
  }

  if (textState == 7) {
    unresolveBoxes();
    animBoxes();
  }

  if (textState == 8) {
    fadeToBlack();

  }
  
  
  

}