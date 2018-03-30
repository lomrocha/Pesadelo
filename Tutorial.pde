public class TutorialSprite extends MaisGeral {
  TutorialSprite(int x, int y, int index) {
    this.setX(x);
    this.setY(y);

    switch (index) {
    case 0:
      this.setSpriteImage(jLeiteMovimento);
      this.setSpriteInterval(75);
      this.setSpriteWidth(63);
      break;
    case 1:
      this.setSpriteImage(jLeiteItem);
      this.setSpriteInterval(150);
      this.setSpriteWidth(94);
      break;
    }
    this.setSpriteHeight(126);
  }
}