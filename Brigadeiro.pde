PImage brigadeiro;

public class Brigadeiro extends Comida {
  public Brigadeiro(int x, int y) {
    this.setX(x);
    this.setY(y);

    setValues();
  }

  public Brigadeiro() {
    this.setX(int(random(200, 500)));
    this.setY(int(random(-300, -1000)));

    setValues();
  }

  void setValues() {
    setSpriteImage(brigadeiro);
    setSpriteInterval(75);
    setSpriteWidth(32);
    setSpriteHeight(31);
    setMovementY(1);

    setAmountHeal(3);
    setAmountRecovered(0);
  }

  void display() {
    image (foodShadow, getX(), getY() + 20);

    super.display();
  }
}