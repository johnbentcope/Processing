color background = #B68BE0;
color breading = #E88F5F;
color potate = #FFE1CC;
color corn = #F2CE8A;
color pepper = #F8FFC0;
color carne = #E85C10;

void setup() {
  size(600, 600, P3D);
  //frameRate(5);
  lights();
  camera(-120, 0, 100, 
    0, 0, 0, 
    0, 0, -1.0);
}

void draw() {
  background(background);
  rotateZ(frameCount*TWO_PI/1440);
  shape(breadSphere(80, 24));
  rotateZ(frameCount*TWO_PI/1440);
  shape(papaSphere(70, 12));
  rotateZ(-frameCount*TWO_PI/1440);
  shape(papaSphere(60, 12));
  rotateZ(frameCount*TWO_PI/1440);
  shape(papaSphere(50, 12));
  rotateZ(frameCount*TWO_PI/1440);
  shape(meatSphere(40, 12));
  rotateZ(-frameCount*TWO_PI/1440);
  shape(meatSphere(30, 8));
  rotateZ(frameCount*TWO_PI/1440);
  shape(meatSphere(20, 6));
  
  if (frameCount < 720) saveFrame("render/####_ghost_in_the_papas.tif");
  if (frameCount == 720) noLoop();
}

PShape breadSphere(float rad, float detail) {
  PShape papas;

  papas = createShape();

  papas.beginShape(QUADS);
  papas.stroke(255);
  papas.strokeWeight(2);
  papas.fill(breading);

  float arcLon = PI/detail;
  float arcLat = PI/detail;


  println();
  println();
  for (int lat = 0; lat < detail; lat++) {
    for (int lon = 0; lon < detail*2; lon++) {
      if ( ((frameCount/6)%detail-lat)%6 == 0 ) {
        int nexLat = lat+1;
        int nexLon = lon+1;
        papas.vertex(rad*cos(lon*arcLon)*sin(lat*arcLat), rad*sin(lon*arcLon)*sin(lat*arcLat), rad*cos(lat*arcLat));
        papas.vertex(rad*cos(nexLon*arcLon)*sin(lat*arcLat), rad*sin(nexLon*arcLon)*sin(lat*arcLat), rad*cos(lat*arcLat));
        papas.vertex(rad*cos(nexLon*arcLon)*sin(nexLat*arcLat), rad*sin(nexLon*arcLon)*sin(nexLat*arcLat), rad*cos(nexLat*arcLat));
        papas.vertex(rad*cos(lon*arcLon)*sin(nexLat*arcLat), rad*sin(lon*arcLon)*sin(nexLat*arcLat), rad*cos(nexLat*arcLat));
      }
    }
  }

  papas.endShape();

  return papas;
}

PShape papaSphere(float rad, float detail) {
  PShape papas;

  papas = createShape();

  papas.beginShape(QUADS);
  papas.stroke(255);
  papas.strokeWeight(1);
  papas.fill(potate);

  float arcLon = PI/detail;
  float arcLat = PI/detail;
  float w = PI/detail/4f;

  println();
  println();
  for (int lat = 0; lat < detail; lat++) {
    for (int lon = 0; lon < detail*2; lon++) {
      int nexLat = lat+1;
      int nexLon = lon+1;
      papas.vertex(rad*cos(lon*arcLon+w)*sin(lat*arcLat+w), rad*sin(lon*arcLon+w)*sin(lat*arcLat+w), rad*cos(lat*arcLat+w));
      papas.vertex(rad*cos(nexLon*arcLon-w)*sin(lat*arcLat+w), rad*sin(nexLon*arcLon-w)*sin(lat*arcLat+w), rad*cos(lat*arcLat+w));
      papas.vertex(rad*cos(nexLon*arcLon-w)*sin(nexLat*arcLat-w), rad*sin(nexLon*arcLon-w)*sin(nexLat*arcLat-w), rad*cos(nexLat*arcLat-w));
      papas.vertex(rad*cos(lon*arcLon+w)*sin(nexLat*arcLat-w), rad*sin(lon*arcLon+w)*sin(nexLat*arcLat-w), rad*cos(nexLat*arcLat-w));
    }
  }

  papas.endShape();

  return papas;
}

PShape meatSphere(float rad, float detail) {
  PShape papas;

  papas = createShape();

  papas.beginShape(QUADS);
  papas.stroke(255);
  papas.strokeWeight(1);
  papas.fill(potate);

  float arcLon = PI/detail;
  float arcLat = PI/detail;
  float w = PI/detail/6f;

  println();
  println();
  for (int lat = 0; lat < detail; lat++) {
    for (int lon = 0; lon < detail*2; lon++) {
      switch((lat+lon)%3) {
      case 0:
        papas.fill(carne);
        break;
      case 1:
        papas.fill(corn);
        break;
      case 2:
        papas.fill(pepper);
        break;
      }
      int nexLat = lat+1;
      int nexLon = lon+1;
      papas.vertex(rad*cos(lon*arcLon+w)*sin(lat*arcLat+w), rad*sin(lon*arcLon+w)*sin(lat*arcLat+w), rad*cos(lat*arcLat+w));
      papas.vertex(rad*cos(nexLon*arcLon-w)*sin(lat*arcLat+w), rad*sin(nexLon*arcLon-w)*sin(lat*arcLat+w), rad*cos(lat*arcLat+w));
      papas.vertex(rad*cos(nexLon*arcLon-w)*sin(nexLat*arcLat-w), rad*sin(nexLon*arcLon-w)*sin(nexLat*arcLat-w), rad*cos(nexLat*arcLat-w));
      papas.vertex(rad*cos(lon*arcLon+w)*sin(nexLat*arcLat-w), rad*sin(lon*arcLon+w)*sin(nexLat*arcLat-w), rad*cos(nexLat*arcLat-w));
    }
  }

  papas.endShape();

  return papas;
}