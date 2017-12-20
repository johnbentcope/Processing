PFont fun, warn;

void setup() {
  size(600, 600);

  //fun = createFont("KozGoPro Heavy");
  //warn = loadFont();
  String[] fontList = PFont.list();
  printArray(fontList);
  char ePDNE[] = {'毒', '极', '不', '要', '吃'};
  fun = createFont("KozGoPro-Bold", 96, false, ePDNE);

  textFont(fun, 96);

  textAlign(CENTER);
  rectMode(CENTER);
}

void draw() {
  background(51);
  pushMatrix();
  translate(width/2, height/2);
  text("不要吃 极毒", 0, 0);
  popMatrix();
}