boolean render = true;

Droplet[] drops;
int countD = 280;

int period = 5;
int frameCt = 0;

void setup(){
  size(1200,1200);
  
  drops = new Droplet[countD];
  
  for (int i = 0; i < countD; i++){
    drops[i] = new Droplet();
  }
  
  frameRate(60);
  fill(255,150);
  //noStroke();
  
  frameCt = int(60*period);
  println(frameCt);
  noStroke();
  //blendMode(ADD);
}

void draw(){
  background(51, 14, 103);

 
  for (int i = 0; i < countD; i++){
    drops[i].render();
  }
  
  if (render){
    saveFrame("####_rain.tif");
    if (frameCount == 60*30){
      noLoop();
    }
  }
}

class Droplet{
  int[] loops = {2,3,4,2,3,4,2,3,4,5,2,3,4,2,3,4,2,3,4,5,6,7,8,15,2,3,4,5,6,7,8,15,12,2,3,4,2,3,4,2,3,4,5,2,3,4,2,3,4,2,3,4,5,6,7,8,15,2,3,4,5,6,7,8,15,12,2,3,4,2,3,4,2,3,4,5,2,3,4,2,3,4,2,3,4,5,6,7,8,15,2,3,4,5,6,7,8,15,12,30,20,45,70};
  int index = int(random(loops.length));
  int r = loops[index];
  
  float domain = (height+40)/r;
  
  int w = 5;
  float h = 10;
  
  int d = int(random(1,4));
  
  int x = int(random(0,width));
  float y = int(random(0,domain));
  float ySp = y;
  
  Droplet(){
    
  }
  
  void reset(){
    y = ySp;
  }
  
  void render(){
    fill(173, 231, 217,150);
    y= ((frameCount+ySp)%frameCt)/frameCt*(domain)-10;
    for (int i = 0; i < r; i++){
      rect(w/2+x, y+(domain)*i, w*0.25*d, h*0.25*d);
    }
      
  }
  
}