PImage skeletonHead;

public class CabecaEsqueleto extends Geral {
  private int movementX;

  private int skeletonHeadTarget;

  private boolean isHeadStraight;

  public CabecaEsqueleto(int x, int y, int skeletonHeadTarget) {
    this.setX(x);
    this.setY(y);
    this.skeletonHeadTarget = skeletonHeadTarget;
    
    setSpriteWidth(36);
    setSpriteHeight(89);
    setMovementY(12);
  }

  void display() {
    image(skeletonHead, getX(), getY());
  }

  void update() {
    setX(getX() + movementX);
    if (!isHeadStraight) {
      if (getX() > skeletonHeadTarget) {
        movementX = -8;
      } else {
        movementX = 8;
      }
    } else {
      movementX = 0;
    }

    setY(getY() + getMovementY());
  }

  void checaCabecaEsqueletoReta() {
    if (getX() < skeletonHeadTarget) {
      if (skeletonHeadTarget - getX() < 10) {  
        isHeadStraight = true;
      } else {
        isHeadStraight = false;
      }
    } else {
      if (getX() - skeletonHeadTarget < 10) {  
        isHeadStraight = true;
      } else {
        isHeadStraight = false;
      }
    }
  }
}

ArrayList<CabecaEsqueleto> cabecasEsqueleto;

void cabecaEsqueleto() {
  for (int i = cabecasEsqueleto.size() - 1; i >= 0; i = i - 1) {
    CabecaEsqueleto c = cabecasEsqueleto.get(i);
    c.update();
    c.display();
    c.checaCabecaEsqueletoReta();
    if (c.hasExitScreen()) {
      cabecasEsqueleto.remove(c);
    }
    if (c.hasCollided()) {
      damage(2);
    }
  }
}