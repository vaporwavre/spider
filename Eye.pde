final int EYE_WIDTH = 10;
final float EYE_HEIGHT = EYE_WIDTH - 4.20;
final int EYE_COLOR = 255;

class Eye
{
  float xPosition, yPosition;
  int eyeWidth; 
  float eyeHeight;
  boolean closing;

  Eye(float xPosition, float yPosition) {
    this.xPosition = xPosition;
    this.yPosition = yPosition;
    this.eyeWidth = EYE_WIDTH;
    this.eyeHeight = EYE_HEIGHT;
    closing = randomBool();
  }
}