class Slag {

  PVector pos;
  PVector vel = new PVector(0, 0, 0);
  PVector vel2;
  float vnaught = 0;
  int age = 0;
  int id = floor(random(3.9));
  float spread = random(5, 2);

  Slag(PVector poss) {
    pos = poss;
    vel2 = PVector.fromAngle(random(0, 2*PI)).mult(spread);
    //vel2 = PVector.fromAngle(PI/2).mult(spread);
    vel.x = vel2.x;
    vel.y = vel2.y;
    vnaught = random(-2, 10);
    vel.z = vnaught;
  }

  void reset(float h) {
    pos = new PVector(600, 600, h);
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

    canvii[d].beginDraw();
    canvii[d].stroke(255,lerp(255, -55, (age/death)));
    canvii[d].pushMatrix();
    canvii[d].translate(pos.x, pos.y, pos.z);
    canvii[d].box(20);
    canvii[d].popMatrix();
    canvii[d].endDraw();
    age ++;
    vel.z -= gravity;
    //println(age);
  }
}