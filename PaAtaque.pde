PImage shovelAttack;

public class PaAtaque extends Arma {
  public PaAtaque() {
    setX(jLeiteX - 70);
    setY(jLeiteY - 44);

    setSpriteImage(shovelAttack);
    setSpriteInterval(90);
    setSpriteWidth(234);
    setSpriteHeight(173);

    setDeleteWeapon(false);
    setDamageBoss(false);

    setFirstCollisionX(jLeiteX + 160);
    setSecondCollisionX(jLeiteX - 70);
    setFirstCollisionY(jLeiteY + 56);
    setSecondCollisionY(jLeiteY - 44);
  }

  void update() {
    setX(jLeiteX - 70);
    setY(jLeiteY - 44);
  }
}