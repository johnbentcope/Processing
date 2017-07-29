
ArrayList<Kernel> corns = new ArrayList<Kernel>();


float gravity = 0.2;
float death = 180;

void setup() {
  size(600, 600, P3D);
  frameRate(30);
}

void draw() {
  background(#3AFFC3);
  camera(-200, 0, 10, 
    0, 0, 0, 
    0, 0, -1.0);
  if (frameCount < 180) {
    corns.add(new Kernel(new PVector(0, 0, -50)));
    corns.add(new Kernel(new PVector(0, 0, -50)));
  }
  for (int s = 0; s < corns.size(); s++) {
    Kernel corn = corns.get(s);
    corn.render();
    if (corn.age >= death) {
      corn.reset(-50);
    }
  }
  fill(255);
  pushMatrix();
  translate(-30,-200,-30);
  rotateY(PI/2);
  rect(0,0,100,600);
  translate(-2,-2,-10);
  for(int i = 0; i < 20; i++){
    pushMatrix();
    translate(-5,i*30+12,5);
    fill(#F7614A);
    rect(0,0,100,18);
    popMatrix();
  }
  popMatrix();
  if (frameCount > 180 && frameCount <= 180*5+3) saveFrame("####_popcorn.tif");
  println(frameCount);
}