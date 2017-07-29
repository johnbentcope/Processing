PGraphics boba, lid, tea, dregs;
PShape straw;
int strawDetail = 10;
int strawRad = 15;

color teaC = color(#AFA3BE);

void setup() {
  size(600, 600, P3D);
  lid = createGraphics(300, 300, P2D);
  tea = createGraphics(294, 294, P2D);
  dregs = createGraphics(300, 300, P2D);
  boba = createGraphics(300, 300, P2D);
  smooth(0);
  strokeWeight(5);
  stroke(255);
  //stroke(180, 90, 210);
  noStroke();
  //noFill();
  frameRate(30);
  straw = createShape();
  straw.beginShape(QUAD_STRIP);
  for (int i = 0; i <= strawDetail; i++) {
    if (i == 2 || i ==7 ) {
      straw.fill(#FF0000);
    } else {
      straw.fill(#FAE6F8);
    }
    straw.vertex(strawRad*sin(2*i*PI/strawDetail), strawRad*cos(2*i*PI/strawDetail), 0);
    straw.vertex(strawRad*sin(2*i*PI/strawDetail), strawRad*cos(2*i*PI/strawDetail), 800);
  } 
  straw.endShape(CLOSE);
}

void draw() {
  hint(ENABLE_DEPTH_SORT);  
  drawLid();
  drawTea();
  drawDregs();
  drawBoba();
  background(#FFBDB8);
  camera(400*sin(frameCount*PI/360), 400*cos(frameCount*PI/360), 250, 
    0, 0, -0, 
    0, 0, -1.0);

  noFill();
  pushMatrix();
  rotateZ(PI/4);
  rotateY(-PI/5.8);
  translate(80, 0, -100);
  shape(straw);
  popMatrix();
  pushMatrix();
  box(300);

  pushMatrix();
  translate(-150, -150, 150);
  image(lid, 0, 0);
  popMatrix();
  for (int i = 0; i < 4; i++) {
    pushMatrix();
    rotateZ(i*PI/2);
    rotateX(-PI/2);
    translate(-150, -150, 150);
    image(tea, 0, 0, 300, 300);
    popMatrix();
  }
  pushMatrix();
  rotateX(PI);
  translate(-150, -150, 150);
  image(dregs, 0, 0);
  popMatrix();
  popMatrix();
  for (int i = 0; i < 4; i++) {
    pushMatrix();
    rotateZ(i*PI/2);
    rotateX(-PI/2);
    translate(-125, -125, 125);
    image(boba, 0, 0, 250, 250);
    popMatrix();
  }
  if (frameCount <= 1441) saveFrame("render/####_boba.tif");
  println(frameCount);
}

void drawBoba() {
  boba.smooth();
  boba.beginDraw();
  boba.background(#B87FFF, 0);
  boba.fill(#B87FFF, 200);
  boba.noStroke();
  boba.beginShape(QUAD_STRIP);
  for (int i = 2; i < boba.width/6-1; i++) {
    boba.vertex(i*6, height);
    boba.vertex(i*6, 10+10*sin((i-(frameCount/2f))*PI/12));
  }
  boba.endShape();
  boba.fill(0);
  for (int i = -1; i < 8; i++) {
    boba.ellipse(i*60+(frameCount%60), 250, 40, 40);
    boba.ellipse(i*60-(frameCount%60), 200, 40, 40);
    boba.ellipse(i*60+(frameCount%60), 150, 40, 40);
  }
  boba.endDraw();
}

void drawTea() {
  tea.smooth();
  tea.beginDraw();
  tea.background(#B87FFF, 0);
  tea.fill(#B87FFF, 200);
  tea.noStroke();
  tea.beginShape(QUAD_STRIP);
  for (int i = 02; i < tea.width/6-1; i++) {
    tea.vertex(i*6, tea.height-6);
    tea.vertex(i*6, 70+10*sin((i+(frameCount/2f))*PI/12));
  }
  tea.endShape();
  tea.endDraw();
}
void drawDregs() {
  dregs.beginDraw();
  dregs.background(#B87FFF, 0);
  dregs.noStroke();
  dregs.fill(#B87FFF, 200);
  dregs.rect(6, 6, dregs.width-12, dregs.height-12);
  dregs.endDraw();
}

void drawLid() {
  lid.smooth(5);
  lid.beginDraw();
  lid.background(255, 255, 255, 0);
  lid.fill(#FFFF00, 200);
  lid.noStroke();
  lid.beginShape(QUAD_STRIP);

  float lT = 50;
  float lR = frameCount%( 360 );
  float start = lR-lT;
  float end = lR;
  if (lR < lT) {
    start = 0;
  }
  for (int i = 0; i <= 40; i++) {
    lid.vertex(lid.width/2+start*sin(i*PI/20), lid.width/2+start*cos(i*PI/20));
    lid.vertex(lid.width/2+end*sin(i*PI/20), lid.width/2+end*cos(i*PI/20));
  }
  lid.endShape(CLOSE);
  lid.beginShape(QUAD_STRIP);
  lT = 50;
  lR = ((frameCount+180)%( 360 ));
  start = lR-lT;
  end = lR;
  if (lR < lT) {
    start = 0;
  }
  for (int i = 0; i <= 40; i++) {
    lid.vertex(lid.width/2+start*sin(i*PI/20), lid.width/2+start*cos(i*PI/20));
    lid.vertex(lid.width/2+end*sin(i*PI/20), lid.width/2+end*cos(i*PI/20));
  }
  lid.endShape(CLOSE);

  lid.endDraw();
}