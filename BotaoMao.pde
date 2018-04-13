public class HandsButton extends MenuButton {

  HandsButton(PImage buttonPlain, PImage buttonOther) {
    super(buttonPlain, buttonOther, 520, 520, 573, GameState.MAINMENU.ordinal());
    this.setButtonX(20);
    this.setFirstBoundary(new PVector(20, 520));
    this.setSecondBoundary(new PVector(125, 573));
    this.setOffsetX(0);
  }
}