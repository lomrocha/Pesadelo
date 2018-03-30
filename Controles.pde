public class Controls {
  private TutorialSprite walking = new TutorialSprite(250, 90, 0);
  private TutorialSprite attacking = new TutorialSprite(540, 60, 1);

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