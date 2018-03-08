PImage[] sceneryImages = new PImage [6];
PImage[] bossSceneryImages =  new PImage [3];

PImage door;
PImage fence;

int sceneryMovement = 2;

public class Cenario {
  private int sceneryX;
  private int sceneryY;

  private int sceneryIndex;

  public Cenario(int sceneryX, int sceneryY, int sceneryIndex) {
    this.sceneryX = sceneryX;
    this.sceneryY = sceneryY;
    this.sceneryIndex = sceneryIndex;
  }

  void display() {
    image (sceneryImages[sceneryIndex], sceneryX, sceneryY);
  }

  void update() {
    if (sceneryY > height) {
      sceneryY = -600;
    }
    
    sceneryY = sceneryY + sceneryMovement;
  }
}

ArrayList<Cenario> cenarios;

void cenario() {
  for (Cenario c : cenarios) {
    c.update();
    c.display();
  }
}