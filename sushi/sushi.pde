import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

PostFX fx;

boolean render = true;


PGraphics canvas, sushi, bloom;

void setup() {
  size(600, 600, P2D);

  fx = new PostFX(this);
  sushi = createGraphics(600, 600, P3D);
  canvas = createGraphics(600, 600, P2D);
  bloom = createGraphics(width, height, P2D);
  frameRate(30);
}

void draw() {
  background(#FF7872);
  
  canvas.beginDraw();
  canvas.clear(); 
  canvas.background(#FF7872);
  canvas.noFill();
  for(int i = 0; i < 600; i++){
 canvas.stroke(#FF7B33, 255*noise(i/100f, 1*sin(frameCount *2*PI/3600f)));
 canvas.ellipse(300,300,i*2,i*2);
  }
  canvas.endDraw();
  
  sushi.beginDraw();
  sushi.camera(-100*sin(frameCount *2*PI/180f), 250, -100*cos(frameCount *2*PI/180f), 
    0, -100, 0, 
    0, 0, -1.0);
  sushi.noStroke();
  sushi.lights();
  sushi.sphereDetail(10);
  sushi.background(canvas.get());
  sushi.fill(#FFFFFF);

  // URUCHIMAI
  for (int i = 0; i < 40; i++) {
    sushi.pushMatrix();
    for (int c = 0; c < 10; c++) {
      sushi.pushMatrix();
      sushi.rotateY(PI/20*i + frameCount *2*PI/720f + (c%2)*PI/20);
      sushi.translate(100+(i%2)*20, -30*c, 0);
      sushi.scale(1, 3, 1);
      sushi.sphere(5);
      sushi.popMatrix();
    }
    sushi.popMatrix();
  }

  // NORI
  sushi.fill(#0D2B0F);
  for (int i = 0; i < 40; i++) {
    sushi.pushMatrix();
    sushi.rotateY(PI/20*i);
    sushi.translate(80, 0, 0);
    sushi.rotateY(PI/2);
    sushi.rect(-8, -20, 15, -200);
    sushi.popMatrix();
  }

  // SASHIMI
  for (int r = 0; r < 3; r++) {
    sushi.pushMatrix();
    sushi.translate(0, -120*r, 0);
    sushi.scale(-2*((r%2)-0.5), 1, 1);

    for (int s = 0; s < 2; s++) {
      sushi.pushMatrix();

      sushi.rotateY(PI*(s%2) + frameCount*2*PI/360f);

      sushi.beginShape(QUAD_STRIP);
      for (int i = 0; i < 60; i ++) {
        sushi.fill(#FF9155);
        if (i %5 ==0) sushi.fill(#FFFEF8);
        //sushi.translate(140, 0, 0);
        sushi.vertex( 130*sin(PI/80*i), -100, 140*cos(PI/80*i));
        sushi.vertex( 150*sin(PI/80*(i+2)), -50, 150*cos(PI/80*(i+2)));
      }
      sushi.endShape(CLOSE);

      sushi.beginShape(QUAD_STRIP);
      for (int i = 0; i < 60; i ++) {
        sushi.fill(#FF9155);
        if (i %5 ==0) sushi.fill(#FFFEF8);
        //sushi.translate(140, 0, 0);
        sushi.vertex( 130*sin(PI/80*i), 0, 140*cos(PI/80*i));
        sushi.vertex( 150*sin(PI/80*(i+2)), -50, 150*cos(PI/80*(i+2)));
      }
      sushi.endShape(CLOSE);
      sushi.popMatrix();
    }
    sushi.popMatrix();
  }

  // THE DUKE OF CUKE

  for (int c = 0; c < 5; c++) {
    sushi.pushMatrix();
    sushi.translate(-22*(c-2), (2-c)*10*sin(frameCount*2*PI/360f), (c%2)*32);
    sushi.beginShape(QUAD_STRIP);
    for (int i = 0; i < 5; i++) {
      sushi.fill(#FFFEF8);
      if (i%4 <= 1) sushi.fill(#BFC63C);
      sushi.vertex(20*sin(i*PI/2), 00, 20*cos(i*PI/2));
      sushi.vertex(20*sin(i*PI/2), -200, 20*cos(i*PI/2));
    }
    sushi.endShape(CLOSE);
    sushi.popMatrix();
  }


  sushi.pushMatrix();
  sushi.translate(0, 0, -40);
  sushi.scale(3, 1, 1);
  sushi.beginShape(QUAD_STRIP);

  for (int i = 0; i < 5; i++) {
    sushi.fill(#FFD641);
    sushi.vertex(20*sin(i*PI/2+PI/4), 00, 20*cos(i*PI/2+PI/4));
    sushi.vertex(20*sin(i*PI/2+PI/4), -200, 20*cos(i*PI/2+PI/4));
  }
  sushi.endShape(CLOSE);
  sushi.popMatrix();

  sushi.endDraw();

  blendMode(BLEND);
  fx.render(sushi)
    .blur(15, 15, false)
    .blur(15, 15, true)
    .compose(bloom);
  image(sushi, 0, 0);
  blendMode(SCREEN);
  image(bloom, 0, 0);
  blendMode(BLEND);


  println(frameRate + " : " + frameCount);
  
  
  if (render) {
    saveFrame("render/####-breathe.tif");
    if (frameCount > 720) {
      noLoop();
    }
  }
}