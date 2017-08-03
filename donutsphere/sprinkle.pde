class Sprinkles {

  PVector pos = new PVector(random(10, 20), random(2*PI), random(2*PI));
  color col;

  Sprinkles(color col) {
    this.col = col;
  }

  void render() {
    fill(col);
    noStroke();
    pushMatrix();
    translate(0, 0, rd+2);
    rotateZ(pos.y);
    translate(pos.x, 0, 0);
    rotateZ(pos.z);
    rect(0, 0, 4, 1);
    popMatrix();
  }
}