PShape custard, quesillo, caramel;

int flanDetail = 13;
int flanRadius = 30;

float raspBerryRad = 10;

float phi = (sqrt(5)+1)/2 - 1; // golden ratio
float ga = phi*2*PI;           // golden angle

int numBerries = 20;

PShape leaf;

PGraphics face;

boolean render = true;

SpherePoint[] pts = new SpherePoint[numBerries];

void setup() {
  size(600, 600, P3D);

  initSphere();

  face = createGraphics(100, 50, P3D);

  leaf = drawLeaf(#D1DC42, #9CB004);

  // Custard is the bulk of the desert
  custard = createShape();
  custard.beginShape(QUAD_STRIP);
  custard.noStroke();
  for (int i = 0; i <= flanDetail; i++) {
    custard.fill(#FFF991);
    custard.vertex(flanRadius*cos(i*TWO_PI/flanDetail)*1.3, flanRadius*sin(i*TWO_PI/flanDetail)*1.3, 0);
    custard.vertex(flanRadius*cos(i*TWO_PI/flanDetail)*1.1, flanRadius*sin(i*TWO_PI/flanDetail)*1.1, flanRadius*0.8);
  }
  for (int i = 0; i <= flanDetail; i++) {
    custard.fill(#FFF991);
    custard.vertex(flanRadius*cos(i*TWO_PI/flanDetail)*1.1, flanRadius*sin(i*TWO_PI/flanDetail)*1.1, flanRadius*0.8);
    custard.fill(#924412);
    custard.vertex(flanRadius*cos(i*TWO_PI/flanDetail), flanRadius*sin(i*TWO_PI/flanDetail), flanRadius);
  }
  custard.endShape();

  flanDetail *= 8;
  // Using createshape for quesillo so it's automatically at the right height, and minimizing unecessary detail
  quesillo = createShape();
  quesillo.beginShape(TRIANGLE_FAN);
  quesillo.noStroke();
  quesillo.fill(#924412);
  quesillo.vertex(0, 0, flanRadius);
  for (int i = 0; i <= flanDetail; i++) { // <= is necessary to wrap all the way back to the start
    quesillo.vertex(flanRadius*cos(i*TWO_PI/flanDetail), flanRadius*sin(i*TWO_PI/flanDetail), flanRadius);
  }
  quesillo.endShape();
  //frameRate(30);
  camera(-75, 0, 59, 
    0, 0, 5, 
    0, 0, -1.0);
  perspective(PI/3.0, width/height, 0.1, 55*10.0);
}

void draw() {
  background(#C5D12A);
  noLights();
  caramel = createShape();
  caramel.beginShape(QUAD_STRIP);
  caramel.fill(#DF932A, 150);
  caramel.noStroke();
  for (int i = 0; i <= flanDetail; i ++) {
    int j = i+1;
    float drip = 9-1*(
      sin(i*14*TWO_PI/flanDetail+frameCount*PI/60) + 
      sin(i*17*TWO_PI/flanDetail-frameCount*PI/60) +
      sin(i*11*TWO_PI/flanDetail+frameCount*PI/60)
      );
    float dripScale = (map(drip, 0, 10, 1, 1.2));
    caramel.vertex(flanRadius*cos(i*TWO_PI/flanDetail), flanRadius*sin(i*TWO_PI/flanDetail), flanRadius);
    caramel.vertex(flanRadius*cos(i*TWO_PI/flanDetail)*dripScale, flanRadius*sin(i*TWO_PI/flanDetail)*dripScale, flanRadius-drip
      );
  }

  caramel.endShape();
  fill(255);
  noStroke();
  translate(0, 0, -1);
  ellipse(0, 0, 100, 100);
  translate(0, 0, 1);
  fill(230);
  ellipse(0, 0, 90, 85);
  rotateZ(frameCount*PI/120f);
  quesillo.setFill(color(#924412));
  shape(custard);
  shape(quesillo);
  quesillo.setFill(color(#DF932A, 150));
  translate(0, 0, flanRadius*(0.1+0.05*sin(frameCount*TWO_PI/360)));
  lights();
  shape(quesillo);
  shape(caramel);

  translate(0, 0, flanRadius*1.0);
  noLights();
  pushMatrix();
  scale(0.2);
  rotateY(-PI/6);
  shape(leaf);
  rotateZ(PI);
  rotateY(-2*PI/6);
  shape(leaf);
  popMatrix();
  lights();
  for (int i = 0; i < flanDetail/9; i++) {
    pushMatrix();
    raspBerryRad = 4-2*cos(frameCount*PI/120-i*TWO_PI/(flanDetail/9));
    rotateZ(i*TWO_PI/(flanDetail/9));
    translate(flanRadius*0.8, 0, flanRadius*0.2);
    renderRaspberry();
    popMatrix();
  }
  println(frameCount, frameRate);

  if (render) {
    saveFrame("render/####_flan.tif");
    if (frameCount >= 720) noLoop();
  }
}

void renderRaspberry()
{
  pushMatrix();
  float zRot = frameCount/360f*PI;
  rotateZ( zRot );


  strokeWeight(3);


  for (int i = 0; i < numBerries; i++)
  {
    float lat = pts[i].lat;
    float lon = pts[i].lon;

    pushMatrix();
    rotateY( lon);
    rotateZ( -lat);
    float lum = (cos(pts[i].lon+PI*.33+zRot)+1)/2;
    stroke(.5, .5*lum, .2+lum*.8);
    pushMatrix();
    translate(raspBerryRad, 0, 0);
    rotateY(PI/2);
    rotateZ(frameCount/60f*PI);
    noStroke();
    fill(#D9042B);
    sphere(1);
    popMatrix();

    popMatrix();
  }

  popMatrix();
}

void initSphere()
{
  for (int i = 0; i < numBerries; i++) {
    float lon = ga*i;
    lon /= 2*PI; 
    lon -= floor(lon); 
    lon *= 2*PI;
    if (lon > PI)  lon -= 2*PI;

    float lat = asin(-1 + 2*i/(float)numBerries);

    pts[i] = new SpherePoint(lat, lon);
  }
}


PShape drawLeaf(color body, color vein) {
  PShape leaf;
  leaf = createShape();
  leaf.beginShape(TRIANGLE_FAN);
  leaf.noStroke();
  leaf.vertex(0, 0, 0);
  leaf.fill(body);

  leaf.vertex(05, -26, 0);
  leaf.vertex(15, -30, 5);

  leaf.vertex(15, -30, 5);
  leaf.vertex(29, -27, 10);

  leaf.vertex(29, -27, 10);
  leaf.vertex(55, -06, 5);

  leaf.vertex(55, -06, 5);
  leaf.vertex(70, 0, 0);

  leaf.fill(vein);
  leaf.vertex(70, 0, 0);
  leaf.vertex(35, 0, 7);
  leaf.vertex(70, 0, 0);

  leaf.fill(body);
  leaf.vertex(70, 0, 0);
  leaf.vertex(55, 06, 5);

  leaf.vertex(55, 06, 5);
  leaf.vertex(29, 27, 10);

  leaf.vertex(29, 27, 10);
  leaf.vertex(15, 30, 5);

  leaf.vertex(15, 30, 5);
  leaf.vertex(05, 26, 0);


  leaf.endShape(CLOSE);

  return leaf;
}