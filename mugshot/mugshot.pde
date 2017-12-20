Vessel mug; 

PShape hwc;
PGraphics bg;

void setup() {
  size(600, 600, P3D);
  strokeWeight(3);
  fill(#AE9072);
  stroke(#FADCBD);
  bg = createGraphics(width, height);

  hwc = loadShape("assets/hwcBLANK.svg");
  hwc.setFill(255);
  mug = new Vessel();

  bg.beginDraw();
  bg.background(0);
  bg.shape(hwc, 0, 0.75*height, width/10, -height/10);
  bg.endDraw();
}

void draw() {
  background(200);
  set(0, 0, bg);
  camera(-290, 0, 40+mug.mH// - mouseY/3
    , 
    0, 0, mug.mH/2, 
    0, 0, -1);
  //rotate(frameCount*TWO_PI/720);
  rotate(PI);
  //rotateZ(-frameCount*TWO_PI/1440);

  pushMatrix();
  translate(0, 0, 140);
  stroke(255);
  strokeWeight(25);
  fill(0);
  noFill();
  rotateY(frameCount*TWO_PI/360);
  rotateZ(frameCount*TWO_PI/360);
  box(100);
  popMatrix();

  mug.render();

  //if (frameCount % 360 == 1) saveFrame("render/####_test.tif");
}