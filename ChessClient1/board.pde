void drawBoard() {
  for (int r = 0; r < 8; r++) {
    for (int c = 0; c < 8; c++) { 
      if ( (r%2) == (c%2) ) { 
        fill(lightbrown);
      } else { 
        fill(darkbrown);
      }
      rect(boardx + c*boardWid/8, boardy + r*boardHei/8, boardWid/8, boardHei/8);
    }
  }
}
