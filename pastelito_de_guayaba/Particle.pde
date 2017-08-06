class Particle {
  PVector pos;
  PVector vel;
  int id;
  float rad = 0;
  float phase = 0;

  color col = #000000;

  Particle(int id) {
    pos = new PVector(random(140)-70, random(140)-70);
    vel = new PVector(random(-3, 3), random(-3, 3));
    col = lerpColor(#F0A8ED, #7D0F5B, random(1));
    rad = random(10,70);
    phase = random(TWO_PI);
    this.id = id;
  }

  void update() {
    pos.x = rad*sin((id%2+1)/1f*frameCount*TWO_PI/360 + phase);
    pos.y = rad*cos((id%2+1)/1f*frameCount*TWO_PI/360 + phase);
    if (id == 0) println(pos.x,pos.y,rad);
    //PVector acc = new PVector(pos.x, pos.y);
    //acc.normalize();
    //acc.mult(-0.2);
    //vel.add(acc);
    //pos.add(vel);
  }
}