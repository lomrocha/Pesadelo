PImage whip;
PImage whipShadow;

final int WHIP = 2;
final int WHIPTOTAL = 5;

private class Chicote extends Item {
  Chicote(int x, int y) {
    setValues(x, y, 1);
  }

  Chicote() {
    setValues(int(random(100, 600)), -50, 0);
  }

  private void setValues(int x, int y, int index) {
    this.setSelf(new PVector(x, y));
    
    this.setTypeOfObject((index == 0) ? OBJECT_WITH_SHADOW : OBJECT_WITHOUT_SHADOW);

    this.setShadowImage(whipShadow);
    this.setShadowOffset(new PVector(10, 76));

    this.setSpriteImage(whip);
    this.setSpriteInterval(75);
    this.setSpriteWidth(101);
    this.setSpriteHeight(91);
    this.setMotionY(SCENERY_VELOCITY / 2);

    this.setItemIndex(WHIP);
    this.setItemTotal(WHIPTOTAL);
  }
}
