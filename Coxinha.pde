PImage coxinha;

public class Coxinha extends Comida {
  public Coxinha(int x, int y) {
    this.setX(x);
    this.setY(y);

    setValues();
  }

  public Coxinha() {
    setX(int(random(200, 500)));
    setY(int(random(-300, -1000)));

    setValues();
  }

  void setValues() {
    setSpriteImage(coxinha);
    setSpriteInterval(75);
    setSpriteWidth(28);
    setSpriteHeight(30);
    setMovementY(1);

    setAmountHeal(5);
    setAmountRecovered(0);
  }

  void display() {
    image (foodShadow, getX(), getY() + 20);

    super.display();
  }
}