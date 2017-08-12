float ga = PI*(3-sqrt(5));
int numPoints = 720;
float R = 70;
float t = 0;
int plumeDt = 13;
int pR = 20;
int pH = 80;

void setup() {
  size(600, 600, P3D);
  float cameraZ = ((height/2.0) / tan(PI*60.0/360.0));
  perspective(PI/3.0, width/height, cameraZ/100.0, cameraZ*10.0);
}

void draw() {
  background(200);
  camera(-200, 0, 100, 
    0, 0, R/2, 
    0, 0, -1.0);
  //rotateZ(frameCount*TWO_PI/720);
  pushMatrix();
  translate(0, 0, pH);
  cloud();
  popMatrix();
  plume();
  println(frameCount);
  if (frameCount <= 720) saveFrame("render/####_doomsday.tif");
}

void plume() {
  for (int i = 0; i < plumeDt; i++) {
    for (int j = 0; j < plumeDt*2; j++) {
      float jIndex = (j+t/10)%(plumeDt*2); // local index for looped mapping
      float r = pR / sqrt(jIndex); // give it an ominous shape
      r = constrain(r, 0, pR*1.5); // remove this if you want, your boxes will just fly in from the bottom edges
      pushMatrix();
      rotateZ(i*TWO_PI/plumeDt - jIndex*PI/(2*plumeDt)); // radial positioning (i) with a twist moving up (j)
      translate(r, 0, map(jIndex, 0, plumeDt*2, 0, pH+R*0.75)); // Move up to roughly the top of the mushroom
      box(min(jIndex*2, 3)); // ease boxes into existence
      popMatrix();
    }
  }
}

void cloud() {
  // Phi is angle of descent
  // Theta is angle of rotation
  for ( int i = 0; i < numPoints; i++) {
    if (i == 1) fill(0); else fill(255);
    float index = (i + t)%numPoints;  // get a local index for phyotaxic mapping
    float theta = ga * i;  // how phylotaxis works
    float phi = PI * (index/ (float)numPoints); // Compare to the radius modifier in phylotaxy
    float r = map(index, 0, numPoints, 0, PI*0.5); 
    r = R*cos(r)*cos(r); // create limaçon shape
    float x = r*sin(phi)*cos(theta); 
    float y = r*sin(phi)*sin(theta);
    float z = r*cos(phi*1.3)*0.75;  // deforming the spherical shape a bit for mushroom effect
    pushMatrix(); 
    translate(x, y, z);
    rotateZ(i*TWO_PI/(numPoints)-2*(frameCount)*TWO_PI/360); 
    rotateX(i*TWO_PI/(numPoints)-2*(frameCount)*TWO_PI/360); // Spin the boxes
    box(min(index/3, 5, (numPoints-index)/35)); // boxes should ease in and out of existence
    popMatrix();
  }
  // increase offset within phylotaxic mapping
  t += 1;
}