class CorrDisk extends CardBoard {

  int outerRad;
  int outerDia;
  int innerRad;
  int innerDia;

  boolean isRing;

  int detail = 20;

  CorrDisk(int outerDia, boolean isRing, int innerDia) {
    this.outerDia = outerDia;
    this.innerDia = innerDia;
    this.isRing = isRing;
    if (!isRing) innerRad = 0;
    outerRad = outerDia>>1;
    innerRad = innerDia>>1;
  }

  void render() {
    drawLiner(true);
    drawLiner(false);
    drawFlutes();
  }

  /*  |x|     x2 + y2 = rad2
   *          y = (+-)sqrt(rad2-x2)
   * ________
   * \0     |
   *  \     |
   *   \    | y
   *    \   |
   * rad \  |
   *      \ |
   *       \|
   */


  void drawFlutes() {
    fill(midtone);
    stroke(highlight);
    beginShape(QUADS);
    for (int i = 0, x = -outerRad; x < outerRad; i++, x+= fluteStep) {
      int ii = i+1;
      int xx = x + fluteStep;
      int h = fluteAmp - ((i/2)%2)*fluteThicc;
      int hh = fluteAmp - ((ii/2)%2)*fluteThicc;
      float yO = sqrt(outerRad*outerRad -x*x);
      float yyO = sqrt(outerRad*outerRad -xx*xx);
      float yI = sqrt(innerRad*innerRad - x*x);
      float yyI = sqrt(innerRad*innerRad - xx*xx);
      if ( abs(x) > innerRad-fluteStep) {
        vertex(x, yO, h);
        vertex(xx, yyO, hh);
        vertex(xx, -yyO, hh);
        vertex(x, -yO, h);
      } else {
        vertex(x, yO, h);
        vertex(xx, yyO, hh);
        vertex(xx, yyI, hh);
        vertex(x, yI, h);
        vertex(x, -yI, h);
        vertex(xx, -yyI, hh);
        vertex(xx, -yyO, hh);
        vertex(x, -yO, h);
        //println("x " + x + " innerRad + " + innerRad + " yI " + yI);
      }
    }
    endShape(CLOSE);
  }

  void drawLiner(boolean top) {
    float sliceAngle = TWO_PI/detail;
    beginShape(QUAD_STRIP);
    fill(midtone);
    noStroke();
    float h = linerAmp;
    if (top) h*=-1;
    for (int i = 0; i <= detail; i++) {
      float currAngle = sliceAngle*i;
      vertex(outerRad*sin(currAngle), outerRad*cos(currAngle), h);
      vertex(innerRad*sin(currAngle), innerRad*cos(currAngle), h);
    }
    endShape(CLOSE);
    beginShape();
    noFill();
    stroke(highlight);
    for (int i = 0; i < detail; i++) {
      int ii = i+1;
      float currAngle = sliceAngle*i;
      float nextAngle = sliceAngle*ii;
      vertex(outerRad*sin(currAngle), outerRad*cos(currAngle), h);
      vertex(outerRad*sin(nextAngle), outerRad*cos(nextAngle), h);
    }
    endShape(CLOSE);

    if (isRing) {
      beginShape();
      noFill();
      stroke(highlight);
      for (int i = 0; i < detail; i++) {
        int ii = i+1;
        float currAngle = sliceAngle*i;
        float nextAngle = sliceAngle*ii;
        vertex(innerRad*sin(currAngle), innerRad*cos(currAngle), h);
        vertex(innerRad*sin(nextAngle), innerRad*cos(nextAngle), h);
      }
      endShape(CLOSE);
    }
  }
}