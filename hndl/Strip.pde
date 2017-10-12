class Strip {

  Point p1, p2;
  Strip child;
  int id;
  float period = 12, segLen = 4;

  Strip(Point p1, Point p2, int id) {
    this.p1 = p1;
    this.p2 = p2;
    this.id = id;
    this.child = null;
  }

  void setChild(Strip s) {
    if(child == null){
      this.child = s;
    } else {
      child.setChild(s);
    }
  }

  void render() {

    line( p1.x(), p1.y(), 
      p2.x(), p2.y() );
    if (child != null)
      child.render();

    //float x= 0;
    //float len = dist( p1.x(), p1.y(), 
    //  p2.x(), p2.y() );

    //while (x <= len){
    //  x += segLen;
    //}
  }
}