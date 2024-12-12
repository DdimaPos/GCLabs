import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import java.util.Iterator;
import org.jbox2d.dynamics.contacts.Contact;
Box2DProcessing box2d; 
ArrayList<DropBack> dList; 
ArrayList<Umbrella> umbrellas; 
Surface s; //surface
UmbrellaBack u; 
void setup(){
  box2d = new Box2DProcessing(this); //initialize and create Box2D world 
  box2d.createWorld(); 
  box2d.listenForCollisions();
  size(1000, 500); 
  dList = new ArrayList<DropBack>(); 
  umbrellas = new ArrayList<Umbrella>(); 
  s = new Surface();// declare the surface 
  u = new UmbrellaBack(new PVector(width/2, height/2)); 
}

void draw(){
  //Moving box2d world through time
  box2d.step(); 
  background(#EDFFFF);
  
    u.run(); 
  //Background drops  -----------  each dList has own drops
  dList.add(new DropBack(new PVector(random(-10, width), -40), new PVector(0, random(1, 2)), 50, false));
  dList.add(new DropBack(new PVector(random(-10, width), -40), new PVector(0, random(3, 4)), 100, true));
  dList.add(new DropBack(new PVector(random(-10, width), -40), new PVector(0, random(4, 5)), 200, true));
  dList.add(new DropBack(new PVector(random(-10, width), -40), new PVector(0, random(6, 7)), 255, true));
  Iterator<DropBack> it = dList.iterator();
   while(it.hasNext()){
      DropBack d = it.next(); 
      d.run(); 
      if(d.isBottom()){
         d.velocity = new PVector(random(-2, 2), random(-5, -7));  
         d.acceleration = new PVector(.01, .1); 
         if(d.dying==2){
           it.remove(); 
         }
      }
      if(dist(d.location.x, d.location.y, u.initLoc.x, u.initLoc.y)<45 && d.blocked==true){
         d.dying++; 
         d.velocity = new PVector(random(-2, 2), random(-2, -3));  
         d.acceleration = new PVector(.01, .1); 
      }
  }
  // End background drops -----------------
  
  //draw the umbrellas
  Iterator<Umbrella> it3 = umbrellas.iterator();
   while(it3.hasNext()){
    Umbrella b = it3.next(); 
    b.display(); 
    if(box2d.getBodyPixelCoord(b.canopyBody).y > height+20){
      it3.remove(); 
    }
  }
}
void mouseReleased(){
    Umbrella u = new Umbrella(colorPicker()); 
    umbrellas.add(u); 
}

void beginContact(Contact cp){
    Fixture f1 = cp.getFixtureA();
    Fixture f2 = cp.getFixtureB();

    Body b1 = f1.getBody();
    Body b2 = f2.getBody();
    
    if((Object)b1.getUserData()==null || (Object)b2.getUserData() == null){
      return; 
    }
        //drop and umbrella collide
    if((Object)b1.getUserData().getClass()==Drop.class && (Object)b2.getUserData().getClass()==Umbrella.class){ 
      Object o1 = (Drop) b1.getUserData();
      Object o2 = (Umbrella) b2.getUserData();
      Drop d1 = (Drop) o1;
      Umbrella d2 = (Umbrella) o2;
      d1.dying++; 
      d1.body.setLinearVelocity(new Vec2(random(-2, 2), random(-5, -6)));  
    }
 
}

void endContact(Contact cp) {
}

float[] colorPicker(){
  float h = random(0, 255); 
  float s = 255; 
  float b = 255; 
  float[] c = {h, s, b}; 
  return c; 
}
