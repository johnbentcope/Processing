import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

PostFX fx;

boolean render = true;

PGraphics canvas;
PGraphics bloom;

int c = 4;

float goldenAngle = (180.0*(3-sqrt(5)));

float period = 6;

PImage sfc;
PShape pot;
float angle;

PShader texShader;

void setup() {
  size(1200, 1200, P3D);
  fx = new PostFX(this);
  sfc =  loadImage("assets/stuco.jpg");
  canvas = createGraphics(width, height, P3D);
  bloom = createGraphics(width, height, P3D);
}

void draw() {
  background(0);

  canvas.smooth(5);
  canvas.beginDraw();
  canvas.spotLight(250, 0, 0, 
    -400, 400, 400, 
    1, -1, -1, 
    PI, 100);

  canvas.spotLight(255, 255, 255, 
    400, 120, 300, 
    -1, -0.3, -0.8, 
    PI, 100);
  canvas.spotLight(0, 150, 255, 
    400, 120, 000, 
    -1, -0.3, 0, 
    PI, 100);

  canvas.background(#4B8DB0);
  canvas.rotateZ(radians((frameCount/16f/60f)*360));
  canvas.pushMatrix();
  canvas.translate(0, 0, -50);       
  canvas.rotateX(PI/2);
  createPot(100, 100, 32, sfc);
  createCap(100, 32);
  canvas.popMatrix();

  for (int i = 0; i < 600; i++) {
    float a = i * goldenAngle;
    float r = c * sqrt(i);
    float h = (600-i)/8f;
    canvas.pushMatrix();
    canvas.rotateZ(a);
    drawLeaf(r, h);
    canvas.popMatrix();
  }
  
  for (int i = 0; i<8; i++){
    canvas.pushMatrix();
    
    canvas.rotateZ(radians(i/8f*360));
    canvas.translate(110,0,10);
    canvas.rotateY(PI/8);
    drawFlower();
    
    canvas.popMatrix();
    canvas.pushMatrix();
    
    canvas.rotateZ(radians(i/8f*360));
    canvas.translate(50,0,45);
    canvas.scale(0.7);
    canvas.rotateY(PI/8);
    drawFlower();
    
    canvas.popMatrix();
  }
  for (int i = 0; i<8; i++){
    canvas.pushMatrix();
    
    canvas.rotateZ(radians(i/8f*360)+PI/8);
    canvas.translate(80,0,30);
    canvas.scale(0.7);
    canvas.rotateY(PI/8);
    drawFlower();
    
    canvas.popMatrix();
  }
  
  canvas.camera(
    220
    , 0
    , 80, 
    00, 00, -50, 
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
  
  if (render){
    saveFrame("render/####.tif");
    if (frameCount > 16*60){
      noLoop();
    }
  }
}

void drawFlower(){
  canvas.pushMatrix();
  
  drawPetal();
  canvas.rotate(PI/3*2);
  drawPetal();
  canvas.rotate(PI/3*2);
  drawPetal();
  canvas.rotate(PI/3*2);
  canvas.scale(0.7);
  canvas.translate(0,0,5);
  drawPetal();
  canvas.rotate(PI/3*2);
  drawPetal();
  canvas.rotate(PI/3*2);
  drawPetal();
  canvas.rotate(PI/3*2);
  canvas.fill(#FFFF00);
  canvas.box(3);
  canvas.popMatrix();
}

void drawPetal(){
canvas.pushMatrix();
  canvas.rotateZ(-PI/2);
  canvas.scale(3);
  canvas.noStroke();
  canvas.fill(#9031B9);
  canvas.beginShape(TRIANGLE_FAN);
  canvas.vertex(0, 0, 0);

  canvas.vertex(2, 0.25, 0.5 );
  canvas.vertex(3.5, 1, 1);
  canvas.vertex(4, 2.5, 0.5);
  canvas.vertex(3.5, 4.5, 1);
  canvas.vertex(2, 5.5, 0.5);

  canvas.vertex(0, 5.75, 0);

  canvas.vertex(-2, 5.5, 0.5);
  canvas.vertex(-3.5, 4.5, 1);
  canvas.vertex(-4, 2.5, 0.5);
  canvas.vertex(-3.5, 1, 1);
  canvas.vertex(-2, 0.25, 0.5);
  
  canvas.endShape(CLOSE);
  canvas.popMatrix();
  
}


void drawLeaf(float radius, float h) {
  h *= 0.7;
  canvas.pushMatrix();
  canvas.strokeWeight(3);
  canvas.noFill();
  canvas.stroke(5, 88, 30);
  canvas.bezier(0, 0, 0, 
    0, radius/2, h, 
    0, radius/2, h, 
    0, radius, h);

  canvas.translate(0, radius, h);
  canvas.scale(map(h, (600/8), 0, 1, 3));
  canvas.noStroke();
  canvas.fill(10, 128, 50);
  canvas.beginShape(TRIANGLE_FAN);
  canvas.vertex(0, 0, 0);

  canvas.vertex(2, 0.25, 0.5 );
  canvas.vertex(3.5, 1, 1);
  canvas.fill(20, 200, 80);
  canvas.vertex(4, 2.5, 0.5);
  canvas.vertex(3.5, 4.5, 1);
  canvas.fill(10, 128, 50);
  canvas.vertex(2, 5.5, 0.5);

  canvas.vertex(0, 5.75, 0);

  canvas.vertex(-2, 5.5, 0.5);
  canvas.fill(20, 200, 80);
  canvas.vertex(-3.5, 4.5, 1);
  canvas.vertex(-4, 2.5, 0.5);
  canvas.fill(10, 128, 50);
  canvas.vertex(-3.5, 1, 1);
  canvas.vertex(-2, 0.25, 0.5);
  canvas.endShape(CLOSE);

  // Vein
  canvas.noStroke();
  canvas.fill(5, 88, 30);
  canvas.beginShape();
  canvas.vertex(0, 0, 0);
  canvas.vertex(0, 5.75, 0);
  canvas.vertex(0, 2*5.75/3, 0.5);
  canvas.vertex(0, 5.75/3, 0.5);
  canvas.endShape(CLOSE);
  canvas.popMatrix();
}
void createPot(float r, float h, int detail, PImage tex) {
  canvas.textureMode(NORMAL);
  canvas.beginShape(QUAD_STRIP);
  canvas.noStroke();
  canvas.texture(tex);
  for (int i = 0; i <= detail; i++) {
    float angle = TWO_PI / detail;
    float x = sin(i * angle);
    float z = cos(i * angle);
    float u = float(i) / detail;
    canvas.normal(x, 0, z);
    canvas.vertex(x * r, -h/2, z * r, u, 0);
    canvas.vertex(x * r*0.9, +h/2, z * r, u, 1);
  }
  canvas.endShape();
}


PShape createCap(float r, int detail) {
  PShape sh = createShape();
  sh.beginShape(TRIANGLE_FAN);
  sh.noStroke();
  sh.fill(128);
  sh.vertex(0, 0, 0);
  for (int i = 0; i <= detail; i++) {
    float angle = TWO_PI / detail;
    float x = sin(i * angle);
    float z = cos(i * angle);
    sh.vertex(x * r, 0, z * r);
  }  
  sh.endShape();
  return sh;
}