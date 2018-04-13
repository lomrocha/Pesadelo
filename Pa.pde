PImage shovel;
PImage shovelShadow;

final int SHOVEL = 1;
final int SHOVELTOTAL = 5;

public class Pa extends Item {
  public Pa() {
    setX(int(random(100, 616)));
    setY(int(random(-300, -1000)));

    setValues();
  }

  public Pa(int x, int y) {
    this.setX(x);
    this.setY(y);

    setValues();
  }

  void setValues() {
    setSpriteImage(shovel);
    setSpriteInterval(75);
    setSpriteWidth(84);
    setSpriteHeight(91);
    setMotionY(1);

    setItemIndex(SHOVEL);
    setItemTotal(SHOVELTOTAL);
  }

  void display() {
    image (shovelShadow, getX() + 1, getY() + 85);

    super.display();
  }
}