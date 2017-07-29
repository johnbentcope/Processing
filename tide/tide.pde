import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

PostFX fx;

int grid = 20;

boolean render = true;

PGraphics canvas;
PGraphics bloom;

float period = 6;

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
  //canvas.noStroke();
  canvas.strokeWeight(2);
  canvas.stroke(255);
  canvas.background(#CCCCCC);
  canvas.camera(-75, 1500, 400, 
    400, 1500, 0, 
    0, 0, -1.0);

  for (int i = 0; i < 110; i++) {
    canvas.beginShape(QUAD_STRIP);
    for (int j = 0; j < 150; j++) {
      canvas.fill(lerpColor(#0D1D24,#78BAD4,noise((10+(i/4f))*(1+cos(radians((frameCount*6/period/2))))+i/160f, j/4f)));
      canvas.vertex(i*grid, j*grid, 50*noise((10+(i/4f))*(1+cos(radians((frameCount*6/period/2)))), j/4f));
      canvas.vertex((i+1)*grid, j*grid, 50*noise((10+((i+1)/4f))*(1+cos(radians((frameCount*6/period/2)))), j/4f));
    }
    canvas.endShape(CLOSE);
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

  if (render) {
    saveFrame("render/####-tide.tif");
    if (frameCount > 60*2*period) {
      noLoop();
    }
  }
}