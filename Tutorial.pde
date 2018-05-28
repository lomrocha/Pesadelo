private class TutorialSprite extends MaisGeral {
  TutorialSprite(int x, int y, int index) {
    this.setSelf(new PVector(x, y));
    
    this.setTypeOfObject(OBJECT_WITHOUT_SHADOW);

    switch (index) {
    case WALKING_SPRITE:
      this.setSpriteImage(jLeiteMovimento);
      this.setSpriteInterval(75);
      this.setSpriteWidth(63);
      break;
    case ATTACKING_SPRITE:
      this.setSpriteImage(jLeiteItem);
      this.setSpriteInterval(150);
      this.setSpriteWidth(94);
      break;
    }
    this.setSpriteHeight(126);
  }
}
