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

  gameoverTimer--;

  if (gameoverTimer <= 0) {
    mode = INTRO;
    intro.rewind();
    intro.loop();

    leftScore = 0;
    rightScore = 0;

    startTimer = 180;
    gameoverTimer = 180; // reset for next game
  }
}
