public class MaisGeral {
  private PImage sprite;
  private PImage spriteImage;

  private int x;
  private int y;
  private int movementY;

  private int step;
  private int spriteTime;
  private int spriteInterval;

  private int spriteWidth;
  private int spriteHeight;

  private boolean deleteObject;

  public PImage getSprite() {
    return sprite;
  }
  protected void setSprite(PImage sprite) {
    this.sprite = sprite;
  }

  public PImage getSpriteImage() {
    return spriteImage;
  }
  protected void setSpriteImage(PImage enemy) {
    this.spriteImage = enemy;
  }

  public int getX() {
    return x;
  }
  protected void setX(int x) {
    this.x = x;
  }

  public int getY() {
    return y;
  }
  protected void setY(int y) {
    this.y = y;
  }

  public int getMovementY() {
    return movementY;
  }
  protected void setMovementY(int movementY) {
    this.movementY = movementY;
  }

  public int getStep() {
    return step;
  }
  protected void setStep(int step) {
    this.step = step;
  }

  public int getSpriteTime() {
    return spriteTime;
  }
  protected void setSpriteTime(int spriteTime) {
    this.spriteTime = spriteTime;
  }

  public int getSpriteInterval() {
    return spriteInterval;
  }
  protected void setSpriteInterval(int spriteInterval) {
    this.spriteInterval = spriteInterval;
  }

  public int getSpriteWidth() {
    return spriteWidth;
  }
  protected void setSpriteWidth(int spriteWidth) {
    this.spriteWidth = spriteWidth;
  }

  public int getSpriteHeight() {
    return spriteHeight;
  }
  protected void setSpriteHeight(int spriteHeight) {
    this.spriteHeight = spriteHeight;
  }

  public boolean getDeleteObject() {
    return deleteObject;
  }
  protected void setDeleteObject(boolean deleteObject) {
    this.deleteObject = deleteObject;
  }

  void display() {
    if (millis() > spriteTime + spriteInterval) {
      sprite = spriteImage.get(step, 0, spriteWidth, spriteHeight);
      step = step % spriteImage.width + spriteWidth;
      image(sprite, x, y);
      spriteTime = millis();
    } else {
      image(sprite, x, y);
    }

    if (step == spriteImage.width) {
      step = 0;
      deleteObject = true;
    }
  }
}

public class Geral extends MaisGeral {
  void update() {
    setY(getY() + getMovementY());
  }

  boolean hasCollided() {
    if (getX() + getSpriteWidth() >= jLeiteX && getX() <= jLeiteX + 63 && getY() + getSpriteHeight() >= jLeiteY && getY() <= jLeiteY + 126) {
      return true;
    }

    return false;
  }

  boolean hasExitScreen() {
    if (getY() > height) {
      return true;
    }

    return false;
  }
}