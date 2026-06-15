void pause() {
  //resume button
  noStroke();
  fill(255);
  circle(400, 50, 60);
  fill(0);
  triangle(390, 30, 420, 50, 390, 70);

}

void pauseClicks() {
  if ( dist(mouseX, mouseY, 400, 50) < 40) {
    mode = GAME;
  }
}
