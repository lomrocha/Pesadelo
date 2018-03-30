public class TransitionGate extends MaisGeral {
  private boolean hasOpened;

  TransitionGate(int x, int y, int index) {
    this.setX(x); // 230 para porta, 188 para cerca.
    this.setY(y); // cenarioY para porta, cenarioY + 20 para cerca.

    switch (index) {
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

  void display() {
    if (!hasOpened) {
      super.display();
    } else {
      image(getSpriteImage(), getX(), getY());
    }
  }

  void stepHandler() {
    if (getStep() == getSpriteImage().width) {
      hasOpened = true;
    }
  }
}