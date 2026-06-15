void intro() {
}

void introClicks() {
  }

// Handles drawing the button and checking for hover thickness
void drawButton(float x, float y, float w, float h, String label, color buttonColor) {
  // Center-aligned bounding box math
  if (mouseX > x - w/2 && mouseX < x + w/2 &&
    mouseY > y - h/2 && mouseY < y + h/2) {
    strokeWeight(5); // Thick border on hover
  } else {
    strokeWeight(1); // Normal border
  }

  stroke(255);
  fill(buttonColor);
  rect(x, y, w, h);

  fill(255);
  textSize(25);
  text(label, x, y);

  //reset score
  leftScore = 0;
  rightScore = 0;
}
