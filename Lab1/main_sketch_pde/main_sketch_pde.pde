void setup(){
  size(1200, 1000);
  background(250);
  noStroke();
  fill(255,255,255);
}
void fig1(){
  pushMatrix();
  fill(#B02229);
  translate(300, 550); 
  rotate(PI); 
  arc(0, 0, 300, 300, -PI/2, PI/2, CLOSE); 
  popMatrix();
}
void fig2(){
  pushMatrix();
  fill(#D4452A);
  translate(300, 775);
  rotate(PI); 
  arc(0, 0, 150, 150, -PI/2, PI/2, CLOSE); 
  popMatrix();
}

void fig3(){
  fill(#B02229);
  rect(250,850, 50, 100);
}
void fig4(){
  fill(#DDC626);
  rect(250,950, 50, 100);
}
void fig5(){
  pushMatrix();
  translate(100, 450);
  rotate(-PI/2);
  fill(#D85226);
  arc(0, 0, 200, 200, 0, HALF_PI, PIE);
  
  fill(255);
  arc(0, 0, 100, 100, 0, HALF_PI, PIE);
  popMatrix();
}
void fig6(){
  pushMatrix();
  translate(200, 800);
  rotate(PI);
  fill(#A82126);
  arc(0, 0, 200, 200, 0, HALF_PI, PIE);
  fill(255);
  arc(0, 0, 100, 100, 0, HALF_PI, PIE);
  popMatrix();
}
void fig7(){
  pushMatrix();
  translate(50, 800);
  fill(#E5D01B);
  arc(0, 0, 200, 200, 0, HALF_PI, PIE);
  fill(255);
  arc(0, 0, 100, 100, 0, HALF_PI, PIE);
  popMatrix();
}
void fig8(){
  fill(#3178BE);
  rect(300, 400, 300, 300);
}
void fig9(){
  fill(#D64B2C);
  rect(600, 400, 50, 300);
}
  
void fig10(){
  fill(#E5D01B);
  rect(600, 700, 50, 50);
}
void fig11(){
  fill(#3178BE);
  rect(600, 750, 50, 100);
}
void fig12(){
  fill(#E5D01B);
  rect(600, 850, 50, 100);
}
void fig13(){
  pushMatrix();
  translate(650, 800);
  rotate(-PI/2);
  fill(#3178BE);
  arc(0, 0, 200, 200, 0, HALF_PI, PIE);
  
  fill(255);
  arc(0, 0, 100, 100, 0, HALF_PI, PIE);
  popMatrix();
}
void fig14(){

  fill(#E5D01B);
  rect(700, 800, 50, 100);
}
void fig15(){

  fill(#B9222A);
  triangle(650, 400, 650, 700, 950, 400);
}
void fig16(){
    pushMatrix();
  translate(600, 350);
  fill(#B32029);
  rotate(5*PI/4);
  rect(0, 0, -(50*sqrt(2)), 200*sqrt(2));
    popMatrix();

}
void fig17(){

  fill(#3178BE);
  triangle(650, 400, 850, 400, 850, 200);
}
void fig18(){
    fill(#66A040);
    rect(850, 200, 100, 200);
}
void fig19(){
    fill(#D1422B);
    triangle(950, 400, 1150, 400, 950, 200);
}
void fig20(){
    pushMatrix();
    fill(#E5CE1F);
    translate(1075, 400); 
    arc(0, 0,150, 150, 0, PI, CLOSE); 
    popMatrix();
}
void fig21(){
    pushMatrix();
    fill(#DD4E2B);
    translate(900, 125); 
    rotate(PI/3);
    arc(0, 0,150, 150, 0, PI, CLOSE); 
    popMatrix();
}
float x = 50;  // Initial x position
//float y = 100;
float amplitude = 50; // Amplitude of the sine wave
float frequency = 0.01; 
void draw(){
    background(255);
    fig1();
    fig2();
    fig3();
    fig4();
    fig5();
    fig6();
    fig7();
    fig8();
    fig9();
    fig10();
    fig11();
    fig12();
    fig13();
    fig14();
    fig15();
    fig16();
    fig17();
    fig18();
    fig19();
    fig20();
    fig21();
    float y = height/2 + sin(x * frequency) * amplitude;
    ellipse(x, y, 50, 50);
  
    // Update the x position to move the circle to the right
    x = x - 5; // Increase this value to make the movement faster
  
    // Reset the position if it goes off screen
    if (x < 0) {
        x = width;
    }
}
