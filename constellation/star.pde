class Star {

  PVector pos;
  PVector vel;
  PVector acc;
  int id;

  Star(int idd) {
    id = idd;
    pos = new PVector(random(width), random(height));
    vel = new PVector(random(-3, 3), random(-3, 3));
  }
  void update() {
    PVector mouse = new PVector(width/2, height/2);
    PVector dir = PVector.sub(mouse, pos);
    dir.normalize();
    dir.mult(0.02);
    acc = dir;
    vel.add(acc);
    vel.limit(3);
    pos.add(vel);
    fill(255);
    //println("x " + pos.x + " : y " + pos.y);
  }

  void render() {
    noStroke();
    ellipse(pos.x, pos.y, 5, 5);
  }

  float x() {
    return pos.x;
  }
  float y() {
    return pos.y;
  }
}