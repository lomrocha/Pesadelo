PImage queijo;

public class Queijo extends Comida {
  public Queijo(int x, int y) {
    this.setX(x);
    this.setY(y);

    setValues();
  }

  public Queijo() {
    this.setX(int(random(200, 500)));
    this.setY(int(random(-300, -1000)));

    setValues();
  }

  void setValues() {    
    setSpriteImage(queijo);
    setSpriteInterval(75);
    setSpriteWidth(31);
    setSpriteHeight(29);
    setMovementY(1);

    setAmountHeal(4);
    setAmountRecovered(0);
  }

  void display() {
    image (foodShadow, getX(), getY() + 19);

    super.display();
  }
}