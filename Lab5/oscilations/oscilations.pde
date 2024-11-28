int xspacing = 8;   
int w;             
int maxwaves = 5;  

float theta = 0.0;
float[] amplitude = new float[maxwaves];   //height of wave
float[] dx = new float[maxwaves];          //value for incrementing X, to be calculated as a function of period and xspacing
float[] baseWave;                          //the baseline wave values (animated)
float[] modifications;                     //persistent modifications
float[] yvalues;                           //final combined wave values
//float modificationShiftSpeed = 0.00001;        //speed of the leftward shift

void setup() {
  size(640, 360);
  colorMode(RGB, 255, 255, 255, 100);
  w = width + 16;

  for (int i = 0; i < maxwaves; i++) {
    amplitude[i] = random(10, 30);
    float period = random(100, 300); //how many pixels before the wave repeats
    dx[i] = (TWO_PI / period) * xspacing;
  }

  int numPoints = w / xspacing;
  baseWave = new float[numPoints];
  modifications = new float[numPoints];
  yvalues = new float[numPoints];

  calcWave();
}

void draw() {
  background(45, 65, 214);

  calcWave();             //update the base wave motion
  shiftModifications();   //move modifications to the left
  applyModifications();   //combine base wave with modifications
  
  if (mousePressed) {
    modifyWaveWithMouse(); //allow modifications with the mouse
  }

  renderWave();
}

void calcWave() {
  //increment theta (try different values for 'angular velocity' here)
  theta += 0.02;

  //set all height values to zero
  for (int i = 0; i < baseWave.length; i++) {
    baseWave[i] = 0;
  }

  //accumulate wave height values
  for (int j = 0; j < maxwaves; j++) {
    float x = theta;
    for (int i = 0; i < baseWave.length; i++) {
      //every other wave is cosine instead of sine
      if (j % 2 == 0) baseWave[i] += sin(x) * amplitude[j];
      else baseWave[i] += cos(x) * amplitude[j];
      x += dx[j];
    }
  }
}

void applyModifications() {
  //combine base wave with modifications
  for (int i = 0; i < yvalues.length; i++) {
    yvalues[i] = baseWave[i] + modifications[i];
  }
}

void renderWave() {
  //a simple way to draw the wave with an ellipse at each position
  noStroke();
  fill(255, 50);
  ellipseMode(CENTER);
  for (int x = 0; x < yvalues.length; x++) {
    ellipse(x * xspacing, height / 2 + yvalues[x], 16, 16); // y values can be negative or positive
  }
}

void modifyWaveWithMouse() {
  //find the index of the wave closest to the mouse
  int index = int(mouseX / xspacing);
  
  //check bounds
  if (index >= 0 && index < modifications.length) {
    //modify a portion of the wave around the mouse position
    int range = 10; //how many points around the mouse to modify
    float factor = map(mouseY, 0, height, -50, 50); //map mouseY to a height adjustment
    
    for (int i = max(0, index - range); i < min(modifications.length, index + range); i++) {
      modifications[i] += factor * exp(-0.1 * sq(i - index)); //apply a Gaussian-like curve
    }
  }
}

void shiftModifications() {
  //shift modifications to the left
  for (int i = 0; i < modifications.length - 1; i++) {
    modifications[i] = modifications[i + 1];
  }
  
  modifications[modifications.length - 1] = 0;
}
