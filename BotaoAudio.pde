final int SOUND = 0;
final int MUSIC = 1;

public class AudioButton extends Button {
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