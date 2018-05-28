PImage queijo;

private class Queijo extends Comida {
  Queijo(int x, int y) {
    setValues(x, y);
  }

  public Queijo() {
    setValues(int(random(100, 670)), -50);
  }

  private void setValues(int x, int y) {
    this.setSelf(new PVector(x, y));

    this.setShadowImage(foodShadow);
    this.setShadowOffset(new PVector(0, 19));
    
    this.setTypeOfObject(OBJECT_WITH_SHADOW);

    this.setSpriteImage(queijo);
    this.setSpriteInterval(75);
    this.setSpriteWidth(31);
    this.setSpriteHeight(29);
    this.setMotionY(1);

    this.setAmountHeal(4);
    this.setAmountRecovered(0);
  }
}
