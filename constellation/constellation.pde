Star[] stars = new Star[100];
int steps = 5;
float thresh = 100;
int fR = 30;
int duration = fR*20;
int fade = fR*2;
float maxi = 50*sqrt(2)*0.9;

PImage nebR, nebG, nebB, mask;

void setup() {
  size(600, 600);
  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star(i);
  }
  strokeWeight(2);
  frameRate(30);
  background(0);

  mask = createImage(50, 50, RGB);
  mask.loadPixels();
  for (int i = 0; i < mask.pixels.length; i++ ) {
    mask.pixels[i] = color(255*(1-dist(i%50, i/50, 10, 10)/maxi));
  }
  mask.updatePixels();
  nebR = createImage(50, 50, RGB);
  nebR.loadPixels();
  for (int i = 0; i < nebR.pixels.length; i++ ) {
    nebR.pixels[i] = color(10*noise(
      (i%nebR.width)/5f, 
      (i/nebR.height)/5f, 
      0
      ), 10*noise(
      (i%nebR.width)/5f, 
      (i/nebR.height)/5f, 
      0
      ), 0);
  }
  nebR.updatePixels();

  nebG = createImage(50, 50, RGB);
  nebG.loadPixels();
  for (int i = 0; i < nebR.pixels.length; i++ ) {
    nebG.pixels[i] = color(10*noise(
      (i%nebR.width)/5f, 
      (i/nebR.height)/5f, 
      10
      ), 0, 10*noise(
      (i%nebR.width)/5f, 
      (i/nebR.height)/5f, 
      10
      ));
  }
  nebG.updatePixels();

  nebB = createImage(50, 50, RGB);
  nebB.loadPixels();
  for (int i = 0; i < nebR.pixels.length; i++ ) {
    nebB.pixels[i] = color(0, 10*noise(
      (i%nebR.width)/5f, 
      (i/nebR.height)/5f, 
      20
      ), 10*noise(
      (i%nebR.width)/5f, 
      (i/nebR.height)/5f, 
      20
      ));
  }
  nebB.updatePixels();

  nebR.mask(mask);
  nebG.mask(mask);
  nebB.mask(mask);
}

void draw() {
  blendMode(BLEND);
  for (Star s : stars) {
    for (Star c : stars) {
      float d = dist(s.x(), s.y(), c.x(), c.y());
      if (d != 0 && d < thresh ) {
        makeConnection(s.x(), s.y(), c.x(), c.y(), d);
      }
    }
  }

  for (Star s : stars) {
    s.update();
    s.render();
  }
  int test = frameCount%duration;
  if (test < fade) {
    fill(0, (20+(255-(255-20)/fade*test*1.45)));
    println(frameCount + " % " +(20+(255-(255-20)/fade*test*1.45)));
  } else if (test > duration-fade) {
    fill(0, (20+(255-(255-20)/fade*(duration-test)*1.45)));
    println(frameCount + " % " +(20+(255-(255-20)/fade*(duration-test)*1.4)));
  } else {
    fill(0, 20);
    println(frameCount + " % " +20);
  }
  rect(0, 0, width, height);

  blendMode(ADD);
  image(nebR, 0, 0, width, height);
  pushMatrix();
  rotate(PI/2);
  translate(0,-height);
  image(nebG,0,0,width,height);
  popMatrix();
  pushMatrix();
  rotate(-PI/2);
  translate(-width,0);
  image(nebB,0,0,width,height);
  popMatrix();
  //println(frameRate + " + " + frameCount + " % " + (frameCount%duration) + " -- " + (20+(255-(255-20)/fade*test)));
  if (frameCount <= duration) saveFrame("render/####-constellation.tif");
}

void makeConnection(float x1, float y1, float x2, float y2, float d) {
  stroke(255, 255-d*255/thresh);
  int spacing = floor(d/steps);
  for (int i = 0; i <= steps*2; i++) {
    point(lerp(x1, x2, (i*spacing)/d/2), lerp(y1, y2, (i*spacing)/d/2));
  }
  //line(x1,y1,x2,y2);
}