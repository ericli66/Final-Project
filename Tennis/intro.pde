void intro() {
  background(#D7ECFA);

  // top green area
  noStroke();
  fill(green);
  rect(width/2, 140, width, 280);

  // title
  fill(255);
  textFont(bold);
  textSize(60);
  text("TENNIS", width/2, 120);

  // white background
  fill(255);
  rect(width/2, 430, 430, 500, 30);

  // instructions
  fill(darkGray);

  textAlign(LEFT, TOP);
  textFont(regular);
  textSize(20);
  text("Press W to jump with the red player\nand press UP to jump with the blue \nplayer. Hit the ball with your racket,\nand if you hit it with the center of the\ntennis racket, the ball will go really\nfast.", 430, 230);

  // buttons
  textFont(bold);
  textAlign(LEFT);
  drawButton(width/2, 480, 300, 100, "FRIEND", darkBlue);
  drawButton(width/2, 590, 300, 100, "BOT", darkBlue);
  textAlign(CENTER, CENTER);

  //Person icon
  fill(white);
  noStroke();
  // head
  circle(510, 470, 35);
  // shoulders/body
  arc(510, 510, 40, 60, PI, TWO_PI);

  //robot icon
  // head
  rect(510, 585, 45, 35, 15);
  //face
  fill(darkBlue);
  rect (510, 587, 35, 23, 10);
  // eyes
  fill(white);
  circle(500, 585, 8);
  circle(520, 585, 8);
  //mouth
  arc(510, 590, 12, 10, 0, PI);
  // body
  rect(510, 613, 30, 15, 8);
  // antennas
  stroke(white);
  strokeWeight(5);
  line(510, 570, 510, 560);
  fill(white);
  circle(510, 560, 5);
}

void introClicks() {

  // FRIEND button
  if (mouseX > width/2 - 150 && mouseX < width/2 + 150 &&  mouseY > 490 - 42 &&  mouseY < 490 + 42) {

    AI = false;
    leftScore = 0;
    rightScore = 0;
    resetBall();
    mode = GAME;
  }

  // BOT button
  if (mouseX > width/2 - 150 && mouseX < width/2 + 150 && mouseY > 590 - 42 && mouseY < 590 + 42) {

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

  stroke(white);
  fill(buttonColor);
  rect(x, y, w, h, 15);

  fill(white);
  textSize(35);
  text(label, x-50, y+20);

  fill(blue);
  textSize(15);
  text("play vs.", x-50, y-15);
}
