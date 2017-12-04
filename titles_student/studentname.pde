class StudentName {
  PVector position;
  String names;

  StudentName(PVector iPos, String iNames) {
    position = iPos;
    names = iNames;
  }

  void update() {
    fill(0);
    rectMode(CENTER);
    rect(position.x, (position.y + height/4) - (0.03 * height), width/4, height/6);
    rectMode(CORNER); //return rect mode
  }

  void display() {
    fill(255);
    text(names, position.x, position.y + height/4);
  }

}
    