void gameover() {
  textSize(160);
  fill(255);

  if (leftScore > rightScore) {
    background(red);
    text("RED", width/2, height/2-100);
    text("WINS", width/2, height/2+50);
  } else {
    background(blue);
    text("BLUE", width/2, height/2-100);
    text("WINS", width/2, height/2+50);
  }
}

void gameoverClicks() {
  mode = INTRO;
  intro.rewind();
}
