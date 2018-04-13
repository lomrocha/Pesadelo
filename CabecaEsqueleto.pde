PImage skeletonHead;

final PVector SKELETON_HEAD_VELOCITY = new PVector(0, 12);

class CabecaEsqueleto extends Projectile {
  CabecaEsqueleto(int x, int y) {
    this.setSelf(new PVector(x, y));
    this.setTarget(new PVector(playerX, playerY));

    this.setStart(new PVector(x, y));
    this.setVelocity(SKELETON_HEAD_VELOCITY);

    this.setSpriteImage(skeletonHead);
    this.setSpriteWidth(36);
    this.setSpriteHeight(89);

    this.setDamage(2);
    this.setType(TypeOfEnemy.SKELETON_HEAD.ordinal());
  }
}

ArrayList<CabecaEsqueleto> cabecasEsqueleto = new ArrayList<CabecaEsqueleto>();