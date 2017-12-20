int R = 250;
int rT = 75;
int cD = 6;
int torusLayers = 15;
float spacing ;

PShape[] corrus = new PShape[2*(1+torusLayers)];

void setup() {
  size(600, 600, P3D);
  ellipseMode(RADIUS);
  torusLayers++;
  torusLayers*=2;
  spacing = 2*(rT/ (float) (torusLayers-2));
  strokeWeight(3);
  fill(#AE9072);
  stroke(#FADCBD);
}
void draw() {
  background(#9EE8FF);
  hint(ENABLE_DEPTH_SORT);
  hint(ENABLE_DEPTH_TEST);
  camera(-500, 0, 175+125*sin(frameCount*TWO_PI/360), 
    0, 0, 75+125*sin(frameCount*TWO_PI/360+PI), 
    0, 0, -1);
  pushMatrix();
  //translate(width/2, height/2);
  rotate(frameCount*TWO_PI/720);
  rotate(PI/2);

  //ellipse(0, 0, R+r, R+r);
  //ellipse(0, 0, R-r, R-r);
  if (frameCount == 1) {
    for (int j = 1; j < torusLayers; j++) {
      float r = sqrt( sq(rT) - sq( 2*rT*( 1 - ( j / (float) torusLayers) ) - rT) );
      float outer = R+r;
      float inner = R-r;
      translate(0, 0, spacing);
      if ( j %2 == 1) {
        drawRing(outer, inner, 80);
      } else {
        corrus[j] = createShape();
        corrus[j].beginShape(QUADS);
        //corrus[j].fill(255);
        for (int i = 0; i < (outer*2)/cD; i++) {
          int ii = i+1;
          float z1 = spacing*(( i/2)%2)-spacing/2;
          float z2 = spacing*((ii/2)%2)-spacing/2;
          float y1 = sqrt( sq(outer) - sq(i*cD-outer));
          float y2 = sqrt( sq(outer) - sq(ii*cD-outer));

          if (abs( R - abs((i*cD-outer)) ) < r) {
            //corrus[j].stroke(#0000FF);
            //line(i*cD-outer, -y, i *cD-outer, y);
            corrus[j].vertex(i *cD-outer, -y1, z1);
            corrus[j].vertex(i *cD-outer, y1, z1);
            corrus[j].vertex(ii *cD-outer, y2, z2);
            corrus[j].vertex(ii *cD-outer, -y2, z2);
          }
          if (abs((i*cD-outer)) <= R-r) {
            float y1p = sqrt( sq(inner) - sq(i * cD-outer));
            float y2p = sqrt( abs(sq(inner) - sq(ii * cD-outer)));
            //corrus[j].stroke(#FF0000);
            corrus[j].vertex(i * cD-outer, -y1, z1);
            corrus[j].vertex(i * cD-outer, -y1p, z1);
            corrus[j].vertex(ii * cD-outer, -y2p, z2);
            corrus[j].vertex(ii * cD-outer, -y2, z2);

            //corrus[j].stroke(#00FF00);
            corrus[j].vertex(i * cD-outer, y1, z1);
            corrus[j].vertex(i * cD-outer, y1p, z1);
            corrus[j].vertex(ii * cD-outer, y2p, z2);
            corrus[j].vertex(ii * cD-outer, y2, z2);
            //vertex(ii *cD-outer, y2, z2);
            //vertex(ii *cD-outer, -y2, z2);
            //line(i*cD-outer, -y1, i *cD-outer, -y2);
            //stroke(#00FF00);
            //line(i*cD-outer, y2, i *cD-outer, y1);
          }
        }
        corrus[j].endShape(CLOSE);
      }
    }
  } else {    
    for (int j = 1; j < torusLayers; j++) {
      float r = sqrt( sq(rT) - sq( 2*rT*( 1 - ( j / (float) torusLayers) ) - rT) );
      float outer = R+r;
      float inner = R-r;
      translate(0, 0, spacing);
      if ( j %2 == 1) {
        drawRing(outer, inner, 80);
      } else {
        shape(corrus[j]);
      }
    }
  }
  popMatrix();
  if(frameCount < 721) saveFrame("render/####_corroidal.tif");
}

void drawRing(float outerL, float innerL, int detail) {
  beginShape(QUAD_STRIP);
  noStroke();
  for (int i = 0; i <= detail; i++) {
    float xO = outerL*cos(i*TWO_PI/detail);
    float yO = outerL*sin(i*TWO_PI/detail);
    float xI = innerL*cos(i*TWO_PI/detail);
    float yI = innerL*sin(i*TWO_PI/detail);
    vertex(xO, yO);
    vertex(xI, yI);
  }
  endShape(CLOSE);
  noFill();
  stroke(#FADCBD);
  beginShape();
  for (int i = 0; i <= detail; i++) {
    float xO = outerL*cos(i*TWO_PI/detail);
    float yO = outerL*sin(i*TWO_PI/detail);
    vertex(xO, yO);
  }
  endShape(CLOSE);
  beginShape();
  for (int i = 0; i <= detail; i++) {
    float xI = innerL*cos(i*TWO_PI/detail);
    float yI = innerL*sin(i*TWO_PI/detail);
    vertex(xI, yI);
  }
  endShape(CLOSE);
  fill(#AE9072);
  //noFill();
  //ellipse(0, 0, innerL, innerL);
  //ellipse(0, 0, outerL, outerL);
}