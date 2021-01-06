void mouseReleased() {
  if(mouseX > boardx && mouseX < boardx + boardWid && mouseY > boardy && mouseY < boardy + boardHei && itsMyTurn) {
    if (firstClick) {
      row1 = (mouseY - boardy)/(boardHei/8);
      col1 = (mouseX - boardx)/(boardWid/8);
      fill(255);
      rect(boardx + col1*boardWid/8, boardy + row1*boardHei/8, boardWid/8, boardHei/8);
      
      if(white){
        if(grid[row1][col1] == 'r' || grid[row1][col1] == 'b' || grid[row1][col1] == 'n' || grid[row1][col1] == 'q' || grid[row1][col1] == 'k' || grid[row1][col1] == 'p')
          firstClick = false;
      }
      else {
        if(grid[row1][col1] == 'R' || grid[row1][col1] == 'B' || grid[row1][col1] == 'N' || grid[row1][col1] == 'Q' || grid[row1][col1] == 'K' || grid[row1][col1] == 'P')
          firstClick = false;
      }
     
    } else {
      row2 = (mouseY - boardy)/(boardHei/8);
      col2 = (mouseX - boardx)/(boardWid/8);
      if (!(row2 == row1 && col2 == col1)) {
        for(int r = 0; r < 8; r++)
          for(int c = 0; c < 8; c++)
            gridTakeBack[r][c] = grid[r][c];
        grid[row2][col2] = grid[row1][col1];
        grid[row1][col1] = ' ';
        
        println("server mouse: " + row1 + "," + col1 + "," + row2 + "," + col2 + "," + 0);
        
        
        if(white && grid[row2][col2] == 'p' && row2 == 0) {
          pawnPromo = true;
          myClient.write(row1 + "," + col1 + "," + row2 + "," + col2 + "," + 0 + "," + 1);
        } else if(!white && grid[row2][col2] == 'P' && row2 == 7) {
          pawnPromo = true;
          myClient.write(row1 + "," + col1 + "," + row2 + "," + col2 + "," + 0 + "," + 1);
        } else {
          itsMyTurn = false;  
          myClient.write(row1 + "," + col1 + "," + row2 + "," + col2 + "," + 0 + "," + 0);
        }
      }
      firstClick = true;
    }
  }
  
  if(white && pawnPromo) { 
    if(buttonPressed(boardx + boardWid*17/80, boardy + boardHei*7/16, boardWid*1/8, boardHei*1/8)){
        grid[row2][col2] = 'r';
        pawnPromo = false;
        myClient.write(row2 + "," + col2 + "," + 0 + "," + 0 + "," + 2 + "," + 0);
        itsMyTurn = false;
        firstClick = true;
    }
    else if(buttonPressed(boardx + boardWid*29/80, boardy + boardHei*7/16, boardWid*1/8, boardHei*1/8)){
      grid[row2][col2] = 'b';
      pawnPromo = false;
      myClient.write(row2 + "," + col2 + "," + 1 + "," + 0 + "," + 2 + "," + 0);
      itsMyTurn = false;
      firstClick = true;
    }
    else if(buttonPressed(boardx + boardWid*41/80, boardy + boardHei*7/16, boardWid*1/8, boardHei*1/8)){
      grid[row2][col2] = 'n';
      pawnPromo = false;
      myClient.write(row2 + "," + col2 + "," + 2 + "," + 0 + "," + 2 + "," + 0);
      itsMyTurn = false;
      firstClick = true;
    }
    else if(buttonPressed(boardx + boardWid*53/80, boardy + boardHei*7/16, boardWid*1/8, boardHei*1/8)){
      grid[row2][col2] = 'q';
      pawnPromo = false;
      myClient.write(row2 + "," + col2 + "," + 3 + "," + 0 + "," + 2 + "," + 0);
      itsMyTurn = false;
      firstClick = true;
    }
  }
  else if (!white && pawnPromo){
    if(buttonPressed(boardx + boardWid*17/80, boardy + boardHei*7/16, boardWid*1/8, boardHei*1/8)){
      grid[row2][col2] = 'R';
      pawnPromo = false;
      myClient.write(row2 + "," + col2 + "," + 0 + "," + 0 + "," + 2 + "," + 0);
      itsMyTurn = false;
      firstClick = true;
    }
    else if(buttonPressed(boardx + boardWid*29/80, boardy + boardHei*7/16, boardWid*1/8, boardHei*1/8)){
      grid[row2][col2] = 'B';
      pawnPromo = false;
      myClient.write(row2 + "," + col2 + "," + 1 + "," + 0 + "," + 2 + "," + 0);
      itsMyTurn = false;
      firstClick = true;
    }
    else if(buttonPressed(boardx + boardWid*41/80, boardy + boardHei*7/16, boardWid*1/8, boardHei*1/8)){
      grid[row2][col2] = 'N';
      pawnPromo = false;
      myClient.write(row2 + "," + col2 + "," + 2 + "," + 0 + "," + 2 + "," + 0);
      itsMyTurn = false;
      firstClick = true;
    }
    else if(buttonPressed(boardx + boardWid*53/80, boardy + boardHei*7/16, boardWid*1/8, boardHei*1/8)){
      grid[row2][col2] = 'Q';
      pawnPromo = false;
      myClient.write(row2 + "," + col2 + "," + 3 + "," + 0 + "," + 2 + "," + 0);
      itsMyTurn = false;
      firstClick = true;
    }
  }
}
