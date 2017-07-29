import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

PostFX fx;
PGraphics bg;
PGraphics[] canvii = new PGraphics[41];

int detail = 21;
int r = 155;

void setup() {
  size(600, 600, P3D);

  fx = new PostFX(this);


  for (int c = 0; c < canvii.length; c++) {
    canvii[c] = createGraphics(width, height, P3D);
    canvii[c].smooth(5);
    canvii[c].camera(-300, 0, 0, 
      0, 0, 0, 
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
    canvii[c].noStroke();
    canvii[c].camera(-300, 000, 000, 
      000, 000, 000, 
      0, 0, -1.0);
    canvii[c].endDraw();
  }

  for (int phi = 0; phi < detail+1; phi++) {
    for (int theta = 0; theta < 2*detail; theta++) {
      float x = r*cos(theta*PI/(detail) + frameCount*PI/360f)*sin(phi*PI/detail);
      float y = r*sin(theta*PI/(detail) + frameCount*PI/360f)*sin(phi*PI/detail);
      float z = r*cos(phi*PI/detail);
      int c = floor(x/30)+10;
      //println(c);
      canvii[c].beginDraw();

      canvii[c].translate(x, y, z);
      switch(theta%3) {
        case 0:
        canvii[c].fill(#FF00FF);
        break;        
        case 1:
        canvii[c].fill(#FFFF00);
        break;        
        case 2:
        canvii[c].fill(#00FFFF);
        break;
      }
      canvii[c].rotateY(PI/2+frameCount*PI/120f);
      canvii[c].rect(0, 0, 12, 12);
      canvii[c].endDraw();
    }
  }

  image(bg, 0, 0);
  blendMode(ADD);
  for (int c = 0; c < canvii.length; c++) {
    int sigma = abs(floor((c-20)*1))+1;
    float blurAmt = abs((c-20))*2+1;
    println(sigma + " : " + blurAmt + " : " + c);
    fx.render(canvii[c])
      .blur(sigma, blurAmt, false)
      .blur(sigma, blurAmt, true)
      .compose();
    //image(canvii[c], 0, 0);
  }
  //println(mouseX);
  println(frameRate + " FR : FC " + frameCount);
  saveFrame("render/####_eve.tif");
  if (frameCount > 720) noLoop();
}