import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

PostFX fx;


PGraphics canvas;

PImage lidtx;
PImage[] sfc = new PImage[5];
PShape basket, lid;

PShader texShader;

void setup() {
  size(600, 600, P3D);
  fx = new PostFX(this);
  lidtx =  loadImage("assets/bamboo.jpg");
  canvas = createGraphics(width, height, P3D);
  sfc[0] = loadImage("assets/bamboo0.png");
  sfc[1] = loadImage("assets/bamboo1.png");
  sfc[2] = loadImage("assets/bamboo2.png");
  sfc[3] = loadImage("assets/bamboo3.png");
  sfc[4] = loadImage("assets/bamboo4.png");

  canvas.beginDraw();
  canvas.background(#0DDBF0);
  canvas.noStroke();
  canvas.fill(#FFD73B);
  canvas.rect(0, 100, width, 50);
  canvas.rect(0, 170, width, 20);
  canvas.rect(0, height-170, width, 20);
  canvas.rect(50, 0, 50, height);
  canvas.rect(120, 0, 20, height);
  canvas.rect(width-140, 0, 20, height);
  canvas.endDraw();

  lid = createShape();
  lid.beginShape(TRIANGLE_FAN);
  lid.fill(#F1ECF0);
  lid.noStroke();
  lid.vertex(0, 0, -20);
  float theta = TWO_PI / 40;
  for (int i=0; i<41; i++) {
    float angle = theta * i;
    float x = cos(angle);
    float y = sin(angle);
    lid.vertex(x * 50, y * 50, -15);
  }
  lid.endShape();
  lid.getTessellation();

  perspective(0.5*PI, width/height, 20/100.0f, 200*10.0f);
  frameRate(30);
}

void draw() {
  background(0);
  set(0, 0, canvas.get(0, 0, width, height));
  camera(-180*sin(frameCount*PI/180f), -180*cos(frameCount*PI/180f), 150, 
    0, 0, -90, 
    0, 0, -1.0);
  pushMatrix();
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      pushMatrix();
      translate((i-1)*110, (j-1)*110, 0);

      // Next two lines make it Cat Cow
      rotateX( 0.1*( (j-1) )*sin(frameCount*PI/60f));
      rotateY( 0.1*( (i-1) )*sin(frameCount*PI/60f));

      makeDimSum(i, j, sfc[(i*3+j)%5]);
      popMatrix();
    }
  }
  popMatrix();
  if (frameCount <=1080) saveFrame("render/####_dimsum.tif");
  println(frameCount);
}

void makeDimSum(int i, int j, PImage tex) {
  createPot(tex);
  shape(lid);
  switch((i*3+j)) {
  case 0:
    makeRoll();
    break;
  case 1:
    makeBeefThing();
    break;
  case 2:
    makePouchies();
    break;
  case 3:
    makeYodas();
    break;
  case 4:
    pushMatrix();
    rotateZ(PI/2);
    makeRoll();
    popMatrix();
    break;
  case 5:
    pushMatrix();
    scale(1, -1, 1);
    makeYodas();
    popMatrix();
    break;
  case 6:
    makeBeefThing();
    break;
  case 7:
    makePouchies();
    break;
  case 8:
    pushMatrix();
    rotateZ(PI);
    makeRoll();
    popMatrix();
    break;
  }
}

void makePouchies() {
  sphereDetail(30);
  for (int i = 0; i < 2; i++) {
    for (int j = 0; j < 2; j++) {
      pushMatrix();
      translate((i-0.5)*35, (j-0.5)*35, 0);
      pushMatrix();
      rotateZ(frameCount*PI/90f);
      fill(#FFC43B);
      box(26, 26, 20);
      fill(#FFB200);
      box(27, 27, 19);
      translate(0, 0, 3);
      fill(#F7F7F0);
      sphere(13);
      translate(0, 0, 4);
      fill(#E00000);
      sphere(10);
      popMatrix();
      popMatrix();
    }
  }
}

void makeYodas() {
  for (int y = 0; y < 3; y++) {
    pushMatrix();
    rotateZ(y*2*PI/3 + frameCount *PI/270);
    translate(-20, 0, 0);
    rotateZ(-frameCount *PI/270);
    beginShape(TRIANGLE_FAN);
    fill(#A8BF9F);
    vertex(0, 0, 10);
    for (int i = 0; i < 7; i++) {
      fill(#6ABF49);
      if (i %2 ==0) {
        vertex(15*sin(i*PI/3), 15*cos(i*PI/3), 0);
      } else {
        vertex(20*sin(i*PI/3), 20*cos(i*PI/3), 0);
      }
    }
    endShape();
    popMatrix();
  }
}

void makeBeefThing() {
  pushMatrix();
  rotateZ(-frameCount*PI/135);
  beginShape(QUAD_STRIP);
  fill(#731F0D);
  for (int i = 0; i < 40; i++) {
    fill(#731F0D);
    vertex(i*sin(i*PI/4), i*cos(i*PI/4), 0);
    fill(#BF5A1F);
    vertex(i*sin(i*PI/4), i*cos(i*PI/4), 10);
  }
  endShape();
  popMatrix();
  noFill();
  strokeWeight(3);
  for (int i = 0; i < 3; i++) {
    pushMatrix();
    rotateZ(2*i/3f*PI);
    translate(5, 0, 12);
    stroke(#A2A62E);
    ellipse(0, 0, 10, 10);
    popMatrix();
  }
  for (int i = 0; i < 3; i++) {
    pushMatrix();
    rotateZ(PI/4);
    rotateZ(2*i/5f*PI);
    translate(10, 0, 12);
    stroke(#F02810);
    ellipse(0, 0, 10, 10);
    popMatrix();
  }
}

void makeRoll() {
  pushMatrix();
  rotateZ(0.1*sin(frameCount*PI/30f));
  for (int r = 0; r < 3; r++) {
    pushMatrix();
    translate((r-1)*20, 0, 0);
    fill(#A2A62E);
    translate(-5, -5, 0);
    box(5, 45, 10);
    translate(5, 0, 0);
    fill(#D9B878);
    box(5, 50, 10);
    translate(5, 0, 0);
    fill(#BF5A1F);
    box(5, 45, 10);
    popMatrix();
  }
  for (int r = 0; r < 3; r++) {
    pushMatrix();
    translate((r-1)*20, 5, 15);
    fill(#0D0608);
    stroke(#040F4B);
    sphere(3);
    translate(0, -5, 0);
    sphere(3);
    translate(0, -5, 0);
    sphere(3);
    popMatrix();
  }
  for (int r = 0; r < 3; r++) {
    pushMatrix();
    translate((r-1)*20, 0, 0);
    beginShape(QUAD_STRIP);
    noStroke();
    fill(#F1ECF0, 150);
    for (int i = 0; i < 21; i++) {
      vertex(10*sin(i*PI/10), 20-abs(i-10), 10*cos(i*PI/10));
      vertex(10*sin(i*PI/10), -20-abs(i-10), 10*cos(i*PI/10));
    }
    endShape();
    popMatrix();
  }
  popMatrix();
}

void createPot(PImage tex) {
  int detail = 40;
  int r = 50;
  int h = 30;
  textureMode(NORMAL);
  beginShape(QUAD_STRIP);
  noStroke();
  texture(tex);
  for (int i = 0; i <= detail; i++) {
    float angle = TWO_PI / detail;
    float x = sin(i * angle);
    float z = cos(i * angle);
    float u = float(i) / detail;
    normal(x, 0, z);
    vertex(x * r, z * r, -h/2, u, 0);
    vertex(x * r, z * r, +h/2, u, 1);
  }
  endShape();
}