class Chain {

  Strip first;
  
  Chain() {
  }

  void addStrip(Strip s) {
    if (first != null){
      first.setChild(s);
    } else {
      first = s;
    }
  }
  
  void render(){
    
    first.render();
  }
}