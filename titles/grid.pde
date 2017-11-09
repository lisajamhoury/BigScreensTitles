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
int VERTICALDIV = 100;
int HORIZONTALDIV = 10;


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
  ROWHEIGHT = floor( height / HORIZONTALDIV );  
}