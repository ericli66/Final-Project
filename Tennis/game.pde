void game() {
  intro.pause();

  drawCourt();

  if (startTimer > 0) {

    fill(255);
    textSize(150);

    if (startTimer > 120) {
      text("3", width/2, height/2);
    } else if (startTimer > 60) {
      text("2", width/2, height/2);
    } else {
      text("1", width/2, height/2);
    }

    startTimer--;
      if (startTimer == 0)  {
    whistle.rewind();
    whistle.play();
  }
  } else if (resetTimer > 0) {
    movePlayers();
    resetTimer--;
  } else if (rocketTimer > 0) {
    rocketTimer--;
    movePlayers();

    if (rocketTimer == 0) {
      vx = rocketVX;
      vy = 0;
      rocketShot = false;
      leftFrozen = false;
      rightFrozen = false;
    }
  } else {
    moveBot();
    movePlayers();
    moveBall();
    racketCollision();
  }

  drawPlayers();
  drawBall();
}


void gameClicks() {
  if (dist(mouseX, mouseY, width/2, height) <= 50) mode = INTRO;
}

void drawCourt() {
  background(lightBlue);

  // Stadium
  noStroke();
  fill(gray);
  rect(width/2, 410, width, 290);

  // Outside court
  fill(green);
  rect(width/2, 700, width, 300);

  // Inside court
  fill(lightGreen);
  quad(150, 580, 1050, 580, 1140, 660, 60, 660);

  // Court lines
  stroke(white);
  strokeWeight(6);
  noFill();

  quad(150, 580, 1050, 580, 1140, 660, 60, 660);
  line(width/2, 580, width/2, 660);
  line(260, 620, 950, 620);
  line(280, 580, 240, 660);
  line(930, 580, 970, 660);

  // score
  noStroke();
  fill(white);
  circle(width/2, 0, 100);

  fill(red);
  textSize(20);
  text(leftScore, width/2 - 20, 20);

  fill(blue);
  text(rightScore, width/2 + 20, 20);

  fill(0);
  circle(width/2, 20, 10);

  //exit button
  noStroke();
  fill(white);
  circle(width/2, height, 100);
  fill(0);
  text("exit", width/2, height - 20);
}



void movePlayers() {
  if (leftFrozen == false) {
    leftVY = leftVY + gravity;
    leftY = leftY + leftVY;
  }

  if (rightFrozen == false) {
    rightVY = rightVY + gravity;
    rightY = rightY + rightVY;
  }

  if (leftY > groundY) {
    leftY = groundY;
    leftVY = 0;
  }

  if (rightY > groundY) {
    rightY = groundY;
    rightVY = 0;
  }

  if (leftY < 110) {
    leftY = 110;
    leftVY = 0;
  }

  if (rightY < 110) {
    rightY = 110;
    rightVY = 0;
  }
}



void drawPlayers() {
  drawLeftPlayer();
  drawRightPlayer();
}



void drawLeftPlayer() {
  // hat brim
  fill(0);
  noStroke();
  ellipse(leftX - 30, leftY - 30, 55, 18);

  // red hat
  stroke(0);
  fill(red);
  circle(leftX, leftY - 20, 60);

  // body
  stroke(0);
  strokeWeight(5);
  fill(darkGray);
  rect(leftX, leftY, 60, 50, 15);

  // eyes
  noStroke();
  fill(white);
  circle(leftX + 15, leftY - 10, 22);
  circle(leftX - 5, leftY - 10, 22);

  fill(0);
  circle(leftX + 20, leftY - 10, 8);
  circle(leftX, leftY - 10, 8);
  stroke(0);
  line(leftX - 30, leftY - 20, leftX + 30, leftY - 20);

  // racket handle
  stroke(red);
  strokeWeight(8);
  line(leftX + 55, leftY + 15, leftX + 55, leftY - 60);

  // racket head
  fill(white);
  stroke(red);
  strokeWeight(6);
  ellipse(leftX + 55, leftY - 70, 50, 70);

  // hand
  strokeWeight(2);
  stroke(0);
  fill(darkGray);
  circle(leftX + 55, leftY - 20, 20);
}



