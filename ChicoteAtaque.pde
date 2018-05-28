PImage whipAttack;

private class ChicoteAtaque extends Arma {
  ChicoteAtaque() {
    this.setSelf(new PVector(playerX - 70, playerY - 140));
    
    this.setTypeOfObject(OBJECT_WITHOUT_SHADOW);

    this.setSpriteImage(whipAttack);
    this.setSpriteInterval(110);
    this.setSpriteWidth(234);
    this.setSpriteHeight(278);

    this.setDeleteWeapon(false);
    this.setDamageBoss(false);

    this.setFirstCollisionX(playerX + 86);
    this.setSecondCollisionX(playerX + 20);
    this.setFirstCollisionY(playerY);
    this.setSecondCollisionY(playerY - 140);
  }

  void update() {
    setX(playerX - 70);
    setY(playerY - 140);
  }
}
