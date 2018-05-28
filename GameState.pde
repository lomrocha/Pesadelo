private enum GameState {
  FIRST_MAP(0), 
  SECOND_MAP(1), 
  THIRD_MAP(2), 
  FIRST_BOSS(3), 
  SECOND_BOSS(4), 
  THIRD_BOSS(5), 
  MAIN_MENU(6), 
  CONTROLS_MENU(7), 
  CREDITS_MENU(8), 
  WIN(9), 
  GAMEOVER(10);

  private int value;

  private GameState(final int value) {
    this.value = value;
  }

  public int getValue() {
    return this.value;
  }
}
