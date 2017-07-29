import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

PostFX fx;

boolean render = true;

PGraphics canvas;
PGraphics bloom;


Bean[] beans = new Bean[200];

void setup() {
  size(1200, 1200, P3D);

  fx = new PostFX(this);

  canvas = createGraphics(width, height, P3D);
  bloom = createGraphics(width, height, P3D);

  frameRate(60);

  for (int i = 0; i < beans.length; i++) {
    int posneg = Math.random() < 0.5 ? -1 : 1;
    beans[i] = new Bean(new PVector( i * 30, 30 * sqrt(i), ceil(random(3)) * posneg));
  }
  //colorMode(HSB);
}

void draw() {
  background(0);

  canvas.smooth(5);
  canvas.beginDraw();
  canvas.noStroke();
  canvas.camera(-200, -200, 300, 
    600, 600, -50, 
    0, 0, -1.0);
  //canvas.ortho();
  canvas.lights();
  canvas.fill(0);
  canvas.background(#563BA9);

  for (Bean b : beans) {
    b.render();
  }

  canvas.endDraw();

  blendMode(BLEND);
  fx.render(canvas)
    .blur(15, 15, false)
    .blur(15, 15, true)
    .compose(bloom);
  image(canvas, 0, 0);
  blendMode(SCREEN);
  image(bloom, 0, 0);

  if (render && frameCount != 1) {
    saveFrame("render/####-tumble.tif");
    if (frameCount > 60*6+1) {
      noLoop();
    }
  }
}