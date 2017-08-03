PVector pos;
PVector vel;

float sigma = 15;
float beta = 11/3.0;
float rho = 28;
float dt = 0.01;
PShape swirlie;

float goldenAngle = (180.0*(3-sqrt(5)));
int segments = 20;
int cookieRadius = 4;

int cookieHeight = 1;

Cookie[] cookies = new Cookie[15];

void setup() {
  size(600, 600, P3D);
  pos = new PVector(5.51, 10, 20);
  vel = new PVector(0, 0, 0);
  swirlie = createShape();
  swirlie.beginShape();
  swirlie.noFill();
  swirlie.stroke(255);
  swirlie.endShape();
  for (int i = 0; i < cookies.length; i++) {
    cookies[i] = new Cookie(i%5, new PVector(random(-20,20), random(-20,20), random(0,30)) , new PVector(0, 0, 0));
  }
  perspective(PI/3.0, width/height, 0.01,1000);
}

void draw() {
  PVector cameraPos = new PVector( 90*sin(frameCount*PI/320f), 90*cos(frameCount*PI/320f), 40);

  camera( cameraPos.x, cameraPos.y, cameraPos.z, 
    0, 0, 20, 
    0, 0, -1.0);
  background(#51086E);
  vel.x = (sigma*(pos.y-pos.x))*dt;
  vel.y = (pos.x*(rho-pos.z)-pos.y)*dt;
  vel.z = (pos.x*pos.y-beta*pos.z)*dt;
  pos.add(vel);
  swirlie.beginShape();
  swirlie.stroke(lerpColor(#F277B0, #F2F2F2, vel.mag()/2f));
  swirlie.vertex(pos.x*2, pos.y*2, pos.z);
  swirlie.endShape();
  shape(swirlie);
  for (int i = 0; i < cookies.length; i++) {
    pushMatrix();
    translate(cookies[i].pos.x*2, cookies[i].pos.y*2, cookies[i].pos.z);
    println(
      degrees(atan((cameraPos.y-cookies[i].pos.y)/(float)(cameraPos.x-cookies[i].pos.x)))
      );
    if ((cameraPos.y-cookies[i].pos.y) < 0 && (cameraPos.x-cookies[i].pos.x) < 0) rotateZ(PI);
    rotateZ( atan((cameraPos.y-cookies[i].pos.y)/(float)(cameraPos.x-cookies[i].pos.x)) );
    rotateY(  PI/2-asin( (cameraPos.z-cookies[i].pos.z)/( dist(cookies[i].pos.x, cookies[i].pos.y, cookies[i].pos.z, cameraPos.x, cameraPos.y, cameraPos.z) ) ) );
    //rotateZ( frameCount*PI/60 );
    cookies[i].render();
    popMatrix();
    cookies[i].update();
  }
  println(pos.x, pos.y, pos.z, vel.mag()/2f);
  if (frameCount < 2160 && frameCount %3 == 0) saveFrame("render/####_lorenzeCookies.tif");
if (frameCount > 2160) noLoop();
}