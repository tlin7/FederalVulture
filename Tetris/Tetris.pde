boolean gameOver;
int timer;
Tetromino currPiece;

void setup() {
  size( 600, 600 );
  
  gameOver = false;
  timer = 1;
}

void draw() {
  if( timer == 60 ) {
    timer = 1;
  } else {
    timer++;
  }
}

void fall() {
  if( timer % 60 == 0 ) {
    currPiece.y -= 10;
  }
}