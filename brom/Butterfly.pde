class Butterfly{
 
  Butterfly(){
    
  }
  
  void makeButterfly(){
    canvas.pushMatrix();
    canvas.rotateZ(PI/3*frameCount/120f);
    canvas.translate(45,-12,0);
    canvas.scale(3);
    makeWing(1);
    makeWing(-1);
    canvas.popMatrix();
  }
  
  void makeWing(int mir){
    canvas.pushMatrix();
    canvas.rotateY(-mir*radians(frameCount%90*2));
    canvas.beginShape(TRIANGLE_FAN);
    canvas.fill(#FF9542);
    canvas.vertex(mir*1.9,2.6,0);
    canvas.vertex(mir*3.1,1.2,0);
    canvas.vertex(mir*1.5,0,0);
    canvas.vertex(0,1.1,0);
    canvas.fill(#FFC63C);
    canvas.vertex(0,5,0);
    canvas.fill(#ED6431);
    canvas.vertex(mir*1.5,6.8,0);
    canvas.vertex(mir*3.4,5.4,0);
    
    canvas.endShape(CLOSE);
    canvas.popMatrix();
  }
  
}