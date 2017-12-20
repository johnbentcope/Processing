class Tape {

  PVector dims;
  boolean isDw;
  boolean isCloud;

  Tape(PVector dims, boolean isDw, boolean isCloud) {
    this.dims = dims;
    this.isDw = isDw;
    this.isCloud = isCloud;
  }

  void render(boolean isTop) {
    if (isCloud)
      fill(255, 100); 
    else 
    fill(#CFAB87);

    top(isTop);
    if (isDw || dims.y > 12) {
      span();
      pushMatrix();
      scale(-1, 1, 1);
      span();
      popMatrix();
    }
  }

  void top(boolean isTop) {
    float topSet = 0;
    if (isTop) topSet = 0.1;
    topLong(topSet);
    topEnd(topSet);
    pushMatrix();
    scale(-1, 1, 1);
    topEnd(topSet);
    popMatrix();
  }

  void topLong(float topSet) {
    pushMatrix();
    translate(0, 0, dims.z/2+off*2);
    beginShape(); 
    vertex(dims.x/2+off*2+topSet, -tapeWidth/2, 0);
    vertex(-dims.x/2-off*2-topSet, -tapeWidth/2, 0);
    vertex(-dims.x/2-off*2-topSet, tapeWidth/2, 0);
    vertex(dims.x/2+off*2+topSet, tapeWidth/2, 0);
    endShape(CLOSE);
    popMatrix();
  }

  void topEnd(float topSet) {
    float overlap = min(3, dims.z);
    pushMatrix();
    beginShape();
    translate(dims.x/2+off*2, 0, dims.z/2+off*2);
    vertex(topSet, -tapeWidth/2, 0);
    vertex(topSet, -tapeWidth/2, -overlap);
    vertex(topSet, tapeWidth/2, -overlap);
    vertex(topSet, tapeWidth/2, 0);
    endShape(CLOSE);
    popMatrix();
  }

  void span() {
    pushMatrix();
    translate(dims.x/2+off, 0, dims.z/2+off);
    beginShape();
    vertex(0, -dims.y/2+0.5, 0);
    vertex(0, -dims.y/2+0.5, -tapeWidth/2);
    vertex(0, dims.y/2-0.5, -tapeWidth/2);
    vertex(0, dims.y/2-0.5, 0);
    endShape(CLOSE);
    popMatrix();

    pushMatrix();
    translate(dims.x/2+off, 0, dims.z/2+off);
    beginShape();
    vertex(0, -dims.y/2+0.5, 0);
    vertex(-tapeWidth/2, -dims.y/2+0.5, 0);
    vertex(-tapeWidth/2, dims.y/2-0.5, 0);
    vertex(0, dims.y/2-0.5, 0);
    endShape(CLOSE);
    popMatrix();
  }
}