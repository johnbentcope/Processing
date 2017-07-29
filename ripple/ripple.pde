/*color [] colors = {
 #232726,
 #084359,
 #48735A,
 #726158,
 #F1956F
};
*/

boolean render = false;

color [] colors = {
 #5D2626,
 #084359,
 #48735A,
 #726158,
 #F1956F
};


float period = 1;
int fR = 60;

  float frames = fR * period;
int steps = 25;

float[] spacing = new float[steps];

float[] distances = new float[steps+1];

void setup(){
  size(1000,1000);
  
distances[0]=0;
  frameRate(fR);
  noStroke();
  for (int i = 0; i < steps; i++){
    spacing[i] = map(((i+1)*(i+1))/(21.0*25.0),0,8.5,0,700);
    if (i != 23 && i != 24) distances[i+1] = spacing[i]+distances[i];
    println(i + " " + distances[i] + " " + spacing[i]);
  }
  distances[24] = 800; 
  distances[25] = 800; 
  
}

void draw(){
  
  background(colors[0]);
  
  pushMatrix();
  
  translate(0,115);
  for(int i = 0; i < steps-1;i++){
    
    fill(#0AC0A3, map(frameCount%frames,0,frames,map(i,0,24,0,255),map(i+1,0,24,00,255)));
    stroke(colors[0]);
    strokeWeight(2);
    
    beginShape();
    vertex(00,map(frameCount%frames,0,frames,distances[i],distances[i+1]));
    vertex(width-0,map(frameCount%frames,0,frames,distances[i],distances[i+1]));
    vertex(width-0,map(frameCount%frames,0,frames,distances[i+1],distances[i+2]));
    vertex(00, map(frameCount%frames,0,frames,distances[i+1],distances[i+2]));
    
    endShape(CLOSE);
  }
  
  
  for(int i = 0; i < steps-1;i++){
    
    fill(255, map(frameCount%frames,0,frames,map(i,0,24,0,150),map(i+1,0,24,00,150)));
    stroke(colors[0]);
    strokeWeight(2);
    
    beginShape();
    vertex(00,map(frameCount%frames,0,frames,distances[i],distances[i+1]));
    vertex(width-0,map(frameCount%frames,0,frames,distances[i],distances[i+1]));
    vertex(width-0,map(frameCount%frames,0,frames,distances[i+1],distances[i+2]));
    vertex(00, map(frameCount%frames,0,frames,distances[i+1],distances[i+2]));
    
    endShape(CLOSE);
  }
  
  popMatrix();
  noStroke();
  fill(colors[0]);
  beginShape();
  vertex(width/2,0);
  for(float i = 0; i <= 360; i+=0.5){
    vertex(width/2+sin(radians(i))*380.0,height/2-cos(radians(i))*380.0);
  }
  vertex(width/2,0);
  vertex(0,0);
  vertex(0,height);
  vertex(width,height);
  vertex(width,0);
  vertex(width/2,0);
  
  endShape(CLOSE);
  //strokeWeight(5);
  noFill();
  //stroke(colors[0]);
  //ellipse(width/2, height/2,800,800);
  //noLoop();
  
  
  if (render){
    saveFrame("####_ripple.tif");
    if (frameCount == 60*30){
      noLoop();
    }
  }
  
}