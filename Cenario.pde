PImage[] sceneryImages = new PImage [6];
PImage[] bossSceneryImages =  new PImage [3];

PImage door;
PImage fence;

final int SCENERY_MOVEMENT = 2;

int numberOfSceneries;

public class Scenery {
  private PVector scenery = new PVector();
  private int movementY;

  private int sceneryIndex;

  public Scenery(int y, int sceneryIndex) {
    this.scenery.x = 0;
    this.scenery.y = y;
    this.sceneryIndex = sceneryIndex;
  }

  void display() {
    image (sceneryImages[sceneryIndex], scenery.x, scenery.y);
  }

  void update() {
    if (scenery.y > height) {
      scenery.y = -600;
      numberOfSceneries++;
    }

    scenery.y += movementY;
  }

  void updateMovement() {
    movementY = (numberOfSceneries < 35) ? SCENERY_MOVEMENT : 0;
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