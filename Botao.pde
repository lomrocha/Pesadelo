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
