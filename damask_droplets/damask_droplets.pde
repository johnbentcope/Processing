import java.util.*;
// http://www.publicdomainpictures.net/view-image.php?image=53052
ArrayList<PVector> blobs = new ArrayList<PVector>();

PImage wallpaper;
PGraphics mask;
Random generator;

void setup() {
  size(600, 600);
  generator = new Random();
  wallpaper = loadImage("assets/wallpaper.jpg");
  mask = createGraphics(width, height);
  mask.beginDraw();
  mask.background(0);
  mask.ellipse(width/2, height/2, 300, 300);
  mask.endDraw();
  frameRate(30);
}

void draw() {
  float num = (float) generator.nextGaussian();
  float sd = 80;
  float mean = 300;
  float xP = sd * num + mean;
  blendMode(BLEND);
  image(wallpaper, 0, -wallpaper.height+frameCount % wallpaper.height);
  if (frameCount % wallpaper.height < height) {
    image(wallpaper, 0, (frameCount % wallpaper.height));
  }
  if (frameCount < wallpaper.height && (frameCount%20 == 0 || frameCount%12 ==0)) {
    blobs.add(new PVector(xP, random(10, 40), frameCount));
    println("PING " + frameCount + " + " + wallpaper.height);
  }
  mask.beginDraw();
  mask.background(0);
  for (PVector b : blobs) {
    //  if ((b.z%wallpaper.height) >= -20 && (b.z%wallpaper.height) <= height+20) {
    mask.fill(255);
    mask.noStroke();
    //mask.ellipse(b.x, b.z+height/2+(frameCount%wallpaper.height), b.y, b.y);
    //mask.ellipse(b.x, b.z+height/2+(frameCount%wallpaper.height)+wallpaper.height, b.y, b.y);
    mask.ellipse(b.x, b.z+height/2+(frameCount)-wallpaper.height, b.y, b.y);
    mask.fill(255, 150);
    mask.noStroke();
    //mask.ellipse(b.x, b.z+height/2+(frameCount%wallpaper.height), b.y+20, b.y+20);
    //mask.ellipse(b.x, b.z+height/2+(frameCount%wallpaper.height)+wallpaper.height, b.y+20, b.y+20);
    mask.ellipse(b.x, b.z+height/2+(frameCount)-wallpaper.height, b.y+20, b.y+20);
    mask.fill(255, 50);
    mask.noStroke();
    //mask.ellipse(b.x, b.z+height/2+(frameCount%wallpaper.height), b.y+50, b.y+50);
    //mask.ellipse(b.x, b.z+height/2+(frameCount%wallpaper.height)+wallpaper.height, b.y+50, b.y+50);
    //mask.ellipse(b.x, b.z+height/2+(frameCount%wallpaper.height)-wallpaper.height, b.y+50, b.y+50);
    mask.fill(255, 20);
    mask.noStroke();
    //mask.ellipse(b.x, b.z+height/2+(frameCount%wallpaper.height), b.y+100, b.y+100);
    //mask.ellipse(b.x, b.z+height/2+(frameCount%wallpaper.height)+wallpaper.height, b.y+100, b.y+100);
    mask.ellipse(b.x, b.z+height/2+(frameCount)-wallpaper.height, b.y+100, b.y+100);
    // }
  }
  mask.endDraw();
  blendMode(SUBTRACT);
  image(mask, 0, 0, width, height);
  if (frameCount+300 > wallpaper.height/2 && frameCount < wallpaper.height*2-300) saveFrame("render/####_damask_droplets.tif");
  //println(frameCount + " + " + wallpaper.height);
}