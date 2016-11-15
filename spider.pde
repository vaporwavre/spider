final int CEPHALOTHORAX_SIZE = 169; //<>//
final int MAX_EYES = 22;
float[][] cephalothoraxDeviations = getCephalothoraxDeviations();
float jointOneGrowth = 0.25;
float jointTwoGrowth = 0.25;
int eyeCount = 0;
float cephalothoraxCenterX, cephalothoraxCenterY;
float[][] legEnds = new float[73][2];
float[][] jointOneEndPoints = new float[73][2];
Eye[] eyes = new Eye[MAX_EYES];

void setup()
{
  for (int i = 0; i < legEnds.length; i++) {
    legEnds[i][0] = 0;
    legEnds[i][1] = 0;
  }
  frameRate(24);
  size(420, 420);
  cephalothoraxCenterX = width/2;
  cephalothoraxCenterY = height/2;
  background(255, 0, 0);
  smooth();
  drawCephalothorax();
  initEyes();
}

void draw() {
  background(255, 0, 0);
  cephalothoraxDeviations = getCephalothoraxDeviations();
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
    float randomX = random(cephalothoraxCenterX + radius + 15);
    float randomY = random(cephalothoraxCenterY + radius + 15);
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
  fill(0);
  int radius = CEPHALOTHORAX_SIZE/2;
  float x, y;
  float lastx = -999;
  float lasty = -999;
  final float JOINT_ONE_LENGTH = 25;
  final float JOINT_TWO_LENGTH = 42;
  beginShape();
  int singleIncrementIndex;
  for (float ang = 0; ang <= 360; ang += 5) {
    singleIncrementIndex = ang == 0 ? 0 : round(ang/5);
    radius += 0.5;
    float rad = radians(ang);
    x = cephalothoraxCenterX + (radius * cos(rad) + cephalothoraxDeviations[singleIncrementIndex][0]);
    y = cephalothoraxCenterY + (radius * sin(rad) + cephalothoraxDeviations[singleIncrementIndex][1]);
    vertex(x, y);
    lastx = x;
    lasty = y;
    if (lastx > -999) {
      line(x, y, lastx, lasty);
    }

    //legs
    boolean jointOneComplete = (dist(x, y, legEnds[singleIncrementIndex][0], legEnds[singleIncrementIndex][1]) >= JOINT_ONE_LENGTH) && legEnds[singleIncrementIndex][0] != 0;
    if (!jointOneComplete) {
      if (x < cephalothoraxCenterX & !jointOneComplete) {
        legEnds[singleIncrementIndex][0] = x - jointOneGrowth;
      } else if (!jointOneComplete) {
        legEnds[singleIncrementIndex][0] = x + jointOneGrowth;
      }
      legEnds[singleIncrementIndex][0] += random(3) - 3;
      if (y < cephalothoraxCenterY & !jointOneComplete) {
        legEnds[singleIncrementIndex][1] = y - jointOneGrowth;
      } else {
        legEnds[singleIncrementIndex][1] = y + jointOneGrowth;
      }
      legEnds[singleIncrementIndex][1] += random(3) - 3;
      line(x, y, legEnds[singleIncrementIndex][0], legEnds[singleIncrementIndex][1]);
      jointOneEndPoints[singleIncrementIndex][0] = legEnds[singleIncrementIndex][0];
      jointOneEndPoints[singleIncrementIndex][1] = legEnds[singleIncrementIndex][1];
    } else {
      line(x, y, jointOneEndPoints[singleIncrementIndex][0], jointOneEndPoints[singleIncrementIndex][1]);
      line(jointOneEndPoints[singleIncrementIndex][0], jointOneEndPoints[singleIncrementIndex][1], legEnds[singleIncrementIndex][0] + (random(3) - 3), legEnds[singleIncrementIndex][1] + jointTwoGrowth);
    }
  }
  endShape(CLOSE);
  if (jointOneGrowth > JOINT_ONE_LENGTH) {
    if (jointTwoGrowth < JOINT_TWO_LENGTH)
      jointTwoGrowth += 0.25;
  } else
    jointOneGrowth += 0.25;
}

float[][] getCephalothoraxDeviations() {
  float[][] result = new float[73][2];
  for (int i = 0; i < result.length; i++) {
    result[i][0] = random(1, 6);
    result[i][1] = random(1, 6);
  }
  return result;
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