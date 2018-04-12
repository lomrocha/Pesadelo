PImage whipAttack;

public class ChicoteAtaque extends Arma {
  public ChicoteAtaque() {
    setX(playerX - 70);
    setY(playerY - 140);

    setSpriteImage(whipAttack);
    setSpriteInterval(110);
    setSpriteWidth(234);
    setSpriteHeight(278);

    setDeleteWeapon(false);
    setDamageBoss(false);

    setFirstCollisionX(playerX + 86);
    setSecondCollisionX(playerX + 20);
    setFirstCollisionY(playerY);
    setSecondCollisionY(playerY - 140);
  }

  void update() {
    setX(playerX - 70);
    setY(playerY - 140);
  }
}