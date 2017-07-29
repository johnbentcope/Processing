import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

PostFX fx;

boolean render = true;

PGraphics canvas;
PGraphics bloom;

Bromeliad brom;

Butterfly butt;

void setup() {
  size(1200, 1200, P3D);
  fx = new PostFX(this);

  butt = new Butterfly();

  brom = new Bromeliad();

  canvas = createGraphics(width, height, P3D);
  bloom = createGraphics(width, height, P3D);
  frameRate(60);
}

void draw() {
  background(0);

  canvas.smooth(5);
  canvas.beginDraw();
  
  canvas.spotLight(250, 200, 200, 
    -300, 400, 400, 
    1, -1, -1, 
    PI, 100);

  canvas.spotLight(150, 200, 150, 
    400, 320, 300, 
    -1, -0.8, -0.8, 
    PI, 10);
    
  canvas.spotLight(0, 50, 750, 
    400, -320, 000, 
    -1, 0.8, 0, 
    PI, 1);
    
  canvas.spotLight(255,255,255, 
    300, 200, 300, 
    0, 0, -1, 
    PI, 1);

  //canvas.ortho();
  canvas.strokeCap(ROUND);
  canvas.strokeJoin(ROUND);
  canvas.fill(0);
  canvas.strokeWeight(2);
  canvas.stroke(255);
  canvas.background(#1C130A);

  //canvas.lights();
  canvas.camera(350, 200, 400, 
    0, 0, 0, 
    0, 0, -1.0);

  canvas.pushMatrix();
  //canvas.rotateZ(PI/2*frameCount/60);

  canvas.scale(2);
    canvas.rotateZ(-radians(((frameCount%360f)/10f)));
  brom.makeBrom();
  canvas.popMatrix();

  canvas.sphereDetail(3);
  canvas.pushMatrix();
  canvas.translate(0, 0, 150);
  //canvas.rotateZ(PI/2*frameCount/60);

  canvas.scale(4);
  butt.makeButterfly();
  canvas.popMatrix();

  for( int i = 0; i < 30; i++){
    canvas.pushMatrix();
    canvas.fill(noise(i)*255);
    canvas.rotateZ(radians(i/30f*360));
    canvas.rotateX(radians(i/30f*(60+360)));
    canvas.translate(150,0,0);
    canvas.sphere(20);
    canvas.popMatrix();
  }

  for (int i = 0; i < 50; i++) {
    canvas.pushMatrix();
    canvas.stroke(#332006);
    canvas.translate(0, 0, -1*(i+1));
    canvas.fill(lerpColor(#D1B68A, #2C7036, i/50f));
    canvas.ellipse(0, 0, 200+i*10, 200+i*10);
    canvas.popMatrix();
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
    saveFrame("render/####-brom.tif");
    if (frameCount > 60*6*2+1) {
      noLoop();
    }
  }
}