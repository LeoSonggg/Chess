void keyReleased() {
  if(key == 'z' && !itsMyTurn){
    for(int r = 0; r < 8; r++)
      for(int c = 0; c < 8; c++)
        grid[r][c] = gridTakeBack[r][c];
     myServer.write(row1 + "," + col1 + "," + row2 + "," + col2 + "," + 1);
     itsMyTurn = true;
  }
}
