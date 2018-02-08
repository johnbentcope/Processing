CorrPanel p;
CorrConic c;
CorrConic c2;
CorrDisk  d;
CorrDisk  r;

void setup() {
  size(600, 600, P3D);

  p = new CorrPanel(150, 150);
  d = new CorrDisk(150, false, 0);
  r = new CorrDisk(125, true, 45);
  c = new CorrConic(15, 85, 50, TWO_PI, 21);
  c2 = new CorrConic(85, 85, 50, TWO_PI/3f, 7);
  frameRate(60);
  strokeWeight(2);
}

void draw() {

  background(#9EE8FF);
  camera(200*sin(frameCount*TWO_PI/720), 200*cos(frameCount*TWO_PI/720), 250, 
    0, 0, 60, 
    0, 0, -1);
  p.render();
  rotateZ(-PI/6);
  translate(0, 0, 20);
  d.render();
  rotateZ(-PI/6);
  translate(0, 0, 20);
  r.render();
  rotateZ(-PI/6);
  translate(0, 0, 20);
  c.render();
  rotateZ(-PI/6);
  translate(0, 0, 60);
  c2.render();
  if (frameCount%60 == 59)
    println((int)frameRate + " FPS");
}

void keyPressed() {
  if (key == ' ') {
    saveFrame("####_corru.png");
  }
}
