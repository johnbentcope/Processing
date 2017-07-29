import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

PostFX fx;

PShape print;

PGraphics canvas;
PGraphics bloom;
PGraphics toon; 

int r = 200;
int c = 25;

PShape pizza, crust, bottom, cheese, topping, bean, pad;

void setup() {
  size(600, 600, P2D);

  fx = new PostFX(this);

  print = loadShape("print.svg");
  print.setFill(color(#E56289));

  canvas = createGraphics(width, height, P3D);
  bloom = createGraphics(width, height, P3D);
  toon = createGraphics(width, height, P3D);
}


void draw() {


  bottom = createShape();
  bottom.beginShape(TRIANGLE_FAN);
  bottom.vertex(0, 0);
  for (int t = 0; t < 30; t++) {
    bottom.vertex(r*sin(t*PI/120f), r*cos(t*PI/120f));
  }
  bottom.noStroke();
  bottom.endShape(CLOSE);
  bottom.setFill(color(#51BDBD));

  cheese = createShape();
  cheese.beginShape(TRIANGLE_FAN);
  cheese.vertex(0, 0);
  for (int t = 0; t < 30; t++) {
    cheese.vertex((r-c+5*cos(t*PI/5f + frameCount*PI/60f))*sin(t*PI/120f), (r-c+5*cos(t*PI/5f + frameCount*PI/60f))*cos(t*PI/120f));
  }
  cheese.noStroke();
  cheese.endShape(CLOSE);
  cheese.setFill(color(#70FF81));

  crust = createShape();
  crust.beginShape(QUAD_STRIP);
  for (int t = 0; t < 30; t++) {
    crust.vertex((r-c+5*cos(t*PI/5f + frameCount*PI/60f))*sin(t*PI/120f), (r-c+5*cos(t*PI/5f + frameCount*PI/60f))*cos(t*PI/120f));
    crust.vertex(r*sin(t*PI/120f), r*cos(t*PI/120f));
  }
  crust.noStroke();
  crust.endShape(CLOSE);
  crust.setFill(color(#FF997D));

  pad = createShape();
  pad.beginShape();
  pad.vertex(0, 20);
  pad.bezierVertex(20, 20, 20, 0, 40, 0);
  pad.bezierVertex(70, 00, 50, 50, 0, 50);
  pad.bezierVertex(-50, 50, -70, 0, -40, 0);
  pad.bezierVertex(-20, 0, -20, 20, 0, 20);

  pad.noStroke();
  pad.endShape(CLOSE);
  pad.setFill(color(#E5A1B5));

  canvas.beginDraw();
  canvas.fill(#E5A1B5);
  canvas.noStroke();
  canvas.camera(-300, 0, 300, 
    -50, 0, 0, 
    0, 0, -1.0);
  canvas.background(#AC6BC7);
  for (int i = 0; i < 6; i++) {
    canvas.pushMatrix();
    canvas.rotateZ(i*PI/3 + -frameCount*PI/720f);
    canvas.shape(cheese);
    canvas.translate(0, 0, -10);
    canvas.shape(bottom);
    canvas.translate(0, 0, 20);
    canvas.shape(crust);
    canvas.pushMatrix();
    canvas.rotateZ(PI*0.22);
    canvas.translate(0, 120, -10);
    canvas.scale(0.5);
    canvas.pushMatrix();
    canvas.rotateZ(PI);
    canvas.translate(0, 30, 20);
    canvas.rotateX(-PI/10);
    canvas.translate(-55, -70, 0);
    canvas.scale(0.25);
    canvas.shape(print);
    canvas.popMatrix();
    canvas.popMatrix();
    canvas.popMatrix();
  }
  canvas.endDraw();

  fx.render(canvas)
    //.sobel()
    .bloom(0, 20, 30)
    .compose();
  
  saveFrame("####_pizza.tif");
  if (frameCount > 60*24) noLoop();
}