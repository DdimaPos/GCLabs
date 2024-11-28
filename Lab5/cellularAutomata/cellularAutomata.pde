GOL gol;

void setup() {
  size(1000, 800);
    frameRate(15);
  gol = new GOL();
}

void draw() {
  background(255);

  gol.generate();
  gol.display();
}

// reset board when mouse is pressed
void mousePressed() {
  gol.init();
}
