import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;
import codeanticode.syphon.*;
import ddf.minim.*;

Minim minim;
AudioInput in;

SyphonServer server1;

PostFX fx;

PGraphics canvas;
PGraphics bloom;


int grid = 5;
int seed = floor(random(10000));
boolean render = false;

void settings() {
  size(400,400, P3D);
  PJOGL.profile=1;
}
void setup() {
  size(1200, 1200, P3D);
  fx = new PostFX(this);
server1 = new SyphonServer(this, "Processing Syphon 4");

  minim = new Minim(this);

  canvas = createGraphics(width, height, P3D);
  bloom = createGraphics(width, height, P3D);
  frameRate(60);
  noiseSeed(8925);
  println(seed);
  in = minim.getLineIn();
}


void draw() {
  background(#89CBE0);

  canvas.smooth(5);
  canvas.beginDraw();
  canvas.background(#89CBE0);
  canvas.camera(250, 1000, 300, 
    250, 250, 200, 
    0, 0, -1);
  canvas.noStroke();
 canvas.fill(255);
  canvas.noStroke();
  canvas.lights();
  for (int i = 0; i < 100; i++) {
    for (int j = 0; j < 100; j++) {
      canvas.beginShape(QUAD);
      canvas.vertex(grid*i, grid*j, getz(i, j, true, false, false));
      canvas.vertex(grid*(i+1), grid*j, getz((i+1), j, true, false, false));
      canvas.vertex(grid*(i+1), grid*(j+1), getz((i+1), (j+1), true, false, false));
      canvas.vertex(grid*i, grid*(j+1), getz(i, (j+1), true, false, false));
      canvas.endShape();
      if (j == 99) {

        canvas.beginShape(QUAD);
        canvas.vertex(grid*i, grid*(j+1), getz(i, (j+1), true, true, false));
        canvas.vertex(grid*(i+1), grid*(j+1), getz((i+1), (j+1), true, true, false));
        canvas.vertex(grid*(i+1), grid*(j+1), 0);
        canvas.vertex(grid*i, grid*(j+1), 0);
        canvas.endShape();
      }
    }
  }

  for (int i = 0; i < 100; i++) {
    for (int j = 0; j < 100; j++) {
      canvas.beginShape(QUAD);
      canvas.vertex(grid*i, grid*j, getz(i, j, false, false, false)+in.left.get(0)*30);
      canvas.vertex(grid*(i+1), grid*j, getz((i+1), j, false, false, false)+in.left.get(0)*30);
      canvas.vertex(grid*(i+1), grid*(j+1), getz((i+1), (j+1), false, false, false)+in.left.get(0)*30);
      canvas.vertex(grid*i, grid*(j+1), getz(i, (j+1), false, false, false)+in.left.get(0)*30);
      canvas.endShape();
      if (j == 99) {
        canvas.beginShape(QUAD);
        canvas.vertex(grid*i, grid*(j+1), getz(i, (j+1), false, true, false)+in.left.get(0)*30);
        canvas.vertex(grid*(i+1), grid*(j+1), getz((i+1), (j+1), false, true, false)+in.left.get(0)*30);
        canvas.vertex(grid*(i+1), grid*(j+1), getz(i+1, (j+1), false, true, true));
        canvas.vertex(grid*i, grid*(j+1), getz(i, (j+1), false, true, true));
        canvas.endShape();
      }
    }
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

server1.sendImage(canvas);
  println(frameCount);
  //noLoop();
  if (render) {
    saveFrame("render/####-grotto.tif");
    if (frameCount > 1440) {
      noLoop();
    }
  }
}

float getz(int i, int j, boolean land, boolean edge, boolean check) {
  float z;
  float n; 
  float c;
  if (land) {
    n = noise(i/80f-0.8, j/80f-0.35);
    z = 800*n-150;
    c = n*10-4.5;
    if (edge) c = 0;
    canvas.fill(lerpColor(#FFFCD9, #6AAB26, c ));
  } else if (!check) {
    n = noise(i/80f-0.8, j/80f-0.35, 2+cos(frameCount*2*PI/720f+PI/2));
    z = 50*n+190 + 10*sin(frameCount*2*PI/720f);
    c = n*4-2;
    //println(c);
    canvas.fill(lerpColor(color(#35B5AC, 150), color( #91D9CE, 150), c ));
  } else {
    n = noise(i/80f-0.8, j/80f-0.35);
    z = 800*n-150;
    c = n;
    if (edge) c = 0;
    canvas.fill(lerpColor(color(#11736C, 150), color( #26EDCF, 150), c ));
  }
  //println(c);
  return z;
}