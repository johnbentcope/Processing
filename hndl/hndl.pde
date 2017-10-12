Chain handle;

Point[] points = {
  new Point(new PVector(0, 100)), 
  new Point(new PVector(100, 50)), 
  new Point(new PVector(200, 100)), 
  new Point(new PVector(350, 300)), 
  new Point(new PVector(350, 600)), 
  new Point(new PVector(250, 850)), 
  new Point(new PVector(100, 950)), 
  new Point(new PVector(0, 900))
};

void setup() {
  size(1000, 1000, P3D);

  handle = new Chain();
  for (int i = 0; i < points.length-1; i++) {
    handle.addStrip(
      new Strip( points[i], points[i+1], i )
      );
  }
  strokeWeight(1);
  smooth();
}

void draw() {
  handle.render();
}