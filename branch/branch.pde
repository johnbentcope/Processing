float theta =radians (30);
float phi = PI* (3.0-sqrt (5) );

float t =120;

void setup (){
  size(1200,1200,P3D);
}

void draw (){
  background(0);
  
  stroke(#fF0000);
  line(0,0,0,20,0,0);
  stroke(#00Ff00);
  line(0,0,0,0,20,0);
  stroke(#0000FF);
  line(0,0,0,0,0,20);
  stroke(255);
  
  camera(
  2000//*sin (frameCount/120.0)
  ,2000//*cos (frameCount/120.0)
  ,900,
  0,0,100,
  0,0,-1.0);
  pushMatrix ();
  float tl =t;
  for (int i =0; i <20;i++){
  //rotateZ (phi);
  rotateX(radians(3+1*sin(frameCount*2*PI/120)));
    
  line (0,0,0,0,0,tl);
  translate (0,0,tl);
  branch (tl);
  tl*=0.9;
  }
  popMatrix ();
  
}

void branch (float h){
  
  h*=0.66;
  pushMatrix();
  rotateZ(radians(h*360));
  line(h*3,0,0,-h*3,0,0);
  line(0,h*3,0,0,-h*3,0);
  popMatrix();
  /*
  if (h > 5) {
    pushMatrix();
    // Save the current state of transformation (i.e. where are we now)
     rotateZ((PI-phi));
     // Rotate by theta
     line(0, 0, 0, -h*2, 0, 0);
     // Draw the branch
     translate(-h*2, 0, 0); 
     // Move to the end of the branch
     branch(h);
     // Ok, now call myself to draw two new branches!!
     
     popMatrix();
     
     // Whenever we get back here, we "pop" in order to restore the previous matrix state
     
     // Repeat the same thing, only branch off to the "left" this time!
     
    pushMatrix();
    rotate(-(PI-phi)); 
    line(0, 0, 0, -h*2, 0, 0);
    translate( -h*2,0,0);
    branch(h);
    popMatrix();
  }
  */
}