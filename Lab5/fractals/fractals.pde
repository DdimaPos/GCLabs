float theta;   

void setup() {
  size(1000, 800);
  smooth();
}

void draw() {
  background(255);
  // Let's pick an angle 0 to 90 degrees based on the mouse position
  theta = map(mouseX,0,width,0,PI/2);

  // Start the tree from the bottom of the screen
  translate(width/2, height);
  stroke(23, 148, 9);
  branch(180);
}

void branch(float len) {
  // Each branch will be 2/3rds the size of the previous one

  float sw = map(len,2,120,1,10);
  strokeWeight(sw);
      
  line(0, 0, 0, -len);
  // Move to the end of that line
  translate(0, -len);

  len *= 0.70;
  // All recursive functions must have an exit condition!!!!
  // Here, ours is when the length of the branch is 2 pixels or less
  if (len > 1) {
    pushMatrix();    // Save the current state of transformation (i.e. where are we now)
    rotate(theta);   // Rotate by theta
    branch(len);       // Ok, now call myself to draw two new branches!!
    popMatrix();     // Whenever we get back here, we "pop" in order to restore the previous matrix state

    // Repeat the same thing, only branch off to the "left" this time!
    pushMatrix();
    rotate(-theta);
    branch(len);
    popMatrix();
  }
}
