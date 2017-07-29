
PImage mask;
int bogSize = 600;
int gridSize = 3;
int[] bog = new int[bogSize*bogSize];
void setup() {
  size(600, 600, P3D);
  for (int i = 0; i < bogSize; i++) {
    for (int j = 0; j < bogSize; j++) {
      bog[i+j*bogSize] = floor(255*noise(i/50f, j/50f));
    }
  }
  frameRate(30);
  camera(-0, (bogSize*gridSize/2), 250, 
    (bogSize*gridSize/2)-300, (bogSize*gridSize/2), -200, 
    0, 0, -1.0);
}

void draw() {
  for (int i = 0; i < bogSize; i++) {
    for (int j = 0; j < bogSize; j++) {
      bog[i+j*bogSize] = floor(255*noise(i/50f, j/50f, 0.5*sin(frameCount*PI/60f)));
    }
  }
  background(0);
  noStroke();
  println(frameCount + " + " + frameRate);
  //image(bogMask, 0, 0);
  drawPeat();
  drawWater();
  drawGrass();
  saveFrame("render/####_bog.tif");
}

void drawPeat() {
  for (int i = 0; i < bogSize-2; i++) {
    for (int j = 0; j < bogSize-2; j++) {
      int ii = i+1;
      int jj = j+1;
      beginShape(QUAD);

      getBogfill(floor(brightness(bog[i+j*bogSize])/13));
      vertex(i*gridSize, j*gridSize, bog[i+j*bogSize]/2+(5* floor(brightness(bog[i+j*bogSize])/13)) );

      getBogfill(floor(brightness(bog[i+jj*bogSize])/13));
      vertex(i*gridSize, jj*gridSize, bog[i+jj*bogSize]/2+(5* floor(brightness(bog[i+jj*bogSize])/13)) );

      getBogfill(floor(brightness(bog[ii+jj*bogSize])/13));
      vertex(ii*gridSize, jj*gridSize, bog[ii+jj*bogSize]/2+(5* floor(brightness(bog[ii+jj*bogSize])/13)) );

      getBogfill(floor(brightness(bog[ii+j*bogSize])/13));
      vertex(ii*gridSize, j*gridSize, bog[ii+j*bogSize]/2+(5* floor(brightness(bog[ii+j*bogSize])/13)) );
      //println( bog[ii+j*bogSize]/2+(20* floor(brightness(bog[ii+j*bogSize])/51)) );

      endShape();
    }
  }
}

void getBogfill(int b) {
  if (b < 3 ) {
    //fill(#5A0078);
    fill(lerpColor(#5A0078, #7601A3, (b-3)/3f));
  } else if ( b < 6) {

    //fill(#7601A3);
    fill(lerpColor(#7601A3, #7A6A50, (b-3)/3f));
  } else if ( b < 9) {

    //fill(#7A6A50);
    fill(lerpColor(#7A6A50, #40885D, (b-6)/3f));
  } else if ( b < 12) {
    // fill(#40885D);
    fill(lerpColor(#40885D, #255B49, (b-9)/3f));
  } else {
    fill(#255B49);
  }
  //println(b);
}

void drawWater() {
  for (int i = 0; i < bogSize-2; i++) {
    for (int j = 0; j < bogSize-2; j++) {
      int ii = i+1;
      int jj = j+1;
      beginShape(QUAD);
      
      fill(255, 30+50*noise(i/50f, j/50f, sin(frameCount*PI/60f)));
      vertex(i*gridSize, j*gridSize,80);

      fill(255, 30+50*noise(i/50f, jj/50f, sin(frameCount*PI/60f)));
      vertex(i*gridSize, jj*gridSize,80);

      fill(255, 30+50*noise(ii/50f, jj/50f, sin(frameCount*PI/60f)));
      vertex(ii*gridSize, jj*gridSize,80);

      fill(255, 30+50*noise(ii/50f, j/50f, sin(frameCount*PI/60f)));
      vertex(ii*gridSize, j*gridSize,80);
      endShape();
    }
  }
}

void drawGrass() {
}