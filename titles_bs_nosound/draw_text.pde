import geomerative.*;

// setup grid of boxes for big screens text 
BoxGrid boxGridBS;
BoxGrid boxGridTitle;

TextBlock bigScreens;

int textState = 0; 
boolean changeState = false;

void setupText() {
  // Initialize geomerative 
  RG.init(this);

  int bsGridDivs = 3;

  boxGridBS = new BoxGrid(bsGridDivs, 0.002 * width);

  //  Load the font file we want to use (the file must be in the data folder in the sketch floder)
  int fontSize = floor(0.105 * width);
  float bsOffsetX = width/2 - COLUMNWIDTH/2;
  float bsOffsetY = height * 13/16;  
  
  bigScreens = new TextBlock(fontSize, bsOffsetX, bsOffsetY, "BIG SCREENS 2017", "Block-Berthold-Regular.ttf");
  
  // Match box of grids to big screens letters 
  boxGridBS.boxesToText(bigScreens);
}

void drawText() {

  fill(0);
  bigScreens.display();

}

void advanceState() {
  textState++;
  changeState = false;
} 

void animText() {
  // Hold times 
  int bigScreensHold = 180000; //60000


  // Unresolve title squares slower
  float unresolveIncBS = 0.005;
  float ftbInc = 0.005;
      
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
    changeState = boxGridBS.holdBoxesState(bigScreensHold);
    boxGridBS.animBoxes();
  } 

  // unresolve big screens
  if (textState == 3) {
    boxGridBS.unresolveBoxes(unresolveIncBS);
    boxGridBS.animBoxes();
  }

  // fade to black
  if (textState == 4) {
    changeState = boxGridBS.fadeToBlack(ftbInc);
  }

  // restart loop
  if (textState == 5) {
    boxGridBS.drawBoxes();

    bgValue = 0;
    bgColor = color(bgValue);

    sketchState = 0;
    changeSketchState = false;

    textState = 0;
    changeState = false;


  }


}