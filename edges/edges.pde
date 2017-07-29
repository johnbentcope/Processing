import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

boolean render = false;

PostFX fx;

PGraphics canvas;
PGraphics dummy;
PGraphics dummy1;
PGraphics dummy2;
PGraphics dummy3;
PGraphics dummy4;
int period = 5;
void setup()
{
  size(1200, 1200, P3D);

  fx = new PostFX(this);
  canvas = createGraphics(width, height, P3D);
  dummy = createGraphics(width, height, P3D);
  dummy1 = createGraphics(width, height, P3D);
  dummy2 = createGraphics(width, height, P3D);
  dummy3 = createGraphics(width, height, P3D);
  dummy4 = createGraphics(width, height, P3D);
}

void draw()
{

  background(0);
    canvas.beginDraw();
    canvas.background(0);
for (int i = 0; i < 3; i++){
  for (int j = 0; j< 3; j++){
  for (int k = 0; k< 3; k++){
    canvas.pushMatrix();
    canvas.translate(75*i,75*j,75*k+25);
    canvas.rotateZ(-frameCount*2*PI/(16*60)+PI/8);
    canvas.strokeWeight(3);
    canvas.stroke(0);
    canvas.fill(#4ECEFF);
    canvas.box(40, 10, 10);
    canvas.fill(#C6FF00);
    canvas.box(10, 40, 10);
    canvas.fill(#FF1874);
    canvas.box(10, 10, 40);
    canvas.fill(#000104);
    canvas.strokeWeight(1);
    canvas.stroke(255);
    canvas.box(20);
    canvas.popMatrix();
  }
    }
  }

  canvas.camera(
    75+300*sin(frameCount*2*PI/(16*60)),75+300*cos(frameCount*2*PI/(16*60)),225, 
    75, 75,75, 
    0, 0, -1.0);

  canvas.endDraw();

  fx.render(canvas)
    .invert()
    .compose();

  blendMode(BLEND);
  image(canvas, 0, 0);

  blendMode(ADD);
  fx.render(canvas)
    .blur(100, 50, false)
    .blur(10, 5, true)
    .compose(dummy);
  image(dummy, 0, 0);
  if(render){
 saveFrame("####.tif");
 if(frameCount == (4*60*4 + 1)){
   noLoop();
 }
  }

}