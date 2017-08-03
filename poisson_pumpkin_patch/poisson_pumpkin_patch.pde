import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

PostFX fx;

boolean render = true;

PGraphics canvas, terr;
PGraphics bloom, bloom2;

ArrayList<Particle> patch = new ArrayList<Particle>();
ArrayList<Vine> bramble = new ArrayList<Vine>();

PShape tendril;
void setup() {
  size(600, 600, P3D);
  int id = 0;   
  fx = new PostFX(this);


  canvas = createGraphics(width, height, P3D);
  terr = createGraphics(width, height, P3D);
  bloom = createGraphics(width, height, P3D);
  bloom2 = createGraphics(width, height, P3D);

  while (id < 100) {
    PVector attempt = new PVector(random(width), random(height));
    boolean valid = true;

    for (int i = 0; i < patch.size(); i++) {
      Particle p = patch.get(i);
      if ( dist(attempt.x, attempt.y, p.pos.x, p.pos.y) < 50) valid = false;
    }
    if (valid) {
      patch.add(new Particle(new PVector(attempt.x, attempt.y, getTerrainHeight(attempt.x, attempt.y)), id));
      id++;
    }
  }

  for (Particle p : patch) {
    for (Particle q : patch) {
      if ( p.id != q.id) {
        if (dist(p.pos.x, p.pos.y, q.pos.x, q.pos.y) < 100) {
          bramble.add( new Vine(p, q));
        }
      }
    }
  }
}

void draw() {
  background(#5A433B);
  canvas.beginDraw();
  canvas.background(#5A433B, 0);
  canvas.camera(-100, 300, 200, 
    200, 300, 0, 
    0, 0, -1.0);
  //canvas.clear();
  for (Particle p : patch) {
    p.render();
  }
  for (Vine v : bramble) {
    v.render();
  }
  canvas.endDraw();
  terr.beginDraw();
  terr.clear();
  terr.camera(-100, 300, 200, 
    200, 300, 0, 
    0, 0, -1.0);
  for (int x = 0; x < 600; x+=60) {
    for (int y = 0; y < 600; y+=60) {
      int xx = x+60; 
      int yy = y+60;
      PShape qd;
      qd = createShape();
      qd.beginShape(QUAD);
      qd.stroke(255);
      qd.fill( lerpColor(#C9AA63, #5C4323, getTerrainHeight(x, y)/90f));
      qd.vertex(x, y, getTerrainHeight(x, y)-20);
      qd.fill( lerpColor(#C9AA63, #5C4323, getTerrainHeight(xx, y)/90f));
      qd.vertex(xx, y, getTerrainHeight(xx, y)-20);
      qd.fill( lerpColor(#C9AA63, #5C4323, getTerrainHeight(xx, yy)/90f));
      qd.vertex(xx, yy, getTerrainHeight(xx, yy)-20);
      qd.fill( lerpColor(#C9AA63, #5C4323, getTerrainHeight(x, yy)/90f));
      qd.vertex(x, yy, getTerrainHeight(x, yy)-20);
      qd.endShape(CLOSE);
      terr.shape(qd);
      //println(getTerrainHeight(x,yy)/90f);
    }
  }
  terr.endDraw();
  println(frameCount, frameRate);
  fx.render(canvas)
    .brightPass(0.5)
    .blur(15, 15, false)
    .blur(15, 15, true)
    .compose(bloom);
  fx.render(terr)
    .brightPass(0.9)
    .blur(15, 15, false)
    .blur(15, 15, true)
    .compose(bloom2);
  blendMode(BLEND);
  image(terr, 0, 0);
  image(canvas, 0, 0);
  blendMode(SCREEN);
  image(bloom2, 0, 0);
  image(bloom, 0, 0);
  if(frameCount < 720) saveFrame("render/####_poisson_patch.tif");
  else noLoop();
}

float getTerrainHeight(float x, float y) {
  float detail = 180;
  float scale = 90;
  return scale*noise(x/detail, y/detail);
}


void drawLeaf(boolean isPetal, color body, color vein) {
  canvas.beginShape();
  canvas.fill(body);
  canvas.noStroke();
  canvas.vertex(05, -26, 0);
  canvas.vertex(15, -30, 5);
  canvas.vertex(0, 0, 0);

  canvas.vertex(15, -30, 5);
  canvas.vertex(29, -27, 10);
  canvas.vertex(0, 0, 0);

  canvas.vertex(29, -27, 10);
  canvas.vertex(55, -06, 5);
  canvas.vertex(0, 0, 0);

  canvas.vertex(55, -06, 5);
  canvas.vertex(70, 0, 0);
  canvas.vertex(0, 0, 0);

  canvas.vertex(70, 0, 0);
  canvas.vertex(55, 06, 5);
  canvas.vertex(0, 0, 0);

  canvas.vertex(55, 06, 5);
  canvas.vertex(29, 27, 10);
  canvas.vertex(0, 0, 0);

  canvas.vertex(29, 27, 10);
  canvas.vertex(15, 30, 5);
  canvas.vertex(0, 0, 0);

  canvas.vertex(15, 30, 5);
  canvas.vertex(05, 26, 0);
  canvas.vertex(0, 0, 0);
  canvas.endShape(CLOSE);

  canvas.fill(vein);

  canvas.beginShape();
  canvas.vertex(0, 0, 0);
  canvas.vertex(70, 0, 0);
  canvas.vertex(35, 0, 7);
  canvas.endShape(CLOSE);
  canvas.noFill();
  canvas.noStroke();
}