class Nebula {

  color tint;
  int id;
  PGraphics cloud, mask;
  Particle[] runner = new Particle[5];

  Nebula(color tint, int id) {
    for (int i = 0; i < runner.length; i++) {
      runner[i] = new Particle();
    }
    this.tint = tint;
    this.id = id;
    cloud = createGraphics(width, height);
    cloud.noStroke();
    mask = createGraphics(width, height);
  }

  void update() {
    cloud.beginDraw();
    cloud.loadPixels();
    for (int i = 0; i < width; i++) { 
      for (int j = 0; j < height; j++) {
        cloud.pixels[i+j*width] = lerpColor(0, tint, (noise(i/100f, j/100f, id*20+sineCache[(frameCount+id*20)%120])));
      }
    }
    cloud.updatePixels();
    cloud.endDraw();
    mask.beginDraw();
    mask.background(0);
    for (Particle r : runner) {
      r.update();
      r.render(mask);
    }
    mask.endDraw();
  }

  void render() {
    update();
    blendMode(ADD);
    cloud.mask(mask);
    image(cloud, 0, 0);
  }
}