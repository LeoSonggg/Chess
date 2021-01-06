import processing.net.*;

Server myServer;
boolean itsMyTurn;
boolean white; //Check the color player select
boolean firstClick;
boolean pawnPromo;
color lightbrown = #FFFFC3; //The color of the chessboard
color darkbrown  = #D8864E; //The color of the chessboard
PImage wrook, wbishop, wknight, wqueen, wking, wpawn;
PImage brook, bbishop, bknight, bqueen, bking, bpawn;

int row1, col1, row2, col2;
int boardx, boardy, boardWid, boardHei; //The x, y, and size for the chess board

char grid[][] = {
  {'R', 'B', 'N', 'Q', 'K', 'N', 'B', 'R'}, 
  {'P', 'P', 'P', 'P', 'P', 'P', 'P', 'P'}, 
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, 
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, 
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, 
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, 
  {'p', 'p', 'p', 'p', 'p', 'p', 'p', 'p'}, 
  {'r', 'b', 'n', 'q', 'k', 'n', 'b', 'r'}
};

char gridTakeBack[][] = {
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, 
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, 
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, 
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, 
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, 
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, 
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}, 
  {' ', ' ', ' ', ' ', ' ', ' ', ' ', ' '}
};

void setup() {
  size(400, 400);
  myServer = new Server(this, 1234);
  white = true;
  if(white) itsMyTurn = true;
  else itsMyTurn = false;
  firstClick = true;
  pawnPromo = false;

  brook = loadImage("blackRook.png");
  bbishop = loadImage("blackBishop.png");
  bknight = loadImage("blackKnight.png");
  bqueen = loadImage("blackQueen.png");
  bking = loadImage("blackKing.png");
  bpawn = loadImage("blackPawn.png");

  wrook = loadImage("whiteRook.png"); 
  wbishop = loadImage("whiteBishop.png");
  wknight = loadImage("whiteKnight.png");
  wqueen = loadImage("whiteQueen.png");
  wking = loadImage("whiteKing.png");
  wpawn = loadImage("whitePawn.png");
  
  boardx = 0;
  boardy = 0;
  boardWid = 400;
  boardHei = 400;
  
  col1 = -1;
  row1 = -1;
}

void draw() {
  drawBoard();
  selected();
  drawPieces();
  receiveMove();
  takeTurn();
  pawnPromotion();
}

void takeTurn() {
  if(!itsMyTurn){
    fill(0,150);
    rect(boardx, boardy, boardWid, boardHei);
  }
}

void receiveMove() {
  Client myClient = myServer.available();
  if(myClient != null) {
    String incoming = myClient.readString();
    int r1 = int(incoming.substring(0,1));
    int c1 = int(incoming.substring(2,3));
    int r2 = int(incoming.substring(4,5));
    int c2 = int(incoming.substring(6,7));
    int e = int(incoming.substring(8,9));
    int f = int(incoming.substring(10,11));
    println(r1 + " " + c1 + " " + r2 + " " + c2 + " " + e + " " + f);
    
    if(e == 0) {
      for(int r = 0; r < 8; r++)
          for(int c = 0; c < 8; c++)
            gridTakeBack[r][c] = grid[r][c];
      grid[r2][c2] = grid[r1][c1];
      grid[r1][c1] = ' ';
      
     if(f == 0)
        itsMyTurn = true;
    }
    else if(e == 1) {
      for(int r = 0; r < 8; r++)
        for(int c = 0; c < 8; c++)
          grid[r][c] = gridTakeBack[r][c];
      itsMyTurn = false;
    }
    else if(e == 2) {
      if(white) {
        if(r2 == 0) grid[r1][c1] = 'R';
        else if(r2 == 1) grid[r1][c1] = 'B';
        else if(r2 == 2) grid[r1][c1] = 'N';
        else if(r2 == 3) grid[r1][c1] = 'Q';
      }
      else {
        if(r2 == 0) grid[r1][c1] = 'r';
        else if(r2 == 1) grid[r1][c1] = 'b';
        else if(r2 == 2) grid[r1][c1] = 'n';
        else if(r2 == 3) grid[r1][c1] = 'q';
      }
      itsMyTurn = true;
    }
  }
}

