import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

PostFX fx;

int grid = 20;

boolean render = false;

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
  canvas.noStroke();
  //canvas.strokeWeight(2);
  //canvas.stroke(255);
  canvas.background(#CCCCCC);
  canvas.camera(-75, 1500, 400, 
    400, 1500, 0, 
    0, 0, -1.0);

  for (int i = 0; i < 110; i++) {
    canvas.beginShape(QUAD_STRIP);
    for (int j = 0; j < 150; j++) {
      float locNoise = noise( i   /4f, j/4f)*(0.6+0.5*sin(frameCount*2*PI/720));
      float nbrNoise = noise((i+1)/4f, j/4f)*(0.6+0.5*sin(frameCount*2*PI/720));
      color f = color(255);
      float h = 0;
      float h2 = 0;
      if (locNoise > 0.1){
        h = map(locNoise,0.1,1,40,200);
        f = lerpColor(#7C7D5E,#153800,map(locNoise,0.1,1,0,1));
      } else {
        h = map(locNoise,0,0.1,0,40);
        f = lerpColor(#001325,#7C7D5E,map(locNoise,0,0.1,0,1));
      }
      if (nbrNoise>0.1){
        h2 = map(nbrNoise,0.1,1,40,200);
      } else {
        h2 = map(nbrNoise,0,0.1,0,40);
      }
      canvas.fill(f);
      canvas.vertex(i*grid, j*grid, h);
      canvas.vertex((i+1)*grid, j*grid,h2);
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
    saveFrame("render/####-breathe.tif");
    if (frameCount > 60*2*period) {
      noLoop();
    }
  }
}