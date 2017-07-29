class Arm {

  Segment[] chunks;
  int id;

  // arm = new Arm(0.9, 20, 15, 50);
  Arm(float scaling, int segments, float radius, float len, int id) {
    chunks =  new Segment[segments];
    for (int i = 0; i < chunks.length; i++) {
      chunks[i] = new Segment(radius*pow(scaling, i), len*pow(scaling, i), PI/2, i, id*PI/24f);
    }
  }

  void render() {
    for (Segment s : chunks) {
      s.render();
      println(frameCount + " : " + s.id);
    }
  }
}