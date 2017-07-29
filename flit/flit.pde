PImage[] sprites;
int count = 20;

FireFly[] murmer;
int murmct = 50;

int period = 12;

void setup(){
  size(1200,1200);
  
  ellipseMode(CENTER);
  
  sprites = new PImage[count];
  
  for (int i = 0; i < count; i++){
    String id = nf(i+1,2,0);
    sprites[i] = loadImage("assets/" + id + ".tif");
  }
  
  murmer = new FireFly[murmct];
  
  for (int i = 0; i < murmer.length; i++){
    murmer[i] = new FireFly();
    
  }
  
  
  
  blendMode(ADD);
  
  frameRate(60);
  
  noStroke();
  
  println("0.1 * 1000000000 = " + 0.1 * 1000000000 );
  noLoop();
}

void draw(){
  background(0);
  //strokeWeight(4);
  //stroke(255);
  //line(0,50,width,50);
  //for (int i = 0; i<count; i++){
  //  pushMatrix();
  //  translate(int(i/2)*100,(i%2)*100);
  //  image(sprites[i],0,0);
  //  popMatrix();
  //}
  for (int i = 0; i < murmer.length; i++){
    murmer[i].render();
    
  }
  murmer[0].debug();
  
  //saveFrame("####.tif");
  /*if (frameCount > (period*60)){
    noLoop();
  }*/
}

class FireFly{
  
  PVector pos = new PVector(0,0,0);
  
  float seed = random(-100,100);
  
  float space = random(0,2*PI);
  
  FireFly(){
    
  }
  
  void render(){
    //pushMatrix();
    //translate(pos.x, pos.y, pos.z);
    pushMatrix();
    translate(-600,-600);
  fill(255);
  pos.x = 2400*noise(3.0*sin(frameCount/(period *60.0) + space), seed);
  pos.y = 2400*noise(3.0*cos(frameCount/(period *60.0) + space),-seed);
  pos.z = 40*(noise(3.0*cos(frameCount/(period*60.0) + space),-seed)-0.5);
  image(sprites[abs(int(pos.z))],pos.x,pos.y,50*map(pos.z,-20,20,0.5,2),50*map(pos.z,-20,20,0.5,2));
  popMatrix();
  //fill(0,0,0,50);
  //rect(0,0,width,height);
    //image(sprites[0],0,0);
   // popMatrix();
  }
  
  void debug(){
  println(pos.z);
  }
  
}