int Rd = 48;
int rd = 13;
int donutDetail = 16;

float phi = (sqrt(5)+1)/2 - 1; // golden ratio
float ga = phi*2*PI;           // golden angle

int nbrPoints = 24;

Donut[] carton = new Donut[nbrPoints];

PShape donutChunk, glazeChunk;

void setup() {
  size(600, 600, P3D); 

  for (int i= 0; i < nbrPoints; i++) {
    carton[i] = new Donut();
  }


  donutChunk = createShape();
  donutChunk.beginShape(QUAD_STRIP);
  donutChunk.noStroke();
  for (int j= 0; j < donutDetail+1; j++) {
    float beta = PI/donutDetail+j*TWO_PI/donutDetail;
    float alpha = TWO_PI/donutDetail;
    donutChunk.vertex((Rd-rd*cos(beta))*sin(alpha), (Rd-rd*cos(beta))*cos(alpha), rd*sin(beta));
    donutChunk.vertex((Rd-rd*cos(beta))*sin(alpha+TWO_PI/donutDetail), (Rd-rd*cos(beta))*cos(alpha+TWO_PI/donutDetail), rd*sin(beta));
  }
  donutChunk.endShape();

  glazeChunk  = createShape();
  glazeChunk.beginShape(QUAD_STRIP);
  glazeChunk.noStroke();
  glazeChunk.fill(#EF82FF);
  for (int j= 0; j < donutDetail/2; j++) {
    float beta = PI/donutDetail+j*TWO_PI/donutDetail;
    float alpha = TWO_PI/donutDetail;
    glazeChunk.vertex((Rd-rd*cos(beta))*sin(alpha), (Rd-rd*cos(beta))*cos(alpha), rd*sin(beta)+1);
    glazeChunk.vertex((Rd-rd*cos(beta))*sin(alpha+TWO_PI/donutDetail), (Rd-rd*cos(beta))*cos(alpha+TWO_PI/donutDetail), rd*sin(beta)+1);
  }
  glazeChunk.endShape();
}


void draw() {
  background(#FFBEEB);
  noStroke();
  fill(#573620);
  camera(-950*sin(frameCount*PI/360), -950*cos(frameCount*PI/360), 0, 
    0, 0, 00, 
    0, 0, -1.0);
  pushMatrix();
  rotateX(PI/2);
  pushMatrix();
  rotateZ(frameCount*PI/360);
  scale(1, 1, -1);
  donutRing();
  popMatrix();

  pushMatrix();
  translate(0, 0, 190);
  rotateY(PI/3);
  translate(0, 0, 300);
  rotateZ(frameCount*PI/360);
  donutRing();
  popMatrix();

  pushMatrix();
  translate(0, 0, 190);
  rotateY(-PI/3);
  translate(0, 0, 300);
  rotateZ(frameCount*PI/360);
  donutRing();
  popMatrix();
  pushMatrix();
  translate(00, 0, 400*sqrt(2));
  rotateX(PI/2);
  rotateZ(frameCount*PI/360);
  donutRing();
  popMatrix();
  pushMatrix();
  scale(1, 1, -1);
  pushMatrix();
  translate(0, 0, 190);
  rotateY(PI/3);
  translate(0, 0, 300);
  rotateZ(frameCount*PI/360);
  donutRing();
  popMatrix();

  pushMatrix();
  translate(0, 0, 190);
  rotateY(-PI/3);
  translate(0, 0, 300);
  rotateZ(frameCount*PI/360);
  donutRing();
  popMatrix();
  pushMatrix();
  translate(00, 0, 400*sqrt(2));
  rotateX(PI/2);
  rotateZ(frameCount*PI/360);
  donutRing();
  popMatrix();
  popMatrix();

  pushMatrix();
  translate(400, 0, 0);
  rotateX(PI/2);
  rotateZ(frameCount*PI/360);
  donutRing();
  popMatrix();

  pushMatrix();
  translate(-400, 0, 0);
  rotateX(PI/2);
  rotateZ(frameCount*PI/360);
  donutRing();
  popMatrix();
  popMatrix();
  println(frameRate + " : " + frameCount);

  if (frameCount >= 70 && frameCount <= 790)
    saveFrame("render/####_donutchain.tif");
  if ( frameCount > 790)noLoop();
}

void donutRing() {
  for (int i = 0; i < carton.length; i++) {
    pushMatrix();
    rotateZ(i*PI/(carton.length/2));
    translate(250, 0, 0);
    rotateY((i%2)*PI/2 + i*PI/carton.length + frameCount*PI/60f);
    rotateZ(frameCount*PI/180f);
    carton[i].render();
    popMatrix();
  }
}

class Donut {
  color[] donutColors = {
    #FFD18A, // vanilla donut
    #FF9188, 
    #573620  // chocolate donut
  };

  color[] sprinkleColors = {
    #FFFF33, // YELLOW
    #FF9421, // ORANGE
    #FF35D2, // PINK
    #3367FF, 
    #13F263, 
    #E6E8E8, 
    #FF3535
  };
  color[] glazeColors = {
    color(#42DEE8, 200), // blue raspberry
    color(#573620, 150), // chocolate donut
    color(#EF82FF, 150), // blurple
    color(#E6E8E8, 150)  // clear glaze
  };

  color[] drizzleColors = {
    color(#42DEE8, 150), 
    color(#573620, 150), 
    color(#FFD18A, 150), 
    color(#E6E8E8, 150)
  };

  int flav = int(random(donutColors.length));
  boolean isGlazed = int(random(4)) <= 2;
  int glaze = int(random(glazeColors.length));
  boolean isSprink = int(random(2)) == 0;
  Sprinkles[] load = new Sprinkles[100];

  Donut() {
    for (int i = 0; i < load.length; i++) {
      load[i] = new Sprinkles(color( sprinkleColors[ int(random(sprinkleColors.length)) ] ));
    }
  }

  void render() {
    for (int i = 0; i < donutDetail; i ++) {
      pushMatrix();
      rotateZ(i*TWO_PI/donutDetail);
      donutChunk.setFill(donutColors[flav]);
      shape(donutChunk);
      popMatrix();
    }
    if (isGlazed)
      for (int i = 0; i < donutDetail; i ++) {
        pushMatrix();
        rotateZ(i*TWO_PI/donutDetail);
        translate(0, 0, 1);
        glazeChunk.setFill(glazeColors[glaze]);
        shape(glazeChunk);
        popMatrix();
      }
    if (isSprink) 
      for (Sprinkles s : load) {
        s.render();
      }
  }
}

class Sprinkles {

  PVector pos = new PVector(random(Rd-rd/2, Rd+rd/2), random(2*PI), random(2*PI));
  color col;

  Sprinkles(color col) {
    this.col = col;
  }

  void render() {
    fill(col);
    noStroke();
    pushMatrix();
    translate(0, 0, rd+2);
    rotateZ(pos.y);
    translate(pos.x, 0, 0);
    rotateZ(pos.z);
    rect(0, 0, 4, 1);
    popMatrix();
  }
}

class Drizle {
}