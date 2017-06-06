import java.util.Queue;
import java.util.LinkedList;

boolean gameOver;
Tetromino currPiece;//current piece in play.
int Grid[][] = new int[10][20];//Playing field.
int currPos[] = new int[2];//x y of starting piece.
Queue<Tetromino> shapes;
int score = 0;
boolean on = false;
boolean off = false;

void setup() {
  size( 600, 800 );
}

void initialize() {
  shapes = new LinkedList<Tetromino>(); 
  //currPiece = new Tetromino();
  currPos[0] = 4;
  currPos[1] = 0;
  gameOver = false;
  fillQ();
  currPiece = getShape();
  on = true;
  off = false;
}

void draw() {
  //clear everything
  background(0);

  if ( on == false ) {
    background(8, 46, 53);
    textSize(80);
    fill(255, 0, 0);
    text("T", 180, 200); //T

    fill(255, 153, 0);
    text("E", 230, 200); //E

    fill(255, 255, 0);
    text("T", 280, 200); //T

    fill(0, 255, 0);
    text("R", 330, 200); //R

    fill(0, 0, 255);
    text("I", 370, 200); //I

    fill(153, 0, 255);
    text("S", 410, 200);// S

    textAlign(CENTER);
    textSize( 25 );

    fill(255, 255, 255);
    text( "Press Enter/Return to start!", 300, 250);
  }

  if ( on == true && off == false) {

    //draw grid
    for (int x = 0; x < 10; x++) {
      for (int y = 0; y < 20; y++) {
        if (Grid[x][y] == 0) {
          fill(150);
        } else if (Grid[x][y] == 1) {//cyan I
          fill(0, 255, 255);
        } else if (Grid[x][y] == 2) {//red Z
          fill(255, 0, 0);
        } else if (Grid[x][y] == 3) {//green S
          fill(0, 255, 0);
        } else if (Grid[x][y] == 4) {//orange L
          fill(255, 165, 0);
        } else if (Grid[x][y] == 5) {//blue J
          fill(0, 0, 255);
        } else if (Grid[x][y] == 6) {//yellow O
          fill(255, 255, 0);
        } else {                     //purple T
          fill(255, 0, 255);
        }
        rect(x*30+50, y*30+50, 26, 26);
      }
    }

    displayShape();
    showNext();

    //tetromino falls every 1/2 of a second
    if (frameCount % 30 == 0) {
      currPos[1]++;
    }
    stack();
    fillQ();

    if (frameCount % 60 == 0) {
      score+=10;
    }
    showScore();
  }
}

void showScore() {

  if ( on == true && off == false ) {
    textSize(30);
    textAlign(CENTER);
    fill(53, 223, 255);
    text("Score: "+ score, 300, 700);
  }

  if ( on == false && off == true ) {
    textSize(30);
    textAlign(CENTER);
    fill ( 255, 255, 255 );
    text("Score: "+ score, 300, 300);
  }
}

