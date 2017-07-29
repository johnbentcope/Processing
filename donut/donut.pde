int Rd = 15;
int rd = 7;

float R = 800;

float rotationX = 0;
float rotationY = 0;
float velocityX = 0;
float velocityY = 0;
float pushBack = 0;

float phi = (sqrt(5)+1)/2 - 1; // golden ratio
float ga = phi*2*PI;           // golden angle

int nbrPoints = 500;

Donut[] box = new Donut[nbrPoints];

PShape donutChunk, glazeChunk;


class SpherePoint {
  float  lat, lon;
  SpherePoint(float lat, float lon)
  {
    this.lat = lat;
    this.lon = lon;
  }
};

SpherePoint[] pts = new SpherePoint[nbrPoints];

void initSphere()
{
  for (int i = 0; i < nbrPoints; i++) {
    float lon = ga*i;
    lon /= 2*PI; 
    lon -= floor(lon); 
    lon *= 2*PI;
    if (lon > PI)  lon -= 2*PI;

    // Convert dome height (which is proportional to surface area) to latitude
    float lat = asin(-1 + 2*i/(float)nbrPoints);

    pts[i] = new SpherePoint(lat, lon);
  }
}

void setup() {
  size(600, 600, P3D); 
  R = .9 * height/2;


  for (int i= 0; i < nbrPoints; i++) {
    box[i] = new Donut();
  }

  initSphere();

  donutChunk = createShape();
  donutChunk.beginShape(QUAD_STRIP);
  donutChunk.noStroke();
  for (int j= 0; j < 9; j++) {
    float beta = PI/8+j*PI/4;
    float alpha = PI/4;
    donutChunk.vertex((Rd-rd*cos(beta))*sin(alpha), (Rd-rd*cos(beta))*cos(alpha), rd*sin(beta));
    donutChunk.vertex((Rd-rd*cos(beta))*sin(alpha+PI/4), (Rd-rd*cos(beta))*cos(alpha+PI/4), rd*sin(beta));
  }
  donutChunk.endShape();

  glazeChunk  = createShape();
  glazeChunk.beginShape(QUAD_STRIP);
  glazeChunk.noStroke();
  glazeChunk.fill(#EF82FF);
  for (int j= 0; j < 4; j++) {
    float beta = PI/8+j*PI/4;
    float alpha = PI/4;
    glazeChunk.vertex((Rd-rd*cos(beta))*sin(alpha), (Rd-rd*cos(beta))*cos(alpha), rd*sin(beta)+1);
    glazeChunk.vertex((Rd-rd*cos(beta))*sin(alpha+PI/4), (Rd-rd*cos(beta))*cos(alpha+PI/4), rd*sin(beta)+1);
  }
  glazeChunk.endShape();
}


void draw() {
  background(#FFBEEB);
  noStroke();
  fill(#573620);
  camera(400, 400, 100, 
    0, 0, 0, 
    0, 0, -1.0);


  renderGlobe();

  println(frameRate + " : " + frameCount);

  saveFrame("####_donuts.tif");
  if (frameCount > 720) noLoop();
}

void renderGlobe()
{
  pushMatrix();
  float zRot = frameCount/360f*PI;
  rotateZ( zRot );


  strokeWeight(3);


  for (int i = 0; i < nbrPoints; i++)
  {
    float lat = pts[i].lat;
    float lon = pts[i].lon;

    pushMatrix();
    rotateY( lon);
    rotateZ( -lat);
    float lum = (cos(pts[i].lon+PI*.33+zRot)+1)/2;
    stroke(.5, .5*lum, .2+lum*.8);
    pushMatrix();
    translate(R, 0, 0);
    rotateY(PI/2);
    rotateZ(frameCount/60f*PI);
    box[i].render();
    popMatrix();

    popMatrix();
  }

  popMatrix();
}
class Donut {
  color[] donutColors = {
    color(#FFD18A, 255), // vanilla donut
    color(#FF9188, 255), 
    color(#573620, 255)  // chocolate donut
  };

  color[] sprinkleColors = {
    color(#FFFF33), // YELLOW
    color(#FF9421), // ORANGE
    color(#FF35D2), // PINK
    color(#3367FF), 
    color(#13F263), 
    color(#E6E8E8), 
    color(#FF3535)
  };
  color[] glazeColors = {
    color(#42DEE8, 200), // blue raspberry
    color(#573620, 150), // chocolate donut
    color(#EF82FF, 150), // blurple
    color(#E6E8E8, 150)  // clear glaze
  };

  color[] drizzleColors = {
    color(#42DEE8, 150), 
    color(#573620, 150), 
    color(#FFD18A, 150), 
    color(#E6E8E8, 150)
  };
  int flav = int(random(donutColors.length));
  boolean isGlazed = int(random(4)) <= 2;
  int glaze = int(random(glazeColors.length));
  boolean isSprink = int(random(2)) == 0;
  Sprinkles[] load = new Sprinkles[100];

  Donut() {
    for (int i = 0; i < load.length; i++) {
      load[i] = new Sprinkles(color( sprinkleColors[ int(random(sprinkleColors.length)) ] ));
    }
  }

  void render() {
    for (int i = 0; i < 8; i ++) {
      pushMatrix();
      rotateZ(i*PI/4);
      donutChunk.setFill(donutColors[flav]);
      shape(donutChunk);
      popMatrix();
    }
    if (isGlazed)
      for (int i = 0; i < 8; i ++) {
        pushMatrix();
        rotateZ(i*PI/4);
        translate(0, 0, 1);
        glazeChunk.setFill(glazeColors[glaze]);
        shape(glazeChunk);
        popMatrix();
      }
    if (isSprink) 
      for (Sprinkles s : load) {
        s.render();
      }
  }
}

class Sprinkles {

  PVector pos = new PVector(random(10, 20), random(2*PI), random(2*PI));
  color col;

  Sprinkles(color col) {
    this.col = col;
  }

  void render() {
    stroke(col);
    strokeWeight(2);
    pushMatrix();
    translate(0, 0, 9);
    rotateZ(pos.y);
    translate(pos.x, 0, 0);
    rotateZ(pos.z);
    line(0, 0, 0, 4, 0, 0);
    popMatrix();
  }
}

class Drizle {
}