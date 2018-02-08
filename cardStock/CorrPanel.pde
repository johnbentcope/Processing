
class CorrPanel extends CardBoard {

  int panWidth;
  int panLength; 

  CorrPanel(int panWidth, int panLength) {
    this.panWidth = panWidth;
    this.panLength = panLength;
  }

  void render() {
    beginShape(QUADS);
    colorLiner();
    vertex(-panWidth/2, -panLength/2, linerAmp);
    vertex(-panWidth/2, panLength/2, linerAmp);
    vertex( panWidth/2, panLength/2, linerAmp);
    vertex( panWidth/2, -panLength/2, linerAmp);
    vertex(-panWidth/2, -panLength/2, -linerAmp);
    vertex(-panWidth/2, panLength/2, -linerAmp);
    vertex( panWidth/2, panLength/2, -linerAmp);
    vertex( panWidth/2, -panLength/2, -linerAmp);
    colorFlutes();
    for (int i = 0, x = 0; x < panWidth; i++, x+= fluteStep) {
      int ii = i+1;
      int xx = x + fluteStep;
      int h = fluteAmp - ((i/2)%2)*fluteThicc;
      int hh = fluteAmp - ((ii/2)%2)*fluteThicc;
      vertex(-panWidth/2+x, -panLength/2, h);
      vertex(-panWidth/2+xx, -panLength/2, hh);
      vertex(-panWidth/2+xx, panLength/2, hh);
      vertex(-panWidth/2+x, panLength/2, h);
    }

    endShape(CLOSE);
  }
}