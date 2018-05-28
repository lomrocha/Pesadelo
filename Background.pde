private class Background extends MaisGeral {
  Background() {
    this.setSelf(new PVector(0, 0));

    this.setTypeOfObject(OBJECT_WITHOUT_SHADOW);

    this.setSpriteImage(backgroundMenu);
    this.setSpriteInterval(140);
    this.setSpriteWidth(800);
    this.setSpriteHeight(600);
  }
}
