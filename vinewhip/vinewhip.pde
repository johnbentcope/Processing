import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

PostFX fx;

boolean render = true;

PGraphics canvas;
PGraphics bloom;
float period = 6;


float l = 475;
float r = 25;

float steps =200;

float twists = 6;

PVector curr;

PVector innr;

int castR = 350;
int fH = 50;
void setup() {
  size(1200, 1200, P3D);
  fx = new PostFX(this);

  canvas = createGraphics(width, height, P3D);
  bloom = createGraphics(width, height, P3D);

  curr = new PVector(0, 0, 0);
  innr = new PVector(0, 0, 0);
}

void draw() {

  background(0);

  canvas.smooth(5);
  canvas.beginDraw();
  //canvas.ortho();
  canvas.strokeCap(ROUND);
  canvas.strokeJoin(ROUND);
  canvas.lights();
  canvas.fill(0);
  canvas.strokeWeight(2);
  canvas.stroke(255);
  canvas.background(#1C130A);

  for ( int f = 0; f < 100; f++) {
    canvas.pushMatrix();
    canvas.translate(0, 0, (fH+3)*f);
    canvas.rotateZ(PI/20*f);
    for (int b = 0; b < 20; b++) {
      canvas.rotateZ(radians(360/20));
      canvas.pushMatrix();
      canvas.translate(castR, 0, 0);
      canvas.strokeWeight(6);
      canvas.stroke(#111111);
      canvas.fill(#AAAAAA);
      canvas.box(fH, 100, fH);
      canvas.popMatrix();
    }
    canvas.popMatrix();
  }

  for (int i = 0; i < 16; i++) {
    canvas.translate(0, 0, 140);
    canvas.rotateZ(radians(-30));
    vines();
  }

  canvas.camera(
    900
    , 800
    , 1200, 
    0, 0, 1200, 
    0, 0, -1.0);

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
    saveFrame("render/####-vine.tif");
    if (frameCount > 60*12*2+1) {
      noLoop();
    }
  }
}

void vines() {
  // OUTER VINES

  for (int v = 0; v < 3; v ++) {
    canvas.noFill();

    canvas.beginShape();
    for (int i = 0; i < steps+2; i++) {

      float betaC = radians(0+i/steps*twists*360)+ radians(frameCount%360) + v*2*PI/3;
      float alphaC = radians(360*i/steps);


      curr.x = (l-r*sin(betaC))*sin(alphaC);
      curr.y = (l-r*sin(betaC))*cos(alphaC);
      curr.z = r*cos(betaC);

      canvas.strokeWeight(13);
      canvas.stroke(#284907);
      canvas.vertex(curr.x, curr.y, curr.z);
    }
    canvas.endShape();
  }

  // INNER VINE
  canvas.beginShape();
  for (int i = 0; i < steps+2; i++) {
    float alphaI = radians(360*i/steps);

    innr.x = (l)*sin(alphaI);
    innr.y = (l)*cos(alphaI);
    innr.z = 0;
    canvas.strokeWeight(30);
    canvas.stroke(#5C832F);
    canvas.vertex(innr.x, innr.y, innr.z);
  }
  canvas.endShape();

  for (int i = 0; i < 9; i++) {
    canvas.pushMatrix();
    canvas.rotateZ(radians(i/9f*360));
    canvas.translate(l, 0, 0);
    for (int v = 0; v < 3; v++) {
      canvas.pushMatrix();
      canvas.rotateY(-radians(frameCount%360) - 2*v*PI/3);
      canvas.translate(r, 0, 0);
      canvas.pushMatrix();
      canvas.rotateX(PI/4);
        canvas.pushMatrix();
        canvas.scale(1.3);
      drawLeaf(false, color(#5C832F), color(#284907));
        canvas.popMatrix();
      canvas.popMatrix();
      if (v == 1 && i %3 == 1) {
        canvas.pushMatrix();
        canvas.rotateX(PI/2);
        canvas.translate(15, 0, 100);
        canvas.rotateY(PI/2);
        drawFlower(true,false);      
        canvas.popMatrix();
      }
      if (v == 2 && i %3 == 0) {
        canvas.pushMatrix();
        canvas.rotateX(PI/2);
        canvas.translate(10, 0, 100);
        canvas.rotateY(PI/2);
        drawFlower(false,true);      
        canvas.popMatrix();
      }
      if (v == 0 && i %3 == 2) {
        canvas.pushMatrix();
        canvas.rotateX(PI/2);
        canvas.translate(10, 0, 100);
        canvas.rotateY(PI/2);
        drawFlower(false,false);      
        canvas.popMatrix();
      }
      canvas.popMatrix();
    }

    canvas.popMatrix();
  }

  canvas.endShape();
}

void drawFlower(boolean isPink, boolean isYellow) {
  canvas.pushMatrix();
  canvas.scale(0.6);
  for (int p = 0; p < 3; p++) {
    canvas.pushMatrix();
    canvas.rotateZ(p*2*PI/3);
    if ( isPink) drawLeaf(true, color(#E80C7A), color(#850746));
    else if ( isYellow) drawLeaf(true, color(#F2D100), color(#A6861D));
    else drawLeaf(true, color(#00B0FF), color(#006B9C));
    canvas.fill(#FFFF00);
    canvas.translate(0, 0, 5);
    canvas.box(10);
    canvas.popMatrix();
  }
  canvas.popMatrix();
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