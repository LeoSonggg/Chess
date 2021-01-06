void button(float x, float y, float Width, float Height) {
  textAlign(CENTER,CENTER);
  if(mouseX > x && mouseX < x+Width && mouseY > y && mouseY < y+Height){
    fill(darkbrown);
    rect(x,y,Width,Height,10);
  }
  else {
    fill(lightbrown);
    rect(x,y,Width,Height,10);
  }
}

void buttonPause(float x, float y, float Width, float Height) {
  textAlign(CENTER,CENTER);
  if(mouseX > x && mouseX < x+Width && mouseY > y && mouseY < y+Height){
    fill(0);
    rect(x-Width/4,y,Width/3,Height);
    rect(x+Width/4,y,Width/3,Height);
    fill(255);
  }
  else {
    fill(255);
    rect(x-Width/4,y,Width/3,Height);
    rect(x+Width/4,y,Width/3,Height);
    fill(0);
  }
}

boolean buttonPressed(float x, float y, float Width, float Height) {
  if(mouseX > x && mouseX < x+Width && mouseY > y && mouseY < y+Height)
    return true;
  else 
    return false;
}
