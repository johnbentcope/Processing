import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

PostFX fx;

PGraphics canvas;
PGraphics birbs;
PGraphics bloom;

int birbCount = 5;
boolean render = true;
void setup() {
  size(600, 600, P3D);
  fx = new PostFX(this);


  canvas = createGraphics(width, height, P2D);
  birbs = createGraphics(width, height, P3D);
  bloom = createGraphics(width, height, P3D);
}

void draw() {
  canvas.beginDraw();
  canvas.noStroke();
  canvas.background(#73E4F5);
  canvas.fill(#FF76B9);
  canvas.pushMatrix();
  canvas.translate(200, 200);
  canvas.ellipse(0, 0, 200, 200);
  canvas.popMatrix();
  canvas.fill(#6FAAB2);
  canvas.loadPixels();
  canvas.rect(0, 3*height/5, width, height);
  canvas.translate(0, 3*height/5);
  for (int i = 0; i < width/21; i ++ ) {
    for (int j = 0; j < height/10; j++) {
      canvas.fill(canvas.pixels[(i +int(5*(2+sin(j*20 + frameCount*2*PI/360f)))) * 11 + (j+12)*5*width], 150);
      canvas.rect(i*22, j*4, 22, 4);
    }
  }
  canvas.endDraw();

  birbs.smooth(5);
  birbs.beginDraw();
  birbs.clear();
  birbs.noStroke();
  birbs.stroke(#FFF390);
  birbs.fill(#FFF390);
  //birbs.ellipse(0,0,10,10);
  birbs.camera(-100, 300, 100, 
    0, 0, 50, 
    0, 0, -1.0);
  for (int i = 0; i < birbCount; i++) {
    birbs.pushMatrix();
    birbs.rotateZ(2*i*PI/birbCount + frameCount*2*PI/1440f);
    birbs.translate(0, 100, 150);

    birbs.pushMatrix();
    birbs.scale(1, 1, 1);
    birbs.noStroke();
    birbs.beginShape(QUADS);
    birbs.noStroke();
    birbs.vertex(0, 0, 0);
    birbs.vertex(20, 0, 0);
    birbs.vertex(17, 20, 5);
    birbs.vertex(3, 20, 5);
    birbs.endShape();
    birbs.noStroke();
    birbs.beginShape(TRIANGLE);
    birbs.vertex(17, 20, 5);
    birbs.vertex(10, 35, 2);
    birbs.vertex(3, 20, 5);
    birbs.endShape();
    birbs.popMatrix();

    birbs.pushMatrix();
    birbs.scale(1, -1, 1);
    birbs.beginShape(QUADS);
    birbs.vertex(0, 0, 0);
    birbs.vertex(20, 0, 0);
    birbs.vertex(17, 20, 5);
    birbs.vertex(3, 20, 5);
    birbs.endShape();
    birbs.noStroke();
    birbs.beginShape(TRIANGLE);
    birbs.vertex(17, 20, 5);
    birbs.vertex(10, 35, 2);
    birbs.vertex(3, 20, 5);
    birbs.endShape();
    birbs.popMatrix();

    birbs.popMatrix();
  }
  birbs.endDraw();

  blendMode(BLEND);
  fx.render(birbs)
    .blur(1, 15, false)
    .blur(1, 15, true)
    .compose();
  fx.render(canvas)
    .blur(15, 15, false)
    .blur(15, 15, true)
    .compose(bloom);
  image(canvas, 0, 0);
  image(birbs, 0, 0);
  blendMode(SCREEN);
  image(bloom, 0, 0);

  if (render) {
    saveFrame("render/####-bubblegum.tif");
    if (frameCount > 1440) {
      noLoop();
    }
  }
}


void render() {
  wing(1);
  wing(-1);
}

void wing(int scale) {
  birbs.pushMatrix();
  birbs.scale(6, 6*scale,6);
  birbs.noStroke();
  birbs.beginShape(QUADS);
  birbs.noStroke();
  birbs.vertex(0, 0, 0);
  birbs.vertex(20, 0, 0);
  birbs.vertex(17, 20, 5);
  birbs.vertex(3, 20, 5);
  birbs.endShape(CLOSE);
  birbs.noStroke();
  birbs.beginShape(TRIANGLE);
  birbs.vertex(17, 20, 5);
  birbs.vertex(10, 35, 2);
  birbs.vertex(3, 20, 5);
  birbs.endShape(CLOSE);
  birbs.popMatrix();
  //canv.ellipse(10,10,20,20);
}