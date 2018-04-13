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

  MenuButton(PImage buttonPlain, PImage buttonOther, int y, int firstBoundaryY, int secondBoundaryY, int ordinal) {
    this.setButtonPlain(buttonPlain);
    this.buttonOther = buttonOther;
    this.setButton(new PVector(271, y));
    this.setFirstBoundary(new PVector(300, firstBoundaryY));
    this.setSecondBoundary(new PVector(500, secondBoundaryY));
    this.ordinal = ordinal;
    this.offsetX = 29;
  }

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