class Donut {
  
  // Declaring these as global variables ends up killing alpha values
  
  color[] donutColors = {
    color(#FFD18A, 255), // vanilla donut
    color(#FF9188, 255), 
    color(#573620, 255)  // chocolate donut
  };

  color[] sprinkleColors = {
    #FFFF33, // YELLOW
    #FF9421, // ORANGE
    #FF35D2, // PINK
    #3367FF, 
    #13F263, 
    #E6E8E8, 
    #FF3535
  };
  color[] glazeColors = {
    color(#42DEE8, 200), // blue raspberry
    color(#573620, 150), // chocolate donut
    color(#EF82FF, 150), // blurple
    color(#E6E8E8, 150)  // clear glaze
  };

  color[] drizzleColors = {
    color(#42DEE8, 150), 
    color(#573620, 150), 
    color(#FFD18A, 150), 
    color(#E6E8E8, 150)
  };


  // vars to color donuts
  int flav = int(random(donutColors.length));
  boolean isGlazed = int(random(4)) <= 2;
  int glaze = int(random(glazeColors.length));
  boolean isSprink = int(random(2)) == 0;
  Sprinkles[] load = new Sprinkles[100];

  Donut() {
    if ( isSprink)
      for (int i = 0; i < load.length; i++) {
        load[i] = new Sprinkles(color( sprinkleColors[ int(random(sprinkleColors.length)) ] ));
      }
  }

  void render() {

    // Render the donutchunk eight times
    for (int i = 0; i < 8; i ++) {
      pushMatrix();
      rotateZ(i*PI/4);
      donutChunk.setFill(donutColors[flav]);
      shape(donutChunk);
      /* 
       // Not using this if() for glazing because of graphics glitches on glaze render
       if(isGlazed){
       translate(0, 0, 1);
       glazeChunk.setFill(glazeColors[glaze]);
       shape(glazeChunk); 
       } // */
      popMatrix();
    }

    // Render the glaze chunks eight times here
    if (isGlazed)
      for (int i = 0; i < 8; i ++) {
        pushMatrix();
        rotateZ(i*PI/4);
        translate(0, 0, 1);
        glazeChunk.setFill(glazeColors[glaze]);
        shape(glazeChunk);
        popMatrix();
      }

    // Render the sprinkles
    if (isSprink) 
      for (Sprinkles s : load) {
        s.render();
      }
  }
}