void drawRightPlayer() {
  // body
  stroke(0);
  strokeWeight(5);
  fill(darkGray);
  rect(rightX, rightY - 10, 60, 70, 15);

  // eyes
  noStroke();
  fill(white);
  circle(rightX - 15, rightY - 15, 22);
  circle(rightX + 5, rightY - 15, 22);

  fill(0);
  circle(rightX - 20, rightY - 15, 8);
  circle(rightX, rightY - 15, 8);

  // blue headband
  stroke(blue);
  strokeWeight(12);
  line(rightX - 30, rightY - 35, rightX + 30, rightY - 20);

  // racket handle
  stroke(blue);
  strokeWeight(8);
  line(rightX - 55, rightY + 15, rightX - 55, rightY - 70);

  // racket head
  fill(white);
  stroke(blue);
  strokeWeight(6);
  ellipse(rightX - 55, rightY - 70, 50, 70);

  // hand
  strokeWeight(2);
  stroke(0);
  fill(darkGray);
  circle(rightX - 55, rightY - 15, 20);
}



void moveBall() {
  vy = vy + ballGravity;

  ballX = ballX + vx;
  ballY = ballY + vy;

  // roof bounce
  if (ballY < ballD/2) {
    ballY = ballD/2;
    vy = vy * -0.9;
    bounce.play();
    bounce.rewind();
  }

  // floor bounce
  if (ballY > 620 - ballD/2) {
    ballY = 620 - ballD/2;
    vy = vy * -1.1;
    bounce.play();
    bounce.rewind();
  }

  // scoring
  if (ballX < -300) {
    whistle.rewind();
    whistle.play();
    rightScore++;
    resetBall();
  }

  if (ballX > width + 300) {
    whistle.rewind();
    whistle.play();
    leftScore++;
    resetBall();
  }

  if (leftScore == 3 || rightScore == 3) {
    mode = GAMEOVER;
  }
}


void drawBall() {
  if (rocketShot) {
    stroke(#FF9900);
    strokeWeight(8);
  } else {
    stroke(0);
    strokeWeight(2);
  }

  fill(#D9F23D);
  circle(ballX, ballY, ballD);
}



void racketCollision() {
  float racketD = 70;
  float sweetSpot = 10;

  // LEFT RACKET HEAD
  float leftRacketX = leftX + 55;
  float leftRacketY = leftY - 70;

  if (dist(leftRacketX, leftRacketY, ballX, ballY) <= racketD/2 + ballD/2) {
    if (ballY > leftRacketY - sweetSpot && ballY < leftRacketY + sweetSpot) {
      rocketShot = true;
      leftFrozen = true;
      rocketTimer = 25;
      rocketVX = 22;

      firework.rewind();
      firework.play();
    } else {
      vx = (ballX - leftRacketX) / 4;
      vy = (ballY - leftRacketY) / 4;

      if (vx < 6) vx = 6;

      bounce.rewind();
      bounce.play();
    }
  }

  // LEFT HANDLE
  if (ballX > leftX + 45 && ballX < leftX + 65 &&
      ballY > leftY - 60 && ballY < leftY + 20) {
    vx = 8;
    vy = (ballY - (leftY - 25)) / 4;

    bounce.rewind();
    bounce.play();
  }

  // RIGHT RACKET HEAD
  float rightRacketX = rightX - 55;
  float rightRacketY = rightY - 70;

  if (dist(rightRacketX, rightRacketY, ballX, ballY) <= racketD/2 + ballD/2) {
    if (ballY > rightRacketY - sweetSpot && ballY < rightRacketY + sweetSpot) {
      rocketShot = true;
      rightFrozen = true;
      rocketTimer = 25;
      rocketVX = -22;

      firework.rewind();
      firework.play();
    } else {
      vx = (ballX - rightRacketX) / 4;
      vy = (ballY - rightRacketY) / 4;

      if (vx > -6) vx = -6;

      bounce.rewind();
      bounce.play();
    }
  }

  // RIGHT HANDLE
  if (ballX > rightX - 65 && ballX < rightX - 45 &&
      ballY > rightY - 70 && ballY < rightY + 20) {
    vx = -8;
    vy = (ballY - (rightY - 25)) / 4;

    bounce.rewind();
    bounce.play();
  }
}

void resetBall() {
  resetTimer = 180;

  rocketShot = false;
  rocketTimer = 0;
  leftFrozen = false;
  rightFrozen = false;

  if (random(1) < 0.5) {
    // spawn in front of left player
    ballX = 270;
    ballY = 480;
    vx = 8;
  } else {
    // spawn in front of right player
    ballX = 930;
    ballY = 480;
    vx = -8;
  }

  vy = 0;
}


void moveBot() {
  // Only bot if AI mode is on
  if (AI == true) {

    // Bot only jumps when the ball is on the right side
    if (ballX > width/2) {

      // Bot jumps if ball is above the racket
      if (ballY < rightY - 80) {
        rightVY = jumpPower;
      }
    }
  }
}
