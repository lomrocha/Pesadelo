PImage skeletonHead;

public class CabecaEsqueleto extends Inimigo {
  private PVector target = new PVector (playerX, playerY);

  private int startingX;

  private int movementX;

  private int targetDivisor;

  public CabecaEsqueleto(int x, int y) {
    this.setX(x);
    this.setY(y);

    this.startingX = x;
    this.setSpriteWidth(36);
    this.setSpriteHeight(89);

    this.setDamage(2);
    this.setType(TypeOfEnemy.SKELETON_HEAD.ordinal());
  }

  void display() {
    image(skeletonHead, getX(), getY());
  }

  void update() {
    super.update();

    setX(getX() + movementX);
  }

  void updateMovement() {
    setMovementY(12);
    if (startingX != target.x) {
      movementX = (startingX < target.x) ? targetDivisor : -targetDivisor;

      return;
    }

    movementX = 0;
  }

  void updateTarget() {
    int distance = (target.x > startingX) ? int(target.x) - startingX : startingX - int(target.x);
    targetDivisor = int(map(distance, 0, 579, 1, 9));
  }
}

ArrayList<CabecaEsqueleto> cabecasEsqueleto = new ArrayList<CabecaEsqueleto>();