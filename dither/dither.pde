int shades = 34;
size(272, 80);
PImage[] samples = new PImage[shades];

samples[0] = createImage(8, 16, RGB);
samples[0].loadPixels();
for (int i = 0; i < samples[0].pixels.length; i++) {
  samples[0].pixels[i]=color(0);
}
samples[0].updatePixels();
samples[0].set(0, 0, color(255)); 
samples[0].set(4, 4, color(255));

samples[1] = createImage(8, 16, RGB);
samples[1].loadPixels();
for (int i = 0; i < samples[1].pixels.length; i++) {
  samples[1].pixels[i]=color(0);
}
samples[1].updatePixels();
for (int i = 0; i < 2; i++) {
  for (int j = 0; j < 4; j++) {
    samples[1].set(i*4, j*4, color(255));
  }
}
samples[1].set(0, 4, color(0)); 
samples[1].set(0, 12, color(0));

samples[2] = createImage(8, 16, RGB);
samples[2].loadPixels();
for (int i = 0; i < samples[2].pixels.length; i++) {
  samples[2].pixels[i]=color(0);
}
samples[2].updatePixels();
for (int i = 0; i < 2; i++) {
  for (int j = 0; j < 4; j++) {
    samples[2].set(i*4, j*4, color(255));
  }
}
samples[2].set(2, 2, color(255)); 
samples[2].set(6, 6, color(255));

samples[3] = createImage(8, 16, RGB);
samples[3].loadPixels();
for (int i = 0; i < samples[3].pixels.length; i++) {
  samples[3].pixels[i]=color(0);
}
samples[3].updatePixels();
for (int i = 0; i < 2; i++) {
  for (int j = 0; j < 4; j++) {
    samples[3].set(i*4, j*4, color(255));
  }
}
for (int i = 0; i < 2; i++) {
  for (int j = 0; j < 4; j++) {
    samples[3].set(2+i*4, 2+j*4, color(255));
  }
}
samples[3].set(2, 6, color(0)); 
samples[3].set(2, 14, color(0));

samples[4] = createImage(8, 16, RGB);
samples[4].loadPixels();
for (int i = 0; i < samples[4].pixels.length; i++) {
  samples[4].pixels[i]=color(0);
}
samples[4].updatePixels();
for (int i = 0; i < 2; i++) {
  for (int j = 0; j < 4; j++) {
    samples[4].set(i*4, j*4, color(255));
  }
}
for (int i = 0; i < 2; i++) {
  for (int j = 0; j < 4; j++) {
    samples[4].set(2+i*4, 2+j*4, color(255));
  }
}


samples[5] = createImage(8, 16, RGB);
samples[5].loadPixels();
for (int i = 0; i < samples[5].pixels.length; i++) {
  samples[5].pixels[i]=color(0);
}
samples[5].updatePixels();
for (int i = 0; i < 4; i++) {
  for (int j = 0; j < 8; j++) {
    samples[5].set(i*2, j*2, color(255));
  }
}
for (int i = 0; i < 2; i++) {
  for (int j = 0; j < 4; j++) {
    samples[5].set(i*4, 2+j*4, color(0));
  }
}
samples[5].set(2, 4, color(0)); 
samples[5].set(2, 12, color(0));


samples[6] = createImage(8, 16, RGB);
samples[6].loadPixels();
for (int i = 0; i < samples[6].pixels.length; i++) {
  samples[6].pixels[i]=color(0);
}
samples[6].updatePixels();
for (int i = 0; i < 4; i++) {
  for (int j = 0; j < 8; j++) {
    samples[6].set(i*2, j*2, color(255));
  }
}
for (int i = 0; i < 2; i++) {
  for (int j = 0; j < 4; j++) {
    samples[6].set(i*4, 2+j*4, color(0));
  }
}
samples[6].set(2, 12, color(0));


samples[7] = createImage(8, 16, RGB);
samples[7].loadPixels();
for (int i = 0; i < samples[7].pixels.length; i++) {
  samples[7].pixels[i]=color(0);
}
samples[7].updatePixels();
for (int i = 0; i < 4; i++) {
  for (int j = 0; j < 8; j++) {
    samples[7].set(i*2, j*2, color(255));
  }
}
samples[7].set(4, 2, color(0));
samples[7].set(0, 6, color(0));
samples[7].set(4, 10, color(0));
samples[7].set(0, 14, color(0));


