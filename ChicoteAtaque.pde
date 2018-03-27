PImage whipAttack;

public class ChicoteAtaque extends Arma {
  public ChicoteAtaque() {
    setX(jLeiteX - 70);
    setY(jLeiteY - 140);

    setSpriteImage(whipAttack);
    setSpriteInterval(110);
    setSpriteWidth(234);
    setSpriteHeight(278);

    setDeleteObject(false);
    setDamageBoss(false);

    setFirstCollisionX(jLeiteX + 86);
    setSecondCollisionX(jLeiteX + 20);
    setFirstCollisionY(jLeiteY);
    setSecondCollisionY(jLeiteY - 140);
  }

  void update() {
    setX(jLeiteX - 70);
    setY(jLeiteY - 140);
  }
}