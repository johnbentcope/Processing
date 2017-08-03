
class Cookie {

  PShape sugar, choco, pinwheel, peanut, fork, black, white;
  PVector pos;
  PVector vel;
  int type;
  float theta = PI/(segments/2);
float dt = 0.005;

  Cookie(int type, PVector pos, PVector vel) {
    this.type = type;
    this.pos = pos;
    this.vel = vel;

    sugar = createShape();
    sugar.beginShape(QUAD_STRIP);
    sugar.noStroke();
    sugar.fill(lerpColor(#EEE8B9, #CEA56B, 0));
    sugar.vertex(0, 0, cookieHeight);
    sugar.vertex(0, 0, cookieHeight);
    sugar.fill(lerpColor(#EEE8B9, #CEA56B, 0.2));

    sugar.vertex(cookieRadius *0.83, 0, cookieHeight);
    sugar.vertex((cookieRadius *0.83)*cos(theta), (cookieRadius *0.83)*sin(theta), cookieHeight);
    sugar.fill(lerpColor(#EEE8B9, #CEA56B, 0.4));

    sugar.vertex(cookieRadius *0.93, 0, cookieHeight*0.8);
    sugar.vertex((cookieRadius - 2)*cos(theta), (cookieRadius *0.93)*sin(theta), cookieHeight*0.8);
    sugar.fill(lerpColor(#EEE8B9, #CEA56B, 0.6));

    sugar.vertex(cookieRadius, 0, cookieHeight*0.6);
    sugar.vertex((cookieRadius)*cos(theta), (cookieRadius)*sin(theta), cookieHeight*0.6);
    sugar.fill(lerpColor(#EEE8B9, #CEA56B, 1));

    sugar.vertex(cookieRadius *0.93, 0, 0);
    sugar.vertex((cookieRadius *0.93)*cos(theta), (cookieRadius *0.93)*sin(theta), 0);
    sugar.endShape();

    choco = createShape();
    choco.beginShape(QUAD_STRIP);
    choco.noStroke();
    choco.fill(lerpColor(#AB7237, #85440B, 0));
    choco.vertex(0, 0, cookieHeight);
    choco.vertex(0, 0, cookieHeight);
    choco.fill(lerpColor(#AB7237, #85440B, 0.2));

    choco.vertex(cookieRadius*0.83, 0, cookieHeight);
    choco.vertex((cookieRadius *0.83)*cos(theta), (cookieRadius*0.83)*sin(theta), cookieHeight);
    choco.fill(lerpColor(#AB7237, #85440B, 0.4));

    choco.vertex(cookieRadius *0.93, 0, cookieHeight*0.8);
    choco.vertex((cookieRadius *0.93)*cos(theta), (cookieRadius*0.93)*sin(theta), cookieHeight*0.8);
    choco.fill(lerpColor(#AB7237, #85440B, 0.6));

    choco.vertex(cookieRadius, 0, cookieHeight*0.6);
    choco.vertex((cookieRadius)*cos(theta), (cookieRadius)*sin(theta), cookieHeight*0.6);
    choco.fill(lerpColor(#AB7237, #85440B, 1));

    choco.vertex(cookieRadius *0.93, 0, 0);
    choco.vertex((cookieRadius *0.93)*cos(theta), (cookieRadius *0.93)*sin(theta), 0);
    choco.endShape();

    black = createShape();
    black.beginShape(QUAD_STRIP);
    black.noStroke();
    black.fill(lerpColor(#210C00, #0F0600, 0));
    black.vertex(0, 0, cookieHeight);
    black.vertex(0, 0, cookieHeight);
    black.fill(lerpColor(#210C00, #0F0600, 0.2));

    black.vertex(cookieRadius *0.83, 0, cookieHeight);
    black.vertex((cookieRadius *0.83)*cos(theta), (cookieRadius *0.83)*sin(theta), cookieHeight);
    black.fill(lerpColor(#210C00, #0F0600, 0.4));

    black.vertex(cookieRadius *0.93, 0, cookieHeight*0.8);
    black.vertex((cookieRadius *0.93)*cos(theta), (cookieRadius *0.93)*sin(theta), cookieHeight*0.8);
    black.fill(lerpColor(#210C00, #0F0600, 0.6));

    black.vertex(cookieRadius, 0, cookieHeight*0.6);
    black.vertex((cookieRadius)*cos(theta), (cookieRadius)*sin(theta), cookieHeight*0.6);
    black.fill(lerpColor(#210C00, #0F0600, 1));

    black.vertex(cookieRadius *0.93, 0, 0);
    black.vertex((cookieRadius *0.93)*cos(theta), (cookieRadius *0.93)*sin(theta), 0);
    black.endShape();


    white = createShape();
    white.beginShape(QUAD_STRIP);
    white.noStroke();
    white.fill(lerpColor(#FFFFFF, #E3D6C5, 0));
    white.vertex(0, 0, cookieHeight);
    white.vertex(0, 0, cookieHeight);
    white.fill(lerpColor(#FFFFFF, #E3D6C5, 0.2));

    white.vertex(cookieRadius *0.83, 0, cookieHeight);
    white.vertex((cookieRadius *0.83)*cos(theta), (cookieRadius *0.83)*sin(theta), cookieHeight);
    white.fill(lerpColor(#FFFFFF, #E3D6C5, 0.4));

    white.vertex(cookieRadius *0.93, 0, cookieHeight*0.8);
    white.vertex((cookieRadius *0.93)*cos(theta), (cookieRadius *0.93)*sin(theta), cookieHeight*0.8);
    white.fill(lerpColor(#FFFFFF, #E3D6C5, 0.6));

    white.vertex(cookieRadius, 0, cookieHeight*0.6);
    white.vertex((cookieRadius)*cos(theta), (cookieRadius)*sin(theta), cookieHeight*0.6);
    white.fill(lerpColor(#FFFFFF, #E3D6C5, 1));

    white.vertex(cookieRadius *0.93, 0, 0);
    white.vertex((cookieRadius *0.93)*cos(theta), (cookieRadius *0.93)*sin(theta), 0);
    white.endShape();

    peanut = createShape();
    peanut.beginShape(QUAD_STRIP);
    peanut.noStroke();
    peanut.fill(lerpColor(#F2AC57, #BF5B04, 0));
    peanut.vertex(0, 0, cookieHeight);
    peanut.vertex(0, 0, cookieHeight);
    peanut.fill(lerpColor(#F2AC57, #BF5B04, 0.2));

    peanut.vertex(cookieRadius*0.83, 0, cookieHeight);
    peanut.vertex((cookieRadius *0.83)*cos(theta), (cookieRadius*0.83)*sin(theta), cookieHeight);
    peanut.fill(lerpColor(#F2AC57, #BF5B04, 0.4));

    peanut.vertex(cookieRadius *0.93, 0, cookieHeight*0.8);
    peanut.vertex((cookieRadius *0.93)*cos(theta), (cookieRadius *0.93)*sin(theta), cookieHeight*0.8);
    peanut.fill(lerpColor(#F2AC57, #BF5B04, 0.6));

    peanut.vertex(cookieRadius, 0, cookieHeight*0.6);
    peanut.vertex((cookieRadius)*cos(theta), (cookieRadius)*sin(theta), cookieHeight*0.6);
    peanut.fill(lerpColor(#F2AC57, #BF5B04, 1));

    peanut.vertex(cookieRadius *0.93, 0, 0);
    peanut.vertex((cookieRadius *0.93)*cos(theta), (cookieRadius *0.93)*sin(theta), 0);
    peanut.endShape();

    fork = createShape();
    fork.beginShape(QUAD_STRIP);
    fork.fill(lerpColor(#F2AC57, #BF5B04, 0.6));
    fork.noStroke();
    fork.vertex(cookieRadius*0.6, 0, cookieHeight+1);
    fork.vertex(cookieRadius*0.6, 0, cookieHeight+1);

    fork.vertex(0, -cookieRadius*0.06, cookieHeight+1);
    fork.vertex(0, cookieRadius*0.06, cookieHeight+1);

    fork.vertex(-cookieRadius*0.6, 0, cookieHeight+1);
    fork.vertex(-cookieRadius*0.6, 0, cookieHeight+1);
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
  }

  void update() {
    vel.x = (sigma*(pos.y-pos.x))*dt;
    vel.y = (pos.x*(rho-pos.z)-pos.y)*dt;
    vel.z = (pos.x*pos.y-beta*pos.z)*dt;
    pos.add(vel);
  }

  void render() {
    switch(type) {
    case 0:
      makeSugarCookie(false, 0);
      break;

    case 1:
      makeSugarCookie(true, 0);
      break;

    case 2:
      makeChocoCookie();
      break;

    case 3:
      makePeanutCookie();
      break;

    case 4:
      makeBlackWhiteCookie();
      break;
    }
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
    float c = cookieRadius*0.08;
    int i = 0;
    while ( r < cookieRadius*0.8 ) {
      a = i * -goldenAngle;
      r = c * sqrt(i);
      pushMatrix();
      rotateZ(a);
      translate(r, 0, cookieHeight+1);
      rotateX(PI/4);
      rotateY(PI/4);
      fill(sprinkleColors[i%7]);
      noStroke();
      box(cookieHeight/3f);
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
      translate(0, cookieRadius*0.33*(i-1.5), 0);
      shape(fork);

      popMatrix();
    }
    popMatrix();
  }

  void makeChocoCookie() {

    float c = cookieRadius*0.15;
    float r = 0;
    float a = 0;
    for (int i = 0; i < segments; i++) {
      pushMatrix();

      rotateZ(i*PI/(segments/2));

      shape(choco);

      popMatrix();
    }
    for (int i = 0; i < 40; i++) {
      a = i * (goldenAngle); // + 0.02*sin(frameCount*PI/60f));
      r = c * sqrt(i);
      pushMatrix();
      rotateZ(a);
      translate(r, 0, cookieHeight*0.9);
      rotateX(PI/4);
      rotateY(PI/4);
      fill(#260B01);
      box(cookieHeight/3f);
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
}