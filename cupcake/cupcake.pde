PShape frosting, frostop, paper, papbot, cake;

public void setup() {
  size(600, 600, P3D);

  frosting = createShape();

  frosting.beginShape(QUAD_STRIP);
  frosting.noStroke();
  frosting.fill(0xffEAC0FF);
  frosting.vertex(-7, -7, 0);
  frosting.vertex(-5, -5, 5);
  frosting.fill(0xff6EE2E8);
  frosting.vertex(7, -7, 0);
  frosting.vertex(5, -5, 5);
  frosting.fill(0xff8A7EE8);
  frosting.vertex(7, 7, 0);
  frosting.vertex(5, 5, 5);
  frosting.fill(0xffBBFFDC);
  frosting.vertex(-7, 7, 0);
  frosting.vertex(-5, 5, 5);
  frosting.fill(0xffEAC0FF);
  frosting.vertex(-7, -7, 0);
  frosting.vertex(-5, -5, 5);
  frosting.endShape(CLOSE);

  frostop = createShape();
  frostop.beginShape(QUAD);
  frostop.noStroke();
  frostop.fill(0xffEAC0FF);
  frostop.vertex(-5, -5, 5);
  frostop.fill(0xff6EE2E8);
  frostop.vertex(5, -5, 5);
  frostop.fill(0xff8A7EE8);
  frostop.vertex(5, 5, 5);
  frostop.fill(0xffBBFFDC);
  frostop.vertex(-5, 5, 5);
  frostop.fill(0xffEAC0FF);
  frostop.vertex(-5, -5, 5);
  frostop.endShape(CLOSE);

  paper = createShape();
  paper.beginShape(QUAD_STRIP);
  paper.noStroke();
  for (int i = 0; i < 121; i++) {
    int mod = (i%2)*2;
    if (mod == 0) { 
      paper.fill(0xffB8D5FF);
    } else {
      paper.fill(0xffD4E6FF);
    }
    paper.vertex((20+mod)*sin(i*PI/60f), (20+mod)*cos(i*PI/60f), -30);
    paper.vertex((28+mod)*sin(i*PI/60f), (28+mod)*cos(i*PI/60f), 0);
  }
  paper.endShape(CLOSE);

  papbot = createShape();
  papbot.beginShape(TRIANGLE_FAN);
  papbot.noStroke();
  papbot.vertex(0, 0, -30);
  for (int i = 0; i < 121; i++) {
    int mod = (i%2)*2;
    if (mod == 0) { 
      papbot.fill(0xffB8D5FF);
    } else {
      papbot.fill(0xffD4E6FF);
    }
    papbot.vertex((20+mod)*sin(i*PI/60f), (20+mod)*cos(i*PI/60f), -30);
  }
  papbot.endShape(CLOSE);

  cake = createShape();
  cake.beginShape(TRIANGLE_FAN);
  cake.fill(0xffFFF1BF);
  cake.noStroke();
  cake.vertex(0, 0, -5);
  cake.fill(0xffFFF9E0);
  for (int i = 0; i < 61; i++) {
    if (i > 15 && i < 45) {
      cake.fill(0xff4D261E);
    } else {
      cake.fill(0xffFFE891);
    }
    cake.vertex((27)*sin(i*PI/30f), (27)*cos(i*PI/30f), -3);
  }
  cake.endShape(CLOSE);

  perspective(PI/3.0f, width/height, 20/100.0f, 200*10.0f);
  frameRate(30);
}

public void draw() {
  background(0xffFFFEFF);
  pushMatrix();
  translate(0, 0, -31);
  noStroke();
  fill(0xffFFD1CA);
  ellipse(0, 0, 300, 300);
  fill(0xffFFF5FF,150);
  translate(0, 0, 1);
  ellipse(0, 0, 250, 250);
  popMatrix();
  camera(80*sin(frameCount*PI/180f), 80*cos(frameCount*PI/180f), 30, 
    0, 0, 0, 
    0, 0, -1.0f);
  for ( int i = 0; i < 17; i++) {
    for ( int j = 0; j < 12; j++) {
      pushMatrix();
      rotateZ(j*PI/6f + 0.5f*cos(i*PI/10 + frameCount*PI/120));
      translate(20*((16-i)/16f), 0, i*2.5f);
      rotateZ(frameCount*PI/90f+i*PI/20);
      rotateX(PI/100);
      scale((17-i)/16f, (17-i)/16f, (17-i)/18f);
      shape(frosting);
      shape(frostop);
      popMatrix();
    }
  }
  shape(paper);
  shape(papbot);
  shape(cake);
  //if (frameCount < 960) saveFrame("render/####_cupcakes.tif");
}