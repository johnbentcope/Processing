class Particle {

  PVector pos;
  PVector vel;
  PVector acc;

  Particle() {
    pos = new PVector(random(width), random(height));
    vel = new PVector(random(-10, 10), random(-10, 10));
  }

  void update() {
    PVector dir = new PVector(width/2-pos.x,height/2-pos.y);
    dir.normalize();
    dir.mult(0.5);
    acc = dir;
    vel.add(acc);
    pos.add(vel);
  }

  void render(PGraphics mask) {
    mask.noStroke();
    mask.fill(255,20*fader);
    for ( int i = 0; i < 15; i++) {
      mask.ellipse(pos.x,pos.y,i*10+80,i*10+80);
    }
  }
  
}