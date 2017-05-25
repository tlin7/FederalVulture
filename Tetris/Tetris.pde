boolean gameOver;
Tetromino currPiece;
int Grid[][] = new int[10][20];
int currPos[] = new int[2];//x y of starting piece.
int clock = 1;

void setup() {
  size( 600, 800 );
  currPiece = new Tetromino();
  currPos[0] = 4;
  currPos[1] = 0;
  gameOver = false;
}

void draw() {
  background(0);
  for (int x = 0; x < 10; x++) {
    for (int y = 0; y < 20; y++) {
      fill(150);
      rect(x*30+50, y*30+50, 26, 26);
    }
  }
  displayShape();
  if (clock % 15 == 0) {
    currPos[1]++;
  }
  
  
  time();
}

void time() {
  if( clock == 60 ) {
    clock = 1;
  } else {
    clock ++;
  }
}

void displayShape() {
  if (currPiece.getColor() == 1) {
    fill(0, 255, 255);
  } else if (currPiece.getColor() == 2) {
    fill(0, 255, 0);
  } else if (currPiece.getColor() == 3) {
    fill(255, 0, 0);
  } else if (currPiece.getColor() == 4) {
    fill(255, 165, 0);
  } else if (currPiece.getColor() == 5) {
    fill(0, 0, 255);
  } else if (currPiece.getColor() == 6) {
    fill(255, 255, 0);
  } else {
    fill(255, 0, 255);
  }
  for (int i = 0; i < 4; i++) {
    if (currPiece.getY(i) + currPos[1] >= 0) {
      rect((currPiece.getX(i) + currPos[0])*30+50, (currPiece.getY(i) + currPos[1])*30+50, 26, 26);
    }
  }
}

void keyPressed() {
  if( key == 'A' || key == 'a' ) {
    currPiece.rotateCCW();
  } else if( key == 'D' || key == 'd' ) {
    currPiece.rotateCW();
  }
}

class Tetromino {
  int shape[][] =  new int [4][2];
  int colorr;
  public Tetromino() {
    colorr = (int)(random(1, 8));
    if (colorr == 1) {
      shape[1][0] = 1;
      shape[2][0] = -1;
      shape[3][0] = -2;
    } else if (colorr == 2) {
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
  
  public void rotateCW() {
  }
  public void rotateCCW() {
    for (int i = 0; i < 4; i ++) {
      int point = shape[i][0];
      shape[i][0] = shape[i][1];
      shape[i][1] = -point;
    }
  }
}