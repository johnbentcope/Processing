PGraphics damask;

void setup() {
  size(600, 600, P2D);
  colorMode(HSB);
  blendMode(SCREEN);
}

void draw() {
  background(51);
  for(int i = 0 ; i < ceil(width*sqrt(2)); i++){
    float col = i/10f+60;
    noFill();
    stroke(col,255,150);
    ellipse(width/2,height/2,i,i);
  }
  damask = createGraphics(75, 100, P2D);
  damask.beginDraw();
  damask.clear();
  damask.background(255);
  damask.noStroke();
  damask.fill(0);
  //damask.ellipse(0, 0, 20, 20);
  //damask.ellipse(damask.width, damask.height, 20, 20);
  //damask.ellipse(0, damask.height, 20, 20);
  //damask.ellipse(damask.width, 0, 20, 20);
  tendril();
  
  for (int i = 0 ; i < 12; i++){
    damask.pushMatrix();
    
    damask.translate(damask.width,0);
    damask.rotate(i*PI/6-frameCount*PI/480f);
    damask.translate(10,0);
    damask.ellipse(0,0,10,4);
    
    damask.popMatrix();
  }
  damask.fill(255);
  damask.stroke(0);
  damask.strokeWeight(3);
  damask.line(damask.width-30,damask.height,damask.width,damask.height-30);
  damask.line(damask.width-40,damask.height,damask.width,damask.height-40);
  damask.line(damask.width-40,damask.height,damask.width,damask.height-40);
  damask.ellipse(damask.width,damask.height,30,60);
  damask.fill(0);
  damask.strokeWeight(6);
  damask.pushMatrix();
  damask.translate(damask.width,damask.height);
  damask.rotate(-frameCount*PI/120f);
  damask.ellipse(0,0,30,15);
  damask.popMatrix();
  damask.fill(255);
  damask.strokeWeight(1);
  damask.pushMatrix();
  damask.translate(damask.width,damask.height);
  damask.rotate(frameCount*PI/120f);
  damask.ellipse(0,0,7,15);
  damask.popMatrix();
  
  damask.noStroke();
  damask.fill(0);
  damask.beginShape(TRIANGLE_FAN);
  damask.vertex(0,0);
  for(int i = 0; i < 13; i++){
    damask.vertex((40+5*sin(i*PI/2+frameCount*PI/120f))*cos(i*PI/24),(40+5*sin(i*PI/2+frameCount*PI/120f))*sin(i*PI/24));
  }
  damask.endShape(CLOSE);
  damask.noFill();
  damask.stroke(0);
  damask.strokeWeight(3);
  damask.beginShape();
  damask.vertex(20,90);;
  damask.bezierVertex(20,80,40,80,40,70);
  damask.endShape();
  
  damask.beginShape();
  damask.vertex(20,80);;
  damask.bezierVertex(20,70,40,70,40,60);
  damask.endShape();
  damask.beginShape();
  damask.vertex(20,100);;
  damask.bezierVertex(20,90,40,90,40,80);
  damask.endShape();
  damask.noStroke();
  damask.fill(255);
  damask.beginShape(TRIANGLE_FAN);
  damask.vertex(0,0);
  for(int i = 0; i < 13; i++){
    damask.vertex((20+5*-sin(i*PI/2-frameCount*PI/120f))*cos(i*PI/24),(20+5*-sin(i*PI/2-frameCount*PI/120f))*sin(i*PI/24));
  }
  damask.endShape(CLOSE);
  
  damask.pushMatrix();
  damask.translate(40,20);
  damask.pushMatrix();
  damask.rotate(PI/10);
  leafy();
  damask.popMatrix();
  damask.translate(-5,15);
  damask.pushMatrix();
  damask.rotate(PI/10);
  leafy();
  damask.popMatrix();
  damask.popMatrix();
  
  damask.endDraw();
  for (int i = 0; i < width/damask.width; i++) {
    for (int j = 0; j < height/damask.height; j++) {
      pushMatrix();
      translate(i*damask.width, j*damask.height);
      if (i %2 == 1) {
        translate(damask.width, 0);
        scale(-1, 1);
      }      if (j %2 == 1) {
        translate(0, damask.height);
        scale(1, -1);
      }
      image(damask, 0, 0);
      popMatrix();
    }
  }
  if(frameCount <= 720) saveFrame("render/####_damask.tif");
}

void tendril() {
  damask.pushMatrix();
  damask.translate(0, damask.height);
  damask.rotate(-PI/4);
  damask.rotate(0.5 + 0.1*sin(frameCount*PI/360f));
  leafy();
  damask.translate(2, -25);
  damask.rotate(0.5 + 0.1*sin(frameCount*PI/360f));
  leafy();
  damask.translate(2, -25);
  damask.rotate(0.5 + 0.1*sin(frameCount*PI/360f));
  leafy();
  damask.translate(2, -25);
  damask.rotate(0.5 + 0.1*sin(frameCount*PI/360f));
  leafy();
  damask.popMatrix();
}

void leafy() {
  damask.fill(0);
  damask.noStroke();
  damask.pushMatrix();
  damask.beginShape();
  damask.vertex(0, 0);
  damask.bezierVertex(18, 0, 18, -20, +20, -20);
  damask.bezierVertex(2, -20, +2, 0, 0, 0);
  damask.endShape(CLOSE);
  damask.popMatrix();
}