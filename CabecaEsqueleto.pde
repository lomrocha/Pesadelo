PImage skeletonHead;

public class CabecaEsqueleto extends Inimigo {
  private int startingX;

  private int movementX;

  private PVector target = new PVector (jLeiteX, jLeiteY);

  public CabecaEsqueleto(int x, int y) {
    this.setX(x);
    this.setY(y);

    startingX = x;
    setSpriteWidth(36);
    setSpriteHeight(89);

    setDamage(2);
    setIsHead(true);
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
      movementX = (startingX > target.x) ? -9 : 9;

      return;
    }

    movementX = 0;
  }
}

ArrayList<CabecaEsqueleto> cabecasEsqueleto = new ArrayList<CabecaEsqueleto>();