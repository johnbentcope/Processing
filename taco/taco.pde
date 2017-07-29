int foodBowlRadius = 15;
int collarRadius = 25;
int tacoRadius = 15;
int collarThicc = 8;

PShape bowlChunk, collarChunk, spike, shell;
int bowlFaces = 20;
int collarFaces = 40;
int tacoEdges = 30;

void setup() {
  size(600, 600, P3D);

  bowlChunk = createShape();
  bowlChunk.beginShape(QUAD_STRIP);
  bowlChunk.noStroke();
  bowlChunk.fill(200);

  float beta = PI/(bowlFaces/2);
  float alpha = 0;
  bowlChunk.vertex(0, 0, 1);
  bowlChunk.vertex(0, 0, 1);

  bowlChunk.vertex(foodBowlRadius*sin(beta), foodBowlRadius*cos(beta), 1);
  bowlChunk.vertex(foodBowlRadius*sin(alpha), foodBowlRadius*cos(alpha), 1);

  bowlChunk.fill(#F2D9F1);

  bowlChunk.vertex(foodBowlRadius*sin(beta), foodBowlRadius*cos(beta), 1);
  bowlChunk.vertex(foodBowlRadius*sin(alpha), foodBowlRadius*cos(alpha), 1);

  bowlChunk.vertex((foodBowlRadius+1)*sin(beta), (foodBowlRadius+1)*cos(beta), 5);
  bowlChunk.vertex((foodBowlRadius+1)*sin(alpha), (foodBowlRadius+1)*cos(alpha), 5);

  bowlChunk.vertex((foodBowlRadius+2)*sin(beta), (foodBowlRadius+2)*cos(beta), 5);
  bowlChunk.vertex((foodBowlRadius+2)*sin(alpha), (foodBowlRadius+2)*cos(alpha), 5);

  bowlChunk.vertex((foodBowlRadius+3)*sin(beta), (foodBowlRadius+3)*cos(beta), 1);
  bowlChunk.vertex((foodBowlRadius+3)*sin(alpha), (foodBowlRadius+3)*cos(alpha), 1);

  bowlChunk.fill(0);

  bowlChunk.vertex((foodBowlRadius+3)*sin(beta), (foodBowlRadius+3)*cos(beta), 1);
  bowlChunk.vertex((foodBowlRadius+3)*sin(alpha), (foodBowlRadius+3)*cos(alpha), 1);

  bowlChunk.vertex((foodBowlRadius+4)*sin(beta), (foodBowlRadius+4)*cos(beta), 0);
  bowlChunk.vertex((foodBowlRadius+4)*sin(alpha), (foodBowlRadius+4)*cos(alpha), 0);

  bowlChunk.endShape();

  collarChunk = createShape();
  beta = PI/(collarFaces/2);
  collarChunk.beginShape(QUAD_STRIP);
  collarChunk.noStroke();
  collarChunk.fill(#29110C);
  collarChunk.vertex(collarRadius*cos(beta), collarRadius*sin(beta), collarThicc/2);
  collarChunk.vertex(collarRadius*cos(alpha), collarRadius*sin(alpha), collarThicc/2);

  collarChunk.vertex(collarRadius*cos(beta), collarRadius*sin(beta), -collarThicc/2);
  collarChunk.vertex(collarRadius*cos(alpha), collarRadius*sin(alpha), -collarThicc/2);


  collarChunk.fill(#D1A196);
  collarChunk.vertex((collarRadius-1)*cos(beta), (collarRadius-1)*sin(beta), -collarThicc/2);
  collarChunk.vertex((collarRadius-1)*cos(alpha), (collarRadius-1)*sin(alpha), -collarThicc/2);

  collarChunk.vertex((collarRadius-1)*cos(beta), (collarRadius-1)*sin(beta), collarThicc/2);
  collarChunk.vertex((collarRadius-1)*cos(alpha), (collarRadius-1)*sin(alpha), collarThicc/2);

  collarChunk.fill(#29110C);
  collarChunk.vertex(collarRadius*cos(beta), collarRadius*sin(beta), collarThicc/2);
  collarChunk.vertex(collarRadius*cos(alpha), collarRadius*sin(alpha), collarThicc/2);
  collarChunk.endShape();

  shell = createShape();
  shell.beginShape(TRIANGLE_FAN);
  shell.noStroke();
  shell.fill(#FFCB00);
  shell.vertex(0, 0, 0);
  for (int e = 0; e <= tacoEdges; e++) {
    shell.vertex(tacoRadius*cos(e*PI/tacoEdges), 0, tacoRadius*sin(e*PI/tacoEdges));
  }
  shell.endShape();

  spike = createShape();
  spike.beginShape(TRIANGLE_FAN);
  spike.noStroke();
  spike.fill(245);
  spike.vertex(3+collarRadius, 0, 0);
  spike.vertex(collarRadius, -1, -1);
  spike.vertex(collarRadius, 1, -1);
  spike.vertex(collarRadius, 1, 1);
  spike.vertex(collarRadius, -1, 1);
  spike.vertex(collarRadius, -1, -1);
  spike.endShape();

  camera(100, 100, 100, 
    0, 0, 0, 
    0, 0, -1.0);
}

void draw() { 
  noLights();
  background(#F2ADD1);
  camera(55, -55, 25, 
    0, 0, 0, 
    0, 0, -1.0);
  for (int i = 0; i < bowlFaces; i++) {
    pushMatrix();
    rotateZ(i*PI/(bowlFaces/2) + frameCount*PI/720);
    shape(bowlChunk);
    translate(foodBowlRadius+3, 0, 3);
    rotateY(radians(75));
    fill(#F2BCF1);
    noStroke();
    ellipse(0, 0, 3, 3);
    popMatrix();
  }

  pushMatrix();
  rotateX(frameCount *PI / 90f);
  rotateZ(frameCount *PI /180f);
  rotateY(frameCount *PI / 360f);
  for (int i = 0; i < collarFaces; i++) {
    pushMatrix();
    rotateZ(i*PI/(collarFaces/2));
    shape(collarChunk);
    if (i < collarFaces-3 && i%2 ==0) {
      shape(spike);
    } 
    if (i == collarFaces-3) {
      translate(collarRadius, 0, -4);
      noFill();
      stroke(200);
      strokeWeight(5);
      pushMatrix();
      rotateY(-PI/2);
      rect(0, 0, 8, 8);
      popMatrix();
      translate(-0.5, 0, 4);
      line(0, 0, 0, 1, 8, 0);
    }
    popMatrix();
  }
  popMatrix();

  renderTaco();
  println(frameRate + " : " + frameCount);
  saveFrame("render/####-taco.tif");
  if( frameCount >= 720) noLoop();
}

void renderTaco() {
  pushMatrix();
  translate(-5, 0, 5);
  rotateY(PI/12f);
  renderMeat();
  renderLettuce();
  pushMatrix();
  rotateX(PI/8);
  shape(shell);
  popMatrix();
  pushMatrix();
  rotateX(-PI/8);
  shape(shell);
  popMatrix();

  popMatrix();
}

void renderTomato() {

  for (int i = 0; i < 14; i++) {
    pushMatrix();
    translate(-11+2*i, 0, 9);
    if (i%2 == 0) translate(0, -2, 0);

    noStroke();
    fill(#F52B29);
    rotateX(PI/8);
    rotateZ(PI/6);
    rect(0, 0, 1, 1);
    popMatrix();
  }
}

void renderLettuce() {

  for (int i = 0; i < 7; i++) {
    pushMatrix();
    translate(-7+3*i, 0, 10);
    //noStroke();
    stroke(0);
    strokeWeight(5);
    fill(#C5E50E);
    //rotateZ(PI/6);
    rotateX(frameCount*PI/360f - i*PI/2);
    stroke(#F52B29);
    line(0, -2, 0, 3, 0, 2);
    stroke(#C5E50E);
    line(0, 0, 2, 3, 2, 0);
    stroke(#FFFFFF);
    line(0, 2, 0, 3, 0, -2);
    stroke(#7F2D04);
    line(0, 0, -2, 3, -2, 0);
    //rect(0, -2.5, 1, 5);
    popMatrix();
  }
}

void renderMeat() {
  lights();
  for (int i = 0; i < 7; i++) {
    pushMatrix();
    translate(-10+4*i, 0, 5.5);
    rotateY(PI/3);
    rotateX(PI/4);
    noStroke();
    fill(#D96B52);
    sphere(2);
    popMatrix();
  }
  noLights();
}