samples[8] = createImage(8, 16, RGB);
samples[8].loadPixels();
for (int i = 0; i < samples[8].pixels.length; i++) {
  samples[8].pixels[i]=color(0);
}
samples[8].updatePixels();
for (int i = 0; i < 4; i++) {
  for (int j = 0; j < 8; j++) {
    samples[8].set(i*2, j*2, color(255));
  }
}
samples[8].set(0, 6, color(0));
samples[8].set(0, 14, color(0));

samples[9] = createImage(8, 16, RGB);
samples[9].loadPixels();
for (int i = 0; i < samples[9].pixels.length; i++) {
  samples[9].pixels[i]=color(0);
}
samples[9].updatePixels();
for (int i = 0; i < 4; i++) {
  for (int j = 0; j < 8; j++) {
    samples[9].set(i*2, j*2, color(255));
  }
}
samples[9].set(1, 1, color(255));
samples[9].set(5, 5, color(255));
samples[9].set(1, 9, color(255));
samples[9].set(5, 13, color(255));

samples[10] = createImage(8, 16, RGB);
samples[10].loadPixels();
for (int i = 0; i < samples[10].pixels.length; i++) {
  samples[10].pixels[i]=color(0);
}
samples[10].updatePixels();
for (int i = 0; i < 4; i++) {
  for (int j = 0; j < 8; j++) {
    samples[10].set(i*2, j*2, color(255));
  }
}
samples[10].set(1, 1, color(255));
samples[10].set(5, 1, color(255));
samples[10].set(5, 5, color(255));
samples[10].set(1, 9, color(255));
samples[10].set(5, 9, color(255));
samples[10].set(5, 13, color(255));


samples[11] = createImage(8, 16, RGB);
samples[11].loadPixels();
for (int i = 0; i < samples[11].pixels.length; i++) {
  samples[11].pixels[i]=color(0);
}
samples[11].updatePixels();
for (int i = 0; i < 4; i++) {
  for (int j = 0; j < 8; j++) {
    samples[11].set(i*2, j*2, color(255));
  }
}
for (int i = 0; i < 3; i++) {
  for (int j = 0; j < 7; j++) {
    samples[11].set(1+i*2, 1+j*2, color(255));
  }
}
samples[11].set(3, 1, color(0));
samples[11].set(1, 3, color(0));
samples[11].set(5, 3, color(0));
samples[11].set(3, 5, color(0));
samples[11].set(1, 7, color(0));
samples[11].set(3, 7, color(0));
samples[11].set(5, 7, color(0));
samples[11].set(3, 9, color(0));
samples[11].set(1, 11, color(0));
samples[11].set(5, 11, color(0));
samples[11].set(3, 13, color(0));
samples[11].set(7, 15, color(255));
samples[11].set(7, 7, color(255));

samples[12] = createImage(8, 16, RGB);
samples[12].loadPixels();
for (int i = 0; i < samples[12].pixels.length; i++) {
  samples[12].pixels[i]=color(0);
}
samples[12].updatePixels();
for (int i = 0; i < 4; i++) {
  for (int j = 0; j < 8; j++) {
    samples[12].set(i*2, j*2, color(255));
  }
}
for (int i = 0; i < 4; i++) {
  for (int j = 0; j < 8; j++) {
    if ( (i%2 == j%2) )
      samples[12].set(1+i*2, 1+j*2, color(255));
  }
}
samples[12].set(3, 7, color(0));
samples[12].set(3, 15, color(0));

samples[13] = createImage(8, 16, RGB);
samples[13].loadPixels();
for (int i = 0; i < samples[13].pixels.length; i++) {
  samples[13].pixels[i]=color(0);
}
samples[13].updatePixels();
for (int i = 0; i < 4; i++) {
  for (int j = 0; j < 8; j++) {
    samples[13].set(i*2, j*2, color(255));
  }
}
for (int i = 0; i < 4; i++) {
  for (int j = 0; j < 8; j++) {
    if ( (i%2 == j%2) )
      samples[13].set(1+i*2, 1+j*2, color(255));
  }
}

