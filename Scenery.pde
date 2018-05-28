PImage[] sceneryImages = new PImage [6];
PImage[] bossSceneryImages =  new PImage [3];

PImage door;
PImage fence;

final int SCENERY_VELOCITY = 2;

int numberOfSceneries;

private class Scenery {
  private PVector scenery = new PVector();
  private PVector motion = new PVector();

  private int sceneryIndex;

  public Scenery(int y, int sceneryIndex) {
    this.scenery = new PVector(0, y);
    this.sceneryIndex = sceneryIndex;
  }

  void display() {
    image (sceneryImages[sceneryIndex], scenery.x, scenery.y);
  }

  void update() {
    if (scenery.y > height) {
      scenery.y = -600;
      numberOfSceneries = (!movementTutorialScreenActive) ? numberOfSceneries + 1 : 0;
    }

    scenery.y += motion.y;
  }

  void updateMovement() {
    motion.y = (numberOfSceneries < 35) ? SCENERY_VELOCITY : 0;
  }
}

ArrayList<Scenery> cenarios = new ArrayList<Scenery>();

void cenario() {
  for (Scenery c : cenarios) {
    c.updateMovement();
    c.update();
    c.display();
  }
}
