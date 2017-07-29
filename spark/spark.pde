import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

PostFX fx;
PGraphics bg;
PGraphics[] canvii = new PGraphics[11];

float gravity = 0.2;

ArrayList<Slag> slag = new ArrayList<Slag>();

float period = 3;

float pfc = period *60;

float death = 90;

void setup() {
  size(1200, 1200, P3D);

  fx = new PostFX(this);


  for (int c = 0; c < canvii.length; c++) {
    canvii[c] = createGraphics(width, height, P3D);
    canvii[c].smooth(5);
    canvii[c].camera(-200, 300, 300, 
      600, 600, 300, 
      0, 0, -1.0);
  }

  bg = createGraphics(width, height, P3D);
}

void draw() {
  clear();
  bg.beginDraw();
  bg.background(0);
  bg.endDraw();

  for (int c = 0; c < canvii.length; c++) {
    canvii[c].beginDraw();
    canvii[c].clear();
    canvii[c].noFill();
    canvii[c].strokeWeight(8);
    //canvii[c].noStroke();
    canvii[c].camera(-200, 300, 300, 
      600, 600, 300, 
      0, 0, -1.0);
    canvii[c].endDraw();
  }

  if (frameCount < 180) {
    slag.add(new Slag(new PVector(600, 600, -100+(frameCount*2.5)%900)));
    slag.add(new Slag(new PVector(600, 600, -100+(frameCount*2.5)%900)));
  }

  for (int s = 0; s < slag.size(); s++) {
    Slag sl = slag.get(s);
    sl.render();
    if (sl.age > death) {
      sl.reset(-100+(frameCount*2.5)%900);
    }
  }

  image(bg, 0, 0);
  blendMode(ADD);
  for (int c = 0; c < canvii.length; c++) {
    fx.render(canvii[c])
      .blur(6*(1+abs(c-5)), 6*(1+abs(c-5)), false)
      .blur(6*(1+abs(c-5)), 6*(1+abs(c-5)), true)
      .compose();
    //image(canvii[c], 0, 0);
  }
  //println(mouseX);
  println(frameRate + " FR : FC " + frameCount);
  //if (frameCount >= 360 && frameCount < 1080)saveFrame("render/####_spark.tif");
}