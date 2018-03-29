public class MenuButton extends Button {
  private PImage buttonHands;

  private int ordinal;

  MenuButton(PImage buttonPlain, PImage buttonHands, int y, int firstYBoundary, int secondYBoundary, int ordinal) {
    this.setButtonPlain(buttonPlain);
    this.buttonHands = buttonHands;
    this.setButton(271, y);
    this.setFirstXBoundary(300);
    this.setSecondXBoundary(500);
    this.setFirstYBoundary(firstYBoundary);
    this.setSecondYBoundary(secondYBoundary);
    this.ordinal = ordinal;
  }

  void display() {
    if (isMouseOver()) {
      image(buttonHands, getButton().x, getButton().y);

      return;
    }

    image(getButtonPlain(), getButton().x + 29, getButton().y, 200, 77);
  }

  void setState() {
    if (hasClicked()) {
      gameState = ordinal;
    }
  }
}