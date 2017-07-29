int n = 500;
int c =23;

int[] points;

float goldenAngle = (180.0*(3-sqrt(5)));
float goldenAngleLive = goldenAngle;

int start = 0;

void setup() {
  size(1200, 1200);
frameRate(60);
  //colorMode(HSB);
}

void draw() {
  background(#003038);
  translate(width / 2, height / 2);
  //rotate(n * 0.3);
  for (int i = 0; i < n; i++) {
    float a = i * goldenAngleLive;
    float r = c * sqrt(i);
    float x = r * cos(radians(a));
    float y = r * sin(radians(a));
    //float hu = sin(radians(start + i * 0.5));
    //hu = map(hu, -1, 1, 0, 360);
    //fill(hu, 255, 255);
    float R = map(i,500,0,166,217);
    float G = map(i,500,0,66,169);
    float B = map(i,500,0,8,24);
    //println(G);
    fill(R,G,B);//map(abs(goldenAngleLive-goldenAngle),0.01,0.007,150,255));
    noStroke();
    if (i == 0) x += 10;
    ellipse(x, y, 20, 20);
    
  }
    goldenAngleLive = goldenAngle + PI*sin(frameCount*2*PI/(3600.0));
  
  start += 5;
  
  saveFrame("render/####.tif");
  if (frameCount == 3600){
    noLoop();
    println(goldenAngleLive);
  }
}