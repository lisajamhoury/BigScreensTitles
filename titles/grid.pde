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
float VERTICALDIV = 71.008;
float HORIZONTALDIV = 8.88;
int  GRIDBOXDIV = 4;


void setupGrid() {  
  //Set positioning constants
  VISUALCTR = new PVector( 0.44*width, 0.44*height );
  VISUALLEFTCTR = new PVector( 0.16*width, 0.44*height );
  VISUALRIGHTCTR = new PVector( 0.72*width, 0.44*height );
  ONETHIRD = 0.31*width;
  TWOTHIRD = 0.57*width;
  AREA = width * height;
  
  
  //resolution = floor(width/180); // scale resolution to canvas size 
  COLUMNWIDTH = width / VERTICALDIV;
  ROWHEIGHT = height / HORIZONTALDIV;  
}

void drawGrid() {
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