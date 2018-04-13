PImage brigadeiro;

public class Brigadeiro extends Comida {
  public Brigadeiro(int x, int y) {
    setValues(x, y);
  }

  public Brigadeiro() {
    setValues(int(random(100, 670)), -50);
  }

  void setValues(int x, int y) {
    this.setSelf(new PVector(x, y));
    
    this.setSpriteImage(brigadeiro);
    this.setSpriteInterval(75);
    this.setSpriteWidth(32);
    this.setSpriteHeight(31);
    this.setMotionY(1);

    this.setAmountHeal(3);
    this.setAmountRecovered(0);
  }

  void display() {
    image (foodShadow, getX(), getY() + 20);

    super.display();
  }
}