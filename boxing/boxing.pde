ArrayList<Boxx> boxes = new ArrayList<Boxx>();

ArrayList<Boxx> rack = new ArrayList<Boxx>();

int tapeWidth = 3;
float off = 2;

int death = 180;

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

void setup() {
  size(600, 600, P3D);
  float cameraZ = ((height/2.0) / tan(PI*60.0/360.0));
  perspective(PI/3.0, width/height, 0.1, cameraZ*10.0);
  for (int i = 0; i < boxDims.length; i++) {
    boxes.add(new Boxx(boxDims[i], boxDw[i]));
  }
  strokeWeight(2);
  frameRate(30);
}

void draw() {
  off = 0.6-cos(frameCount*TWO_PI/60)*0.5;
  background(#9EE8FF);
  camera(-50, 0, 0, 
    0, 0, 0, 
    0, 0, -1);

  if (frameCount < 180 && frameCount % 2 == 0) {
    rack.add( new Boxx(boxes.get( floor( random( boxes.size() ) ) ).dims, boxes.get( floor( random( boxes.size() ) ) ).isDw ));
  }

  for (Boxx bx : rack) {
    bx.update();
    bx.render();
    if (bx.age >= death) { 
      bx.reset();
    }
  }
  //boxes.get((frameCount/30)%boxes.size()).render();
  //boxes.get(2).render();
  //if (frameCount >= 180 && frameCount <= 180+180*4+4) saveFrame("render/####_boxrain.tif");
}