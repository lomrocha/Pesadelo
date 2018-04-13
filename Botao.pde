boolean hasClickedOnce;

abstract class Button {
  private PImage buttonPlain;

  private PVector button = new PVector();
  
  private PVector firstBoundary = new PVector();
  private PVector secondBoundary = new PVector();

  public PImage getButtonPlain() {
    return this.buttonPlain;
  }
  protected void setButtonPlain(PImage buttonPlain) {
    this.buttonPlain = buttonPlain;
  }

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
  public void setButtonY(int y) {
    this.button.y = y;
  }

  public PVector getFirstBoundary(){
    return this.firstBoundary;
  }
  public void setFirstBoundary(PVector firstBoundary){
    this.firstBoundary = firstBoundary;
  }
  
  public int getFirstBoundaryX() {
    return int(this.firstBoundary.x);
  }
  protected void setFirstBoundaryX(int x) {
    this.firstBoundary.x = x;
  }
  
  public int getFirstBoundaryY() {
    return int(this.firstBoundary.y);
  }
  protected void setFirstBoundaryY(int y) {
    this.firstBoundary.y = y;
  }

  public PVector getSecondBoundary(){
    return this.secondBoundary;
  }
  public void setSecondBoundary(PVector SecondBoundary){
    this.secondBoundary = SecondBoundary;
  }
  
  public int getSecondBoundaryX() {
    return int(this.secondBoundary.x);
  }
  protected void setSecondXBoundary(int x) {
    this.secondBoundary.x = x;
  }
  
  public int getSecondBoundaryY() {
    return int(this.secondBoundary.y);
  }
  protected void setSecondBoundaryY(int y) {
    this.secondBoundary.y = y;
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