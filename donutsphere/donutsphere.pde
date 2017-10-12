int Rd = 15;
int rd = 7;
int donutDetail = 8;

float R = 800;

boolean render = false;

float phi = (sqrt(5)+1)/2 - 1; // golden ratio
float ga = phi*2*PI;           // golden angle

// Amount of donuts
int nbrPoints = 500;

// Hold the donuts
Donut[] box = new Donut[nbrPoints];

PShape donutChunk, glazeChunk; // The actual 3D objects

SpherePoint[] pts = new SpherePoint[nbrPoints];


void setup() {
  size(600, 600, P3D); 
  R = .9 * height/2;


  for (int i= 0; i < nbrPoints; i++) {
    box[i] = new Donut();
  }

  initSphere();

  donutChunk = createShape();
  donutChunk.beginShape(QUADS);
  donutChunk.noStroke();
  for (int i= 0; i < donutDetail+1; i++) {
    for (int j= 0; j < donutDetail+1; j++) {
      float beta = PI/donutDetail+j*TWO_PI/donutDetail;
      float alpha = i*TWO_PI/donutDetail;
      float beta2 = PI/donutDetail+(j+1)*TWO_PI/donutDetail;
      float alpha2 = (i+1)*TWO_PI/donutDetail;
      donutChunk.vertex((Rd-rd*cos(beta))*sin(alpha), (Rd-rd*cos(beta))*cos(alpha), rd*sin(beta));
      donutChunk.vertex((Rd-rd*cos(beta2))*sin(alpha), (Rd-rd*cos(beta2))*cos(alpha), rd*sin(beta2));
      donutChunk.vertex((Rd-rd*cos(beta2))*sin(alpha2), (Rd-rd*cos(beta2))*cos(alpha2), rd*sin(beta2));
      donutChunk.vertex((Rd-rd*cos(beta))*sin(alpha2), (Rd-rd*cos(beta))*cos(alpha2), rd*sin(beta));
    }
  }
  donutChunk.endShape();

  glazeChunk  = createShape();
  glazeChunk.beginShape(QUAD_STRIP);
  glazeChunk.noStroke();
  glazeChunk.fill(#EF82FF);
  for (int i= 0; i < donutDetail+1; i++) {
    for (int j= 0; j < donutDetail/2; j++) {
      float beta = PI/8+j*PI/4;
      float alpha = PI/4;
      glazeChunk.vertex((Rd-rd*cos(beta))*sin(alpha), (Rd-rd*cos(beta))*cos(alpha), rd*sin(beta)+1);
      glazeChunk.vertex((Rd-rd*cos(beta))*sin(alpha+PI/4), (Rd-rd*cos(beta))*cos(alpha+PI/4), rd*sin(beta)+1);
    }
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

  if (render) {
    saveFrame("####_donuts.tif");
    if (frameCount > 720) noLoop();
  }
}

// Code to use phylotaxic packing in spherical coords to plot points
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

// Run through globe positions and draw the donut at each
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