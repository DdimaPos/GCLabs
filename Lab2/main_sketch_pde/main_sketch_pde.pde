
ArrayList<Raindrop> raindrops = new ArrayList<Raindrop>();
ArrayList<Ripple> ripples = new ArrayList<Ripple>();

void setup() {
  size(1200, 920);
  for (int i = 0; i < 100; i++) {
    raindrops.add(new Raindrop());
  }
}

void draw() {
  background(255);
  fill(#64D406);
  noStroke();
  rect(0, height - 30, width, 30); //ground

  //update and display raindrops
  for (int i = 0; i < raindrops.size(); i++) {
    Raindrop raindrop = raindrops.get(i);
    raindrop.fall();
    raindrop.show();
  }

  //update and display ripples
  for (int i = ripples.size() - 1; i >= 0; i--) {
    Ripple ripple = ripples.get(i);
    ripple.expand();
    ripple.show();
    if (ripple.radius > 50) {
      ripples.remove(i);
    }
  }
}
//define the raindrop class
class Raindrop {
  float x;
  float y;
  float length;
  float speed;

  Raindrop() {
    x = random(width);
    y = random(-100, -10);
    length = random(10, 20);
    speed = random(2, 5);
  }

  void fall() {
    y += speed;
    if (y > height - 30) {
      ripples.add(new Ripple(x, height - 30));
      y = random(-100, -10);
      x = random(width);
    }
  }

  void show() {
    stroke(#7E94BB);
    strokeWeight(2);
    line(x, y, x, y + length);
  }
}
//define the ripple class
class Ripple {
  float x;
  float y;
  float radius;
  float alpha;

  Ripple(float x, float y) {
    this.x = x;
    this.y = y;
    this.radius = 1;
    this.alpha = 255;
  }

  void expand() {
    radius += 0.5;
    alpha -= 5;
  }

  void show() {
    noFill();
    stroke(#7E94BB, alpha);
    ellipse(x, y, radius * 2, radius * 2);
  }
}