void drawPieces() {
  for (int r = 0; r < 8; r++) {
    for (int c = 0; c < 8; c++) {
      if (grid[r][c] == 'r') image (wrook, boardx + c*boardWid/8, boardy + r*boardHei/8, boardWid/8, boardHei/8);
      if (grid[r][c] == 'R') image (brook, boardx + c*boardWid/8, boardy + r*boardHei/8, boardWid/8, boardHei/8);
      if (grid[r][c] == 'b') image (wbishop, boardx + c*boardWid/8, boardy + r*boardHei/8, boardWid/8, boardHei/8);
      if (grid[r][c] == 'B') image (bbishop, boardx + c*boardWid/8, boardy + r*boardHei/8, boardWid/8, boardHei/8);
      if (grid[r][c] == 'n') image (wknight, boardx + c*boardWid/8, boardy + r*boardHei/8, boardWid/8, boardHei/8);
      if (grid[r][c] == 'N') image (bknight, boardx + c*boardWid/8, boardy + r*boardHei/8, boardWid/8, boardHei/8);
      if (grid[r][c] == 'q') image (wqueen, boardx + c*boardWid/8, boardy + r*boardHei/8, boardWid/8, boardHei/8);
      if (grid[r][c] == 'Q') image (bqueen, boardx + c*boardWid/8, boardy + r*boardHei/8, boardWid/8, boardHei/8);
      if (grid[r][c] == 'k') image (wking, boardx + c*boardWid/8, boardy + r*boardHei/8, boardWid/8, boardHei/8);
      if (grid[r][c] == 'K') image (bking, boardx + c*boardWid/8, boardy + r*boardHei/8, boardWid/8, boardHei/8);
      if (grid[r][c] == 'p') image (wpawn, boardx + c*boardWid/8, boardy + r*boardHei/8, boardWid/8, boardHei/8);
      if (grid[r][c] == 'P') image (bpawn, boardx + c*boardWid/8, boardy + r*boardHei/8, boardWid/8, boardHei/8);
    }
  }
}

void pawnPromotion() {
  if(pawnPromo){
    fill(lightbrown);
    rect(boardx + boardWid*3/16, boardy + boardHei*6/16, boardWid*5/8, boardHei*2/8, 10);
    button(boardx + boardWid*17/80, boardy + boardHei*7/16, boardWid*1/8, boardHei*1/8);
    button(boardx + boardWid*29/80, boardy + boardHei*7/16, boardWid*1/8, boardHei*1/8);
    button(boardx + boardWid*41/80, boardy + boardHei*7/16, boardWid*1/8, boardHei*1/8);
    button(boardx + boardWid*53/80, boardy + boardHei*7/16, boardWid*1/8, boardHei*1/8);
    
    if(white) {
      image (wrook, boardx + boardWid*17/80, boardy + boardHei*7/16, boardWid*1/8, boardHei*1/8);
      image (wbishop, boardx + boardWid*29/80, boardy + boardHei*7/16, boardWid*1/8, boardHei*1/8);
      image (wknight, boardx + boardWid*41/80, boardy + boardHei*7/16, boardWid*1/8, boardHei*1/8);
      image (wqueen, boardx + boardWid*53/80, boardy + boardHei*7/16, boardWid*1/8, boardHei*1/8);
    } else {
      image (brook, boardx + boardWid*17/80, boardy + boardHei*7/16, boardWid*1/8, boardHei*1/8);
      image (bbishop, boardx + boardWid*29/80, boardy + boardHei*7/16, boardWid*1/8, boardHei*1/8);
      image (bknight, boardx + boardWid*41/80, boardy + boardHei*7/16, boardWid*1/8, boardHei*1/8);
      image (bqueen, boardx + boardWid*53/80, boardy + boardHei*7/16, boardWid*1/8, boardHei*1/8);
    }
  }
}

void selected() {
  if(!(col1 == -1) && !(row1 == -1) && !firstClick) { 
    fill(255);
    rect(boardx + col1*boardWid/8, boardy + row1*boardHei/8, boardWid/8, boardHei/8);
  }
}