//checks if currPiece should stop, and if so, places the piece and gets next piece
void stack() {
  boolean stop = false;
  for (int i = 0; i < 4; i ++) {
    if (currPiece.getY(i) + currPos[1] < 19) {//When piece is in playing field
      try {
        if (Grid[currPiece.getX(i) + currPos[0]][currPiece.getY(i) + currPos[1] + 1] != 0) {//If the square on grid is occupied by a piece.
          stop = true;
        }
      }
      catch (ArrayIndexOutOfBoundsException e) {
        if (currPos[0] == 0) {
          currPos[0] += 1;
        } else if (currPos[0] == 9) {
          currPos[0] -= 1;
        }
      }
    }
  }
  if (currPiece.getMaxY()+ currPos[1] == 19 || stop == true) {//piece is on bottom row or hits another piece.
    for (int i = 0; i < 4; i++) {
      if (currPiece.getY(i) + currPos[1] < 0) {
        endGame();
        on = false;
        off = true;
      } else { 
        Grid[currPiece.getX(i) + currPos[0]] [currPiece.getY(i) + currPos[1]] = currPiece.getColor();//set squares on grid to shape color #. #'d squares get filled in by draw().
      }
    }
    /*for (int i = 0; i < 4; i++) {
     int counter = 0;
     while (counter < 10) {
     if (Grid[counter][currPiece.getY(i) + currPos[1]] != 0) {
     counter++;
     }
     }
     if (counter == 10) {
     for (int x = 0; x < 10; x++) {
     Grid[x][currPiece.getY(i) + currPos[1]-1] = Grid[x][currPiece.getY(i) + currPos[1]];
     }
     }
     }*/

    boolean clear;
    int bonus = 0;
    for (int y = 0; y < 20; y++) {
      clear = true;
      for (int x = 0; x < 10; x++) {
        if (Grid[x][y] == 0) {
          clear = false;
        }
      }
      if (clear == true) {
        for (int prevRow = y-1; prevRow > -1; prevRow--) {
          for (int x = 0; x < 10; x++) {
            Grid[x][prevRow+1] = Grid[x][prevRow];
          }
        }
        bonus ++;
      }
    }
    if (bonus == 1) {
      score+=100; 
      bonus = 0;
    } else if (bonus == 2) {
      score+=200; 
      bonus = 0;
    } else if (bonus == 3) {
      score +=300; 
      bonus = 0;
    } else if (bonus == 4) {
      score+=400; 
      bonus = 0;
    }
    currPiece = getShape();
    currPos[0] = 4;
    currPos[1] = 0;
  }
}

/*
 void place() {
 for (int i = 0; i < 4; i++) {
 Grid[currPiece.getX(i) + currPos[0]] [currPiece.getY(i) + currPos[1]] = currPiece.getColor();//set squares on grid to shape color #. #'d squares get filled in by draw().
 } 
 currPiece = getShape();
 currPos[0] = 4;
 currPos[1] = 0;
 }*/

//fills the queue with tetrominos
void fillQ() {
  if (shapes.size() == 0) {
    for (int i = 0; i < 20; i++) {
      Tetromino toAdd = new Tetromino();    
      shapes.add(toAdd);
    }
  }
}

//removes and returns the first tetromino in the queue
Tetromino getShape() {
  fillQ();
  Tetromino first = shapes.peek();
  shapes.poll();
  return first;
}

