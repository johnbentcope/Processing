class Reed {

  int x =0;
  float p = 0;
  float o = 0;
  int t = 0;

  Reed(int xx, float pp, float oo, int tt) {
    x = xx;
    p = pp;
    o = oo;
    t = tt;
  }

  void render(PGraphics canv) {
    canv.strokeCap(ROUND);
    canv.pushMatrix();
    canv.beginShape();
    for (int s = 0; s < 11; s++) {
        canv.stroke(#3D1D00, t);
      if (s ==8 ||s ==7 || s == 9) {
        canv.strokeWeight(40);
      } else {
        canv.strokeWeight(10);
      }
      if (s == 10) {

        canv.line(0, 0, 0, -30);
        canv.translate(0, 0);
      } else {
        canv.line(0, 0, 0, -60);
        canv.translate(0, -58);
      }
      canv.rotateZ(PI/64-PI/128*cos(frameCount/(60*p)*2*PI+o));
    }
    canv.endShape();
    canv.popMatrix();
    println("HERE");
  }
}