import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

PostFX fx;
int n = 500;
int c =2;

boolean render = true;

PGraphics cream, carm;
PGraphics bloom, bloom2;
float sides = 20;
float goldenAngle = (180.0*(3-sqrt(5)));

void setup() {
  size(600, 600, P2D);
  fx = new PostFX(this);

  cream = createGraphics(600, 600, P3D);
  carm = createGraphics(600, 600, P2D);
  bloom = createGraphics(width, height, P3D);
  bloom2 = createGraphics(width, height, P3D);
  frameRate(30);
}


void draw() {

  cream.beginDraw();
  cream.background(#54D664);
  //cream.lights();
  cream.noStroke();
  cream.fill(#90533A);
  cream.camera(200*sin(frameCount*PI/180f), 200*cos(frameCount*PI/180f), 100, 
    0, 0, 20, 
    0, 0, -1.0);
  cream.beginShape(QUAD_STRIP);

  for (int i = 0; i < 80; i++) {
    if ((i/10)%2 == 0) {
      cream.fill(#90533A);
    } else {
      cream.fill(#FFF8BE);
    }
    cream.vertex(50*(1-(i-10)/100f)*sin(i*PI/(sides/2)), 50*(1-(i-10)/100f)*cos(i*PI/(sides/2)), i*1.3);
    cream.vertex(50*(1-i/100f)*sin(i*PI/(sides/2)), 50*(1-i/100f)*cos(i*PI/(sides/2)), i*1.3+sides*((90-i)/100f));
  }
  cream.endShape();
  cream.stroke(#280C0B);
  cream.strokeWeight(2);
  cream.fill( #F69145);
  for (int i = 0; i < n; i++) {
    float a = i * goldenAngle;
    float r = c * sqrt(i);
    float x = r * cos(radians(a));
    float y = r * sin(radians(a));
    cream.pushMatrix();
    cream.rotateZ(a);
    cream.translate(r, 0, -(115-r*2.6));
    cream.rotateX(PI/4);
    cream.box(0.25, 1*((r+40)/20f), 4*((r+40)/21f));
    cream.popMatrix();
  }

  cream.endDraw();


  carm.beginDraw();
  carm.clear();
  carm.fill(#E89626);
  carm.noStroke();

  carm.beginShape();
  carm.vertex(width, 0);
  carm.vertex(0, 0);

  for (int i = 0; i < 120; i ++) {
    int j = i+1;
    carm.vertex(i*5, 95+30*(sin(i*PI*2/17 +frameCount*PI/60)+sin(i*PI*2/23+frameCount*PI/60)+sin(j*PI*2/50+frameCount*PI/60)));
    carm.vertex(j*5, 95+30*(sin(j*PI*2/17+frameCount*PI/60)+sin(j*PI*2/23+frameCount*PI/60)+sin(j*PI*2/50+frameCount*PI/60)));
  }

  carm.endShape(); 

  carm.endDraw(); 


  blendMode(BLEND); 
  fx.render(cream)
    .blur(10, 10, false)
    .blur(10, 10, true)
    .compose(bloom); 
  fx.render(carm)
    .blur(10, 10, false)
    .blur(10, 10, true)
    .compose(bloom2); 
  image(cream, 0, 0); 
  image(carm, 0, 0); 
  pushMatrix();
  rotate(PI);
  image(carm, -width, -height); 
  popMatrix();
  blendMode(SCREEN); 
  image(bloom, 0, 0);
  
  println(frameRate + " : " + frameCount);
  if (render) {
    saveFrame("render/####-ice_cream.tif");
    if (frameCount > 720) {
      noLoop();
    }
  }
  
}