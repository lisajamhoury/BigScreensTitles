import geomerative.*;

BoxGrid boxGridTitle;

// setup grid of boxes for big screens text 
String studentTitle;
String studentAttribution;
color studentColor;

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

int textState = 2; 
boolean changeState = false;

void setupText() {

  // Initialize geomerative 
  RG.init(this);

  String[] stuInfo = loadStrings("data/title.txt");

  studentTitle = stuInfo[0];
  studentAttribution = stuInfo[1];

  int r = int(stuInfo[2]);
  int g = int(stuInfo[3]);
  int b = int(stuInfo[4]);
  
  studentColor = color(r, g, b);

  int bsGridDivs = 3;
  int stuTitleGridDivs = 7; 

  boxGridTitle = new BoxGrid(stuTitleGridDivs, 0.001 * width);

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
  highLightL = new NameHighlight(namesLPos, limitL, limitR, bsGridDivs, 1500, studentColor);
  
  //limitL = (ONETHIRD/COLUMNWIDTH) * bsGridDivs;
  //limitR = (TWOTHIRD/COLUMNWIDTH) * bsGridDivs;
  highLightC = new NameHighlight(namesCPos, limitL, limitR, bsGridDivs, 1500, studentColor);
  
  //limitL = (TWOTHIRD/COLUMNWIDTH) * bsGridDivs;
  //limitR = (width/COLUMNWIDTH) * bsGridDivs;
  highLightR = new NameHighlight(namesRPos, limitL, limitR, bsGridDivs, 1500, studentColor);
  
}

void combinePoints(RPoint[] fPoints) {
  for (int i = 0; i < fPoints.length; i++ ) {
    PVector newPt = new PVector(fPoints[i].x, fPoints[i].y);
    combTitlesPoints.add(newPt); 
  }
}

void drawText() {

  fill(0);

  titleL.display();
  titleC.display();
  titleR.display();

}

void advanceState() {
  textState++;
  changeState = false;

} 

void animText() {
  // Hold times 
  int initHold = 1000;
  int titleHold = 500;
  int titlePlusNamesHold = 3000;

  // Unresolve title squares incs
  float unresolveIncTitle = 0.005;
  float ftbInc = 0.05;

  float enterClrLimit = 25;
  float exitClrLimit = 50;
      

  if (changeState) advanceState();

  if (textState == 2) {
    changeState = boxGridTitle.holdBoxesState(initHold);
    boxGridTitle.drawBoxes();
  }

  // map grid boxes to big screens
  if (textState == 3) {
    //boxGridTitle.animBoxes();
    changeState = boxGridTitle.gridToRandom();
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
    changeState = boxGridTitle.holdBoxesState(titleHold);
    boxGridTitle.animBoxes();
  }

  // hold title, resolve student names 
  if (textState == 7) {
    changeState = highLightL.enterBoxes(enterClrLimit);
    changeState = highLightC.enterBoxes(enterClrLimit);
    changeState = highLightR.enterBoxes(enterClrLimit);

    boxGridTitle.animBoxes();
  }

  // hold title, resolve student names 
  if (textState == 8) {

    changeState = highLightL.boxesToDest();
    changeState = highLightC.boxesToDest();
    changeState = highLightR.boxesToDest();
    namesL.display();
    namesC.display();
    namesR.display();

    boxGridTitle.animBoxes();
  }

  // hold title, hold student names / highlight
  if (textState == 9) {

    highLightL.boxesToDest(); // keep slowly moving boxes
    highLightC.boxesToDest(); // keep slowly moving boxes
    highLightR.boxesToDest(); // keep slowly moving boxes
    namesL.display();
    namesC.display();
    namesR.display();

    changeState = boxGridTitle.holdBoxesState(titlePlusNamesHold);
    boxGridTitle.animBoxes();
  }

  // hold title, unresolve student names / highlight
  if (textState == 10) {
    
    changeState = highLightL.boxesToInit();
    changeState = highLightC.boxesToInit();
    changeState = highLightR.boxesToInit();  

    boxGridTitle.animBoxes();

  }

  // hold title, remove student names 
  if (textState == 11) {

    changeState = highLightL.exitBoxes(exitClrLimit);
    changeState = highLightC.exitBoxes(exitClrLimit);
    changeState = highLightR.exitBoxes(exitClrLimit);   

    boxGridTitle.animBoxes();

  }

  // unresolve title
  if (textState == 12) {
    boxGridTitle.unresolveBoxes(unresolveIncTitle);
    //boxGridTitle.gridToRandom();
    boxGridTitle.animBoxes();
  }

  // fadet to black
  if (textState == 13) {
    boxGridTitle.fadeToBlack(ftbInc);

  }

}