public class HandsButton extends MenuButton {

  HandsButton(PImage buttonPlain, PImage buttonOther) {
    this.setButtonPlain(buttonPlain);
    this.setButtonOther(buttonOther);
    this.setButton(20, 520);
    this.setFirstXBoundary(20);
    this.setSecondXBoundary(125);
    this.setFirstYBoundary(520);
    this.setSecondYBoundary(573);
    this.setOrdinal(GameState.MAINMENU.ordinal());
    this.setOffsetX(0);
  }
}