// This is a trainwreck and refactoring is a priority if this is ever to be resuscitated 

ArrayList<Boxx> boxes = new ArrayList<Boxx>();

float ga = PI*(3-sqrt(5));
int numPoints = 500;
float R = 60;
float t = 0;
int plumeDt = 13;
int pR = 20;
int pH = 80;

float off = 0.1;
int tapeWidth = 3;

PShape[] grass = new PShape[120];
int gD = 5;

color peak = #F1ED80;
color valley = #F7D565;

color peakg = #8E9E77;
color valleyg = #5A6946;

int gridW = 20;
int gridX = 200;

PVector[] boxDims = {
  new PVector(20, 20, 20), 
};

boolean[] boxDw = {
  false
};


KraftRing[] plumage = new KraftRing[plumeDt];


void setup() {
  size(600, 600, P3D);
  noiseSeed(102);
  float cameraZ = ((height/2.0) / tan(PI*60.0/360.0));
  perspective(PI/3.0, width/height, cameraZ/100.0, cameraZ*10.0);
  for (int i = 0; i < boxDims.length; i++) {
    boxes.add(new Boxx(boxDims[i], boxDw[i], false));
  }  
  for (int g = 0; g < grass.length; g++) {
    PVector pos = new PVector(0, 0, 0);
    float segLen = 10;
    float thicc = 7;
    float deflection = (1+sin(g*TWO_PI/grass.length) )*TWO_PI/90;
    grass[g] = createShape();

    grass[g].beginShape(QUAD_STRIP);
    grass[g].stroke(valley);
    grass[g].strokeWeight(2);
    grass[g].fill(peak);
    grass[g].vertex(0, 0, 0);
    grass[g].vertex(thicc, 0, 0);
    for (int i = 1; i < gD+1; i++) {
      PVector curr;
      curr = new PVector(0, segLen*sin(i*deflection), segLen*cos(i*deflection));
      pos.add(curr);
      grass[g].vertex(    map(i, 0, gD, 0, thicc/2), pos.y, pos.z);
      grass[g].vertex(thicc-map(i, 0, gD, 0, thicc/2), pos.y, pos.z);
    }
    grass[g].endShape();
  }

  for (int i = 0; i < plumeDt; i++) {
    plumage[i] = new KraftRing(plumeDt*4, pR*2);
  }
  frameRate(30);
  smooth(6);
}

void draw() {
  background(#9EE8FF);
  camera(-200, 0, 40, 
    0, 0, R/2+10, 
    0, 0, -1.0);
  pushMatrix();
  rotateZ(frameCount*TWO_PI/360);
  pushMatrix();
  translate(0, 0, pH+pR/1.5);
  cloud();
  popMatrix();
  plume();
  popMatrix();
  println(frameCount, frameRate);
  t += 1;
  pushMatrix();
  fill(0);
  translate(-gridW*gridX/8, -gridW*gridX/2, 0);
  beginShape(QUADS);
  for (int i = 0; i < gridX/4; i++) {
    for (int j = 0; j < gridX; j++) {
      int ii = i+1;
      int jj = j+1;
      fill(lerpColor(valleyg, peakg, noise(i/10f, j/10f)));
      vertex(i*gridW, j*gridW, 30*noise(i/10f, j/10f));
      
      fill(lerpColor(valleyg, peakg, noise(i/10f, jj/10f)));
      vertex(i*gridW, jj*gridW, 30*noise(i/10f, jj/10f));
      
      fill(lerpColor(valleyg, peakg, noise(ii/10f, jj/10f)));
      vertex(ii*gridW, jj*gridW, 30*noise(ii/10f, jj/10f));
      
      fill(lerpColor(valleyg, peakg, noise(ii/10f, j/10f)));
      vertex(ii*gridW, j*gridW, 30*noise(ii/10f, j/10f));
      
      if (noise(i/10f, j/10f) < 0.6 && noise(i/10f, j/10f) > 0.4) {
        pushMatrix();
        translate((i+0.5)*gridW, (j+0.5)*gridW, 30*noise(i/10f, j/10f));
        rotateY(-PI/4);
        rotateZ( PI+new PVector(-(i+0.5)*gridW, -(j+0.5)*gridW).heading());
        scale(0.35, 0.35, 0.35);
        shape(grass[(frameCount+i*4+j*4)%grass.length]);
        popMatrix();
      }
    }
  }
  endShape(CLOSE);
  popMatrix();
  pushMatrix();
  translate(1000, -gridW*gridX/2, 0);
  beginShape();
  vertex(0, 0, 0);
  for ( int i = 0; i < gridX; i++) {
    vertex(0, i*gridW, 100+200*noise(i/10f));
  }
  vertex(0, gridX*gridW, 0);
  endShape(CLOSE);
  popMatrix();
  if (frameCount <= 720) saveFrame("render/####_doomsday.tif");
}

void plume() {
  for (int i = 0; i < plumeDt; i++) {
    pushMatrix();
    rotateZ(i*TWO_PI/plumeDt); // radial positioning (i) with a twist moving up (j)
    plumage[i].render();
    popMatrix();
  }
}

void cloud() {
  // Phi is angle of descent
  // Theta is angle of rotation
  for ( int i = 0; i < numPoints; i++) {
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
    //box(min(index/3, 5, (numPoints-index)/35)); // boxes should ease in and out of existence
    scale(min(index/3, 5, (numPoints-index)/35)/20f);
    boxes.get(0).render();
    popMatrix();
  }
  // increase offset within phylotaxic mapping
}