//displays the tetrominos
void displayShape() {
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

void showNext() {
  textSize(30);
  fill(53, 223, 255);
  text("Next shape", 470, 90);
  if (shapes.peek().getColor() == 1) {     //cyan I
    fill(0, 255, 255);
  } else if (shapes.peek().getColor() == 2) {//red Z
    fill(255, 0, 0);
  } else if (shapes.peek().getColor() == 3) {//green S
    fill(0, 255, 0);
  } else if (shapes.peek().getColor() == 4) {//orange L
    fill(255, 165, 0);
  } else if (shapes.peek().getColor() == 5) {//blue J
    fill(0, 0, 255);
  } else if (shapes.peek().getColor() == 6) {//yellow O
    fill(255, 255, 0);
  } else {                                   //purple T
    fill(255, 0, 255);
  }
  for ( int i = 0; i < 4; i++ ) {
    rect((shapes.peek().getX(i))*30+470, (shapes.peek().getY(i))*30+150, 26, 26);
  }
}

//keyboard inputs
void keyPressed() {
  if ( on == false ) {
    if ( key == ENTER ) {
      initialize();
      on = true;
    } else if ( key == RETURN ) {
      initialize();
      on = true;
    }
  }
  if ( currPiece.getMaxY() + currPos[1] < 19) {
    if ( key == 'A' || key == 'a' ) {//counter clockwise rotation
      currPiece.rotateCCW();
      if (currPiece.getLeastX() + currPos[0] < 0) {
        currPos[0] -= currPiece.getLeastX() + currPos[0];
      }
      if (currPiece.getMaxX() + currPos[0] > 9) {
        currPos[0] -= currPiece.getMaxX() + currPos[0]-9;
      }
      if (currPiece.getLeastY() + currPos[1] < 0) {
        currPos[1] -= currPiece.getLeastY() + currPos[1];
      } 
      if (currPiece.getMaxY() + currPos[1] > 19) {
        currPos[1] -= currPiece.getMaxY() + currPos[1]-19;
      }
    } else if ( key == 'D' || key == 'd' ) {//clockwise rotation
      currPiece.rotateCW();
      if (currPiece.getLeastX() + currPos[0] < 0) {
        currPos[0] -= currPiece.getLeastX() + currPos[0];
      }  
      if (currPiece.getMaxX() + currPos[0] > 9) {
        currPos[0] -= currPiece.getMaxX() + currPos[0]-9;
      }  
      if (currPiece.getLeastY() + currPos[1] < 0) {
        currPos[1] -= currPiece.getLeastY() + currPos[1];
      } 
      if (currPiece.getMaxY() + currPos[1] > 19) {
        currPos[1] -= currPiece.getMaxY() + currPos[1]-19;
      }
    } else if ( key == CODED ) {
      if ( keyCode == DOWN ) {//accelerate down
        //   if ( Grid[currPiece.getMaxX() + currPos[0]][currPiece.getMaxY() + currPos[1] + 1] != 0 ) {
        currPos[1]++;
        score++;
        // }
      } else if ( keyCode == UP ) {//hard drop down
        drop();
      } else if ( keyCode == LEFT ) {//move left
        boolean move = true;
        if (currPiece.getLeastX() + currPos[0] > 0 && currPiece.getLeastY() + currPos[1] >= 0) {
          for (int i = 0; i < 4; i++) {
            if (Grid[currPiece.getX(i) + currPos[0]-1][currPiece.getY(i) + currPos[1]] != 0) {
              move = false;
            }
          }
          if (move != false) {
            currPos[0]--;
          }
        }
      } else if ( keyCode == RIGHT ) {//move right
        boolean move = true;
        if ( currPiece.getMaxX() + currPos[0] < 9  && currPiece.getLeastY() + currPos[1] >= 0) {
          for (int i = 0; i < 4; i++) {
            if (Grid[currPiece.getX(i) + currPos[0]+1][currPiece.getY(i) + currPos[1]] != 0) {
              move = false;
            }
          }
          if (move != false) {
            currPos[0]++;
          }
        }
      }
    }
  }
}



void drop() {
  boolean stop = false;
  for (int i = 0; i < 4; i ++) {
    if (currPiece.getY(i) + currPos[1] < 19) {//When piece is in playing field
      try {
        if (Grid[currPiece.getX(i) + currPos[0]][currPiece.getY(i) + currPos[1] + 1] != 0) {//If the square on grid is occupied by a piece.
          stop = true;
        }
      }
      catch (ArrayIndexOutOfBoundsException e) {
        if (currPos[0] == 0) {
          currPos[0] += 2;
        } else if (currPos[0] == 9) {
          currPos[0] -= 2;
        }
      }
    }
  }
  //piece is not on bottom row or another piece
  if (currPiece.getMaxY()+ currPos[1] == 19 ^ stop == false) {
    currPos[1]++;
    drop();
    score+=2;
  }
  for (int i = 0; i < 4; i++) {
    if (currPiece.getY(i) + currPos[1] < 0) {
      //endGame();
    } else { 
      Grid[currPiece.getX(i) + currPos[0]] [currPiece.getY(i) + currPos[1]] = currPiece.getColor();//set squares on grid to shape color #. #'d squares get filled in by draw().
    }
  }
}

void endGame() {
  noLoop();

  background(8, 46, 53);

  textSize(60);
  fill(255, 0, 0);
  text("G", 120, 200); //G

  fill(255, 153, 0);
  text("A", 170, 200); //A

  fill(255, 255, 0);
  text("M", 220, 200); //M

  fill(0, 255, 0);
  text("E", 270, 200); //E

  fill(0, 0, 255);
  text(" ", 300, 200); // 

  fill(0, 0, 255);
  text("O", 350, 200);// O

  fill(153, 0, 255);
  text("V", 400, 200);// V

  fill(204, 0, 153);
  text("E", 450, 200);// E

  fill(255, 204, 255);
  text("R", 500, 200);// R

  textAlign(CENTER);
  textSize( 25 );

  fill(255, 255, 255);
  text("Great job! Your score was:", 300, 250);

  textSize(30);
  textAlign(CENTER);
  text("Score: "+ score, 300, 300);

  fill(53, 223, 255);
  text("The fun doesn't have to end here!", 300, 450);
  text("Play again!", 300, 500);
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