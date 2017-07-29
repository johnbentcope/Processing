class Segment {

  PVector end;
  PVector root;
  float radius;
  float phase;
  float scaling = 0.9;
  int id;

  Segment(float radius, float len, float angle, int id, float phase) {
    end = PVector.fromAngle(PI+angle).mult(len);
    root = end.copy();
    this.radius = radius;
    this.id = id;
    this.phase = phase;
  }

  void update() {
    end = PVector.fromAngle
      (
      root.heading() + PI/16*sin((id+frameCount/4f)/30f*PI + phase)
      )
      .mult(root.mag());
  }

  void render() {
    update();   

    beginShape(QUAD);
    fill(shadow);
    vertex(-radius, 0);
    vertex(
      end.x-(sin(end.heading())*-radius*scaling), 
      end.y+(cos(end.heading())*-radius*scaling)
      );

    fill(highlight);
    vertex(
      end.x-(sin(end.heading())*radius*scaling), 
      end.y+(cos(end.heading())*radius*scaling)
      );
    vertex(radius, 0);

    fill(shadow);
    vertex(-radius, 0);

    endShape(CLOSE);
    rotate(end.heading()+PI/2);
    translate(0, -end.mag());
  }
}