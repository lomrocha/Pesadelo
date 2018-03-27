PImage[] sceneryImages = new PImage [6];
PImage[] bossSceneryImages =  new PImage [3];

PImage door;
PImage fence;

final int SCENERYMOVEMENT = 2;

public class Cenario {
private PVector scenery = new PVector();

  private int sceneryIndex;

  public Cenario(int y, int sceneryIndex) {
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
    
    scenery.y += SCENERYMOVEMENT;
  }
}

ArrayList<Cenario> cenarios = new ArrayList<Cenario>();

void cenario() {
  for (Cenario c : cenarios) {
    c.update();
    c.display();
  }
}