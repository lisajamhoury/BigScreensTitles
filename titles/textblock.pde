class TextBlock {
	RShape grp;
  RPoint[] fontPoints;

  TextBlock(int ifSize, float iOffsetX, float iOffsetY, String iText, String iFont) {

    grp = RG.getText(iText, iFont, ifSize, CENTER);
    fontPoints = grp.getPoints();

    offSetPoints(iOffsetX, iOffsetY);
  }

  void offSetPoints(float offsetX, float offsetY) {
    for (RPoint point : fontPoints) {
      point.x += offsetX;
      point.y += offsetY;
    }
  }

  void display() {
    fill(0);

    for (int i=0; i<fontPoints.length; i++) {
     rect(fontPoints[i].x, fontPoints[i].y, 5, 5);
    }
    
  }

} 