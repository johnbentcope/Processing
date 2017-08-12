ArrayList<Droplet> slices = new ArrayList<Droplet>();

PShape top, sides;
float r = 20;
int detail = 20;
float thicc = 10;
float skew = thicc;
float noiseDetail = 1;
int id = 0;

void setup() {
  size(600, 600, P3D);
  top = createShape();
  top.beginShape(TRIANGLE_FAN);
  top.noStroke();
  top.fill(#F2B807);//, #BF7E04, noise(x*noiseDetail, y*noiseDetail)));
  top.vertex(0, 0, 0);
  for (int i = 0; i <= detail; i++) {
    float x = r*sin(i*TWO_PI/detail);
    float y = 2*r*cos(i*TWO_PI/detail);
    top.fill(lerpColor(#FABF0A, #B27400, noise(x*noiseDetail+r, y*noiseDetail+2*r)));

    top.vertex(x, y, 0);
  }
  top.endShape(CLOSE);

  sides = createShape();
  sides.beginShape(QUAD_STRIP);
  sides.noStroke();
  sides.stroke(255);
  for (int i = 0; i <= detail; i++) {
    float x = r*sin(i*TWO_PI/detail);
    float y = 2*r*cos(i*TWO_PI/detail);
    sides.fill(lerpColor(#FABF0A, #B27400, noise(x*noiseDetail+r, y*noiseDetail+2*r)));

    sides.vertex(x, y, 0);
    sides.vertex(x, y+skew, -thicc);
  }
  sides.endShape(CLOSE);
  frameRate(30);
}

void draw() {
  background(51);
  if ( frameCount < 360 && frameCount%6 == 0) {
    slices.add(new Droplet(id));
    id++;
  }

  for (Droplet s : slices) {
    s.update();
    s.render();
    if (s.age > 360) {
      s.reInit();
    }
  }
  //camera(-100, 0, 300-mouseY, 
  //  0, 0, 0, 
  //  0, 0, -1.0);
  rotateZ(frameCount*TWO_PI/360f);
  //renderPlatanos();
  println(frameRate, frameCount);
  if (frameCount >=720 && frameCount < 720*2) saveFrame("render/####_platanos.tif");
  if (frameCount > 720*2) noLoop();
}

void renderPlatanos() {
}