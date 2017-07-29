import ch.bildspur.postfx.builder.*;
import ch.bildspur.postfx.pass.*;
import ch.bildspur.postfx.*;

PostFX fx;

PGraphics canvas;
PGraphics bloom;
PGraphics toon;

boolean render = true; 

float period = 2.5;

int flipDuration = 30;

void setup(){
  size(1200,1200, P3D);
  
  fx = new PostFX(this);
  canvas = createGraphics(width, height, P3D);
  bloom = createGraphics(width, height, P3D);
  toon = createGraphics(width, height, P3D);
  
  
}

void draw(){
  background(0);
  
  canvas.beginDraw();
  //background((255/2)+255*sin(frameCount*PI/(period*60)));
  background(#101010);
  canvas.strokeWeight(15);
  canvas.stroke(#170039);
  for (int i = 0; i<3; i++){
    for (int j = 0; j<3; j++){
      for (int k = 0; k<3; k++){
  canvas.fill(#FC5FFF);
        canvas.pushMatrix();
        canvas.translate(
          i*22+8*i*(01-cos(frameCount*PI/(period*60))),
          j*22+8*j*(01-cos(frameCount*PI/(period*60))),
          k*22+5*k*(01-cos(frameCount*PI/(period*60))));
        if (i == 0 || j == 0){
            //canvas.fill(#FFFA8E);
          canvas.translate(0,0,5*k*(01-cos(frameCount*PI/(period*60))));
        } else if (i == 2 && j == 2){
            //canvas.fill(#4EFCD9);
            canvas.translate(0,0,-5*(2-k)*(01-cos(frameCount*PI/(period*60))));
        } else {
          
            canvas.translate(0,0,5*(k-1)*abs((1-cos(frameCount*PI/(period*60)))));
        }
        
        if (frameCount%(period*60) > period*60-flipDuration && i == 2 && j == 2 && k == 2 && frameCount %300 < 150){
          println(frameCount);
          canvas.rotate(map((frameCount%(period*60)),period*60-flipDuration,period*60,0, PI));
        }
        
             canvas.beginShape(QUADS);
   canvas.fill(150,130,0);
   canvas.vertex(-10, -10, 10);
   canvas.vertex(10, -10, 10);
   canvas.vertex(10, 10, 10);
   canvas.vertex(-10, 10, 10);
   canvas.endShape();
  // Top
   canvas.beginShape(QUADS);
   canvas.fill( 255,0,0);
   canvas.vertex(-10, 10, 10);
   canvas.vertex(10, 10, 10);
   canvas.vertex(10, 10, -10);
   canvas.vertex(-10, 10, -10);
   canvas.endShape();
  // Left
   canvas.beginShape(QUADS);
   canvas.fill(255,0,0);
   canvas.vertex(-10, -10, -10);
   canvas.vertex(10, -10, -10);
   canvas.vertex(10, -10, 10);
   canvas.vertex(-10, -10, 10);
   canvas.endShape();
  // Back Right
   canvas.beginShape(QUADS);
   canvas.fill(0,255,75);
   canvas.vertex(10, -10, 10);
   canvas.vertex(10, -10, -10);
   canvas.vertex(10, 10, -10);
   canvas.vertex(10, 10, 10);
   canvas.endShape();
  // Left
  canvas.beginShape(QUADS);
  canvas.fill(0,255,75);
  canvas.vertex(-10, -10, -10);
   canvas.vertex(-10, -10, 10);
   canvas.vertex(-10, 10, 10);
   canvas.vertex(-10, 10, -10);
  canvas.endShape();
        
        
        
        
        canvas.popMatrix();
      }
    }
  }
  ////canvas.
  //canvas.clear();
  //canvas.pushMatrix();
  //canvas.rotateZ(frameCount*PI/(period*120));
  //canvas.fill(#4EFCD9);
  //canvas.box(100,100,25);
  //canvas.rotateZ(frameCount*PI/(period*120));
  //canvas.translate(0,0,-30);
  //canvas.fill(#FC5FFF);
  //canvas.box(100,100,25);
  //canvas.rotateZ(frameCount*PI/(period*120));
  //canvas.translate(0,0,-30);
  //canvas.fill(#FFFA8E);
  //canvas.box(100,100,30);
  //canvas.popMatrix();
  
  canvas.camera(
  165,165,115,
  0,0,0,
  0,0,-1.0);
  canvas.endDraw();
  
  fx.render(canvas)
    .toon()
    //.blur(5,5,false)
    //.blur(15,15,true)
    .compose(toon);
    
  fx.render(canvas)
    .blur(15,15,false)
    .blur(15,15,true)
    .compose(bloom);
  
  blendMode(BLEND);
  image(canvas,0,0);
  blendMode(ADD);
  image(bloom,0,0);
  
  if (render){
    saveFrame("render/####-frufru.tif");
    if(frameCount == period*60*8 + 1){
      noLoop();
    }
  }
  
  
}