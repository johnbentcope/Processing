int cells = 100;
Particle[] guavas = new Particle[cells];
ArrayList<Glaze> azucar = new ArrayList<Glaze>();

void setup() {
  size(600, 600, P3D);

  for (int i = 0; i < cells; i++) {
    guavas[i] = new Particle(i);
  }

  frameRate(30);
  rectMode(CENTER);
}

void draw() {
  background(#80E8AD);
  for (Particle g : guavas) {
    //rect(p.pos.x, p.pos.y, 3,3);
    g.update();
  }
  camera(-150, 0, 55, 
    0, 0, 0, 
    0, 0, -1.0);

  if (frameCount < 120) {
    azucar.add(new Glaze());
  }

  for (int i = 0; i < 10; i++) {

    makeyTheFlakey(i, bakeTheFlakes(i) );

    pushMatrix();

    scale(-1, 1, -1);

    makeyTheFlakey(i, bakeTheFlakes(i) );

    popMatrix();
  }

  for (int i = 0; i < 5; i++) {

    produceTheJuice();
  }
  pushMatrix();
  translate(0, 0, 40);
  amazeWithGlaze();
  popMatrix();
  fumbleTheCrumbles();


  if (frameCount > 120 && frameCount < 720+120) saveFrame("render/####_patelito_de_guayaba.tif");
  if (frameCount => 720+120) noLoop();
}

PShape bakeTheFlakes(float k) {
  PShape flake;

  k *= 0.4 ;
  k -= 0.5+0.5*sin(frameCount*TWO_PI/120)+0.5*cos(frameCount*TWO_PI/120);
  int flakeDimension = 120;
  int flakeDetail = 10;
  float noiseScale = 5;
  float offset = -flakeDimension/2;
  float w = flakeDimension/flakeDetail;
  color light = #FFF1CC;
  color rich  = #FF941C;
  flake = createShape();

  flake.beginShape(QUADS);
  flake.stroke(255);
  flake.strokeWeight(2);
  for (int i = 0; i < flakeDetail; i++) {
    for (int j = 0; j < flakeDetail; j++) {
      int ii = i+1;
      int jj = j+1;
      flake.fill(lerpColor(light, rich, noise(i/noiseScale, j/noiseScale, k)));
      flake.vertex(offset+i*w, offset+j*w, 4*noise(i/noiseScale, j/noiseScale, k) );
      flake.fill(lerpColor(light, rich, noise(i/noiseScale, jj/noiseScale, k)));
      flake.vertex(offset+i*w, offset+jj*w, 4*noise(i/noiseScale, jj/noiseScale, k) );
      flake.fill(lerpColor(light, rich, noise(ii/noiseScale, jj/noiseScale, k)));
      flake.vertex(offset+ii*w, offset+jj*w, 4*noise(ii/noiseScale, jj/noiseScale, k) );
      flake.fill(lerpColor(light, rich, noise(ii/noiseScale, j/noiseScale, k)));
      flake.vertex(offset+ii*w, offset+j*w, 4*noise(ii/noiseScale, j/noiseScale, k) );
    }
  }
  flake.endShape();
  return flake;
}

void makeyTheFlakey(int i, PShape flake) {
  pushMatrix();

  translate(0, 0, 10+i*3);

  shape(flake);

  popMatrix();
}

void produceTheJuice() { 
  fill(#FF2074,80);
  noStroke();
  for (Particle g : guavas) {
    pushMatrix();
    translate(0, 0, 0.01*g.id-0.5);
    ellipse(g.pos.x, g.pos.y, 20, 20);
    popMatrix();
  }
}

void amazeWithGlaze() {
  for (Glaze s : azucar) {
    s.update();
    s.render();
  }
}

void fumbleTheCrumbles() {
}