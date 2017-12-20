class Particle {
  PVector pos;
  PVector vel;
  float r = 125;
  int w, h;

  PFont fun;
  char ePDNE[] = {'毒', '极', '不', '要', '吃', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'};

  Particle(PGraphics field, int i) {
    w = field.width;
    h = field.height;
    pos = new PVector(i*w/8, h/2 + (i%2 - 0.5) * 6*r);
    vel = new PVector((i%2 - 0.5) * 1 * w/360f, (i%2-0.5) * 4 * (h-4*r)/360f);
    fun = createFont("KozGoPro-Bold", 96, false, ePDNE);

    rectMode(CENTER);
  }

  void update() {
    pos.x += vel.x;
    if (pos.x < -w/2) pos.x += w;
    if (pos.x > w/2) pos.x -= w;
    //if (pos.y < 2*r || pos.y > h-2*r) { 
    //  vel.y*=-1;
    //}
  }

  PGraphics render(PGraphics field) {
    field.textFont(fun, 48);
    field.textAlign(CENTER);
    for (int i = -1; i <= 1; i++) {
      field.pushMatrix();
      field.translate(i*w+pos.x, pos.y);
      field.rotate(frameCount*TWO_PI/360);
      field.fill(#FF4400);
      field.rect(0, 0, 2*r, r);
      field.fill(#FFFFFF);
      field.rect(0, 0, 2*r, r/2);
      field.fill(0);
      field.ellipse(0, 0, 10, 10);
      field.text("不要吃" + (frameCount/10)%10 + "极毒", 0, 10);
      //ellipse(0, 0, r, r);
      field.popMatrix();
    }
    return field;
  }
}