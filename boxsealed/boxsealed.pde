// Today's new thing:
// Retexturing a PShape from a generated PGraphic
// Animating PShape via PShape Array

int detail = 24;
color peak = #D7F180;
color valley = #768C2D;

PShape[] grass = new PShape[120];
int gD = 5;

PGraphics fieldTex;
float tH = 100;

float nF = 0;

void setup() {
  size(600, 600, P3D);

  fieldTex = createGraphics(600, 600, P3D);

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

  noiseSeed(19);
  strokeWeight(3);
  frameRate(30);
}

void draw() {
  background(200);
  camera(-320, 0, 200, 
    0, 0, -120, 
    0, 0, -1);
  //rotateZ(frameCount*TWO_PI/720);
  rotateZ(PI);
  fieldTex.beginDraw();
  fieldTex.noStroke();
  float cameraZ = ((height/2.0) / tan(PI*60.0/360.0));
  fieldTex.perspective(PI/3.0, width/height, 0.1, cameraZ*10.0);
  fieldTex.hint(DISABLE_DEPTH_TEST);

  fieldTex.beginShape(QUADS);

  fieldTex.blendMode(BLEND);
  for (int i = 0; i < detail; i++) {
    for (int j = 0; j < detail; j++) {
      int ii = i+1;
      int jj = j+1;

      fieldTex.fill(lerpColor(valley, peak, noise(i/10f, j/10f, nF)));
      fieldTex.vertex(  i*(width/detail), j*(height/detail));

      fieldTex.fill(lerpColor(valley, peak, noise(ii/10f, j/10f, nF)));
      fieldTex.vertex( ii*(width/detail), j*(height/detail));

      fieldTex.fill(lerpColor(valley, peak, noise(ii/10f, jj/10f, nF)));
      fieldTex.vertex( ii*(width/detail), jj*(height/detail));

      fieldTex.fill(lerpColor(valley, peak, noise(i/10f, jj/10f, nF)));
      fieldTex.vertex(  i*(width/detail), jj*(height/detail));
    }
  }
  fieldTex.endShape();

  fieldTex.pushMatrix();
  fieldTex.blendMode(SUBTRACT);
  fieldTex.fill(#657141, 50);
  fieldTex.translate(width/2, height/2, 100);
  fieldTex.rotateY(2*(frameCount)*TWO_PI/360);
  fieldTex.rotateZ(2*(frameCount)*TWO_PI/360);
  fieldTex.box(100, 80, 80);
  fieldTex.popMatrix();
  fieldTex.endDraw();

  //image(fieldTex, -width/2, -height/2);
  pushMatrix();
  translate(-width/2+50, -height/2, 0);
  beginShape(QUADS);
  texture(fieldTex);
  stroke(#F1FFC8);
  for (int i = 0; i < detail; i++) {
    for (int j = 0; j < detail; j++) {
      int ii = i+1;
      int jj = j+1;

      vertex(  i*(width/detail), j*(height/detail), tH*noise(i/10f, j/10f), i*(width/detail), j*(height/detail));

      vertex( ii*(width/detail), j*(height/detail), tH*noise(ii/10f, j/10f), ii*(width/detail), j*(height/detail));

      vertex( ii*(width/detail), jj*(height/detail), tH*noise(ii/10f, jj/10f), ii*(width/detail), jj*(height/detail));

      vertex(  i*(width/detail), jj*(height/detail), tH*noise(i/10f, jj/10f), i*(width/detail), jj*(height/detail));

      if ( tH*noise(i/10f, jj/10f) > 37 && tH*noise(i/10f, jj/10f) < 60) {
        pushMatrix();
        translate(i*(width/detail), jj*(height/detail), tH*noise(i/10f, jj/10f)-2);
        rotateZ(PI/4);
        shape(grass[(frameCount +i*4+j*4)%grass.length]);
        popMatrix();
      }
    }
  }
  endShape();
  popMatrix();
  pushMatrix();
  shape(grass[(frameCount/2)%grass.length]);
  popMatrix();
  if (frameCount <= 720) saveFrame("render/####_boxsealed.tif");
}