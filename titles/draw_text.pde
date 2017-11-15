import geomerative.*;

// Declare the objects we are going to use, so that they are accesible from setup() and from draw()
TextBlock bigScreens;
TextBlock titleL;
TextBlock titleC;
TextBlock titleR;

// RShape grp;
// RPoint[] fontPoints;

// RShape grpStudent;
// RPoint[] fontPointsStuL;
// RPoint[] fontPointsStuC;
// RPoint[] fontPointsStuR;

void setupText() {
  // VERY IMPORTANT: Allways initialize the library in the setup
  RG.init(this);

  //  Load the font file we want to use (the file must be in the data folder in the sketch floder), with the size 60 and the alignment CENTER
  int fontSize = floor(0.105 * width);
  float bsOffsetX = width/2;
  float bsOffsetY = height*7/8; 
  bigScreens = new TextBlock(fontSize, bsOffsetX, bsOffsetY, "BIG SCREENS 2017", "Block-Berthold-Regular.ttf");

  int fontSizeStudent = floor(0.02 * width);
  titleL = new TextBlock(fontSizeStudent, VISUALLEFTCTR.x, VISUALLEFTCTR.y, "RUNNING OUT OF TIME", "Block-Berthold-Regular.ttf");
  titleC = new TextBlock(fontSizeStudent, VISUALCTR.x, VISUALCTR.y, "RUNNING OUT OF TIME", "Block-Berthold-Regular.ttf");
  titleR = new TextBlock(fontSizeStudent, VISUALRIGHTCTR.x, VISUALRIGHTCTR.y, "RUNNING OUT OF TIME", "Block-Berthold-Regular.ttf");
  
}

void drawText() {

  fill(0);
  stroke(0);

  //bigScreens.display();
  titleL.display();
  titleC.display();
  titleR.display();

}