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
AudioPlayer intro, score, whistle, bounce, firework;

// mode framework
int mode;
final int INTRO = 1;
final int GAME = 2;
final int GAMEOVER = 3;

// player variables
float leftX, leftY, rightX, rightY;
float leftVY, rightVY;
float gravity = 0.5;
float jumpPower = -10;
float groundY = 600;

// ball variables
float ballX, ballY, ballD;
float vx, vy;
float ballGravity = 0.12;

// rocket shot variables
boolean rocketShot = false;
boolean leftFrozen = false;
boolean rightFrozen = false;
float rocketVX;

//timers
int startTimer = 180;
int resetTimer = 0;
int gameoverTimer = 180;
int rocketTimer = 0;

//cloud variables
float cloudX;
float cloudY;
float cloudSpeed;

// score
int leftScore, rightScore;

//bot
boolean AI = false;

// colors
color white = #FFFFFF;
color lightBlue = #97fefa;
color darkBlue = #237ec5;
color blue = #04c1ed;
color red = #fe5f56;
color green = #2d8f3c;
color lightGreen = #32b746;
color darkGray = #434852;
color gray = #335972;

//font
PFont bold, regular;


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

  leftScore = 0;
  rightScore = 0;
  
  //cloud
  cloudX = 200;
  cloudY = 120;
  cloudSpeed = 1;

  // minim music
  minim = new Minim(this);
  intro = minim.loadFile("INTRO.mp3");
  intro.loop();
  firework = minim.loadFile("FIREWORK.mp3");
  whistle = minim.loadFile("WHISTLE.mp3");
  bounce = minim.loadFile("BOUNCE.wav");
  
  //font
  bold = createFont("LEMONMILK-Bold.otf", 200);
  regular = createFont("AlteHaasGroteskBold.ttf", 200);
}



void draw() {
  if (mode == INTRO) {
    intro();
  } else if (mode == GAME) {
    game();
  } else if (mode == GAMEOVER) {
    gameover();
  }
}
