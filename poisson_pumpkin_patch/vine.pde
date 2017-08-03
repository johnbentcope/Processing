class Vine {

  Particle a, b;

  Vine(Particle a, Particle b) {
    this.a = a;
    this.b = b;
  }

  void render() {
    canvas.stroke( #5C832F );
    canvas.strokeWeight(5);
    canvas.line(
      a.pos.x, a.pos.y, a.z(), 
      lerp(a.pos.x, b.pos.x, 1/3f), lerp(a.pos.y, b.pos.y, 1/3f), lerp(a.z(), b.z(), 1/3f)+10
      );
    canvas.line(
      lerp(a.pos.x, b.pos.x, 1/3f), lerp(a.pos.y, b.pos.y, 1/3f), lerp(a.z(), b.z(), 1/3f)+10, 
      lerp(a.pos.x, b.pos.x, 2/3f), lerp(a.pos.y, b.pos.y, 2/3f), lerp(a.z(), b.z(), 2/3f)+10
      );
    canvas.line( 
      lerp(a.pos.x, b.pos.x, 2/3f), lerp(a.pos.y, b.pos.y, 2/3f), lerp(a.z(), b.z(), 2/3f)+10, 
      b.pos.x, b.pos.y, b.z()
      );
  }
}