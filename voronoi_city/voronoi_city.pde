int cells = 20;

Particle[] points = new Particle[cells];
color[] pointfill = new color[cells];

void setup() {
  size(600, 600);

  for (int i = 0; i < cells; i++) {
    points[i] = new Particle(i);
    pointfill[i] =  color(random(255), random(255), random(255));
  }
}

void draw() {
  background(0);
  loadPixels();
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      pixels[x+y*width] = getClosestPoint(x, y);
    }
  }
  updatePixels();
  
  for (Particle p: points){
    //rect(p.pos.x, p.pos.y, 3,3);
    p.update();
  }
  saveFrame("render/####_voronoi_city.tif");
  println(frameRate);
}

color getClosestPoint(int x, int y) {

  float minDist = 1000000;

  int pointId = 0;

  for (Particle p : points) {
    float d = (abs(x-p.pos.x)+abs(y-p.pos.y));
    if ( d < minDist) {
      //if (d < minDist){
      minDist = d;
      pointId = p.id;
    }
  }

  return points[pointId].col;
}

class Particle{
  PVector pos;
  PVector vel;
  int id;
  
  color col = #000000;
  
  Particle(int id){
    pos = new PVector(random(width*2-width/2),random(height*2-height/2));
    vel = new PVector(random(-3,3),random(-3,3));
    col = lerpColor(#F0A8ED, #7D0F5B,random(1));
    this.id = id;
  }
  
  void update(){
    PVector acc = new PVector(pos.x-width/2,pos.y-height/2);
    acc.normalize();
    acc.mult(-0.2);
    vel.add(acc);
    pos.add(vel);
  }
  
}