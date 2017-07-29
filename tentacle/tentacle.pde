
Arm[] arms = new Arm[100];

color shadow = #9938A6;
color highlight = #C548D6;

PImage vignette, vigNoise;


float goldenAngle = (180.0*(3-sqrt(5)));

void setup() {
  size(600, 600, P3D);
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
  for (int i =0; i< arms.length; i++) {
    arms[i] = new Arm(0.9, 25, 13, 20, i);
  }


  noStroke();
  frameRate(30);
}

void draw() {
  blendMode(MULTIPLY);
  background(#566B2C);
  pushMatrix();
  translate(width/2, height/2);
  for (int i = arms.length-1; i >= 0; i--) {
    pushMatrix();
    rotate(i*goldenAngle);

    translate(0, -2*sqrt(i)+5);
    scale(0.5+i/50f);

    arms[i].render();
    popMatrix();
  }
  popMatrix();
  image(vignette, 0, 0);
  if (frameCount < 480) saveFrame("render/####_tentacle.tif");
  else noLoop();
}