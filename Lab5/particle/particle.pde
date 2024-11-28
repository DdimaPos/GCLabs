ParticleSystem ps;

void setup() {
  size(640,360);
  ps = new ParticleSystem(new PVector(width/2,50));
}

void draw() {
  background(193, 199, 245);
  
  // Option #1 (move the Particle System origin)
  ps.origin.set(mouseX,mouseY,0);
    
  ps.addParticle();
  ps.run();

  // Option #2 (move the Particle System origin)
  //ps.addParticle(mouseX,mouseY);



}
