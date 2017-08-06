int cafeDetail = 40;
int cafeRad = 50;

PShape cup;

color col;
void setup() {
  size(600, 600, P3D);
  noStroke();
  cup = createShape();

  for (int i = 0; i < cafeDetail/2; i++) {
    for (int j = 0; j < 1; j++) {
      col = color(255);
      cup.beginShape(QUAD_STRIP);
      cup.stroke(255);
      cup.noStroke();
      cup.fill(col);
      int ii = i+1;
      int jj = j+1;
      cup.vertex(cafeRad*cos(j*TWO_PI/cafeDetail)*cos(i*TWO_PI/cafeDetail), cafeRad*sin(j*TWO_PI/cafeDetail)*cos(i*TWO_PI/cafeDetail), -cafeRad*sin(i*TWO_PI/cafeDetail));
      cup.vertex(cafeRad*cos(jj*TWO_PI/cafeDetail)*cos(i*TWO_PI/cafeDetail), cafeRad*sin(jj*TWO_PI/cafeDetail)*cos(i*TWO_PI/cafeDetail), -cafeRad*sin(i*TWO_PI/cafeDetail));
      //cup.vertex(cafeRad*cos(jj*TWO_PI/cafeDetail)*cos(ii*TWO_PI/cafeDetail), cafeRad*sin(jj*TWO_PI/cafeDetail)*cos(ii*TWO_PI/cafeDetail), cafeRad*sin(i*TWO_PI/cafeDetail));
      cup.endShape();
    }
  }
  cafeRad *= 0.99;
  frameRate(30);
}

void draw() {
  background(#FF758E);
  camera(-100, 0, 30, 
    0, 0, 0, 
    0, 0, -1.0);
  noStroke();
  pushMatrix();
  translate(0, 0, -5);
  for (int i = 0; i < cafeDetail; i++) {
    for (int j = 0; j < cafeDetail; j++) {
      int ii = i+1;
      int jj = j+1;
      fill(lerpColor(#CF601F, #FFE2C9, (0.5+cos(
        i*TWO_PI*2.1
        - frameCount*TWO_PI/120
        + sin(j*TWO_PI/cafeDetail)*TWO_PI)
        ) ));
      beginShape(QUAD);
      vertex((cafeRad*i/cafeDetail)*sin(j*TWO_PI/cafeDetail), (cafeRad*i/cafeDetail)*cos(j*TWO_PI/cafeDetail));
      vertex((cafeRad*i/cafeDetail)*sin(jj*TWO_PI/cafeDetail), (cafeRad*i/cafeDetail)*cos(jj*TWO_PI/cafeDetail));
      vertex((cafeRad*ii/cafeDetail)*sin(jj*TWO_PI/cafeDetail), (cafeRad*ii/cafeDetail)*cos(jj*TWO_PI/cafeDetail));
      vertex((cafeRad*ii/cafeDetail)*sin(j*TWO_PI/cafeDetail), (cafeRad*ii/cafeDetail)*cos(j*TWO_PI/cafeDetail));
      endShape(CLOSE);
    }
  }
  popMatrix();
  pushMatrix();
  translate(0,0,-10);
  stroke(#FFFBF7);
  strokeWeight(15);
  noFill();
  for (int m = 0; m < 3; m++) {
    pushMatrix();
    rotateZ(m*TWO_PI/3);
    beginShape();
    for (int i = 10; i < 80; i++) {
      vertex(10*sin(i*TWO_PI/40 +frameCount*TWO_PI/360), 10*cos(i*TWO_PI/40 +frameCount*TWO_PI/360), i);
    }
    endShape();
    translate(10*sin(1*TWO_PI/4 + frameCount*TWO_PI/360), 10*cos(1*TWO_PI/4 + frameCount*TWO_PI/360), 10);
    sphere(2);
    popMatrix();
  }
  stroke(#CF601F);
  for (int m = 0; m < 3; m++) {
    pushMatrix();
    rotateZ(m*TWO_PI/3);
    beginShape();
    for (int i = 10; i < 80; i++) {
      vertex(5*sin(-i*TWO_PI/40 -frameCount*TWO_PI/240), 5*cos(-i*TWO_PI/40 -frameCount*TWO_PI/240), i);
    }
    endShape();
    translate(5*sin(-1*TWO_PI/4 - frameCount*TWO_PI/240), 5*cos(-1*TWO_PI/4 - frameCount*TWO_PI/240), 10);
    sphere(2);
    popMatrix();
  }
  popMatrix();
  for (int i = 0; i < cafeDetail; i++) {
    pushMatrix();
    rotateZ(i*TWO_PI/cafeDetail);
    shape(cup);
    popMatrix();
  }
  noStroke();
  for (int i = 0; i < 8; i++) {
    pushMatrix();
    translate(0, 0, -460+80*i);
    for (int j = 0; j < 8; j++) {
      switch((j+i)%4) {
      case 0:
        fill(#FFDB6E);
        break;
      case 2:
        fill(#F2E6CE);
        break;
      case 1:
        fill(#A3C9A3);
        break;
      case 3:
        fill(#75EBDF);
        break;
      }
      pushMatrix();
      rotateZ(j*TWO_PI/8+(i%2-0.5)*2*frameCount*TWO_PI/720+PI/16);
      translate(300, 0, 0);
      rotateY(PI/2);
      ellipse(0, 0, 60, 60);
      popMatrix();
    }
    popMatrix();
  }
  if (frameCount < 720) saveFrame("render/####_cafeconleche.tif");
  else noLoop();
}