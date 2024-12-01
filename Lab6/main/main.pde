float scaleFactor = 1;
float angleX = 0;
float angleY = 0;
PImage platformTexture;

void setup() {
  size(800, 800, P3D);
  platformTexture = loadImage("80.jpg");
}

void draw() {
  background(50, 150, 255);

  //lighting
  ambientLight(100, 100, 100);
  ambient(blue)
  pointLight(255, 255, 255, width / 2, height / 2, 200); 

  // Center the scene
  translate(width / 2, height / 2 + 100, 0);
  rotateX(angleX); 
  rotateY(angleY);
  scale(scaleFactor); 
  //draw platform
  textureMode(NORMAL);
  pushMatrix();
  translate(0, 90, 0); //shift platform
  noStroke();
  beginShape(QUAD);
  texture(platformTexture);
  vertex(-150, 10, -150, 0, 0);
  vertex(150, 10, -150, 1, 0);
  vertex(150, 10, 150, 1, 1);
  vertex(-150, 10, 150, 0, 1);
  endShape(CLOSE);
  popMatrix();

  //tree trunk
  pushMatrix();
  fill(101, 67, 33); 
  box(40, 200, 40);
  popMatrix();

  // draw the leaves 
  fill(34, 139, 34); //green
  float radius = 80; 
  //tree crown
  for (float theta = -PI / 2; theta < PI / 2; theta += PI / 8) {
    for (float phi = 0; phi < TWO_PI; phi += PI / 8) {
    
      float x = radius * cos(theta) * cos(phi);
      float y = radius * cos(theta) * sin(phi);
      float z = radius * sin(theta);

      pushMatrix();
      translate(x, -120 + z, y); 
      sphere(30); 
      popMatrix();
    }
  }

 
  if (mousePressed) {
    angleX = map(mouseY, 0, -height, -PI, PI);
    angleY = map(mouseX, 0, width, -PI, PI);
  }
}
void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  scaleFactor += e * 0.1; //adjust scale factor with scrolling
  scaleFactor = constrain(scaleFactor, 0.5, 5); //limit scaling range
}
