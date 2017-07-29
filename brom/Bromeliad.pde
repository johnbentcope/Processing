class Bromeliad {


  Bromeliad() {
  }

  void makeBrom() {
    canvas.pushMatrix();
    for (int r = 0; r < 5; r++) {
      canvas.pushMatrix();
      float angle = PI/(32*(r+1));
      canvas.rotateZ(PI/10*r);
      for (int i = 0; i < 10; i++) {
        canvas.pushMatrix();
        canvas.rotateZ(PI/5*i);
        canvas.translate(0, -6*(5-r), 0);
        leaf(10*(5-r), angle);
        canvas.popMatrix();
      } 
      canvas.popMatrix();
    }
    canvas.fill(#822E75);
    canvas.ellipse(0, 0, 70, 70);
    canvas.popMatrix();
  }

  void leaf(float w, float theta) {

    leafHalf(1, w, theta);
    leafHalf(-1, w, theta );
  }

  void leafHalf(int mir, float w, float theta) {
    canvas.noStroke();
    canvas.beginShape(QUAD_STRIP);
    for (int i = 0; i < 11; i++) {
      float angle = -i*theta;
      float y1 = i*10*sin(angle);
      float y2 = i*10*sin(angle-(theta*2));
      float z1 = i*10*cos(angle);
      float z2 = i*10*cos(angle-(theta/4f));
      double augh = (i-11)/121f;
      double x = -w*Math.cbrt( augh );
      //canvas.fill(#F255D9);
      canvas.fill(#BA41A7);

      if ( i >8) canvas.fill(#A8CF00);
      canvas.vertex(0, y2-(11-i)/2.5, z2);
      canvas.vertex(mir*(float)x, y1, z1);
      //rotateY(PI/16);
      //translate(0,0,10);
    }
    canvas.endShape();
  }
}