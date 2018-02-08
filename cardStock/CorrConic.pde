/* GOALS:
 * declare arc sweep of conic
 * declare height of conic
 * declare upper and lower diameters
 * always make flutes along surface of conic
 * flutes follow surface in such a way that with height 0, it's a radial ring
 */

class CorrConic extends CardBoard {

  // Constructor values
  float conicUpperDia;
  float conicLowerDia;
  float high;
  float conicSpan;
  int detail;

  // Derived values
  float conicUpperRad;
  float conicLowerRad;
  float wallSlope;
  float fluteStepAngle;

  CorrConic(float conicLowerDia, float conicUpperDia, float high, float conicSpan, int detail) {
    this.conicUpperDia = conicUpperDia;
    this.conicLowerDia = conicLowerDia;
    this.high = high;
    this.conicSpan = conicSpan;
    this.detail = detail;

    conicUpperRad = conicUpperDia/2;
    conicLowerRad = conicLowerDia/2;

    if (high == 0 ) {
      wallSlope = PI/2;
    } else if (conicUpperDia == conicLowerDia) {
      wallSlope = 0;
    } else {
      wallSlope = atan((conicUpperRad-conicLowerRad)/high);
    }

    fluteStepAngle = asin(fluteStep/conicUpperRad);
  }
  /*  |x|     x2 + y2 = rad2
   *          y = (+-)sqrt(rad2-x2)
   * ________
   * \0     |
   *  \     |
   *   \    | fluteStep
   *    \   |
   *uRad \  |
   *      \ |
   *       \|
   */


  void setHigh() {
    if (high == 0 ) {
      wallSlope = PI/2;
    } else if (conicUpperDia == conicLowerDia) {
      wallSlope = 0;
    } else {
      wallSlope = atan((conicUpperRad-conicLowerRad)/high);
    }
  }
  
  void render() {
    beginShape(QUADS);
    int i = 0;

    // var2 and vvar are ALWAYS THE "NEXT" SWEEP
    for (float currAngle = 0; currAngle < conicSpan; i++, currAngle += fluteStepAngle) {
      float nextAngle = currAngle + fluteStepAngle;
      int ii = i+1;

      float hypotenuse = linerAmp-fluteAmp;
      float hypotenuse2 = linerAmp-fluteAmp; 
      if (( i/2)%2 == 0) hypotenuse += fluteThicc;
      if (( ii/2)%2 == 0) hypotenuse2 += fluteThicc;

      float horiFluteDisplace = hypotenuse*cos(wallSlope);
      float horiFluteDisplace2 = hypotenuse2*cos(wallSlope);
      float radUpper = conicUpperRad + horiFluteDisplace;
      float radLower = conicLowerRad + horiFluteDisplace;
      float radUpper2 = conicUpperRad + horiFluteDisplace2;
      float radLower2 = conicLowerRad + horiFluteDisplace2;

      float vertFluteDisplace = hypotenuse*sin(wallSlope);
      float vertFluteDisplace2 = hypotenuse2*sin(wallSlope);

      // Dear god conics suck
      float xUpper = radUpper*sin(currAngle);
      float xLower = radLower*sin(currAngle);
      float xxUpper = radUpper2*sin(nextAngle);
      float xxLower = radLower2*sin(nextAngle);
      float yUpper = radUpper*cos(currAngle);
      float yLower = radLower*cos(currAngle);
      float yyUpper = radUpper2*cos(nextAngle);
      float yyLower = radLower2*cos(nextAngle);
      float zUpper =  high - vertFluteDisplace;
      float zLower = -vertFluteDisplace;
      float zzUpper =  high - vertFluteDisplace2;
      float zzLower = -vertFluteDisplace2;

      vertex(xUpper, yUpper, zUpper);
      vertex(xxUpper, yyUpper, zzUpper);
      vertex(xxLower, yyLower, zzLower);
      vertex(xLower, yLower, zLower);
    }


    float linerStepAngle = conicSpan/detail;
    for (i = 0; i < detail; i++) {
      int ii = i+1;
      float currAngle = i*linerStepAngle;
      float nextAngle = currAngle + linerStepAngle;
      float hypotenuse = linerThicc;


      float horiFluteDisplace = hypotenuse*cos(wallSlope);
      float radUpper = conicUpperRad + horiFluteDisplace;
      float radLower = conicLowerRad + horiFluteDisplace;
      float vertFluteDisplace = hypotenuse*sin(wallSlope);

      // Dear god conics suck
      float xUpper = radUpper*sin(currAngle);
      float xLower = radLower*sin(currAngle);
      float xxUpper = radUpper*sin(nextAngle);
      float xxLower = radLower*sin(nextAngle);
      float yUpper = radUpper*cos(currAngle);
      float yLower = radLower*cos(currAngle);
      float yyUpper = radUpper*cos(nextAngle);
      float yyLower = radLower*cos(nextAngle);
      float zUpper =  high - vertFluteDisplace;
      float zLower = -vertFluteDisplace;
      float zzUpper =  high - vertFluteDisplace;
      float zzLower = -vertFluteDisplace;

      vertex(xUpper, yUpper, zUpper);
      vertex(xxUpper, yyUpper, zzUpper);
      vertex(xxLower, yyLower, zzLower);
      vertex(xLower, yLower, zLower);
    }
    for (i = 0; i < detail; i++) {
      int ii = i+1;
      float currAngle = i*linerStepAngle;
      float nextAngle = currAngle + linerStepAngle;
      float hypotenuse = 0;// linerThicc;


      float horiFluteDisplace = hypotenuse*cos(wallSlope);
      float radUpper = conicUpperRad + horiFluteDisplace;
      float radLower = conicLowerRad + horiFluteDisplace;
      float vertFluteDisplace = hypotenuse*sin(wallSlope);

      // Dear god conics suck
      float xUpper = radUpper*sin(currAngle);
      float xLower = radLower*sin(currAngle);
      float xxUpper = radUpper*sin(nextAngle);
      float xxLower = radLower*sin(nextAngle);
      float yUpper = radUpper*cos(currAngle);
      float yLower = radLower*cos(currAngle);
      float yyUpper = radUpper*cos(nextAngle);
      float yyLower = radLower*cos(nextAngle);
      float zUpper =  high - vertFluteDisplace;
      float zLower = -vertFluteDisplace;
      float zzUpper =  high - vertFluteDisplace;
      float zzLower = -vertFluteDisplace;

      vertex(xUpper, yUpper, zUpper);
      vertex(xxUpper, yyUpper, zzUpper);
      vertex(xxLower, yyLower, zzLower);
      vertex(xLower, yLower, zLower);
    }

    endShape(CLOSE);
  }

  public float getHeight() {
    return abs(high);
  }
}