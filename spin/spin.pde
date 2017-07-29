Ring[] rings;
int count = 20;

float radius = 60;

void setup(){
  size(1300,1300,P3D);
  blendMode(ADD);
  frameRate(60);
  
  rings = new Ring[count];
  
  for (int i = 0; i < count; i++){
    rings[i] = new Ring();
  }
  
  
}

void draw(){
  camera(150*cos(frameCount/600.0), 150*sin(frameCount/600.0), 150, // eyeX, eyeY, eyeZ
         0.0, 0.0, 0.0, // centerX, centerY, centerZ
         0.0, 0.0, -1.0); // upX, upY, upZ
  background(#1c1c1c);
  for (int i = 0; i < count; i++){
    rings[i].render();
  }
  stroke(255,50);
  strokeWeight(4);
  //stroke(#FF0000);
  line(2,0,0,50,0,0);
  //stroke(#00FF00);
  line(0,2,0,0,50,0);
  //stroke(#0000FF);
  line(0,0,2,0,0,50);
  //stroke(#FF0000);
  line(-2,0,0,-50,0,0);
  //stroke(#00FF00);
  line(0,-2,0,0,-50,0);
  //stroke(#0000FF);
  line(0,0,-2,0,0,-50);
  //saveFrame("####.tif");
  //if (frameCount >= 900) noLoop();
}

class Ring {
  
  int w = 5;
  int h = 100;
  
  float s = random(60,105);
  float s2 = random(10,50);
  
  float phi = random(0,PI);
  float theta = random(0,2*PI);
  
  color c1 = color(random(150,255), random( 00,155), random( 00,155), 150); 
  color c2 = color(random( 00,155), random(150,255), random( 00,155), 150); 
  color c3 = color(random( 00,155), random( 00,155), random(150,255), 150); 
  Ring(){
    
  }
  
  void render(){
    noStroke();
    pushMatrix();
    
    rotateZ(theta);
    rotateX(theta);
      
      pushMatrix();
        fill(c1);
        rotateY(phi + frameCount/(s*PI));
        translate(  0,   0, radius);
        rect(-w/2,-h/2,w,h);
        translate(  0,   0, -2*radius);
        rect(-w/2,-h/2,w,h);
      popMatrix();
      
      pushMatrix();
        fill(c2);
        rotateY(phi + 1*PI/3 + frameCount/(s*PI));
        translate(  0,   0, radius);
        rect(-w/2,-h/2,w,h);
        translate(  0,   0, -2*radius);
        rect(-w/2,-h/2,w,h);
      popMatrix();
      
      pushMatrix();
        fill(c3);
        rotateY(phi + 2*PI/3 + frameCount/(s*PI));
        translate(  0,   0, radius);
        rect(-w/2,-h/2,w,h);
        translate(  0,   0, -2*radius);
        rect(-w/2,-h/2,w,h);
      popMatrix();
    popMatrix();
  }
}