//Eric Li
//2-4
//May 14, 2026

import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

// sound variables
Minim minim;
AudioPlayer intro, score, gameover, bounce, firework;

// mode framework
int mode;
final int INTRO = 1;
final int GAME = 2;
final int PAUSE = 3;
final int GAMEOVER = 4;

// player variables
float leftX, leftY, rightX, rightY;
float leftVY, rightVY;
float gravity = 0.5;
float jumpPower = -13;
float groundY = 600;

// ball variables
float ballX, ballY, ballD;
float vx, vy;
float ballGravity = 0.12;

// rocket shot variables
boolean rocketShot = false;
boolean leftFrozen = false;
boolean rightFrozen = false;
boolean AI = false;
int rocketTimer = 0;
float rocketVX, rocketVY;
int startTimer = 90;

// score
int leftScore, rightScore;

// colors
color white = #FFFFFF;
color lightBlue = #97fefa;
color blue = #04c1ed;
color red = #fe5f56;
color green = #2d8f3c;
color lightGreen = #32b746;
color darkGray = #434852;
color gray = #335972;



void setup() {
  size(1200, 800);
  mode = INTRO;

  rectMode(CENTER);
  imageMode(CENTER);
  textAlign(CENTER, CENTER);

  // player start
  leftX = 180;
  leftY = groundY;

  rightX = 1020;
  rightY = groundY;

  leftVY = 0;
  rightVY = 0;
  
  //ball start
  ballD = 25;
  resetBall();

  // minim
  minim = new Minim(this);
  intro = minim.loadFile("INTRO.mp3");
  firework = minim.loadFile("FIREWORK.mp3");
  gameover = minim.loadFile("FAILURE.wav");
  bounce = minim.loadFile("BOUNCE.wav");
}



void draw() {
  if (mode == INTRO) {
    intro();
  } else if (mode == GAME) {
    game();
  } else if (mode == PAUSE) {
    pause();
  } else if (mode == GAMEOVER) {
    gameover();
  }
}
