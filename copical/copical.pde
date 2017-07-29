
boolean render = true;
void setup() {
  size(1200, 1200, P3D);
  smooth(5);
}

void draw() {
  background(220);
  stroke(#F08F34, 100);
  strokeWeight(30);
  beginShape();

  blendMode(MULTIPLY);
  noFill();
  for (float i = 1; i < 32; i++) {
    vertex(100+1*i*i, 300+i/2);
    vertex(130+1*i*i, height-300-i);
  }
  endShape();
  stroke(29);
  strokeWeight(8);
  strokeCap(ROUND);

  pushMatrix();
  translate(width/2, height/2, 200);
  rotateX(-PI/12);
  rotateY(frameCount*PI/720);
  blendMode(BLEND);
  fill(#F5FCFF);
  box(300);
  noStroke();
  fill(#8CC7D9, 20);
  blendMode(MULTIPLY);
  for (int f = 0; f < 4; f++) {
    pushMatrix();
    rotateY(f*PI/2);
    pushMatrix();
    translate(0, 0, 164);
    for (int i = 0; i < 16; i+=2) {
      beginShape(QUAD);
      vertex(-155, -150+1*i*i, 1*i*0.1);
      vertex(155, -150+1*(1+i)*(1+i), 1*i*0.1);
      vertex(155, -150+1*(1+i)*(1+i)+10, 1*i*0.1);
      vertex(-155, -150+1*i*i+10, 1*i*0.1);
      endShape();
    }
    popMatrix();
    pushMatrix();
    translate(0, 0, 162);
    for (int i = 1; i < 16; i+=2) {
      beginShape(QUAD);
      vertex(155, -150+1*i*i, 1*i*0.1);
      vertex(-155, -150+1*(1+i)*(1+i), 1*i*0.1);
      vertex(-155, -150+1*(1+i)*(1+i)+10, 1*i*0.1);
      vertex(155, -150+1*i*i+10, 1*i*0.1);
      endShape();
    }
    popMatrix();
    popMatrix();
  }
  popMatrix();


  blendMode(BLEND);
  noFill();


  stroke(29);
  bezier(100, 300, 500, 320, 700, 320, 1100, 300);
  pushMatrix();
  translate(7, 5);
  strokeWeight(4);
  rotate(PI/198);
  stroke(28, 50);
  bezier(100, 300, 500, 320, 700, 320, 1100, 300);
  translate(-17, -15);
  rotate(-PI/128);
  stroke(29, 100);
  bezier(100, 300, 500, 320, 700, 320, 1100, 300);

  popMatrix();

  stroke(29);
  strokeWeight(8);

  bezier(100, height-300, 500, height-320, 700, height-320, 1100, height-300);
  pushMatrix();
  translate(7, 5);
  strokeWeight(4);
  rotate(PI/128);
  stroke(28, 50);
  bezier(100, height-300, 500, height-320, 700, height-320, 1100, height-300);
  translate(-7, 5);
  rotate(-PI/128);
  stroke(29, 100);
  bezier(100, height-300, 500, height-320, 700, height-320, 1100, height-300);
  popMatrix();

  stroke(29, 20);
  strokeWeight(2);
  ellipse(200, 160, 300, 300);
  strokeWeight(4);
  pushMatrix();
  translate(-100, -100);
  rotate(PI/30);
  line(500, 250, 700, 250);
  line(510, 255, 680, 250);
  fill(29, 20);
  beginShape();
  vertex(700, 250);
  vertex(680, 240);
  vertex(680, 260);
  endShape();
  popMatrix();
  stroke(29, 20);
  pushMatrix();
  translate(width/2, height/2+300);
  rotate(PI/2.5);
  ellipse(0, 0, 200, 400);
  popMatrix();
  rect(50, height-250, 50, 200);
  fill(29, 15);
  rect(110, height-250, 50, 200);
  fill(29, 10);
  rect(170, height-250, 50, 200);
  fill(29, 5);
  rect(230, height-250, 50, 200);
  noFill();
  strokeWeight(2);
  ellipse(width-200, height-160, 300, 300);
  for (int i = 0; i < 10; i++) {
    pushMatrix();
    strokeWeight(i*0.1);
    translate(950+5*i, 150+5*i);
    rotateX(PI/10);
    rotateY(PI/10);
    box(10, 50, 100);
    popMatrix();
  }
  
  if (render) {
    saveFrame("render/####-copical.tif");
    if (frameCount > 60*32) {
      noLoop();
    }
  }
}