import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

boolean render = true;

PostFX fx;

PGraphics canvas;
PGraphics bloom;

int step = 300;

void setup() {
  size(1200, 1200, P3D);

  fx = new PostFX(this);
  canvas = createGraphics(width, height, P3D);
  bloom = createGraphics(width, height, P3D);
  frameRate(60);
}

void draw() {
  background(0);
  canvas.smooth(5);
  canvas.beginDraw();
  canvas.blendMode(SCREEN);
  canvas.ortho();
  canvas.camera(900, 900, 900, 
    0, 0, 0, 
    0, 0, -1.0);
  canvas.background(#121014);
  canvas.noFill();
  canvas.strokeWeight(20);
  for (int s = 0; s < 4; s++) {
    canvas.pushMatrix();
    canvas.rotateZ((s)*frameCount*2*PI/1080);
    canvas.rotateY((s)*frameCount*2*PI/1080);
    canvas.rotateX((s)*frameCount*2*PI/1080);
    switch(s) {
    case 5:
      canvas.stroke(#FFCA00);
      break;
    case 1:
      canvas.stroke(#FF0000);
      break;
    case 2:
      canvas.stroke(#00FF00);
      break;
    case 3:
      canvas.stroke(#0000FF);
      break;
    case 4:
      canvas.stroke(#F4059E);
      break;
    }

    canvas.noFill();
    for (int l = 0; l <= s; l++) {
      canvas.box(step*(l), step*(s), step*(s));
      canvas.box(step*(s), step*(l), step*(s));
      canvas.box(step*(s), step*(s), step*(l));
    }
    canvas.fill(#1D1A21, 5);
    canvas.popMatrix();
    // canvas.line(-4*step, -4*step, 4*step, -4*step);
  }
  canvas.endDraw();


  blendMode(BLEND);
  fx.render(canvas)
    .blur(45, 45, false)
    .blur(45, 45, true)
    .compose(bloom);
  image(canvas, 0, 0);
  blendMode(ADD);
  image(bloom, 0, 0);

  println(frameCount);

  if (render) {
    saveFrame("render/####-evens.tif");
    if (frameCount > 1440) {
      noLoop();
    }
  }
}