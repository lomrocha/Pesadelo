// -------------------------------------- SCENERY ---------------------------------------------------

PImage[] sceneryImages = new PImage [6];
PImage[] bossSceneryImages =  new PImage [3];

PImage door;
PImage fence;

final int SCENERY_VELOCITY = 8;

int numberOfSceneries;

private class Scenery
{
  private PVector scenery = new PVector();
  private PVector motion = new PVector();

  private int sceneryIndex;

  public Scenery(int y, int sceneryIndex) 
  {
    this.scenery = new PVector(0, y);
    this.sceneryIndex = sceneryIndex;
  }

  void display() 
  {
    image (sceneryImages[sceneryIndex], scenery.x, scenery.y);
  }

  void update()
  {
    if (scenery.y > height)
    {
      scenery.y = -600;
      numberOfSceneries = (!movementTutorialScreenActive) ? numberOfSceneries + 1 : 0;
    }

    scenery.y += motion.y;
  }

  void updateMovement() 
  {
    motion.y = (numberOfSceneries < 37) ? SCENERY_VELOCITY : 0;
  }
}

// -------------------------------------- TRANSITION GATE ---------------------------------------------------

final int DOOR  = 0;
final int FENCE = 1;

private class TransitionGate extends BaseStill 
{
  private PImage stillImage;

  private boolean hasOpened;
  private boolean triggerOpening;
  
  void setTriggerOpening(boolean triggerOpening)
  {
    this.triggerOpening = triggerOpening;
  }

  TransitionGate(int x, int y, int index) 
  {
    this.setSelf(new PVector(x, y)); // X: 230 para porta, 188 para cerca. Y: cenarioY para porta, cenarioY + 20 para cerca.

    this.setTypeOfObject(OBJECT_WITHOUT_SHADOW);

    switch (index) 
    {
    case 0:
      this.setSpriteImage(door);
      this.setSpriteWidth(334);
      this.setSpriteHeight(256);
      break;
    case 1:
      this.setSpriteImage(fence);
      this.setSpriteWidth(426);
      this.setSpriteHeight(146);
      break;
    }
    this.setSpriteInterval(350);
  }

  void display() 
  {
    if (triggerOpening)
    {
      if (!hasOpened) 
      {
        super.display();
      } else 
      {
        stillImage = door.get(1002, 0, 334, 256); 
        image(stillImage, getX(), getY());
      }
    }
    else
    {
      stillImage = door.get(0, 0, 334, 256);
      image(stillImage, getX(), getY());
    }
  }

  void stepHandler() 
  {
    if (getStep() == getSpriteImage().width) 
    {
      hasOpened = true;
    }
  }
}
