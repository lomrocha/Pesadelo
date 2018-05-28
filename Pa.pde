PImage shovel;
PImage shovelShadow;

final int SHOVEL = 1;
final int SHOVELTOTAL = 5;

private class Pa extends Item {
  Pa(int x, int y) {
    setValues(x, y, 1);
  }

  Pa() {
    setValues(int(random(100, 610)), -50, 0);
  }

  private void setValues(int x, int y, int index) {
    this.setSelf(new PVector(x, y));
    
    this.setTypeOfObject((index == 0) ? OBJECT_WITH_SHADOW : OBJECT_WITHOUT_SHADOW);
    
    this.setShadowImage(shovelShadow);
    this.setShadowOffset(new PVector(1, 85));
    
    this.setSpriteImage(shovel);
    this.setSpriteInterval(75);
    this.setSpriteWidth(84);
    this.setSpriteHeight(91);
    this.setMotionY(SCENERY_VELOCITY / 2);

    this.setItemIndex(SHOVEL);
    this.setItemTotal(SHOVELTOTAL);
  }
}
