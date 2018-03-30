PImage[] sceneryImages = new PImage [6];
PImage[] bossSceneryImages =  new PImage [3];

PImage door;
PImage fence;

final int SCENERYMOVEMENT = 2;

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
    }

    scenery.y += movementY;
  }
  
  void updateMovement(){
    movementY = SCENERYMOVEMENT;
  }
}

ArrayList<Scenery> cenarios = new ArrayList<Scenery>();

void cenario() {
  for (Scenery c : cenarios) {
    c.update();
    c.display();
  }
}