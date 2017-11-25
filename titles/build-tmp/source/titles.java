import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import geomerative.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class titles extends PApplet {

boolean debugGrid = false;
boolean debugText = false;
boolean looping = true;

int sketchState = 2;
boolean changeSketchState = false;

public void setup() {
  //size(11520, 1080, P3D);
  //fullScreen(P2D, SPAN);
  //size(5000, 469, P3D); // my display
  //fullScreen(P3D);
  //size(2880, 270, P2D);
  //size(3840,360, P3D);
  //size(1920, 180, P3D); //Aaron's projector 

  
  //surface.setLocation(0,0);

  setupGrid(); 
  setupText();
  setupAnimGrid();
  //setupAnimBoxes();

  //background(0);
  
  noCursor();
}

public void changeSketchState() {
  sketchState++;
  changeSketchState = false;
}

public void draw() {
  background(255);

  if (changeSketchState) {
    changeSketchState();
  }

  if (sketchState == 0) {
    changeSketchState = animGrid();
  }

  if (sketchState == 1) {
    changeSketchState = boxGridBS.holdBoxesState();
    boxGridBS.drawBoxes();
  }

  if (sketchState == 2) {
    animText();  
  }

  if (debugGrid) drawGrid();
  if (debugText) drawText();


}

public void keyPressed() {

  if (looping) noLoop();
  if (!looping) loop();

  looping = !looping;
}



ArrayList<GridLine> rowLines;
ArrayList<GridLine> colLines;

public void setupAnimGrid() {

  rowLines = new ArrayList<GridLine>();
  colLines = new ArrayList<GridLine>();
  
  // Create Rows
  for (int i = 0; i <= HORIZONTALDIV; i++) {
    PVector initLoc = new PVector(0, i* ROWHEIGHT); 
    String initDir = "horizontal";
    GridLine rowLine = new GridLine(initLoc, initDir);

    rowLines.add(rowLine);
  } 
 
  // Create Columns
  for (int i = 0; i <= VERTICALDIV; i++) {
    PVector initLoc = new PVector(i* COLUMNWIDTH, 0); 
    String initDir = "vertical";
    GridLine colLine = new GridLine(initLoc, initDir);

    colLines.add(colLine); 
  } 
  
}

public boolean animGrid() {
  boolean endState = false;

  for (GridLine line : rowLines) {
    line.update();
    endState = line.endState();
    line.run();
  }
  
  for (GridLine line : colLines) {
    line.update();
    line.run();
  }

  return endState;
  
}
class BoxGrid {
  ArrayList<GridBox> gridBoxes = new ArrayList<GridBox>();
  float probability = 0.5f;
  float probInc = 0.005f;

  int now = 0;
  int holdTime = 500; // 3 seconds
  boolean timing = false;

  BoxGrid(int gridBoxDiv, float acceptableDist) {
    
    // Assign initial colors based on grid 
    boolean rowFlipClr = true;

    // Go through columns
    for (int i = 0; i <= VERTICALDIV*gridBoxDiv; i++) {
      // Go through rows

      // STUFF MIMI ADDED
      // Need to reset rowFlipClr to true at the beginning of every loop down each row
      // Otherwise, the logic to set colStartBlk could get reversed in line 50 below
      // depending on the state of rowFlipClr at the end of the row.
      rowFlipClr = true;

      int c = PApplet.parseInt(i/gridBoxDiv);
      for (int j = 0; j <= HORIZONTALDIV*gridBoxDiv; j++) {
        PVector initLoc = new PVector(i*(COLUMNWIDTH/gridBoxDiv), j*(ROWHEIGHT/gridBoxDiv));

        int initClr = color(255, 0, 0);
        // Only r++ for ever 3x j++
        int r = PApplet.parseInt(j/gridBoxDiv);
        // Fill white for even cols + even rows
        // Fill white for odd cols + odd rows
        if ((c%2 == 0 && r%2 == 0) || (c%2 == 1 && r%2 == 1)) initClr = color(255);
        // Fill black for odd cols + even rows
        // Fill black for even cols + odd rows
        else if ((c%2 == 1 && r%2 == 0) || (c%2 == 0 && r%2 == 1)) initClr = color(0);

        GridBox gbox = new GridBox(initLoc, initClr, gridBoxDiv, acceptableDist);

        gridBoxes.add(gbox);

      }
    }

  }

  // calculate boxes distance to text
  public void boxesToText(TextBlock tblock) {
    for (GridBox box : gridBoxes) {
      box.distToLtr = box.distToLtr(tblock.fontPoints);
    }
  }

  // calculate boxes distance to text
  public void boxesToTextPVect(ArrayList<PVector> textPoints) {
    for (GridBox box : gridBoxes) {
      box.distToLtr = box.distToLtrPVect(textPoints);
    }
  }

  // change from random boxes to text
  public void resolveBoxes() {

    if (probability < 1.0f) {
      probability += probInc;
    } else {
      changeState = true;
    }
  }

  // change from text to random boxes
  public void unresolveBoxes() {

    if (probability > 0.5f) {
      probability -= probInc;
    } else {
      changeState = true;
    }
  } 

  // keep boxes as they are
  public boolean holdBoxesState() {
    boolean holdOver = false;

    if (!timing) {
      now = millis(); 
      timing = true;  
    }

    if (millis() > now + holdTime) {
      holdOver = true;
      timing = false;
    }

    return holdOver;
  }

  public void drawBoxes() {
    for (GridBox box : gridBoxes) {
      box.run();
    }
  }

  public void fadeToBlack() {
    if (probability > -0.1f) {
      probability -= probInc;
    } 
    // else {
    //   changeState = true;
    // }

    for (GridBox box : gridBoxes) {
      box.fadeToBlack(probability);
      box.run();
    }
  }


  public void animBoxes() {

    for (GridBox box : gridBoxes) {
      box.update(probability);
      box.run();
    }
  }




}



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

int textState = 4; 
boolean changeState = false;

public void setupText() {
  // Initialize geomerative 
  RG.init(this);

  boxGridBS = new BoxGrid(3, 0.002f * width);
  boxGridTitle = new BoxGrid(7, 0.001f * width);

  // ONETHIRD/COLUMNWIDTH gives amount of columns for width of allowable screen
  float acceptableDist = width * 1.0f;
  float limitR = ((width/3)/COLUMNWIDTH)*2;
  println(ONETHIRD, COLUMNWIDTH, limitR);
  highLightL = new NameHighlight(VISUALLEFTCTR, 0.0f, limitR, 3, acceptableDist, 1000);

  //  Load the font file we want to use (the file must be in the data folder in the sketch floder)
  int fontSize = floor(0.105f * width);
  float bsOffsetX = width/2;
  float bsOffsetY = height*7/8; 
  bigScreens = new TextBlock(fontSize, bsOffsetX, bsOffsetY, "BIG SCREENS 2017", "Block-Berthold-Regular.ttf");

  int fontSizeStudent = floor(0.023f* width);
  titleL = new TextBlock(fontSizeStudent, VISUALLEFTCTR.x, VISUALLEFTCTR.y, studentTitle, "Block-Berthold-Regular.ttf");
  titleC = new TextBlock(fontSizeStudent, VISUALCTR.x, VISUALCTR.y, studentTitle, "Block-Berthold-Regular.ttf");
  titleR = new TextBlock(fontSizeStudent, VISUALRIGHTCTR.x, VISUALRIGHTCTR.y, studentTitle, "Block-Berthold-Regular.ttf");

  combTitlesPoints = new ArrayList<PVector>();

  combinePoints(titleL.fontPoints);
  combinePoints(titleC.fontPoints);
  combinePoints(titleR.fontPoints);

  PFont whitneySemiBoldSC = createFont("Whitney-SemiboldSC.ttf", 50);
  textFont(whitneySemiBoldSC);
  textSize(PApplet.parseInt(fontSizeStudent/2));
  textAlign(CENTER);

  // Create attribution lines 
  namesL = new StudentName(VISUALLEFTCTR, studentAttribution);
  namesC = new StudentName(VISUALCTR, studentAttribution);
  namesR = new StudentName(VISUALRIGHTCTR, studentAttribution);
  
}

public void combinePoints(RPoint[] fPoints) {
  for (int i = 0; i < fPoints.length; i++ ) {
    PVector newPt = new PVector(fPoints[i].x, fPoints[i].y);
    combTitlesPoints.add(newPt); 
  }
}

public void drawText() {

  fill(0);

  bigScreens.display();
  titleL.display();
  titleC.display();
  titleR.display();

}

public void advanceState() {
  textState++;
  changeState = false;

} 

public void animText() {
    


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
    changeState = boxGridTitle.holdBoxesState();
    boxGridTitle.animBoxes();
    highLightL.drawBoxes();

    // namesL.display();
    // namesC.display();
    // namesR.display();
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

  highLightL.drawBoxes();
  
  
  

}
//POSTITIONING
PVector VISUALCTR;
PVector VISUALLEFTCTR;
PVector VISUALRIGHTCTR;
float ONETHIRD;
float TWOTHIRD;
float AREA;

//GRID 
float COLUMNWIDTH;
float ROWHEIGHT;
float VERTICALDIV = 71.008f;
float HORIZONTALDIV = 8.88f;
//int  GRIDBOXDIV = 7; // 3 for big screens big text 


public void setupGrid() {  
  //Set positioning constants
  VISUALCTR = new PVector( 0.44f*width, 0.44f*height );
  VISUALLEFTCTR = new PVector( 0.16f*width, 0.44f*height );
  VISUALRIGHTCTR = new PVector( 0.72f*width, 0.44f*height );
  ONETHIRD = 0.31f*width;
  TWOTHIRD = 0.57f*width;
  AREA = width * height;
  
  
  //resolution = floor(width/180); // scale resolution to canvas size 
  COLUMNWIDTH = width / VERTICALDIV;
  ROWHEIGHT = height / HORIZONTALDIV;  
}

public void drawGrid() {
  for (int i = 0; i <= VERTICALDIV; i++) {
    fill(255);
    stroke(255);
    line(i*COLUMNWIDTH, 0, i*COLUMNWIDTH, height); 
  } 
  
  for (int i = 0; i <= HORIZONTALDIV; i++) {
    fill(255);
    stroke(255);
    line(0, i*ROWHEIGHT, width, i*ROWHEIGHT); 
  } 
}
class GridBox {
  PVector location; //top left corner of rect
  int initClr;
  int boxClr; 
  float distToLtr;
  float acceptableDist;
  int gridBoxDiv;

  GridBox(PVector iLoc, int iClr, int iGBDiv, float iAD) {
    location = iLoc;
    
    initClr = iClr;
    boxClr = initClr; 

    gridBoxDiv = iGBDiv;
    acceptableDist = iAD;
  }

  // Get distance of box to letters
  public float distToLtr(RPoint[] fontPoints) {
    float tempDist = width;  

    for ( RPoint point : fontPoints ) {
      float diff = dist(location.x, location.y, point.x, point.y);
      if (diff < tempDist) tempDist = diff;
    }  

    return tempDist;
  }

  // Get distance of box to letters
  public float distToLtrPVect(ArrayList<PVector> fPoints) {
    float tempDist = width;  

    for ( PVector point : fPoints ) {
      float diff = dist(location.x, location.y, point.x, point.y);
      if (diff < tempDist) tempDist = diff;
    }  

    return tempDist;
  }

  public void fadeToBlack(float prob) {
    //Make random colors 
    float num = random(1);

    if (num >= prob) {
      boxClr = color(0);
    } else {
      boxClr = color (255);
    }
    
  }

  public void update(float prob) {

    //Make random colors 
    float num = random(1);

    // if the box is on letter, 
    // probability increases over time that it is black
    if (distToLtr < acceptableDist) {
      if (num < prob) {
        boxClr = color(0);
      } else {
        boxClr = color (255);
      }
    // if the box is not on letter, 
    // probability increases over time that it is white
    } else {      
      if (num >= prob) {
        boxClr = color(0);
      } else {
        boxClr = color (255);
      }
    }
  }

  public void run() {
    noStroke();
    fill(boxClr);
    rect(location.x, location.y, COLUMNWIDTH/gridBoxDiv, ROWHEIGHT/gridBoxDiv);
  }
}
class GridLine {
  PVector startPoint;
  PVector endPoint;
  String direction;

  GridLine(PVector iSP, String iDir) {
    startPoint = iSP;
    endPoint = startPoint.copy();
    direction = iDir;
  }

  public void update() {

    if (direction.equals("horizontal")) {
      endPoint.x += 0.0035f*width;
    } 

    if (direction.equals("vertical")) {
      endPoint.y += 0.0035f*height;
    }

  }

  public boolean endState() {
    boolean endState = false; 
    
    // check if endpoint has crossed the middle 
    if (endPoint.x >= width/2) {
      endState = true;
    }

    return endState;

  }

  public void run() {
    
    strokeWeight(0.001f*width);
    stroke(0);

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
class NameHighlight {
 ArrayList<GridBox> gridBoxes = new ArrayList<GridBox>();
 PVector destination;

 NameHighlight(PVector iDest, float limitL, float limitR, int gridBoxDiv, float acceptableDist, int numOfBoxes) {

  for (int i = 0; i < numOfBoxes; i++) {
    int randX = PApplet.parseInt(random(limitL, limitR));
    int randY = PApplet.parseInt(random(height));

    PVector initLoc = new PVector(randX*(COLUMNWIDTH/gridBoxDiv), randY*(ROWHEIGHT/gridBoxDiv));
    int initClr = color(255, 0, 0);

    GridBox gbox = new GridBox(initLoc, initClr, gridBoxDiv, acceptableDist);

    gridBoxes.add(gbox);
  }
}

 public void drawBoxes() {
    for (GridBox box : gridBoxes) {
      box.run();
    }
  }

}
class StudentName {
  PVector position;
  String names;

  StudentName(PVector iPos, String iNames) {
    position = iPos;
    names = iNames;
  }

  public void update() {
    fill(0);
    rectMode(CENTER);
    rect(position.x, (position.y + height/4) - (0.03f * height), width/4, height/6);
    rectMode(CORNER); //return rect mode
  }

  public void display() {
    fill(255);
    text(names, position.x, position.y + height/4);
  }

}
    
class TextBlock {
	RShape grp;
  RPoint[] fontPoints;

  TextBlock(int ifSize, float iOffsetX, float iOffsetY, String iText, String iFont) {

    grp = RG.getText(iText, iFont, ifSize, CENTER);
    fontPoints = grp.getPoints();

    offSetPoints(iOffsetX, iOffsetY);
  }

  public void offSetPoints(float offsetX, float offsetY) {
    for (RPoint point : fontPoints) {
      point.x += offsetX;
      point.y += offsetY;
    }
  }

  public void display() {
    fill(0);

    for (int i=0; i<fontPoints.length; i++) {
     rect(fontPoints[i].x, fontPoints[i].y, 5, 5);
    }
    
  }

} 
  public void settings() {  size(1440, 135, P2D);  smooth(4); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--hide-stop", "titles" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
