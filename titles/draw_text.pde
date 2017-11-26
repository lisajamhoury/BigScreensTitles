import geomerative.*;

// setup grid of boxes for big screens text 
BoxGrid boxGridBS;
BoxGrid boxGridTitle;

String studentTitle = "Running Out of Time";
String studentAttribution = "Mayukh Goswami, Utsav Chadha, Mindy Ossi";

TextBlock bigScreens;
TextBlock titleL;
TextBlock titleC;
TextBlock titleR;

StudentName namesL;
StudentName namesC;
StudentName namesR;

NameHighlight highLightL;

ArrayList<PVector> combTitlesPoints;

int textState = 6; 
boolean changeState = false;

void setupText() {
  // Initialize geomerative 
  RG.init(this);

  int bsGridDivs = 3;
  int stuTitleGridDivs = 7; 

  boxGridBS = new BoxGrid(bsGridDivs, 0.002 * width);
  boxGridTitle = new BoxGrid(stuTitleGridDivs, 0.001 * width);

  //  Load the font file we want to use (the file must be in the data folder in the sketch floder)
  int fontSize = floor(0.105 * width);
  float bsOffsetX = width/2;
  float bsOffsetY = height*7/8; 
  bigScreens = new TextBlock(fontSize, bsOffsetX, bsOffsetY, "BIG SCREENS 2017", "Block-Berthold-Regular.ttf");

  int fontSizeStudent = floor(0.023* width);
  titleL = new TextBlock(fontSizeStudent, VISUALLEFTCTR.x, VISUALLEFTCTR.y, studentTitle, "Block-Berthold-Regular.ttf");
  titleC = new TextBlock(fontSizeStudent, VISUALCTR.x, VISUALCTR.y, studentTitle, "Block-Berthold-Regular.ttf");
  titleR = new TextBlock(fontSizeStudent, VISUALRIGHTCTR.x, VISUALRIGHTCTR.y, studentTitle, "Block-Berthold-Regular.ttf");

  combTitlesPoints = new ArrayList<PVector>();

  combinePoints(titleL.fontPoints);
  combinePoints(titleC.fontPoints);
  combinePoints(titleR.fontPoints);

  PFont whitneySemiBoldSC = createFont("Whitney-SemiboldSC.ttf", 50);
  textFont(whitneySemiBoldSC);
  textSize(int(fontSizeStudent/2.5));
  textAlign(CENTER);

  // Create attribution lines 
  namesL = new StudentName(VISUALLEFTCTR, studentAttribution);
  namesC = new StudentName(VISUALCTR, studentAttribution);
  namesR = new StudentName(VISUALRIGHTCTR, studentAttribution);

  // ONETHIRD/COLUMNWIDTH gives amount of columns for width of allowable screen
  float limitL = 0.0;
  float limitR = (ONETHIRD/COLUMNWIDTH) * bsGridDivs;
  //println(ONETHIRD, COLUMNWIDTH, limitR);
  highLightL = new NameHighlight(VISUALLEFTCTR, limitL, limitR, bsGridDivs, 1500);
  
}

void combinePoints(RPoint[] fPoints) {
  for (int i = 0; i < fPoints.length; i++ ) {
    PVector newPt = new PVector(fPoints[i].x, fPoints[i].y);
    combTitlesPoints.add(newPt); 
  }
}

void drawText() {

  fill(0);

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

  // map grid boxes to big screens
  if (textState == 0) {
    boxGridBS.boxesToText(bigScreens);
    boxGridBS.animBoxes();
    changeState = true; 
  } 

  //resolve to Big Screens  
  if (textState == 1) {
    boxGridBS.resolveBoxes();  
    boxGridBS.animBoxes();
  }

  // hold big screens on screen
  if (textState == 2) {
    changeState = boxGridBS.holdBoxesState();
    boxGridBS.animBoxes();
  } 

  // unresolve big screens
  if (textState == 3) {
    boxGridBS.unresolveBoxes();
    boxGridBS.animBoxes();
  }

  // map grid boxes to student title
  if (textState == 4) {
    boxGridTitle.boxesToTextPVect(combTitlesPoints);
    boxGridTitle.animBoxes();
    changeState = true; 
  }

  // resolve bodes to student title
  if (textState == 5) {
    boxGridTitle.resolveBoxes();
    boxGridTitle.animBoxes();
  }

  // hold title on screen 
  if (textState == 6) {

    // boolean dontChange = boxGridTitle.holdBoxesState();
    // changeState = boxGridTitle.holdBoxesState();
    // boxGridTitle.animBoxes();

    highLightL.drawBoxes();
    namesL.display();
    namesC.display();
    namesR.display();
  }

  if (textState == 7) {
    boxGridTitle.unresolveBoxes();
    boxGridTitle.animBoxes();
    // namesL.display();
    // namesC.display();
    // namesR.display();
  }

  if (textState == 8) {
    boxGridTitle.fadeToBlack();

  }

  
  
  
  

}