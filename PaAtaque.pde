PImage shovelAttack;

private class PaAtaque extends Arma {
  PaAtaque() {
    this.setSelf(new PVector(playerX - 70, playerY - 44));

    this.setTypeOfObject(OBJECT_WITHOUT_SHADOW);

    this.setSpriteImage(shovelAttack);
    this.setSpriteInterval(90);
    this.setSpriteWidth(234);
    this.setSpriteHeight(173);

    this.setDeleteWeapon(false);
    this.setDamageBoss(false);

    this.setFirstCollisionX(playerX + 160);
    this.setSecondCollisionX(playerX - 70);
    this.setFirstCollisionY(playerY + 56);
    this.setSecondCollisionY(playerY - 44);
  }

  void update() {
    setX(playerX - 70);
    setY(playerY - 44);
  }
}
