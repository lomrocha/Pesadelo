PImage skeletonHead;

final PVector SKELETON_HEAD_VELOCITY = new PVector(0, 12);

final int SKELETON_HEAD = 3;

private class CabecaEsqueleto extends Projectile {
  CabecaEsqueleto(int x, int y) {
    this.setSelf(new PVector(x, y));
    this.setTarget(new PVector(playerX, playerY));
    
    this.setTypeOfObject(OBJECT_WITHOUT_SHADOW);

    this.setStart(new PVector(x, y));
    this.setVelocity(SKELETON_HEAD_VELOCITY);

    this.setSpriteImage(skeletonHead);
    this.setSpriteWidth(36);
    this.setSpriteHeight(89);

    this.setDamage(2);
    this.setType(SKELETON_HEAD);
  }
}

ArrayList<CabecaEsqueleto> cabecasEsqueleto = new ArrayList<CabecaEsqueleto>();
