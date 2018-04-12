PImage shovelAttack;

public class PaAtaque extends Arma {
  public PaAtaque() {
    setX(playerX - 70);
    setY(playerY - 44);

    setSpriteImage(shovelAttack);
    setSpriteInterval(90);
    setSpriteWidth(234);
    setSpriteHeight(173);

    setDeleteWeapon(false);
    setDamageBoss(false);

    setFirstCollisionX(playerX + 160);
    setSecondCollisionX(playerX - 70);
    setFirstCollisionY(playerY + 56);
    setSecondCollisionY(playerY - 44);
  }

  void update() {
    setX(playerX - 70);
    setY(playerY - 44);
  }
}