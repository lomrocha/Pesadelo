PImage coxinha;

private class Coxinha extends Comida {
  Coxinha(int x, int y) {
    setValues(x, y);
  }

  Coxinha() {
    setValues(int(random(100, 670)), -50);
  }

  private void setValues(int x, int y) {
    this.setSelf(new PVector(x, y));
    
    this.setTypeOfObject(OBJECT_WITH_SHADOW);
    
    this.setShadowImage(foodShadow);
    this.setShadowOffset(new PVector(0, 20));
    
    this.setSpriteImage(coxinha);
    this.setSpriteInterval(75);
    this.setSpriteWidth(28);
    this.setSpriteHeight(30);
    this.setMotionY(1);

    this.setAmountHeal(5);
    this.setAmountRecovered(0);
  }
}
