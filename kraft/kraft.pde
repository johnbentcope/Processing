ArrayList<Boxx> boxes = new ArrayList<Boxx>();

ArrayList<Boxx> rack = new ArrayList<Boxx>();

int tapeWidth = 3;
float off = 0.1;


PVector[] boxDims = {
  new PVector(10, 8, 2), 
  new PVector(10, 10, 2), 
  new PVector(10, 6, 6), 
  new PVector(12, 12, 4), 
  new PVector(13, 10, 8), 
  new PVector(20, 14, 4), 
  new PVector(18, 12, 8), 
  new PVector(18, 14, 12), 
  new PVector(20, 16, 16), 
  new PVector(21, 14, 7), 
  new PVector(29, 21, 6), 
  new PVector(30, 30, 8), 
};

boolean[] boxDw = {
  false, 
  false, 
  false, 
  false, 
  false, 
  false, 
  true, 
  true, 
  true, 
  false, 
  false, 
  false, 
};

KraftRing[] rings = new KraftRing[20];

void setup() {
  size(600, 600, P3D);
  for (int i = 0; i < rings.length; i++) {
    rings[i] = new KraftRing(60, 60);
  }  
  for (int i = 0; i < boxDims.length; i++) {
    boxes.add(new Boxx(boxDims[i], boxDw[i]));
  }
  for (int i = 0; i < 10; i++) {
    rack.add( new Boxx(boxes.get( floor( random( boxes.size() ) ) ).dims, boxes.get( floor( random( boxes.size() ) ) ).isDw ));
  }

  stroke(255);
  perspective(PI/3.0, width/height, 0.01, 1000);
  frameRate(30);
}

void draw() {
  background(#9EE8FF);
  camera(-185, 0, 75, 
    0, 0, -30, 
    0, 0, -1);

  for (int i = 0; i < rings.length; i++) {
    pushMatrix();
    rotateZ(i*TWO_PI/(rings.length)+frameCount*TWO_PI/360);
    translate(80, 0, 0);
    rotateX(PI/2);
    rotateZ((frameCount)*TWO_PI/360);
    rings[i].render();
    popMatrix();
  }

  for (int i = 0; i < rack.size(); i++) {
    pushMatrix();
    rotateZ(i*TWO_PI/(rack.size())-frameCount*TWO_PI/360);
    translate(80, 0, 0);
    rotateX(PI/2);
    rotateZ(i*TWO_PI/(rack.size())-2*(frameCount)*TWO_PI/360);
    rotateX(i*TWO_PI/(rack.size())-2*(frameCount)*TWO_PI/360);
    scale(2, 2, 2);
    rack.get(i).render();
    popMatrix();
  }
  //if (frameCount >= 180 && frameCount <= 180+180*4+4) saveFrame("render/####_krafty.tif");
}