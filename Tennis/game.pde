void game() {
  drawCourt();

  if (startTimer > 0) {
    startTimer--;
    movePlayers();

    // allow hit only when timer is basically finished
    if (startTimer == 0) {
      racketCollision();
    }

  } else if (rocketTimer > 0) {
    rocketTimer--;
    movePlayers();

    if (rocketTimer == 0) {
      vx = rocketVX;
      vy = rocketVY;
      rocketShot = false;
      leftFrozen = false;
      rightFrozen = false;
    }

  } else {
    movePlayers();
    moveBall();
    racketCollision();
  }

  drawPlayers();
  drawBall();
}

void gameClicks() {
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
  fill(red);
  textSize(60);
  text(leftScore, 300, 100);

  fill(blue);
  text(rightScore, 900, 100);
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
  }

  // floor bounce
  if (ballY > 620 - ballD/2) {
    ballY = 620 - ballD/2;
    vy = vy * -1.1;
  }

  // scoring

  if (ballX < -300) {
    rightScore++;
    resetBall();
  }

  if (ballX > width + 300) {
    leftScore++;
    resetBall();
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
  float racketD = 100;
  float sweetSpot = 10;

  // LEFT RACKET
  float leftRacketX = leftX + 45;
  float leftRacketY = leftY - 45;

  if (dist(leftRacketX-10, leftRacketY, ballX, ballY) <= racketD/2 + ballD/2 + 10) {
    //rocket shot
    if (ballY > leftRacketY-25 - sweetSpot && ballY < leftRacketY-25 + sweetSpot) {
      rocketShot = true;
      leftFrozen = true;
      rocketTimer = 25;

      rocketVX = 22;
      rocketVY = 0;
    } else {
      // LEFT normal hit
      vx = (ballX - leftRacketX) / 5;
      vy = (ballY - leftRacketY) / 5;

      if (vx < 6) {
        vx = 6;
      }
    }
  }

  // RIGHT RACKET
  float rightRacketX = rightX - 45;
  float rightRacketY = rightY - 45;

  if (dist(rightRacketX+10, rightRacketY, ballX, ballY) <= racketD/2 + ballD/2 + 10) {
    //rocket shot
    if (ballY > rightRacketY-25 - sweetSpot && ballY < rightRacketY-25 + sweetSpot) {
      rocketShot = true;
      rightFrozen = true;
      rocketTimer = 25;

      rocketVX = -22;
      rocketVY = 0;
    } else {
      // RIGHT normal hit
      vx = (ballX - rightRacketX) / 5;
      vy = (ballY - rightRacketY) / 5;

      if (vx > -6) {
        vx = -6;
      }
    }
  }
}

void resetBall() {
  startTimer = 90;

  rocketShot = false;
  rocketTimer = 0;
  leftFrozen = false;
  rightFrozen = false;

  if (random(1) < 0.5) {
    // spawn in front of left player
    ballX = 270;
    ballY = 480;
    vx = 6;
  } else {
    // spawn in front of right player
    ballX = 930;
    ballY = 480;
    vx = -6;
  }

  vy = 0;
}
