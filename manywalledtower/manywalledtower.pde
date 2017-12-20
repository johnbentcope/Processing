int mD = 50;
int cD = 100;
int cP = 4;

float[] cH = new float[cP];

PShape corru;
PShape flat;
PGraphics mask;

void setup() {
  size(600, 600, P3D);
  mask = createGraphics(width, height);
  fill(#AE9072);
  stroke(#FADCBD);
  strokeWeight(3);
}

void draw() {
  for (int i = 0; i < cP; i++) {
    cH[i] = cos(i*TWO_PI/cP+PI/cP);
  }
  background(#9EE8FF);
  camera(-350, 0, 303*cos(frameCount*TWO_PI/720), 
    0, 0, 253*cos(frameCount*TWO_PI/720 +PI/4), 
    0, 0, -1);
  //rotateZ(frameCount*TWO_PI/720);
  rotateZ(HALF_PI);
  mask.beginDraw();
  mask.background(0);
  mask.translate(mask.width/2, mask.height/2);
  flat = createShape();
  flat.beginShape(TRIANGLE_FAN);
  flat.fill(255);
  flat.stroke(255);
  flat.strokeWeight(3);
  //flat.noStroke();
  flat.vertex(0, 0);
  for (int i = 0; i <= mD; i++) {
    float r = 150+50;//*noise(10+cos(i*TWO_PI/mD), 10+sin(i*TWO_PI/mD), frameCount/50f);
    float x = r*cos(i*TWO_PI/mD);
    float y = r*sin(i*TWO_PI/mD);
    flat.vertex(x, y);
  }
  flat.endShape(CLOSE);
  mask.shape(flat);
  mask.endDraw();
  //image(mask, -20, -20, width+40, height+40);


  mask.loadPixels();
  corru = createShape();
  corru.beginShape(QUAD_STRIP);
  corru.stroke(#FADCBD);
  corru.fill(#AE9072);
  corru.strokeWeight(3);

  for (int i = 0; i < cD; i++) {
    //corru.fill((i%cP)*50);
    for (int scan = 0; scan < mask.height; scan++ ) {
      if (brightness(mask.pixels[i*mask.width/cD+scan*mask.width]) > 150) {
        corru.vertex(i*mask.width/cD, scan, 10*cH[i%cP]); 
        break;
      }
    }
    for (int scan = mask.height-1; scan >=0; scan--) {
      if (brightness(mask.pixels[i*mask.width/cD+scan*mask.width]) > 150) {
        corru.vertex(i*mask.width/cD, scan, 10*cH[i%cP]); 
        break;
      }
    }
  }
  corru.endShape(CLOSE);
  translate(-width/2, -height/2, 0);
  flat.setFill(#AE9072);
  flat.setStroke(#FADCBD);
  for (int i = -40; i < 42; i++) {
    pushMatrix();
    translate(0, 0, 20*i);
    pushMatrix();
    translate(mask.width/2, mask.height/2, 0);
    rotateZ((28*sin(frameCount*TWO_PI/720)+i*8)*TWO_PI/200);
    translate(-mask.width/2, -mask.height/2, 0);
    shape(corru);
    popMatrix();
    translate(mask.width/2, mask.height/2, 10);
    rotateZ((2*sin(frameCount*TWO_PI/720)+i)*TWO_PI/200);
    //shape(flat);
    ellipse(0,0,400,400);
    popMatrix();
  }
  if(frameCount< 720) saveFrame("render/####_manywalledtower.tif");
}