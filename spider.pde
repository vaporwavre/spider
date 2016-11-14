final int CEPHALOTHORAX_SIZE = 169; //<>// //<>//
final int MAX_EYES = 30;

int eyeCount = 0;
float cephalothoraxCenterX, cephalothoraxCenterY;
Eye[] eyes = new Eye[MAX_EYES];

void setup()
{
  frameRate(24);
  size(420, 666);
  cephalothoraxCenterX = width/2;
  cephalothoraxCenterY = height/1.69;
  background(255, 0, 0);
  smooth();
  drawCephalothorax();
  initEyes();
}

void draw() {
  background(255, 0, 0);
  drawCephalothorax();
  animateEyes();
}

void animateEyes() {
  fill(EYE_COLOR);
  for (int i = 0; i < eyes.length; i++) {
    if (eyes[i].closing) {
      if (eyes[i].eyeHeight > 0) {
        eyes[i].eyeHeight -= random(0, 0.55);
        ellipse(eyes[i].xPosition, eyes[i].yPosition, eyes[i].eyeWidth, eyes[i].eyeHeight);
      } else {
        eyes[i].closing = false;
        eyes[i].eyeHeight += random(0, 0.55);
        ellipse(eyes[i].xPosition, eyes[i].yPosition, eyes[i].eyeWidth, eyes[i].eyeHeight);
      }
    } else {
      if (eyes[i].eyeHeight < EYE_HEIGHT) {
        eyes[i].eyeHeight += random(0, 0.25);
        ellipse(eyes[i].xPosition, eyes[i].yPosition, eyes[i].eyeWidth, eyes[i].eyeHeight);
      } else {
        eyes[i].closing = true;
        eyes[i].eyeHeight -= random(0, 0.25);
        ellipse(eyes[i].xPosition, eyes[i].yPosition, eyes[i].eyeWidth, eyes[i].eyeHeight);
      }
    }
  }
}

void initEyes() {
  float radius = CEPHALOTHORAX_SIZE/2;
  fill(EYE_COLOR);
  for (int i = 0; i < MAX_EYES; i++) {
    float randomX = random(cephalothoraxCenterX + radius);
    float randomY = random(cephalothoraxCenterY + radius);
    Eye newEye = new Eye(randomX, randomY);
    if (!eyeOverlaps(newEye) && dist(cephalothoraxCenterX, cephalothoraxCenterY, randomX, randomY) < (radius - 4.20) && (randomY > cephalothoraxCenterY + 15)) {
      eyes[eyeCount] = newEye;
      eyeCount++;
      ellipse(randomX, randomY, EYE_WIDTH, random(1, EYE_HEIGHT));
    } else {
      i--;
    }
  }
}

void drawCephalothorax() {
  noStroke();
  fill(0);
  int radius = CEPHALOTHORAX_SIZE/2;
  float x, y;
  float lastx = -999;
  float lasty = -999;
  beginShape();
  for (float ang = 0; ang <= 360; ang += 5) {
    radius += 0.5;
    float rad = radians(ang);
    x = cephalothoraxCenterX + (radius * cos(rad) + random(1, 15));
    y = cephalothoraxCenterY + (radius * sin(rad) + random(1, 15));
    if (lastx > -999) {
      line(x, y, lastx, lasty);
    }
    vertex(x,y);
    lastx = x;
    lasty = y;
  }
  endShape(CLOSE);
}

boolean eyeOverlaps(Eye eye) {
  for (int i = 0; i < eyeCount; i++) {
    float distance = dist(eye.xPosition, eye.yPosition, eyes[i].xPosition, eyes[i].yPosition);
    if (distance < EYE_WIDTH) {
      return true;
    }
  }
  return false;
}

boolean randomBool() {
  return random(1) > .5;
}