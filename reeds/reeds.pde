import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

PostFX fx;

boolean render = true;

PGraphics canvas;
PGraphics sky;
PGraphics back;
PGraphics mid;
PGraphics fore;
PGraphics bloom;
Reed reed;
Reed reed2;
Reed reed3;

void setup() {
  size(1200, 1200, P3D);

  fx = new PostFX(this);
  
  reed = new Reed(width/2,3,PI/4,255);
  reed2 = new Reed(width/2,5,PI/4,150);
  reed3 = new Reed(width/2,3.75,PI/4,100);

  canvas = createGraphics(width, height, P3D);
  sky = createGraphics(width, height, P3D);
  back = createGraphics(width, height, P3D);
  mid = createGraphics(width, height, P3D);
  fore = createGraphics(width, height, P3D);
  bloom = createGraphics(width, height, P3D);
  frameRate(60);
  noiseSeed(int("thanks for watching!"));
}

void draw() {
  background(0);

  canvas.smooth(5);
  canvas.beginDraw();
  canvas.noStroke();
  //canvas.strokeWeight(2);
  //canvas.stroke(255);
  canvas.background(#000000);

  canvas.background(#000000);
  canvas.endDraw();
  canvas.endDraw();

  sky.beginDraw();
  sky.strokeWeight(6);
  sky.background(#BF5111);
  for (int x =0; x < height/6; x++) {
    sky.stroke(lerpColor(#BA431B,#FFA746,noise(x/30f)));
    sky.line(0,3+x*6,width,3+x*6);
  }
  sky.endDraw();

  back.beginDraw();
  back.clear();
  for (int s = 1; s< 6;s++){
  back.pushMatrix();
  back.translate(s*width/7,height);
  back.scale(1,1.8);
  reed3.render(back);
  back.popMatrix();
  }
  //back.ellipse(width/2, height/2, 400, 400);
  back.endDraw();

  mid.beginDraw();
  mid.clear();
  for (int s = 1; s< 7;s++){
  mid.pushMatrix();
  mid.translate((s-0.5)*width/7,height);
  mid.scale(1,1.4);
  reed2.render(mid);
  mid.popMatrix();
  }
  mid.fill(255);
  //mid.ellipse(width/2, height/2, 200, 200);
  mid.endDraw();

  fore.beginDraw();
  fore.strokeCap(ROUND);
  strokeCap(ROUND);
  fore.clear();
  for (int s = 1; s< 6;s++){
  fore.pushMatrix();
  fore.translate(s*width/7,height);
  fore.scale(1,1.05);
  reed.render(fore);
  fore.popMatrix();
  }
  fore.endDraw();

  blendMode(BLEND);
  fx.render(canvas)
    .blur(15, 15, false)
    .blur(15, 15, true)
    .compose(bloom);
    
    
  fx.render(mid)
    .blur(35, 35, false)
    .blur(35, 35, true)
    .compose(mid);
    
  fx.render(back)
    .blur(65, 65, false)
    .blur(65, 65, true)
    .compose(back);
  image(sky, 0, 0);
  image(back, 0, 0);
  image(mid, 0, 0);
  image(fore, 0, 0);
  
  blendMode(SCREEN);
  image(bloom, 0, 0);

  if (render) {
    saveFrame("render/####-reeds.tif");
    if (frameCount > 60*15) {
      noLoop();
    }
  }
}