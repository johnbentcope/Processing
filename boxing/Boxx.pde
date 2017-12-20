class Boxx {

  PVector dims;
  PVector pos;
  PVector vel;
  boolean isDw = false;
  Tape tape; 
  int age = 0;
  float h = 90;
  ArrayList<Label> labels = new ArrayList<Label>();

  Boxx(PVector dims, boolean isDw) {
    this.dims = dims;
    this.isDw = isDw;
    tape = new Tape(dims, isDw);
    if (dims.z > 4) labels.add( new Label(dims, 0) );
    labels.add( new Label(dims, 1) );
    //vel = new PVector(0, 0, -1);
    pos = new PVector(random(-20,100), random(-100, 100), h);
  }

  void reset() {
    pos = new PVector(pos.x, pos.y, h);
    age = 0;
  }

  void update() {
    pos.z -= 1;
    age++;
  }

  void render() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    rotateZ(frameCount*TWO_PI/360);
    //stroke(#FF0000);
    //line(0, 0, 0, 40, 0, 0);
    //stroke(#00FF00);
    //line(0, 0, 0, 0, 40, 0);
    //stroke(#0000FF);
    //line(0, 0, 0, 0, 0, 40);
    stroke(#FADCBD);
    fill(#AE9072);
    box(dims.x, dims.y, dims.z);
    pushMatrix();
    translate(-dims.x/2, 0, dims.z/2);
    line(0, 0, 0, dims.x, 0, 0);
    translate(0, 0, -dims.z);
    line(0, 0, 0, dims.x, 0, 0);
    popMatrix();
    tape.render(true);
    pushMatrix();
    scale(1, 1, -1);
    tape.render(false);
    popMatrix();

    for (Label l : labels) {
      l.render();
    }
    popMatrix();
  }

  float x() {
    return dims.x;
  }
  float y() {
    return dims.y;
  }
  float z() {
    return dims.z;
  }
}