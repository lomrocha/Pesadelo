public class MenuButton extends Button {
  private PImage buttonOther;

  private int offsetX;
  private int ordinal;

  public PImage getButtonOther() {
    return buttonOther;
  }
  protected void setButtonOther(PImage buttonOther) {
    this.buttonOther = buttonOther;
  }

  protected void setOrdinal(int ordinal) {
    this.ordinal = ordinal;
  }

  protected void setOffsetX(int offsetX) {
    this.offsetX = offsetX;
  }

  MenuButton(PImage buttonPlain, PImage buttonOther, int y, int firstYBoundary, int secondYBoundary, int ordinal) {
    this.setButtonPlain(buttonPlain);
    this.buttonOther = buttonOther;
    this.setButton(271, y);
    this.setFirstXBoundary(300);
    this.setSecondXBoundary(500);
    this.setFirstYBoundary(firstYBoundary);
    this.setSecondYBoundary(secondYBoundary);
    this.ordinal = ordinal;
    this.offsetX = 29;
  }

  MenuButton() {
  };

  void display() {
    if (isMouseOver()) {
      image(buttonOther, getButton().x, getButton().y);

      return;
    }

    image(getButtonPlain(), getButton().x + offsetX, getButton().y);
  }

  void setState() {
    if (hasClicked()) {
      gameState = ordinal;
    }
  }
}