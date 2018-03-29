boolean hasClickedOnce;

public abstract class Button {
  private PImage buttonPlain;

  private PVector button = new PVector();

  private int firstXBoundary;
  private int secondXBoundary;
  private int firstYBoundary;
  private int secondYBoundary;

  public PImage getButtonPlain() {
    return buttonPlain;
  }
  protected void setButtonPlain(PImage buttonPlain) {
    this.buttonPlain = buttonPlain;
  }

  public PVector getButton() {
    return button;
  }
  protected void setButton(int x, int y) { 
    this.button.x = x;
    this.button.y = y;
  }

  public int getFirstXBoundary() {
    return firstXBoundary;
  }
  protected void setFirstXBoundary(int firstXBoundary) {
    this.firstXBoundary = firstXBoundary;
  }

  public int getSecondXBoundary() {
    return secondXBoundary;
  }
  protected void setSecondXBoundary(int secondXBoundary) {
    this.secondXBoundary = secondXBoundary;
  }

  public int getFirstYBoundary() {
    return firstYBoundary;
  }
  protected void setFirstYBoundary(int firstYBoundary) {
    this.firstYBoundary = firstYBoundary;
  }

  public int getSecondYBoundary() {
    return secondYBoundary;
  }
  protected void setSecondYBoundary(int secondYBoundary) {
    this.secondYBoundary = secondYBoundary;
  }

  abstract void display();

  abstract void setState();

  boolean isMouseOver() {
    if (mouseX > firstXBoundary && mouseX < secondXBoundary && mouseY > firstYBoundary && mouseY < secondYBoundary) {
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

ArrayList<Button> buttons = new ArrayList<Button>();