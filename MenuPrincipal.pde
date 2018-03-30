PImage backgroundMenu; 
PImage pesadeloLogo;

public class MainMenu {
  private Background background = new Background();

  private MenuButton play = new MenuButton(playButton, playHands, 300, 300, 377, GameState.FIRSTMAP.ordinal());
  private MenuButton controls = new MenuButton (controlsButton, controlsHands, 400, 400, 477, GameState.CONTROLSMENU.ordinal());
  private MenuButton credits = new MenuButton (creditsButton, creditsHands, 500, 500, 577, GameState.CREDITSMENU.ordinal());

  private AudioButton sound = new AudioButton(soundButton, 660, 660, 720, isSoundActive, SOUND);
  private AudioButton music = new AudioButton(musicButton, 730, 730, 790, isMusicActive, MUSIC);

  private Button[] buttons = new Button [5];

  MainMenu() {
    addButtons();
  }

  void addButtons() {
    buttons[0] = play;
    buttons[1] = controls;
    buttons[2] = credits;
    buttons[3] = sound;
    buttons[4] = music;
  }

  void images() {
    background.display();

    image(pesadeloLogo, 231, 40);
  }

  void buttons() {
    for (Button b : buttons) {
      b.display();

      if (b == controls) {
        timeToMoveClosingCredit = millis();
      }

      b.setState();
    }
  }
}