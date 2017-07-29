class Kernel {

  PVector pos;
  PVector vel = new PVector(0, 0, 0);
  PVector vel2;
  float vnaught = 0;
  int age = 0;
  int id = floor(random(4));
  float spread = random(2, 5);

  Kernel(PVector poss) {
    pos = poss;
    vel2 = PVector.fromAngle(random(-7*PI/8, 7*PI/8)).mult(spread);
    //vel2 = PVector.fromAngle(PI/2).mult(spread);
    vel.x = vel2.x;
    vel.y = vel2.y;
    vnaught = random(3, 10);
    vel.z = vnaught;
  }

  void reset(float h) {
    pos = new PVector(0, 0, h);
    vel.z = vnaught;
    age = 0;
  }

  void render() {

    pos.add(vel);
    int d = int(dist(pos.x, pos.y, -200, 600));
    //println("X:" + pos.x + " - Y:" + pos.y + " - Dist: " + dist(pos.x,pos.y,pos.z,-200,600,300));


    d = (d-500)/(600/10);
    //if (age == 0) println(d);
    if (d < 0) d = 0;
    if (d > 10) d = 10; 

    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    rotateY(PI/2);
    rotateZ((id-1.5)*age/40f);
    noStroke();
    fill(#FFD44F);
    ellipse(0, 0, 8, 8);
    translate(0, 0, 1);
    fill(#FFDE77);
    ellipse(0, -4, 8, 8);
    translate(0, 0, 1);
    ellipse(0, 4, 8, 8);
    translate(0, 0, 1);
    fill(#FFEAA6);
    ellipse(-7, 0, 14, 14);
    popMatrix();
    age ++;
    vel.z -= gravity;
    //println(age);
  }
}