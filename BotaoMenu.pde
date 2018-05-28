private class MenuButton extends Button {
  private PImage buttonOther;

  private int offset;
  private int ordinal;

  // OFFSET
  protected void setOffset(int offset) {
    this.offset = offset;
  }

  MenuButton(PImage buttonPlain, PImage buttonOther, int y, int firstBoundaryY, int secondBoundaryY, int ordinal) {
    this.setButtonPlain(buttonPlain);
    this.buttonOther = buttonOther;
    this.setButton(new PVector(271, y));
    this.setFirstBoundary(new PVector(300, firstBoundaryY));
    this.setSecondBoundary(new PVector(500, secondBoundaryY));
    this.ordinal = ordinal;
    this.offset = 29;
  }

  void display() {
    if (isMouseOver()) {
      image(buttonOther, getButton().x, getButton().y);

      return;
    }

    image(getButtonPlain(), getButton().x + offset, getButton().y);
  }

  void setState() {
    if (hasClicked()) {
      gameState = ordinal;
    }
  }
}
