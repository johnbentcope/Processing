class KraftRing {
  int detail;
  float radius;
  ArrayList<Particle> points = new ArrayList<Particle>();


  KraftRing(int detail, float radius) {
    this.detail = detail;
    this.radius = radius;

    for (int i = 0; i < detail; i++) {
      float scale = radius/7;
      float x = radius*cos(i*TWO_PI/detail)+random(-scale, scale);
      float y = radius*sin(i*TWO_PI/detail)+random(-scale, scale);
      float z = random(-scale, scale);
      points.add(new Particle(new PVector(x, y, z)));
    }
  }

  void render() {

    stroke(#FADCBD);
    fill(#D4AF8B);
    strokeWeight(1);
    beginShape(QUAD_STRIP);
    for (int i = 0; i < detail+2; i++) {
      int index = i%detail;
      Particle p = points.get(index);
      PVector q = p.pos.copy();
      vertex(q.x, q.y, q.z);
    }
    endShape(CLOSE);
  }
}