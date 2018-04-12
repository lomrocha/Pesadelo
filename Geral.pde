public class MaisGeral {
  private PImage sprite;
  private PImage spriteImage;

  private PVector self = new PVector();

  private int step;
  private int spriteTime;
  private int spriteInterval;

  private int spriteWidth;
  private int spriteHeight;

  public PImage getSprite() {
    return this.sprite;
  }
  protected void setSprite(PImage sprite) {
    this.sprite = sprite;
  }

  public PImage getSpriteImage() {
    return this.spriteImage;
  }
  protected void setSpriteImage(PImage enemy) {
    this.spriteImage = enemy;
  }

  public PVector getSelf() {
    return this.self;
  }
  protected void setSelf(PVector self) {
    this.self = self;
  }

  public int getX() {
    return int(this.self.x);
  }
  protected void setX(int x) {
    this.self.x = x;
  }

  public int getY() {
    return int(this.self.y);
  }
  protected void setY(int y) {
    this.self.y = y;
  }

  public int getStep() {
    return this.step;
  }
  protected void setStep(int step) {
    this.step = step;
  }

  public int getSpriteTime() {
    return this.spriteTime;
  }
  protected void setSpriteTime(int spriteTime) {
    this.spriteTime = spriteTime;
  }

  public int getSpriteInterval() {
    return this.spriteInterval;
  }
  protected void setSpriteInterval(int spriteInterval) {
    this.spriteInterval = spriteInterval;
  }

  public int getSpriteWidth() {
    return this.spriteWidth;
  }
  protected void setSpriteWidth(int spriteWidth) {
    this.spriteWidth = spriteWidth;
  }

  public int getSpriteHeight() {
    return this.spriteHeight;
  }
  protected void setSpriteHeight(int spriteHeight) {
    this.spriteHeight = spriteHeight;
  }

  void display() {
    handler.spriteHandler(this);
    stepHandler();
  }

  void stepHandler() {
    handler.stepHandler(this);
  }
}

public class Geral extends MaisGeral {
  private int movementY;

  public int getMovementY() {
    return this.movementY;
  }
  protected void setMovementY(int movementY) {
    this.movementY = movementY;
  }

  void update() {
    setY(getY() + getMovementY());
  }

  boolean hasCollided() {
    if (getX() + getSpriteWidth() >= playerX && getX() <= playerX + 63 && getY() + getSpriteHeight() >= playerY && getY() <= playerY + 126) {
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