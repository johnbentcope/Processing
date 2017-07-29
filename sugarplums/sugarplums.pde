PShape[] sugarPlums = new PShape[10];

void setup() {
  size(600, 600, P3D);
  //noStroke();
  int detail = 50;
  for (int s = 0; s < sugarPlums.length; s++) {
    sugarPlums[s] = createShape();
    int r = (s+1)*5;
    for (int i = 0; i < detail/2; i++) {
      for (int j = 0; j < detail; j++) {
        color col = color(lerpColor( #FED7FB, #8A0081, s/10f ) );
        if (s %2 ==0) col = color(255);
        sugarPlums[s].beginShape(QUAD_STRIP);
        sugarPlums[s].stroke(255);
        sugarPlums[s].noStroke();
        if (i <= 1 || i >= detail/2-2) sugarPlums[s].fill(#73006B);
        else sugarPlums[s].fill(col);
        int ii = i+1;
        int jj = j+1;
        sugarPlums[s].vertex(r*cos(j*TWO_PI/detail)*cos(i*TWO_PI/detail), r*sin(j*TWO_PI/detail)*cos(i*TWO_PI/detail), r*sin(i*TWO_PI/detail));
        sugarPlums[s].vertex(r*cos(j*TWO_PI/detail)*cos(ii*TWO_PI/detail), r*sin(j*TWO_PI/detail)*cos(ii*TWO_PI/detail), r*sin(i*TWO_PI/detail));
        sugarPlums[s].vertex(r*cos(jj*TWO_PI/detail)*cos(i*TWO_PI/detail), r*sin(jj*TWO_PI/detail)*cos(i*TWO_PI/detail), r*sin(i*TWO_PI/detail));
        sugarPlums[s].vertex(r*cos(jj*TWO_PI/detail)*cos(ii*TWO_PI/detail), r*sin(jj*TWO_PI/detail)*cos(ii*TWO_PI/detail), r*sin(i*TWO_PI/detail));
        sugarPlums[s].endShape();
      }
    }
  }
  frameRate(30);
}

void draw() {
  background(#A671A2);
  camera(-80, 00, 60, 
    0, 0, -20, 
    0, 0, -1.0);
  pushMatrix();
  rotateY(-PI);
  drawSugarPlum();
  popMatrix();
  println(frameCount);
  if (frameCount <= 1080) saveFrame("####_sugarplums.tif");
}

void drawSugarPlum() {
  for (int i = 0; i < sugarPlums.length; i++) {
    pushMatrix();
    rotateZ(-frameCount*PI/135f);
    rotateY( (10-i) * sin( frameCount*PI/60f) *PI/20);
    rotateZ(i*PI/2);
    shape(sugarPlums[i]);  
    popMatrix();
  }
}

void drawHalfSphere(int detail, float r, color col) {
  pushMatrix();
  rotateX(PI/2);
  for (int i = 0; i < detail/2; i++) {
    for (int j = 0; j < detail; j++) {
      beginShape(QUAD);
      if (i == 0 || i == detail/2-1) fill(0);
      else fill(col);
      int ii = i+1;
      int jj = j+1;
      vertex(r*cos(j*TWO_PI/detail)*cos(i*TWO_PI/detail), r*sin(j*TWO_PI/detail)*cos(i*TWO_PI/detail), r*sin(i*TWO_PI/detail));
      vertex(r*cos(jj*TWO_PI/detail)*cos(i*TWO_PI/detail), r*sin(jj*TWO_PI/detail)*cos(i*TWO_PI/detail), r*sin(i*TWO_PI/detail));
      vertex(r*cos(jj*TWO_PI/detail)*cos(ii*TWO_PI/detail), r*sin(jj*TWO_PI/detail)*cos(ii*TWO_PI/detail), r*sin(ii*TWO_PI/detail));
      vertex(r*cos(j*TWO_PI/detail)*cos(ii*TWO_PI/detail), r*sin(j*TWO_PI/detail)*cos(ii*TWO_PI/detail), r*sin(ii*TWO_PI/detail));
      endShape();
    }
  }
  popMatrix();
}