samples[14] = createImage(8, 16, RGB);
samples[14].loadPixels();
for (int i = 0; i < samples[14].pixels.length; i++) {
  samples[14].pixels[i]=color(0);
}
samples[14].updatePixels();
for (int i = 0; i < 8; i++) {
  for (int j = 0; j < 16; j++) {
    if ( (i%2 == j%2) )
      samples[14].set(i, j, color(255));
  }
}
for (int i = 0; i < 3; i++) {
  for (int j = 0; j < 3; j++) {
    if ( (i%2 == j%2) ) {
      samples[14].set(1+i*2, 3+j*2, color(0));
      samples[14].set(1+i*2, 11+j*2, color(0));
    }
  }
}


samples[15] = createImage(8, 16, RGB);
samples[15].loadPixels();
for (int i = 0; i < samples[15].pixels.length; i++) {
  samples[15].pixels[i]=color(0);
}
samples[15].updatePixels();
for (int i = 0; i < 8; i++) {
  for (int j = 0; j < 16; j++) {
    if ( (i%2 == j%2) )
      samples[15].set(i, j, color(255));
  }
}
samples[15].set(1,  7, color(0));
samples[15].set(5, 11, color(0));
samples[15].set(1,  15, color(0));

samples[16] = createImage(8, 16, RGB);
samples[16].loadPixels();
for (int i = 0; i < samples[16].pixels.length; i++) {
  samples[16].pixels[i]=color(0);
}
samples[16].updatePixels();
for (int i = 0; i < 8; i++) {
  for (int j = 0; j < 16; j++) {
    if ( (i%2 == j%2) )
      samples[16].set(i, j, color(255));
  }
}
samples[16].set(1,  7, color(0));
samples[16].set(1,  15, color(0));


samples[17] = createImage(8, 16, RGB);
samples[17].loadPixels();
for (int i = 0; i < samples[17].pixels.length; i++) {
  samples[17].pixels[i]=color(0);
}
samples[17].updatePixels();
for (int i = 0; i < 8; i++) {
  for (int j = 0; j < 16; j++) {
    if ( (i%2 == j%2) )
      samples[17].set(i, j, color(255));
  }
}

for (int i = 0; i < 15; i++){
  samples[18+i] = createImage(8,16,RGB);
}

samples[18] = createImage(8, 16, RGB);
samples[19] = createImage(8, 16, RGB);
samples[20] = createImage(8, 16, RGB);
samples[21] = createImage(8, 16, RGB);
samples[22] = createImage(8, 16, RGB);
samples[23] = createImage(8, 16, RGB);
samples[24] = createImage(8, 16, RGB);
samples[25] = createImage(8, 16, RGB);
samples[26] = createImage(8, 16, RGB);
samples[27] = createImage(8, 16, RGB);
samples[28] = createImage(8, 16, RGB);
samples[29] = createImage(8, 16, RGB);
samples[30] = createImage(8, 16, RGB);
samples[31] = createImage(8, 16, RGB);
samples[32] = createImage(8, 16, RGB);
samples[33] = createImage(8, 16, RGB);

for (int s = 18; s < 34; s++){
  
samples[s].loadPixels();
for (int i = 0; i < samples[s].pixels.length; i++) {
  samples[s].pixels[i]=color(0);
}
samples[s].updatePixels();
}

for (int i = 0; i < 16; i++){
  samples[33-i].loadPixels();
  samples[i].loadPixels();
  for(int p = 0; p < samples[i].pixels.length; p++){
    color donor = samples[i+1].pixels[samples[i].pixels.length-1-p];
    if (donor == color(255)){
      donor = color(0);
    } else {
      donor = color(255);
    }
    samples[33-i].pixels[p] = donor;
  }
}

for (int i = 0; i < 34; i++) {
  for (int j = 0; j < 5; j++) {
    image(samples[i], i*8, j*16);
  }
}

saveFrame("dithers.tif");