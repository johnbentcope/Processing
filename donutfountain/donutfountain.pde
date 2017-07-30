int Rd = 48;
int rd = 13;
int donutDetail = 16;

float phi = (sqrt(5)+1)/2 - 1; // golden ratio
float ga = phi*2*PI;           // golden angle

int haloPoints = 18;
int haloPeriod = 67;
int haloTurns = 3;

Donut[] carton = new Donut[haloPeriod];
Donut mother;

PShape donutChunk, glazeChunk;

void setup() {
  size(600, 600, P3D); 

  for (int i= 0; i < haloPeriod; i++) {
    carton[i] = new Donut();
  }
  mother = new Donut();

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
  mother.flav = 2;
  mother.isGlazed = true;
  mother.glaze = 3;
  mother.isSprink = true;
}


void draw() {
  background(#FFBEEB);
  noStroke();
  fill(#573620);
  camera(
    // -400, 0, 200, 
    -300*sin(frameCount*PI/360f), -300*cos(frameCount*PI/360f), 200, 
    0, 0, -80, 
    0, 0, -1.0);

  pushMatrix();
  scale(3, 3, 3);
  mother.render();
  popMatrix();

  for (int i = 0; i < haloTurns; i++) {
    for (int j = 0; j < haloPoints; j++) {
      pushMatrix();
      rotateZ(i*TWO_PI/haloTurns + j*TWO_PI/haloPoints/haloTurns);
      translate(Rd *3, 0, 0);
      rotateY(j*TWO_PI/haloPoints+frameCount*PI/60f);
      translate(Rd*1.6, 0, 0);
      rotateY((frameCount+j)*PI/15f);
      scale(0.25, 0.25, - 0.25);
      carton[(i*haloPoints+j)%haloPeriod].render();
      popMatrix();
    }
  }


  for (int i = 0; i < haloTurns; i++) {
    for (int j = 0; j < haloPoints; j++) {
      pushMatrix();
      rotateZ(i*TWO_PI/haloTurns + j*TWO_PI/haloPoints/haloTurns+PI/6);
      translate(Rd *3, 0, 0);
      rotateY(j*TWO_PI/haloPoints+frameCount*PI/60f);
      translate(Rd*1.6, 0, 0);
      rotateY((frameCount-j)*PI/20f);
      scale(0.25, 0.25, 0.25);
      carton[(i*haloPoints+j)%haloPeriod].render();
      popMatrix();
    }
  }

  for (int i = 0; i < haloTurns; i++) {
    for (int j = 0; j < haloPoints; j++) {
      pushMatrix();
      rotateZ(i*TWO_PI/haloTurns + j*TWO_PI/haloPoints/haloTurns+10*PI/6);
      translate(Rd *3, 0, 0);
      rotateY(j*TWO_PI/haloPoints+frameCount*PI/60f);
      translate(Rd*1.6, 0, 0);
      rotateZ(i*TWO_PI/haloTurns + j*TWO_PI/haloPoints/haloTurns+10*PI/6);
      rotateY((frameCount+j)*PI/15f);
      scale(0.25, 0.25, -0.25);
      carton[(i*haloPoints+j)%haloPeriod].render();
      popMatrix();
    }
  }

  for (int i = 0; i < haloTurns; i++) {
    for (int j = 0; j < haloPoints; j++) {
      pushMatrix();  
      rotateZ(i*TWO_PI/haloTurns + j*TWO_PI/haloPoints/haloTurns+3*PI/6);
      translate(Rd *3, 0, 0);
      rotateY(j*TWO_PI/haloPoints+frameCount*PI/60f);
      translate(Rd*1.6, 0, 0);
      rotateY((frameCount-2*j)*PI/30f);
      scale(0.25, 0.25, 0.25);
      carton[(i*haloPoints+j)%haloPeriod].render();
      popMatrix();
    }
  }

  println(frameCount + " + " + frameRate);
  saveFrame("render/####_donutfountain.tif");
  if (frameCount > 720) noLoop();
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
    //isSprink = false;
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

  PVector pos = new PVector(random(Rd-rd, Rd+rd), random(2*PI), random(2*PI));
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