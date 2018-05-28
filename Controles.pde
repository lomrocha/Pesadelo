final int WALKING_SPRITE = 0;
final int ATTACKING_SPRITE = 1;

private class Controls {
  private TutorialSprite walking = new TutorialSprite(250, 90, WALKING_SPRITE);
  private TutorialSprite attacking = new TutorialSprite(540, 60, ATTACKING_SPRITE);

  private HandsButton handButton = new HandsButton(menuThumbsUp, menuPointingBack);

  void images() {
    image(imagemControles, 0, 0);
  }

  void sprites() {
    walking.display();
    attacking.display();
  }

  void button() {
    handButton.display();
    handButton.setState();
  }
}
