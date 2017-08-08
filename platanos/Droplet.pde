class Droplet {
  PVector pos, posHome;
  PVector vel, velHome;
  int age = 0;
  int id;
  Droplet(int id) {
    this.id = id;
    pos = new PVector(random(0, width), -200, random(-200,300));
    posHome = pos.copy();
    vel = new PVector(0, 3);
    velHome = vel.copy();
  }

  void reInit() {
    pos = posHome.copy();
    vel = velHome.copy();
    age = 0;
  }

  void update() {
    pos.add(vel);
    age++;
  }

  void render() {
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    translate(20*sin(frameCount*TWO_PI/42.75), -20*abs(cos(frameCount*TWO_PI/42.75)), 0);
    rotateY(frameCount*TWO_PI/170);
    rotateX(PI/6);
    makePlantain();
    popMatrix();
  }
  
  void makePlantain(){
    
    shape(top);
    shape(sides);
    pushMatrix();
    translate(0, 0, 1);
    for (int i = 0; i < 3; i++) {
      fill(0);
      pushMatrix();
      rotateZ(i*TWO_PI/3 - frameCount*TWO_PI/720);
      translate(5, 0, 0);
      ellipse(0, 0, 4, 2);
      popMatrix();
    }
    popMatrix();
    pushMatrix();
    translate(0, skew, -thicc);
    shape(top);
    translate(0, 0, -1);
    for (int i = 0; i < 3; i++) {
      fill(0);
      pushMatrix();
      rotateZ(i*TWO_PI/3 - frameCount*TWO_PI/720);
      translate(5, 0, 0);
      ellipse(0, 0, 4, 2);
      popMatrix();
    }
    popMatrix();
  }
}