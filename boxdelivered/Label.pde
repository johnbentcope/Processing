class Label {

  PVector dims;
  int type;

  Label(PVector dims, int type) {
    this.dims = dims;
    this.type = type;
  }

  void render() {
    switch(type) {
    case 0:
      thisSideUp();
      pushMatrix();
      rotateZ(PI);
      thisSideUp();
      popMatrix();
      break;
    case 1:
      wholeSale();
      break;
    }
  }

  void thisSideUp() {
    pushMatrix();
    fill(#F7F4F0);
    stroke(#DBD8D5);
    translate(dims.x/2+off*3+0.1, 0, 0);
    beginShape();
    vertex(0, -1.5, 2);
    vertex(0, 1.5, 2);
    vertex(0, 1.5, -2);
    vertex(0, -1.5, -2);
    endShape(CLOSE);
    noStroke();
    fill(#DC7F8A);
    translate(0.1, 0, 0);
    beginShape();
    vertex(0, 0, 1.5);
    vertex(0, 1, 0.5);
    vertex(0, 0.5, 0.5);
    vertex(0, 0.5, -1.5);
    vertex(0, -0.5, -1.5);
    vertex(0, -0.5, 0.5);
    vertex(0, -1, 0.5);
    endShape(CLOSE);
    popMatrix();
  }

  void wholeSale() {
    pushMatrix();
    stroke(#DBD8D5);
    fill(#F7F4F0);
    translate(dims.x/2+off*3.5+0.1, dims.y/2, dims.z/2);
    beginShape(QUAD);
    vertex( 0, 0, 0);
    vertex( 0, -3, 0);
    vertex( 0, -3, -1);
    vertex( 0, 0, -1);
    endShape(CLOSE);
    popMatrix();
  }
}