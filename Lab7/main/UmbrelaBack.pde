class UmbrellaBack{
  
  PVector initLoc; 
  PVector velocity; 
  int state; 
  boolean up; 
  
  UmbrellaBack(PVector l){
    initLoc = l; 
    velocity = new PVector(0, 1); 
    state = 0; 
    up = false; 
  }
  
  void run(){
    update(); 
    drawUmbrella(); 
  }
  
  void update(){
    //if(state == 0){
    //  initLoc.x = width-100; 
    //  initLoc.y = height-100; 
    //} else if(state == 1){
      initLoc.x = mouseX; 
      initLoc.y = mouseY;   
    //  up = true; 
    //}  
  }
  
  void drawUmbrella(){
     fill(#b5f3f7);
     arc(initLoc.x, initLoc.y, 100, 80, PI, 2*PI);
     rect(initLoc.x-4, initLoc.y, 5, 60);
     noFill(); 
     stroke(#54dfe8);
     strokeWeight(5); 
     arc(initLoc.x-15, initLoc.y+31, 20, 20, 0, PI);
     noStroke(); 
     fill(#54dfe8);
     triangle(initLoc.x+4, initLoc.y-38, initLoc.x-6, initLoc.y-38, initLoc.x-1, initLoc.y-48);  
     noStroke(); 
     noFill(); 
  }
  
  
}
