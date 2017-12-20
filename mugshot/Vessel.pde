class Vessel {

  int lumps = 8;
  int period = 4;
  float[] rCache = new float[period];
  int frills = 36;
  int facets = 17;
  int corDetail = period*frills;
  float corThick = 2;
  float R = 50;
  int mB = 0;
  int mH = 150;

  PGraphics  mugSkin;
  Particle[] stickers = new Particle[8];

  Vessel() {

    for ( int i = 0; i < period; i++) {
      rCache[i] = corThick*cos(i*TWO_PI/period+PI/period);
    }

    initMug();
  }

  void initMug() {
    int mSw;
    mSw = (int) ( (R + corThick*2) * sin(TWO_PI/facets)/sin(PI-PI/facets));
    mugSkin = createGraphics(mSw*20, mH*10, P2D);
    for (int i = 0; i < stickers.length; i++) {
      stickers[i] = new Particle(mugSkin, i);
    }
  }

  void updateSkin() {
    mugSkin.beginDraw();
    mugSkin.rectMode(RADIUS);
    hint(ENABLE_DEPTH_SORT);
    hint(ENABLE_DEPTH_TEST);
    mugSkin.background(#AE9072);
    mugSkin.noStroke();
    //  mugSkin.ellipse(mugSkin.width/2, mugSkin.height/2, mugSkin.height, mugSkin.height);
    for (Particle p : stickers) {
      p.update();
      p.render(mugSkin);
    }
    mugSkin.endDraw();
  }

  void render() {
    strokeWeight(2);
    updateSkin();

    // Outer skin
    beginShape(QUADS);
    texture(mugSkin);
    for ( int i = 0; i < facets; i++) {
      int ii = i+1;
      float r  = R + corThick*2;
      float x = r*cos(i*TWO_PI/facets);
      float y = r*sin(-i*TWO_PI/facets);
      float x2 = r*cos(ii*TWO_PI/facets);
      float y2 = r*sin(-ii*TWO_PI/facets);
      vertex(x, y, mB, i*mugSkin.width/facets, mugSkin.height);
      vertex(x, y, 5+mH, i*mugSkin.width/facets, 0);
      vertex(x2, y2, 5+mH, ii*mugSkin.width/facets, 0);
      vertex(x2, y2, mB, ii*mugSkin.width/facets, mugSkin.height);
    }
    endShape();

    // Inner skin
    beginShape(QUADS);
    for ( int i = 0; i < facets; i++) {
      int ii = i+1;
      float r  = R - corThick*2;
      float x = r*cos(i*TWO_PI/facets);
      float y = r*sin(i*TWO_PI/facets);
      float x2 = r*cos(ii*TWO_PI/facets);
      float y2 = r*sin(ii*TWO_PI/facets);
      vertex(x, y, mB);
      vertex(x, y, 10+mH);
      vertex(x2, y2, 10+mH);
      vertex(x2, y2, mB);
    }
    endShape();

    // Corrugation
    beginShape(QUADS);
    fill(#AE9072);
    stroke(#FADCBD);
    for ( int i = 0; i < corDetail; i++) {
      int ii = i+1;
      float r  = R + rCache[i%period]; //+3*corThick*i/corDetail; // use this for overlap experiment
      float x = r*cos(i*TWO_PI/corDetail
        //+ frameCount*TWO_PI/(360*4)
        );
      float y = r*sin(i*TWO_PI/corDetail
        //+ frameCount*TWO_PI/(360*4)
        );
      float r2  = R + rCache[ii%period]; // +3*corThick*i/corDetail;
      float x2 = r2*cos(ii*TWO_PI/corDetail
        //+ frameCount*TWO_PI/(360*4)
        );
      float y2 = r2*sin(ii*TWO_PI/corDetail
        //+ frameCount*TWO_PI/(360*4)
        );
      float h = 10+5*cos(i*TWO_PI*lumps/corDetail - frameCount*TWO_PI/360);
      float h2 = 10+5*cos(ii*TWO_PI*lumps/corDetail - frameCount*TWO_PI/360);
      vertex(x, y, mB);
      vertex(x, y, h+mH);
      vertex(x2, y2, h2+mH);
      vertex(x2, y2, mB);
    }
    endShape();
  }
}