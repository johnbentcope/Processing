Nebula[] stellar = new Nebula[5];

color[] field = {
  #7A0C41, 
  #054B76, 
  #1A95A2, 
  #18731B, 
  #BB781A
};

int period = 12;
float[] sineCache = new float[30*period];

int fade = 30;
int fadePos = 0;
float fader = 0;

void setup() {
  size(600, 600);
  for ( int i = 0; i < stellar.length; i++) {
    stellar[i] = new Nebula(field[i], i);
    println(i);
  }

  for (int i = 0; i < period*30; i++) {
    sineCache[i] = sin(i*PI/60f);
  }

  frameRate(30);
}

void draw() {
  background(0);
  if (frameCount < 30 || frameCount > 720-30) {
    fadePos = min((frameCount%720), 720-(frameCount%720));
    fader = abs( fadePos/30f);
  } else {
    fader = 1;
  }
  fader = constrain(fader, 0, 1);
  println(fader + " + " + frameCount);
  for ( int i = 0; i < stellar.length; i++) {
    stellar[i].render();
  }
  //println(frameCount + " + " + frameRate);
  if (frameCount < 720) saveFrame("render/####_nebulae");
}