// -------------------------------------- BASE STILL -------------------------------------------------

final int OBJECT_WITHOUT_SHADOW = 0;
final int OBJECT_WITH_SHADOW = 1;

private class BaseStill
{
  private PImage sprite;
  private PImage spriteImage;
  private PImage shadowImage;

  private PVector self = new PVector();

  private PVector shadowOffset = new PVector();

  private int typeOfObject;

  private int step;
  private int spriteTime;
  private int spriteInterval;

  private int spriteWidth;
  private int spriteHeight;

  // SPRITE_IMAGE
  public PImage getSpriteImage()
  {
    return this.spriteImage;
  }
  protected void setSpriteImage(PImage spriteImage)
  {
    this.spriteImage = spriteImage;
  }

  // SHADOW_IMAGE
  protected void setShadowImage(PImage shadowImage)
  {
    this.shadowImage = shadowImage;
  }

  // SELF
  protected void setSelf(PVector self)
  {
    this.self = self;
  }

  public int getX()
  {
    return (int)this.self.x;
  }
  protected void setX(int x)
  {
    this.self.x = x;
  }

  public int getY()
  {
    return (int)this.self.y;
  }
  protected void setY(int y)
  {
    this.self.y = y;
  }

  // SHADOW_OFFSET
  protected void setShadowOffset(PVector shadowOffset)
  {
    this.shadowOffset = shadowOffset;
  }

  // TYPE_OF_OBJECT
  protected void setTypeOfObject(int typeOfObject)
  {
    this.typeOfObject = typeOfObject;
  }

  // STEP
  public int getStep()
  {
    return this.step;
  }

  // SPRITE_INTERVAL
  protected void setSpriteInterval(int spriteInterval)
  {
    this.spriteInterval = spriteInterval;
  }

  // SPRITE_WIDTH
  public int getSpriteWidth()
  {
    return this.spriteWidth;
  }
  protected void setSpriteWidth(int spriteWidth)
  {
    this.spriteWidth = spriteWidth;
  }

  // SPRITE_HEIGHT
  public int getSpriteHeight()
  {
    return this.spriteHeight;
  }
  protected void setSpriteHeight(int spriteHeight)
  {
    this.spriteHeight = spriteHeight;
  }

  void display()
  {
    if (typeOfObject == OBJECT_WITH_SHADOW)
    {
      image(shadowImage, self.x + shadowOffset.x, self.y + shadowOffset.y);
    }

    if (millis() > spriteTime + spriteInterval)
    {
      sprite = spriteImage.get(step, 0, spriteWidth, spriteHeight);
      step = step % spriteImage.width + spriteWidth;
      spriteTime = millis();
    }

    image(sprite, self.x, self.y);


    stepHandler();
  }

  void stepHandler()
  {
    if (step == spriteImage.width)
    {
      step = 0;
    }
  }
}

// -------------------------------------- BASE MOVEMENT -------------------------------------------------

private class BaseMovement extends BaseStill
{
  private PVector motion = new PVector();

  // MOTION
  public int getMotionX()
  {
    return (int)this.motion.x;
  }
  protected void setMotionX(int x)
  {
    this.motion.x = x;
  }

  public int getMotionY()
  {
    return (int)this.motion.y;
  }
  protected void setMotionY(int y)
  {
    this.motion.y = y;
  }

  void update()
  {
    setY(getY() + getMotionY());
    setX(getX() + getMotionX());
  }

  boolean hasCollided()
  {
    if (getX() + getSpriteWidth() >= playerX && getX() <= playerX + 63 && getY() + getSpriteHeight() >= playerY && getY() <= playerY + 126)
    {
      return true;
    }

    return false;
  }

  boolean hasExitScreen()
  {
    if (getY() > height)
    {
      return true;
    }

    return false;
  }
}
