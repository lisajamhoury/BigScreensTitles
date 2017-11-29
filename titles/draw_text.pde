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
NameHighlight highLightC;
NameHighlight highLightR;

ArrayList<PVector> combTitlesPoints;

int textState = 4; 
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
  //float bsOffsetX = width/2;
  //float bsOffsetY = height*7/8;
  float bsOffsetX = width/2;
  float bsOffsetY = height * 13/16;
  
  
  bigScreens = new TextBlock(fontSize, bsOffsetX, bsOffsetY, "BIG SCREENS 2017", "Block-Berthold-Regular.ttf");
  
  // Match box of grids to big screens letters 
  boxGridBS.boxesToText(bigScreens);

  int fontSizeStudent = floor(0.023* width);
  float titleOffsetY = height / 8 ;
  titleL = new TextBlock(fontSizeStudent, VISUALLEFTCTR.x, VISUALLEFTCTR.y  - titleOffsetY, studentTitle, "Block-Berthold-Regular.ttf");
  titleC = new TextBlock(fontSizeStudent, VISUALCTR.x, VISUALCTR.y - titleOffsetY, studentTitle, "Block-Berthold-Regular.ttf");
  titleR = new TextBlock(fontSizeStudent, VISUALRIGHTCTR.x, VISUALRIGHTCTR.y  - titleOffsetY, studentTitle, "Block-Berthold-Regular.ttf");

  combTitlesPoints = new ArrayList<PVector>();

  combinePoints(titleL.fontPoints);
  combinePoints(titleC.fontPoints);
  combinePoints(titleR.fontPoints);

  // Match student title grid to combined font points
  boxGridTitle.boxesToTextPVect(combTitlesPoints);

  // Allow all boxes to be drawn — FIX THIS SO NO LONGER NEEDED
  boxGridTitle.resetAlpha();

  PFont whitneySemiBoldSC = createFont("Whitney-SemiboldSC.ttf", 50);
  textFont(whitneySemiBoldSC);
  textSize(int(fontSizeStudent/2.5));
  textAlign(CENTER);

  // Create attribution lines 
  float namesOffsetY = height / 10 ;
  PVector namesLPos = new PVector(VISUALLEFTCTR.x, VISUALLEFTCTR.y - namesOffsetY);
  PVector namesCPos = new PVector(VISUALCTR.x, VISUALCTR.y - namesOffsetY);
  PVector namesRPos = new PVector(VISUALRIGHTCTR.x, VISUALRIGHTCTR.y - namesOffsetY);
  
  namesL = new StudentName(namesLPos, studentAttribution);
  namesC = new StudentName(namesCPos, studentAttribution);
  namesR = new StudentName(namesRPos, studentAttribution);

  // ONETHIRD/COLUMNWIDTH gives amount of columns for width of allowable screen
  //float limitL = 0.0;
  //float limitR = (ONETHIRD/COLUMNWIDTH) * bsGridDivs;
  
  float limitL = 0.0;
  float limitR= (width/COLUMNWIDTH) * bsGridDivs;
  highLightL = new NameHighlight(namesLPos, limitL, limitR, bsGridDivs, 1500);
  
  //limitL = (ONETHIRD/COLUMNWIDTH) * bsGridDivs;
  //limitR = (TWOTHIRD/COLUMNWIDTH) * bsGridDivs;
  highLightC = new NameHighlight(namesCPos, limitL, limitR, bsGridDivs, 1500);
  
  //limitL = (TWOTHIRD/COLUMNWIDTH) * bsGridDivs;
  //limitR = (width/COLUMNWIDTH) * bsGridDivs;
  highLightR = new NameHighlight(namesRPos, limitL, limitR, bsGridDivs, 1500);
  
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
  //println(textState);
  

  if (changeState) advanceState();

  // map grid boxes to big screens
  if (textState == 0) {
    changeState = boxGridBS.gridToRandom();
  } 

  //resolve to Big Screens  
  if (textState == 1) {
    boxGridBS.resolveBoxes();  
    boxGridBS.animBoxes();
  }

  // hold big screens on screen
  if (textState == 2) {
    changeState = boxGridBS.holdBoxesState(1000);
    boxGridBS.animBoxes();
  } 

  // unresolve big screens
  if (textState == 3) {
    boxGridBS.unresolveBoxes();
    boxGridBS.animBoxes();
  }

  // map grid boxes to student title
  if (textState == 4) {
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
    changeState = boxGridTitle.holdBoxesState(1000);
    boxGridTitle.animBoxes();
  }

  // hold title, resolve student names 
  if (textState == 7) {
    highLightL.enterBoxes();
    highLightC.enterBoxes();
    highLightR.enterBoxes();

    changeState = boxGridTitle.holdBoxesState(4000);
    boxGridTitle.animBoxes();

    

  }

  // hold title, resolve student names 
  if (textState == 8) {

    highLightL.boxesToDest();
    highLightC.boxesToDest();
    highLightR.boxesToDest();
    namesL.display();
    namesC.display();
    namesR.display();

    changeState = boxGridTitle.holdBoxesState(4000);
    boxGridTitle.animBoxes();
  }

  // hold title, remove student names 
  if (textState == 9) {
    
    highLightL.boxesToInit();
    highLightC.boxesToInit();
    highLightR.boxesToInit();  

    changeState = boxGridTitle.holdBoxesState(4000);
    boxGridTitle.animBoxes();

  }

  // hold title, remove student names 
  if (textState == 10) {

    highLightL.exitBoxes();
    highLightC.exitBoxes();
    highLightR.exitBoxes();   

    changeState = boxGridTitle.holdBoxesState(4000);
    boxGridTitle.animBoxes();

  }

  // unresolve title
  if (textState == 11) {
    boxGridTitle.unresolveBoxes();
    boxGridTitle.animBoxes();
  }

  // fadet to black
  if (textState == 12) {
    boxGridTitle.fadeToBlack();

  }

  //print(textState);
  
  
  

}