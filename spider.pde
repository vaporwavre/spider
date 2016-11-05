int cephalothoraxSize = 169;
float cephalothoraxCenterX, cephalothoraxCenterY;

void setup()
{
  size(420, 666);
  cephalothoraxCenterX = width/2;
  cephalothoraxCenterY = height/1.69;
  background(255, 0, 0);
  smooth();
  drawBody();
  drawEyes(50);
}

void draw() {
}

void drawEyes(int eyeCount) {
  int eyeSize = 6;
  float radius = cephalothoraxSize/2;
  fill(255);
  for (int i = 0; i < eyeCount; i++) {
    float randomX = random(cephalothoraxCenterX + radius);
    float randomY = random(cephalothoraxCenterY+radius);
    if (dist(cephalothoraxCenterX, cephalothoraxCenterY, randomX, randomY) < (radius - 4.20) && (randomY > cephalothoraxCenterY + 15)) {
      ellipse(randomX, randomY, eyeSize+4, eyeSize);
    } else {
      i--;
    }
  }
}

void drawBody() {
  fill(0);
  ellipse(cephalothoraxCenterX, cephalothoraxCenterY, cephalothoraxSize, cephalothoraxSize);
}