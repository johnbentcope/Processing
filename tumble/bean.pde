class Bean {

  PVector pos;
  int steps = 30;
  int twists = 10;
  int rings = 20;

  PVector curr;
  float l = 475;
  float r = 200;

  PVector innr;

  Bean(PVector post) {
    pos = post;
    curr = new PVector(0, 0, 0);
    innr = new PVector(0, 0, 0);
  }

  void render2() {
    pushMatrix();
    translate(width/2, height/2);
    rotateZ(pos.x);
    rotateY(frameCount/60f*pos.z);
    translate(pos.y, 0, 0);
    println(pos.z);
    sphere(25);

    popMatrix();
  }

  void render() {
    for (int v = 0; v < rings; v ++) {

      for (int i = 0; i < steps; i++) {
        canvas.pushMatrix();
        float betaC = 2*PI*(v/float(rings)+frameCount/180f);
        float alphaC = radians(360*i/steps+1.2*v);


        curr.x = (l-r*sin(betaC))*sin(alphaC);
        curr.y = (l-r*sin(betaC))*cos(alphaC);
        curr.z = r*cos(betaC);
      canvas.fill(#B00BAF);
        canvas.translate(width/2+ curr.x, height/2+curr.y, curr.z);
        canvas.rotateZ(radians(frameCount/180f));
        canvas.box(20);
        canvas.popMatrix();
      }
    }
    println(frameRate);
  }
}