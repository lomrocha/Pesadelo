boolean hasClickedOnce;

abstract private class Button {
  private PImage buttonPlain;

  private PVector button = new PVector();
  
  private PVector firstBoundary = new PVector();
  private PVector secondBoundary = new PVector();

  // BUTTON_PLAIN
  public PImage getButtonPlain() {
    return this.buttonPlain;
  }
  protected void setButtonPlain(PImage buttonPlain) {
    this.buttonPlain = buttonPlain;
  }

  // BUTTON
  public PVector getButton() {
    return this.button;
  }
  public void setButton(PVector button) {
    this.button = button;
  }
  
  public int getButtonX() {
    return int(this.button.x);
  }
  public void setButtonX(int x) {
    this.button.x = x;
  }

  public int getButtonY() {
    return int(this.button.y);
  }
  

  // FIRST_BOUNDARY
  public void setFirstBoundary(PVector firstBoundary){
    this.firstBoundary = firstBoundary;
  }
  
  // SECOND_BOUNDARY
  public void setSecondBoundary(PVector SecondBoundary){
    this.secondBoundary = SecondBoundary;
  }

  abstract void display();

  abstract void setState();

  boolean isMouseOver() {
    if (mouseX > firstBoundary.x && mouseX < secondBoundary.x && mouseY > firstBoundary.y && mouseY < secondBoundary.y) {
      return true;
    } 

    return false;
  }

  boolean hasClicked() {
    if (isMouseOver() && mousePressed) {
      return true;
    }

    return false;
  }
}

// -------------------------------------- AUDIO BUTTON ---------------------------------------------------

final int SOUND = 0;
final int MUSIC = 1;

private class AudioButton extends Button {
  private int index;

  private boolean isXActive;

  AudioButton(PImage buttonPlain, int x, int firstBoundaryX, int secondBoundaryX, boolean isAudioActive, int index) {
    this.setButtonPlain(buttonPlain);
    this.setButton(new PVector(x, 10));
    this.setFirstBoundary(new PVector(firstBoundaryX, 10));
    this.setSecondBoundary(new PVector(secondBoundaryX, 60));
    this.isXActive = !isAudioActive;
    this.index = index;
  }

  void display() {
    image(getButtonPlain(), getButtonX(), getButtonY());

    if (isXActive) {
      image(botaoX, getButtonX(), getButtonY());
    }
  } 

  void setBooleans(boolean setter) {
    switch(index) {
    case SOUND:
      isSoundActive = !setter;
      break;
    case MUSIC:
      isMusicActive = !setter;
      break;
    }
  }

  void setState() {
    if (hasClicked() && !hasClickedOnce) {
      if (isXActive) {
        isXActive = false;
      } else {
        isXActive = true;
      }

      setBooleans(isXActive);
      hasClickedOnce = true;
    }
  }
}

// -------------------------------------- HAND BUTTON ---------------------------------------------------

private class HandsButton extends MenuButton {

  HandsButton(PImage buttonPlain, PImage buttonOther) {
    super(buttonPlain, buttonOther, 520, 520, 573, GameState.MAIN_MENU.getValue());
    this.setButtonX(20);
    this.setFirstBoundary(new PVector(20, 520));
    this.setSecondBoundary(new PVector(125, 573));
    this.setOffset(0);
  }
}

// -------------------------------------- MENU BUTTON ---------------------------------------------------

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
