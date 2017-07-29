boolean render = false;

void setup(){
  size(1200,1200);
  

  frameRate(60);
  fill(255,150);
  //noStroke();
  
  noStroke();
  //blendMode(ADD);
}

void draw(){
  background(71, 27, 98);
  for (int i = 0; i < width/50; i++){
    for (int j = 0; j < height/50; j++){
      strokeWeight(1);
      fill(173, 231, 217,noise(i,j,sin(frameCount/(60.0)))*150+105);
      rect(i*50+2,j*50+2,46,46);
    }
  }
  noStroke();
  blendMode(MULTIPLY);
  
  fill(34, 13, 51,150);
  rect(900,150,200,height);
  //blendMode(MULTIPLY);
  beginShape();
  
  vertex(0,50);
  vertex(450,200);
  vertex(450,height-200);
  vertex(0,height-50);
  
  endShape(CLOSE);
  
  fill(34, 13, 51,100);
  beginShape();
  
  vertex(0,0);
  vertex(450,150);
  vertex(450,50);
  vertex(0,-100);
  
  endShape(CLOSE);
  
  fill(34, 13, 51, 150);
  rect(700,000,150,height-400);
  rect(700,height-350,150,150);
  fill( 241, 23, 82, 150);
  rect(500,400,150,height);
  rect(500,200,150,50);
  
  rect(500,300,150,50);
  blendMode(BLEND);
  
  
  if (render){
    saveFrame("####_tile.tif");
    if (frameCount == 60*30){
      noLoop();
    }
  }
}