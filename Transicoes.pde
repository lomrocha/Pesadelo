final int DOOR  = 0;
final int FENCE = 1;

private class TransitionGate extends MaisGeral {
  private boolean hasOpened;

  TransitionGate(int x, int y, int index) {
    this.setSelf(new PVector(x, y)); // X: 230 para porta, 188 para cerca. Y: cenarioY para porta, cenarioY + 20 para cerca.
    
    this.setTypeOfObject(OBJECT_WITHOUT_SHADOW);

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
