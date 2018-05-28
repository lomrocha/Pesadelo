private class HandsButton extends MenuButton {

  HandsButton(PImage buttonPlain, PImage buttonOther) {
    super(buttonPlain, buttonOther, 520, 520, 573, GameState.MAIN_MENU.getValue());
    this.setButtonX(20);
    this.setFirstBoundary(new PVector(20, 520));
    this.setSecondBoundary(new PVector(125, 573));
    this.setOffset(0);
  }
}
