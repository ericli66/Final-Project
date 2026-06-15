void intro() {
  background(#D7ECFA);

  // top green area
  noStroke();
  fill(#2D8F3C);
  rect(width/2, 140, width, 280);

  // title
  fill(255);
  textSize(60);
  text("TENNIS", width/2, 120);

  // white card
  fill(255);
  rect(width/2, 430, 430, 500, 30);

  // instructions
  fill(#434852);
  textSize(28);
  textAlign(LEFT, TOP);
  text("Click to jump with the\nplayer and hit the ball.\nIf you hit it with the\ncenter of the racket,\nthe ball will go really\nfast.", 420, 250);

  textAlign(CENTER, CENTER);

  // buttons
  drawButton(width/2, 520, 300, 85, "FRIEND", blue);
  drawButton(width/2, 630, 300, 85, "BOT", blue);
  drawButton(width/2, 760, 180, 65, "BACK", #E99675);
}

void introClicks() {
  // FRIEND button
  if (mouseX > width/2 - 150 && mouseX < width/2 + 150 &&
      mouseY > 520 - 42 && mouseY < 520 + 42) {
    AI = false;
    leftScore = 0;
    rightScore = 0;
    resetBall();
    mode = GAME;
  }

  // BOT button
  if (mouseX > width/2 - 150 && mouseX < width/2 + 150 &&
      mouseY > 630 - 42 && mouseY < 630 + 42) {
    AI = true;
    leftScore = 0;
    rightScore = 0;
    resetBall();
    mode = GAME;
  }
}

void drawButton(float x, float y, float w, float h, String label, color buttonColor) {
  if (mouseX > x - w/2 && mouseX < x + w/2 &&
      mouseY > y - h/2 && mouseY < y + h/2) {
    strokeWeight(5);
  } else {
    strokeWeight(1);
  }

  stroke(255);
  fill(buttonColor);
  rect(x, y, w, h, 15);

  fill(255);
  textSize(35);
  text(label, x, y);
}
