PShape straw, smoothie;
int strawRad = 10;
float smoothieRad = 100.1;

void setup() {
  size(600, 600, P3D);

  ortho();
  straw = createShape();
  straw.beginShape(QUAD_STRIP);
  straw.noStroke();
  straw.fill(#FFCB00);
  for (int i = 0; i <= 16; i++) {
    int j = i+1;
    if (i%8 < 4 ) {
      straw.fill(#FF0000);
    } else {
      straw.fill(255);
    }
    straw.vertex(strawRad*sin(i*PI/8f), strawRad*cos(i*PI/8f), 0);
    straw.vertex(strawRad*sin(j*PI/8f), strawRad*cos(j*PI/8f), 10);
  }
  straw.endShape(CLOSE);

  smoothie = createShape();
  smoothie.beginShape(QUAD_STRIP);
  smoothie.noStroke();
  for (int i = 0; i <= 32; i++) {


    smoothie.vertex(smoothieRad*sin(i*PI/16f), smoothieRad*cos(i*PI/16f), 0);
    smoothie.vertex(smoothieRad*sin(i*PI/16f), smoothieRad*cos(i*PI/16f), 500+5*sin(i*PI/8));
  }
  smoothie.endShape(CLOSE);

  frameRate(30);
  ellipseMode(CENTER);
}

void draw() {
  background(#3CAFCC);
  camera(300, 900, 300, 
    300, 0, 300, 
    0, 0, -1.0);
  for (int c = 0; c < 3; c++) {
    pushMatrix();
    translate(100+200*c, 0, 0);
    for (int i = 0; i < 60; i++) {
      pushMatrix();
      rotateZ(-i*PI/8 + frameCount*PI/90);
      translate(0, 0, i*10);
      shape(straw);
      popMatrix();
    }
    pushMatrix();
    rotateZ(-frameCount*PI/90 + (c-2)*PI/4);
    translate(0, 0, -100-50*cos(  abs(c-1)*PI/2+ frameCount*PI/180f));
    switch(c) {
    case 0:
      smoothie.setFill(#D63AB7);
      break;
    case 1:
      smoothie.setFill(#A6FF7D);
      break;
    case 2:
      smoothie.setFill(#FF4F4F);
      break;
    case 3:
      smoothie.setFill(#F4FFE5);
      break;
    case 4:
      smoothie.setFill(#FFC012);
      break;
    }
    shape(smoothie);
    popMatrix();
    pushMatrix();
    noFill();
    stroke(255);
    strokeWeight(3);
    translate(0, 0, 500 /*+50*(sin(2*abs(c-1)*PI/3+frameCount*PI/120f))*/);
    ellipse(0, 0, 200, 200);    
    line(-100, 20, 1, -100, 20, -600);    
    line(100, 20, 1, 100, 20, -600);
    translate(0, 0, -20);
    ellipse(0, 0, 200, 200);    
    translate(0, 0, -20);
    ellipse(0, 0, 200, 200);    
    translate(0, 0, -20);
    ellipse(0, 0, 200, 200);  
    translate(0, 0, -100);
    ellipse(0, 0, 200, 200);   
    translate(0, 0, -20);
    ellipse(0, 0, 200, 200);    
    translate(0, 0, -20);
    ellipse(0, 0, 200, 200);
    translate(0, 0, -100);
    ellipse(0, 0, 200, 200);   
    translate(0, 0, -20);
    ellipse(0, 0, 200, 200);    
    translate(0, 0, -20);
    ellipse(0, 0, 200, 200);
    translate(0, 0, -100);
    ellipse(0, 0, 200, 200);   
    translate(0, 0, -20);
    ellipse(0, 0, 200, 200);    
    translate(0, 0, -20);
    ellipse(0, 0, 200, 200);
    popMatrix();
    popMatrix();
  }


  println(frameRate + " + " + frameCount);
  if (frameCount < 720) saveFrame("####_smoothies.tif");
}