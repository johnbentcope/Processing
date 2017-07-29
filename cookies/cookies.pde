PShape sugar, choco, pinwheel, peanut, fork, black, white;


float goldenAngle = (180.0*(3-sqrt(5)));

int segments = 20;
int cookieRadius = 30;

int cookieHeight = 10;


void setup() {
  size(600, 600, P3D);

  float theta = PI/(segments/2);

  sugar = createShape();
  sugar.beginShape(QUAD_STRIP);
  sugar.noStroke();
  sugar.fill(lerpColor(#EEE8B9, #CEA56B, 0));
  sugar.vertex(0, 0, cookieHeight);
  sugar.vertex(0, 0, cookieHeight);
  sugar.fill(lerpColor(#EEE8B9, #CEA56B, 0.2));

  sugar.vertex(cookieRadius - 5, 0, cookieHeight);
  sugar.vertex((cookieRadius - 5)*cos(theta), (cookieRadius - 5)*sin(theta), cookieHeight);
  sugar.fill(lerpColor(#EEE8B9, #CEA56B, 0.4));

  sugar.vertex(cookieRadius - 2, 0, cookieHeight-2);
  sugar.vertex((cookieRadius - 2)*cos(theta), (cookieRadius - 2)*sin(theta), cookieHeight-2);
  sugar.fill(lerpColor(#EEE8B9, #CEA56B, 0.6));

  sugar.vertex(cookieRadius, 0, cookieHeight-6);
  sugar.vertex((cookieRadius)*cos(theta), (cookieRadius)*sin(theta), cookieHeight-6);
  sugar.fill(lerpColor(#EEE8B9, #CEA56B, 1));

  sugar.vertex(cookieRadius - 2, 0, 0);
  sugar.vertex((cookieRadius - 2)*cos(theta), (cookieRadius - 2)*sin(theta), 0);
  sugar.endShape();

  choco = createShape();
  choco.beginShape(QUAD_STRIP);
  choco.noStroke();
  choco.fill(lerpColor(#AB7237, #85440B, 0));
  choco.vertex(0, 0, cookieHeight);
  choco.vertex(0, 0, cookieHeight);
  choco.fill(lerpColor(#AB7237, #85440B, 0.2));

  choco.vertex(cookieRadius - 5, 0, cookieHeight);
  choco.vertex((cookieRadius - 5)*cos(theta), (cookieRadius - 5)*sin(theta), cookieHeight);
  choco.fill(lerpColor(#AB7237, #85440B, 0.4));

  choco.vertex(cookieRadius - 2, 0, cookieHeight-2);
  choco.vertex((cookieRadius - 2)*cos(theta), (cookieRadius - 2)*sin(theta), cookieHeight-2);
  choco.fill(lerpColor(#AB7237, #85440B, 0.6));

  choco.vertex(cookieRadius, 0, cookieHeight-6);
  choco.vertex((cookieRadius)*cos(theta), (cookieRadius)*sin(theta), cookieHeight-6);
  choco.fill(lerpColor(#AB7237, #85440B, 1));

  choco.vertex(cookieRadius - 2, 0, 0);
  choco.vertex((cookieRadius - 2)*cos(theta), (cookieRadius - 2)*sin(theta), 0);
  choco.endShape();

  black = createShape();
  black.beginShape(QUAD_STRIP);
  black.noStroke();
  black.fill(lerpColor(#210C00, #0F0600, 0));
  black.vertex(0, 0, cookieHeight);
  black.vertex(0, 0, cookieHeight);
  black.fill(lerpColor(#210C00, #0F0600, 0.2));

  black.vertex(cookieRadius - 5, 0, cookieHeight);
  black.vertex((cookieRadius - 5)*cos(theta), (cookieRadius - 5)*sin(theta), cookieHeight);
  black.fill(lerpColor(#210C00, #0F0600, 0.4));

  black.vertex(cookieRadius - 2, 0, cookieHeight-2);
  black.vertex((cookieRadius - 2)*cos(theta), (cookieRadius - 2)*sin(theta), cookieHeight-2);
  black.fill(lerpColor(#210C00, #0F0600, 0.6));

  black.vertex(cookieRadius, 0, cookieHeight-6);
  black.vertex((cookieRadius)*cos(theta), (cookieRadius)*sin(theta), cookieHeight-6);
  black.fill(lerpColor(#210C00, #0F0600, 1));

  black.vertex(cookieRadius - 2, 0, 0);
  black.vertex((cookieRadius - 2)*cos(theta), (cookieRadius - 2)*sin(theta), 0);
  black.endShape();


  white = createShape();
  white.beginShape(QUAD_STRIP);
  white.noStroke();
  white.fill(lerpColor(#FFFFFF, #E3D6C5, 0));
  white.vertex(0, 0, cookieHeight);
  white.vertex(0, 0, cookieHeight);
  white.fill(lerpColor(#FFFFFF, #E3D6C5, 0.2));

  white.vertex(cookieRadius - 5, 0, cookieHeight);
  white.vertex((cookieRadius - 5)*cos(theta), (cookieRadius - 5)*sin(theta), cookieHeight);
  white.fill(lerpColor(#FFFFFF, #E3D6C5, 0.4));

  white.vertex(cookieRadius - 2, 0, cookieHeight-2);
  white.vertex((cookieRadius - 2)*cos(theta), (cookieRadius - 2)*sin(theta), cookieHeight-2);
  white.fill(lerpColor(#FFFFFF, #E3D6C5, 0.6));

  white.vertex(cookieRadius, 0, cookieHeight-6);
  white.vertex((cookieRadius)*cos(theta), (cookieRadius)*sin(theta), cookieHeight-6);
  white.fill(lerpColor(#FFFFFF, #E3D6C5, 1));

  white.vertex(cookieRadius - 2, 0, 0);
  white.vertex((cookieRadius - 2)*cos(theta), (cookieRadius - 2)*sin(theta), 0);
  white.endShape();

  peanut = createShape();
  peanut.beginShape(QUAD_STRIP);
  peanut.noStroke();
  peanut.fill(lerpColor(#F2AC57, #BF5B04, 0));
  peanut.vertex(0, 0, cookieHeight);
  peanut.vertex(0, 0, cookieHeight);
  peanut.fill(lerpColor(#F2AC57, #BF5B04, 0.2));

  peanut.vertex(cookieRadius - 5, 0, cookieHeight);
  peanut.vertex((cookieRadius - 5)*cos(theta), (cookieRadius - 5)*sin(theta), cookieHeight);
  peanut.fill(lerpColor(#F2AC57, #BF5B04, 0.4));

  peanut.vertex(cookieRadius - 2, 0, cookieHeight-2);
  peanut.vertex((cookieRadius - 2)*cos(theta), (cookieRadius - 2)*sin(theta), cookieHeight-2);
  peanut.fill(lerpColor(#F2AC57, #BF5B04, 0.6));

  peanut.vertex(cookieRadius, 0, cookieHeight-6);
  peanut.vertex((cookieRadius)*cos(theta), (cookieRadius)*sin(theta), cookieHeight-6);
  peanut.fill(lerpColor(#F2AC57, #BF5B04, 1));

  peanut.vertex(cookieRadius - 2, 0, 0);
  peanut.vertex((cookieRadius - 2)*cos(theta), (cookieRadius - 2)*sin(theta), 0);
  peanut.endShape();

  fork = createShape();
  fork.beginShape(QUAD_STRIP);
  fork.fill(lerpColor(#F2AC57, #BF5B04, 0.6));
  fork.noStroke();
  fork.vertex(20, 0, cookieHeight+1);
  fork.vertex(20, 0, cookieHeight+1);

  fork.vertex(0, -2, cookieHeight+1);
  fork.vertex(0, 2, cookieHeight+1);

  fork.vertex(-20, 0, cookieHeight+1);
  fork.vertex(-20, 0, cookieHeight+1);
  fork.endShape();

  pinwheel = createShape();
  pinwheel.beginShape(QUAD_STRIP);
  pinwheel.noStroke();
  pinwheel.fill(#8C5423);
  pinwheel.vertex(0, 0, cookieHeight+1);
  pinwheel.vertex(0, 0, cookieHeight+1);

  for (int i = 0; i < 70; i++) {
    pinwheel.vertex( (i/3f)*sin(i*PI/10), (i/3f)*cos(i*PI/10), cookieHeight+1);
    pinwheel.vertex( ( (i/3f)+3)*sin(i*PI/10), ( (i/3f)+3)*cos(i*PI/10), cookieHeight+1);
  }
  pinwheel.endShape();

  frameRate(30);
  rectMode(CORNERS);
}

void draw() {
  background(#D894DC);
  camera(-210, 000, 220, 
    100, 0, 0, 
    0, 0, -1.0);
  pushMatrix();
  translate( 50, 0, 0);
  for ( int i = -2; i < 42; i++ ) {
    pushMatrix();
    translate( i*55, 0, 0);
    rotateY(-PI/5);

    pushMatrix();
    rotateZ(i*PI/4);
    translate(0, 0, 15-15*cos(frameCount*PI/30 + i*PI/8 + PI));
    rotateZ(+ frameCount *PI/30);
    makePinWheelCookie();
    popMatrix();

    if (i > -2) {

      pushMatrix();
      translate(0, cookieRadius*2, 15-15*cos(frameCount*PI/30 + i*PI/8 + PI/2));
      rotateZ(i*PI/4 -frameCount*PI/60f);
      makePeanutCookie();
      popMatrix();

      pushMatrix();
      translate(0, -cookieRadius*2, 15-15*cos(frameCount*PI/30 + i*PI/8 + PI/2));
      rotateZ(i*PI/4 );
      makeChocoCookie(i);
      popMatrix();

      if (i > -1) {

        pushMatrix();
        translate(0, cookieRadius*4, 15-15*cos(frameCount*PI/30 + i*PI/8));
        rotateZ(i*PI/4);
        makeSugarCookie(true, i);
        popMatrix();

        pushMatrix();
        translate(0, -cookieRadius*4, 15-15*cos(frameCount*PI/30 + i*PI/8));
        rotateZ(i*PI/4 -frameCount*PI/60f);
        makeBlackWhiteCookie();
        popMatrix();
      }
    }
    popMatrix();
  }
  popMatrix();
  fill(#E6C3E8);
  pushMatrix();
  translate(0, 0, -20);
  rect(-100, -190, 10000, 190);
  popMatrix();
  println(frameRate + " : " + frameCount);
  if (frameCount <= 1080) saveFrame("render/####_cookies.tif");
}

void makeSugarCookie(boolean sprinkles, int j) {

  for (int i = 0; i < segments; i++) {
    pushMatrix();

    rotateZ(i*PI/(segments/2));

    shape(sugar);

    popMatrix();
  }
  if ( sprinkles) sprinkles(j);
}

void sprinkles(int j) {
  color[] sprinkleColors = {
    color(#FFFF33), // YELLOW
    color(#FF9421), // ORANGE
    color(#FF35D2), // PINK
    color(#3367FF), 
    color(#13F263), 
    color(#E6E8E8), 
    color(#FF3535)
  };
  float a = 0;
  float r = 0;
  float c = 2.5 + 0.5*sin(frameCount*PI/108+ j*PI/8);
  int i = 0;
  while ( r < 25 ) {
    a = i * -goldenAngle;
    r = c * sqrt(i);
    pushMatrix();
    rotateZ(a);
    translate(r, 0, cookieHeight+1);
    rotateX(PI/4);
    rotateY(PI/4);
    fill(sprinkleColors[i%7]);
    noStroke();
    box(1.5);
    popMatrix();
    i++;
  }
}

void makePeanutCookie() {

  for (int i = 0; i < segments; i++) {
    pushMatrix();

    rotateZ(i*PI/(segments/2));

    shape(peanut);

    popMatrix();
  }
  pushMatrix();
  rotateZ(PI/4);
  for (int i = 0; i < 4; i++) {
    pushMatrix();
    translate(0, 10*(i-1.5), 0);
    shape(fork);

    popMatrix();
  }
  popMatrix();
}

void makeChocoCookie(int j) {

  float c =4;
  float r = 0;
  float a = 0;
  for (int i = 0; i < segments; i++) {
    pushMatrix();

    rotateZ(i*PI/(segments/2));

    shape(choco);

    popMatrix();
  }
  for (int i = 0; i < 40; i++) {
    a = i * (goldenAngle + 0.02*sin(frameCount*PI/60f - j*PI/4));
    r = c * sqrt(i);
    pushMatrix();
    rotateZ(a);
    translate(r, 0, 9);
    rotateX(PI/4);
    rotateY(PI/4);
    fill(#260B01);
    box(4);
    popMatrix();
  }
}

void makePinWheelCookie() {
  makeSugarCookie(false, 0);
  shape(pinwheel);
}

void makeBlackWhiteCookie() {
  for (int i = 0; i < segments; i++) {
    pushMatrix();

    rotateZ(i*PI/(segments/2)+3*PI/4 );
    if (i < 10)
      shape(black);
    else 
    shape(white);

    popMatrix();
  }
}