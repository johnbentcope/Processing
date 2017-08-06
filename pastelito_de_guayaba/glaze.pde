class Glaze {
  PVector pos;
  int age = 0;
  int size = 4;
  
  Glaze() {
    pos = new PVector(random(140)-70, random(140)-70, 50);
  }

  void update() {
    if (pos.z > 0)
      pos.z--;
    if (age > 120) {
      age = 0;
      size = 4;
      pos.z = 50;
    }
    if (age > 100 && size > 0) {
      size-=0.2;
    }
    age++;
  }

  void render() {
    pushMatrix();
    fill(255,200);
    noStroke();
    translate(pos.x, pos.y, pos.z);
    rotateY(-0.3);
    rect(0, 0, size, size);
    popMatrix();
  }
}