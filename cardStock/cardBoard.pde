class CardBoard {

  color midtone   = #AE9072;
  color shadow    = #444444;
  color highlight = #FADCBD;

  int linerThicc = 10;
  int fluteThicc = 6;
  int linerAmp   = linerThicc/2;
  int fluteAmp   = fluteThicc/2;

  int flutePeriod = 12;
  int fluteStep = flutePeriod/4;

  void colorFlutes() {
    fill(midtone);
    stroke(highlight);
  }

  void colorLiner() {
    fill(midtone);
    stroke(highlight);
  }
}