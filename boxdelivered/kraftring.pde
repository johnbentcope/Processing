class KraftRing {
  int detail;
  float radius;
  ArrayList<Particle> points = new ArrayList<Particle>();
  PVector[] pts;

  KraftRing(int detail, float radius) {
    this.detail = detail;
    this.radius = radius;
    pts = new PVector[detail];
    for (int i = 0; i < pts.length; i++) {
      pts[i] = new PVector(random(6)-3, random(6)-3, 0);
    }

    for (int j = 0; j < detail; j++) {
      float jIndex = detail-(j+t/10)%(detail); // local index for looped mapping
      float r = pR / sqrt(jIndex); // give it an ominous shape
      r = constrain(r, 0, pR*3); // remove this if you want, your boxes will just fly in from the bottom edges
      float x = r*cos(-jIndex*PI/(2*plumeDt));
      float y = r*sin(-jIndex*PI/(2*plumeDt));
      float z = map(jIndex, 0, detail, 0, pH+R*0.75);
      points.add(new Particle(new PVector(x, y, z)));
    }
  }

  void addParticle(Particle p) {
    points.add(p);
  }

  void render() {

    stroke(#FADCBD);
    fill(#D4AF8B);
    strokeWeight(1);
    beginShape(QUAD_STRIP);
    for (int i = 0; i < pts.length; i++) {
      float h = (t*0.5+i)%pts.length;
      int ptI = (int) h;
      Particle q = points.get(i);
      vertex(q.pos.x+pts[ptI].x, q.pos.y+pts[ptI].y, pH*1.7-i*2.4);
     //println(t);
    }
    //for (int i = 0; i < detail; i++) {
    //  float h = (t+i)%pts.length;
    //  float jIndex = (i+t/10)%(detail); // local index for looped mapping
    //  float z = map(jIndex, 0, detail, 0, pH+R*0.75);
    //  int ptI = (int) h;
    //  Particle q = points.get(ptI);
    //  vertex(q.pos.x, q.pos.y, pH+R*0.75-map(ptI, detail, 0, 0, pH+R*0.75));
    //}
    endShape(CLOSE);
  }
}