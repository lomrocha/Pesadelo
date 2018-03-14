PImage shovelAttack;

public class PaAtaque extends Arma {
  public PaAtaque() {
    setX(jLeiteX - 70);
    setY(jLeiteY - 44);

    setSpriteImage(shovelAttack);
    setSpriteInterval(90);
    setSpriteWidth(234);
    setSpriteHeight(173);

    setDeleteObject(false);
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

boolean umaPa;

void paAtaque() {
  if (jLeiteUsoItem) {
    if (armas.size() == 0 && item == SHOVEL && weaponTotal > 0 && !umaPa) {
      armas.add(new PaAtaque());
      weaponTotal--;
      umaPa = true;
    }
  }
}