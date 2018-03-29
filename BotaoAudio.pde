final int SOUND = 0;
final int MUSIC = 1;

public class AudioButton extends Button {
  private int index;

  private boolean isXActive;

  AudioButton(PImage buttonPlain, int x, int firstXBoundary, int secondXBoundary, boolean isAudioActive, int index) {
    this.setButtonPlain(buttonPlain);
    this.setButton(x, 10);
    this.setFirstXBoundary(firstXBoundary);
    this.setSecondXBoundary(secondXBoundary);
    this.setFirstYBoundary(10);
    this.setSecondYBoundary(60);
    this.isXActive = !isAudioActive;
    this.index = index;
  }

  void display() {
    image(getButtonPlain(), getButton().x, getButton().y);

    if (isXActive) {
      image(botaoX, getButton().x, getButton().y);
    }
  } 

  void setBooleans(boolean setter) {
    switch(index) {
    case 0:
      isSoundActive = !setter;
      break;
    case 1:
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