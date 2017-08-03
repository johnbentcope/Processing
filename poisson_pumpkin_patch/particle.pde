class Particle {
  PVector pos;
  boolean isPumpkin = (random(6)<1);
  int id; 

  Particle(PVector pos, int id) {
    this.pos = pos;
    this.id = id;
  }

  void render() {
    
  canvas.pushMatrix();
    canvas.translate(pos.x, pos.y, z());
    if (isPumpkin) {
      canvas.fill(#FF8800);
      canvas.noStroke();
      canvas.sphereDetail(10);
      canvas.translate(0,0,15);
      canvas.sphere(20);
    } else {
      canvas.fill(#00FF00);
      canvas.translate(0,0,15);
      canvas.rotateZ(id*PI/30 + sin(id*PI/50+ frameCount*PI/120f));
      canvas.rotateZ(-PI/10);
      canvas.rotateY(-PI/6);
      canvas.scale(0.5,0.5,0.5);
      drawLeaf(false, #507434, #2E3D1E);
    }
    canvas.popMatrix();
  }



  float z() {
    return pos.z + 20*sin(dist(pos.x,pos.y,300,300)/50 - frameCount*PI/360f);
  }
}