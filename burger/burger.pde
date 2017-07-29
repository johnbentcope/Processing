Sesame[] cloud =new Sesame[60];
PShape seed;
public void setup() {
  size(600,600,P3D);

  for (int i = 0; i < cloud.length; i++) {
    cloud[i] = new Sesame();
  }

  camera(600, 600, 200, 
    0, 0, 0, 
    0, 0, -1.0f);
  frameRate(30);
  seed = createShape();
  seed.beginShape(QUAD);
  seed.fill(0xffF2ECDC);
  seed.noStroke();
  seed.vertex(0, 0);
  seed.vertex(4, 8);
  seed.vertex(0, 12);
  seed.vertex(-4, 8);
  seed.endShape();
  ellipseMode(CENTER);
}

public void draw() {
  noFill();
  stroke(0xff954BEA);
  strokeWeight(2);
  background(0xff20143A);
  ellipse(0, 0, 255, 255);
  ellipse(0, 0, 420, 420);
  ellipse(0, 0, 700, 700);
  ellipse(0, 0, 1200, 1200);

  for (int i = 0; i < cloud.length; i++) {
    pushMatrix();
    if ( i == cloud.length-1) {
      stroke(255);
    }
    for (int s = 0; s < 6; s++) {
      pushMatrix();
      rotateZ(cloud[i].pos.x + s*PI/3 + frameCount*2*PI/1080);
      translate(0, 420+cloud[i].pos.y, 0);
      cloud[i].render();
      popMatrix();
    }
    popMatrix();
  }

  // SOLAR EG
  pushMatrix();
  fill(255);
  noStroke();
  rotateZ(-frameCount*2*PI/720);
  rotateX(-PI/6);
  ellipse(0, 0, 100, 190);
  translate(0, 30, 10);
  fill(0xffFFD821);
  ellipse(0, 0, 70, 70);
  translate(0, -60, -20);
  ellipse(0, 0, 70, 70);
  popMatrix();
  lights();
  //CHEESE
  pushMatrix();
  rotateZ(frameCount*2*PI/360 );
  translate(350, 0, 0);
  for (int i = 0; i < 5; i++) {
    fill(0xffFFD821);
    noStroke();
    pushMatrix();
    rotateZ(-frameCount*2*PI/720);
    rotateX(-PI/10);
    translate(0, 0, 20*(i-2));
    box(90, 90, 2);

    popMatrix();
  }
  popMatrix();
  noLights();

  //PIKL
  pushMatrix();
  fill(0xff5DFF50);
  stroke(0xff678C42);
  strokeWeight(5);
  rotateZ(frameCount*2*PI/120+ PI/2);
  translate(225/2, 0, 0);  
  rotateZ(frameCount*2*PI/120);
  rotateX(-PI/6);
  ellipse(0, 0, 60, 60);
  popMatrix();
  pushMatrix();
  fill(0xff5DFF50);
  stroke(0xff678C42);
  strokeWeight(5);
  rotateZ(frameCount*2*PI/120+PI+ PI/2);
  translate(225/2, 0, 0);  
  rotateZ(frameCount*2*PI/120);
  rotateX(-PI/6);
  ellipse(0, 0, 60, 60);
  popMatrix();

  //MATO
  pushMatrix();
  fill(0xffE91000);
  noStroke();
  rotateZ(frameCount*2*PI/720+ PI/2);
  translate(0, 600, 0);
  rotateZ(-frameCount*2*PI/720+ PI/1);
  rotateX(-PI/2);
  rotateZ(frameCount*2*PI/720);
  ellipse(0, 0, 200, 200);
  for (int i = 0; i < 6; i++) {
    pushMatrix();
    rotateZ(i*PI/3);
    fill(0xffFF6A5E);
    beginShape(QUAD);
    vertex(0, 10, 4);
    vertex(40, 89, 4);
    vertex(0, 97, 4);
    vertex(-40, 89, 4);
    endShape();
    beginShape(QUAD);
    vertex(0, 10, -4);
    vertex(40, 89, -4);
    vertex(0, 97, -4);
    vertex(-40, 89, -4);
    endShape();
    popMatrix();
  }
  popMatrix();

  // ANACONDA FOOD
  pushMatrix();
  scale(10, 10, 8);

  translate(0, 0, 30);
  rotateY(PI/20);
  rotateZ(-frameCount*2*PI/720+ PI/2);
  rotateY(PI/20);
  noStroke();
  for (int i = 0; i < 40; i++) {
    int j = i+1;
    beginShape(QUAD_STRIP);
    fill(0xffF2E1B1);
    vertex(26*sin(i*PI/20), 26*cos(i*PI/20), 0);
    vertex(26*sin(j*PI/20), 26*cos(j*PI/20), 0);

    vertex(28*sin(i*PI/20), 28*cos(i*PI/20), 2);
    vertex(28*sin(j*PI/20), 28*cos(j*PI/20), 2);
    fill(0xffD9A05B);
    vertex(28*sin(i*PI/20), 28*cos(i*PI/20), 6);
    vertex(28*sin(j*PI/20), 28*cos(j*PI/20), 6);

    vertex(24*sin(i*PI/20), 24*cos(i*PI/20), 10);
    vertex(24*sin(j*PI/20), 24*cos(j*PI/20), 10);

    vertex(13*sin(i*PI/20), 13*cos(i*PI/20), 13);
    vertex(13*sin(j*PI/20), 13*cos(j*PI/20), 13);

    vertex(0, 0, 13);
    vertex(0, 0, 13);
    endShape();
  }

  fill(0xffF2E1B1);
  beginShape(TRIANGLE_FAN);
  vertex(0, 0, 0);
  for (int i = 0; i < 41; i++) {
    vertex(26*sin(i*PI/20), 26*cos(i*PI/20), 0);
  }
  endShape();


  popMatrix();
  pushMatrix();
  scale(10, 10, 8);

  translate(0, 0, 30);
  rotateY(PI/20);
  rotateZ(-frameCount*2*PI/720+ PI/2);
  rotateY(PI/20);
  noStroke();
  for (int i = 0; i < 40; i++) {
    int j = i+1;
    beginShape(QUAD_STRIP);
    fill(0xffF2E1B1);
    vertex(26*sin(i*PI/20), 26*cos(i*PI/20), 0);
    vertex(26*sin(j*PI/20), 26*cos(j*PI/20), 0);

    vertex(28*sin(i*PI/20), 28*cos(i*PI/20), 2);
    vertex(28*sin(j*PI/20), 28*cos(j*PI/20), 2);
    fill(0xffD9A05B);
    vertex(28*sin(i*PI/20), 28*cos(i*PI/20), 6);
    vertex(28*sin(j*PI/20), 28*cos(j*PI/20), 6);

    vertex(24*sin(i*PI/20), 24*cos(i*PI/20), 10);
    vertex(24*sin(j*PI/20), 24*cos(j*PI/20), 10);

    vertex(13*sin(i*PI/20), 13*cos(i*PI/20), 13);
    vertex(13*sin(j*PI/20), 13*cos(j*PI/20), 13);

    vertex(0, 0, 13);
    vertex(0, 0, 13);
    endShape();
  }

  fill(0xffF2E1B1);
  beginShape(TRIANGLE_FAN);
  vertex(0, 0, 0);
  for (int i = 0; i < 41; i++) {
    vertex(26*sin(i*PI/20), 26*cos(i*PI/20), 0);
  }
  endShape();


  popMatrix();
  pushMatrix();
  scale(10, 10, -8);

  translate(0, 0, 30);
  rotateY(PI/20);
  rotateZ(-frameCount*2*PI/720+ PI/2);
  rotateY(PI/20);
  noStroke();
  for (int i = 0; i < 40; i++) {
    int j = i+1;
    beginShape(QUAD_STRIP);
    fill(0xffF2E1B1);
    vertex(26*sin(i*PI/20), 26*cos(i*PI/20), 0);
    vertex(26*sin(j*PI/20), 26*cos(j*PI/20), 0);

    vertex(28*sin(i*PI/20), 28*cos(i*PI/20), 2);
    vertex(28*sin(j*PI/20), 28*cos(j*PI/20), 2);
    fill(0xffD9A05B);
    vertex(28*sin(i*PI/20), 28*cos(i*PI/20), 6);
    vertex(28*sin(j*PI/20), 28*cos(j*PI/20), 6);

    vertex(24*sin(i*PI/20), 24*cos(i*PI/20), 10);
    vertex(24*sin(j*PI/20), 24*cos(j*PI/20), 10);

    vertex(13*sin(i*PI/20), 13*cos(i*PI/20), 13);
    vertex(13*sin(j*PI/20), 13*cos(j*PI/20), 13);

    vertex(0, 0, 13);
    vertex(0, 0, 13);
    endShape();
  }

  fill(0xffF2E1B1);
  beginShape(TRIANGLE_FAN);
  vertex(0, 0, 0);
  for (int i = 0; i < 41; i++) {
    vertex(26*sin(i*PI/20), 26*cos(i*PI/20), 0);
  }
  endShape();


  popMatrix();

  lights();
  pushMatrix();
  fill(0xff732020);
  strokeWeight(3);
  rotateZ(frameCount*2*PI/180+ PI/2);
  translate(0, 210, 0);
  rotateZ(-frameCount*2*PI/60+ PI/1);
  rotateX(-PI/10);
  stroke(0xff542E00);
  ellipse(0, 0, 90, 90);
  stroke(0xff732020);
  translate(0, 0, 3);
  ellipse(0, 0, 90, 90);
  translate(0, 0, -6);
  ellipse(0, 0, 90, 90);
  popMatrix();
  noLights();

  saveFrame("####_burger.tif");
  if (frameCount > 1440) noLoop();
}

class Sesame {

  PVector pos;



  Sesame() {
    pos = new PVector(random(PI/3), random(140));
  }

  public void render() {
    shape(seed);
  }
}