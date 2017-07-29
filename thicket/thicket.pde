import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

PostFX fx;
import java.util.*;
PImage bg, vignette, vigNoise;

ArrayList<PVector> vine = new ArrayList<PVector>();


PGraphics canvas, bloom;
Random generator;

float theta;
int maxLength = 270;
int fade =30;
void setup() {
  size(600, 600, P2D);
  generator = new Random();
  fx = new PostFX(this);
  bg = loadImage("assets/bg.jpg");

  canvas = createGraphics(width, height);
  bloom  = createGraphics(width, height);

  vignette = createImage(width, height, RGB);
  vignette.loadPixels();

  for (int i = 0; i < width; i++) {
    for (int j = 0; j < width; j++) {
      float col = 0;
      col = 255*noise(i/30f, j/30f)+255-255*dist(i, j, width/2, height/2)/(width/2*sqrt(2));
      vignette.pixels[i+j*width] = color(col);
    }
  }

  vignette.updatePixels();
  stroke(255);
  frameRate(30);
  smooth();
}

void draw() {  
  if (frameCount%(maxLength+fade) == 1) {
    theta = PI/random(60, 120);
    println(theta);
  }
  background(255); 
  blendMode(BLEND);
  image(bg, (width-bg.width)/2, (height-bg.height)/2);
  canvas.smooth();
  canvas.beginDraw();
  canvas.clear();
  canvas.strokeWeight(5);
  canvas.pushMatrix();
  vine();
  canvas.popMatrix();
  canvas.endDraw();
  image(canvas, 0, 0); 
  blendMode(MULTIPLY);
  image(vignette, 0, 0);
  blendMode(SCREEN);   
  fx.render(canvas)
    .blur(15, 80, false)
    .blur(15, 80, true)
    .compose();
  //image(bloom,0,0);
  saveFrame("render/####_thicket.tif");
  if (frameCount > 30*30) noLoop();
}

void vine() {
  color plant = color(#CEC2FA);
  color leaf = color(#CEC2FA);
  canvas.pushMatrix();
  if ( (frameCount%(maxLength+fade)) < fade) {
    canvas.stroke(plant, 255 * (frameCount%(maxLength+fade))/fade);
    //println("FADE + " + 255 * (frameCount%(maxLength+fade))/fade);
    canvas.fill(leaf, 255 * (frameCount%(maxLength+fade))/fade);
  } else if (( frameCount%(maxLength+fade))< maxLength) {
    canvas.stroke(plant, 255);
    canvas.fill(leaf, 255);
  } else {
    canvas.stroke(plant, 255-255*((frameCount%(maxLength+fade))-maxLength)/fade);
    canvas.fill(leaf, 255-255*((frameCount%(maxLength+fade))-maxLength)/fade);
  }
  for (int s = 0; s < 8; s++) {
    canvas.pushMatrix();
    canvas.translate(width/2, height/2);
    canvas.rotate(s*PI/4);
    canvas.translate(0, height/2);
    canvas.line(0, 200, 0, 0);
    for (int i =0; i < frameCount%(maxLength+fade); i++) {
      canvas.line(0, 0, 0, -5);
      canvas.translate(0, -8);
      canvas.rotate(theta*(i/50f));
      if (i%10 == 0) {
        canvas.pushMatrix();
        if ((i/10)%2 == 0) {
          canvas.translate(8, 0);
          canvas.rotate(-PI/4);
        } else {
          canvas.translate(-8, 0);
          canvas.rotate(PI/4);
        }
        canvas.ellipse(0, 0, 10, 3);
        canvas.popMatrix();
      }
    }
    canvas.popMatrix();

    canvas.pushMatrix();
    canvas.translate(width/2, height/2);
    canvas.rotate(s*PI/4);
    canvas.translate(0, height/2);
    for (int i =0; i < frameCount%(maxLength+fade); i++) {
      canvas.line(0, 0, 0, -5);
      canvas.translate(0, -8);
      canvas.rotate(-theta*(i/50f));
      if (i%10 == 5) {
        canvas.pushMatrix();
        if ((i/10)%2 == 1) {
          canvas.translate(8, 0);
          canvas.rotate(-PI/4);
        } else {
          canvas.translate(-8, 0);
          canvas.rotate(PI/4);
        }
        canvas.ellipse(0, 0, 10, 3);
        canvas.popMatrix();
      }
    }
    canvas.popMatrix();
  }
  //println(frameCount);
  canvas.popMatrix();
}