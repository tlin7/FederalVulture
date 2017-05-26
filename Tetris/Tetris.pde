import java.util.Queue;
import java.util.LinkedList;
boolean gameOver;
Tetromino currPiece;//current piece in play.
int Grid[][] = new int[10][20];//Playing field.
int currPos[] = new int[2];//x y of starting piece.
int clock = 1;
Queue<Tetromino> shapes;

void setup() {
  size( 600, 800 );
  shapes = new LinkedList<Tetromino>(); 
  //currPiece = new Tetromino();
  currPos[0] = 4;
  currPos[1] = 0;
  gameOver = false;
  fillQ();
  currPiece = getShape();
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
  if ( clock == 60 ) {
    clock = 1;
  } else {
    clock ++;
  }
}

void fillQ() {//Fills the queue with tetrominos
  if (shapes.size() == 0) {
    for (int i = 0; i < 10; i++) {
      Tetromino toAdd = new Tetromino();    
      shapes.add(toAdd);
    }
  }
}

Tetromino getShape() {//removes and returns the first tetromino in the queue.
  Tetromino first = shapes.peek();
  shapes.poll();
  return first;
}
void displayShape() {//desplays the tetrominos.
  if (currPiece.getColor() == 1) {       //cyan I
    fill(0, 255, 255);
  } else if (currPiece.getColor() == 2) {//red Z
    fill(255, 0, 0);
  } else if (currPiece.getColor() == 3) {//green S
    fill(0, 255, 0);
  } else if (currPiece.getColor() == 4) {//orange L
    fill(255, 165, 0);
  } else if (currPiece.getColor() == 5) {//blue J
    fill(0, 0, 255);
  } else if (currPiece.getColor() == 6) {//yellow O
    fill(255, 255, 0);
  } else {                               //purple T
    fill(255, 0, 255);
  }
  for (int i = 0; i < 4; i++) {
    if (currPiece.getY(i) + currPos[1] >= 0) {//so the pieces don't show before appearing on grid.
      rect((currPiece.getX(i) + currPos[0])*30+50, (currPiece.getY(i) + currPos[1])*30+50, 26, 26);
    }
  }
}

void keyPressed() {
  if ( key == 'A' || key == 'a' ) {//counter clockwise rotation
    currPiece.rotateCCW();
  } else if ( key == 'D' || key == 'd' ) {//clockwise rotation
    currPiece.rotateCW();
  } else if ( key == CODED ) {
    if ( keyCode == DOWN ) {//accelerate down
      currPos[1]++;
    } else if ( keyCode == LEFT ) {//move left
      currPos[0]--;
    } else if ( keyCode == RIGHT ) {//move right
      currPos[0]++;
    }
  }
}

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
  public int getColor() {
    return colorr;
  }

  public void rotateCW() {
  }
  public void rotateCCW() {//90 degree counter clockwise rotation.
    if (colorr != 6) {
      for (int i = 0; i < 4; i ++) {
        int point = shape[i][0];
        shape[i][0] = shape[i][1];
        shape[i][1] = -point;
      }
    }
  }
}