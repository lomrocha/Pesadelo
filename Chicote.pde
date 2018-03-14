PImage whip;
PImage whipShadow;

final int WHIP = 2;
final int WHIPTOTAL = 5;

public class Chicote extends Item {
  public Chicote() {
    setX(int(random(100, 599)));
    setY(int(random(-300, -1000)));

    setValues();
  }

  public Chicote(int x, int y) {
    this.setX(x);
    this.setY(y);

    setValues();
  }

  void setValues() {
    setSpriteImage(whip);
    setSpriteInterval(75);
    setSpriteWidth(101);
    setSpriteHeight(91);
    setMovementY(1);

    setItemIndex(WHIP);
    setItemTotal(WHIPTOTAL);
  }

  void display() {
    image (whipShadow, getX() + 10, getY() + 76);

    super.display();
  }
}