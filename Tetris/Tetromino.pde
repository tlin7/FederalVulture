class Tetromino {

  int shape[][] =  new int [4][2];
  int colorr;

  public Tetromino() {
    colorr = (int)(random(1, 8));
    if (colorr == 1) {//I
      shape[1][0] = 1;
      shape[2][0] = -1;
      shape[3][0] = -2;
    } else if (colorr == 2) {//Z
      shape[1][0] = -1;
      shape[1][1] = -1;
      shape[2][1] = -1;
      shape[3][0] = 1;
    } else if (colorr == 3) {//S
      shape[1][0] = -1;
      shape[2][1] = -1;
      shape[3][0] = 1;
      shape[3][1] = -1;
    } else if (colorr == 4) {//L
      shape[1][0] = -2;
      shape[2][0] = -1;
      shape[3][1] = -1;
    } else if (colorr == 5) {//J
      shape[1][0] = -2;
      shape[2][0] = -1;
      shape[3][1] = 1;
    } else if (colorr == 6) {//O
      shape[1][0] = -1;
      shape[2][0] = -1;
      shape[2][1] = -1;
      shape[3][1] = -1;
    } else {                 //T
      shape[1][0] = -1;
      shape[2][1] = -1;
      shape[3][0] = 1;
    }
  }

  public int getX(int i) {
    return shape[i][0];
  }

  public int getY(int i) {
    return shape[i][1];
  }

  public int getMaxX() {
    int i = 0;
    for (int x = 0; x < 4; x++) {
      if (shape[x][0] > shape[i][0]) {
        i = x;
      }
    }
    return shape[i][0];
  }

  public int getMaxY() {
    int i = 0;
    for (int x = 0; x < 4; x++) {
      if (shape[x][1] > shape[i][1]) {
        i = x;
      }
    }
    return shape[i][1];
  }

  public int getLeastX() {
    int i = 0;
    for (int x = 0; x < 4; x++) {
      if (shape[x][0] < shape[i][0]) {
        i = x;
      }
    }
    return shape[i][0];
  }

  public int getColor() {
    return colorr;
  }

  public int getLeastY() {
    int i = 0;
    for (int x = 0; x < 4; x++) {
      if (shape[x][1] < shape[i][1]) {
        i = x;
      }
    }
    return shape[i][1];
  }

  //90 degree clockwise rotation
  public void rotateCW() {
    if (colorr != 6) {
      for (int i = 0; i < 4; i ++) {
        int point = shape[i][0];
        shape[i][0] = -shape[i][1];
        shape[i][1] = point;
      }
    }
  }


  //90 degree counter clockwise rotation
  public void rotateCCW() {
    if (colorr != 6) {
      for (int i = 0; i < 4; i ++) {
        int point = shape[i][0];
        shape[i][0] = shape[i][1];
        shape[i][1] = -point;
      }
    }
  }
}