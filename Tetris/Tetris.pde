import java.util.Queue;

boolean gameOver;
int timer;
Tetromino currPiece;
Queue pieces;

void setup() {
  size( 600, 600 );

  gameOver = false;
  timer = 1;
}

void draw() {
  fall();

  if ( timer == 60 ) {
    timer = 1;
  } else {
    timer++;
  }
}

void fall() {
  if ( timer % 60 == 0 ) {
  }
}

class Tetromino {
  int shape[][] =  new int [4][2];
  int colorr;
  public Tetromino() {
    colorr = (int)(random(1, 8));
    if (colorr == 1) { //I
      shape[1][0] = 1;
      shape[2][0] = -1;
      shape[3][0] = -2;
    } else if (colorr == 2) { //S
      shape[1][0] = -1;
      shape[1][1] = -1;
      shape[2][1] = -1;
      shape[3][0] = 1;
    } else if (colorr == 3) {
      shape[1][0] = -1;
      shape[2][1] = -1;
      shape[3][0] = 1;
      shape[3][1] = -1;
    } else if (colorr == 4) {
      shape[1][0] = -2;
      shape[2][0] = -1;
      shape[3][1] = -1;
    } else if (colorr == 5) {
      shape[1][0] = -2;
      shape[2][0] = -1;
      shape[3][1] = 1;
    } else if (colorr == 6) {
      shape[1][0] = -1;
      shape[2][0] = -1;
      shape[2][1] = -1;
      shape[3][1] = -1;
    } else {
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
  public int getColor() {
    return colorr;
  }
  public void rotate() {
    for (int i = 0; i < 4; i ++) {
      int point = shape[i][0];
      shape[i][0] = shape[i][1];
      shape[i][1] = -point;
    }
  }
}