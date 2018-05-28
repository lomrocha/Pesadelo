PImage brigadeiro;

private class Brigadeiro extends Comida {
  Brigadeiro(int x, int y) {
    setValues(x, y);
  }

  Brigadeiro() {
    setValues(int(random(100, 670)), -50);
  }

  private void setValues(int x, int y) {
    this.setSelf(new PVector(x, y));
    
    this.setTypeOfObject(OBJECT_WITH_SHADOW);
    
    this.setShadowImage(foodShadow);
    this.setShadowOffset(new PVector(0, 20));
    
    this.setSpriteImage(brigadeiro);
    this.setSpriteInterval(75);
    this.setSpriteWidth(32);
    this.setSpriteHeight(31);
    this.setMotionY(1);

    this.setAmountHeal(3);
    this.setAmountRecovered(0);
  }
}
