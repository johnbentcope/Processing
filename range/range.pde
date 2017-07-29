int spacing = 40;
PImage sps = createImage(1200, 1200, RGB);
PGraphics range;
boolean render = false;

void setup() {
  size(1200, 1200);

  //noiseSeed(420);

  sps.loadPixels();
  for (int i = 0; i < sps.pixels.length; i++) {
    sps.pixels[i] = color(#A3C500);
  }
  sps.updatePixels();
  println("Loaded 1");
  range = createGraphics(width*7,height);
  
  range.beginDraw();
  range.background(0);
  for (int x = 0; x < width*6; x++) {

    int h = floor( height/4 * noise( 100+1*sin(x*PI/3000), 100+1*cos(x*PI/3000) ) );

      range.strokeWeight(1);
      range.stroke(255);
      range.line(x, h, x, height);
      println("Loaded 2 : " + x);
  }
  println(range.width);
  range.endDraw();
  noStroke();
}

void draw() {
  background(#F4F4F4);
  PImage stripes = sps;
  PImage mask = range.get( ( frameCount*6 + width * 0) % 6000 , 0, 1200, 1200);
  stripes.mask(mask);
  image(stripes, 0, 0);
  fill(#F4F4F4, 100);

  rect(0, 0, 1200, 1200);
  stripes = sps.get(0, 0, 1200, 1200);
  mask = range.get( ( frameCount*6 + width * 1) % 6000 , -height/5, 1200, 1200);
  stripes.mask(mask);
  image(stripes, 0, 0);

  rect(0, 0, 1200, 1200);
  stripes = sps.get(0, 0, 1200, 1200);
  mask = range.get( ( frameCount*6 + width * 2) % 6000 , -2*height/5, 1200, 1200);
  stripes.mask(mask);
  image(stripes, 0, 0);
  
  rect(0, 0, 1200, 1200);
  stripes = sps.get(0, 0, 1200, 1200);
  mask = range.get( ( frameCount*6 + width * 3) % 6000 , -3*height/5, 1200, 1200);
  stripes.mask(mask);
  image(stripes, 0, 0);

  
  rect(0, 0, 1200, 1200);
  stripes = sps.get(0, 0, 1200, 1200);
  mask = range.get( ( frameCount*6 + width * 4) % 6000 , -4*height/5, 1200, 1200);
  stripes.mask(mask);
  image(stripes, 0, 0);
  
  //println(( frameCount*6 + width * 4) % 6000);
  
  println("FC : " + frameCount);
  if (render){
    saveFrame("####-range.tif");
  if (frameCount > 1000){
    noLoop();
  }
  }
}