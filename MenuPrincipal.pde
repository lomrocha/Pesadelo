PImage backgroundMenu; 
PImage spriteBackgroundMenu;
PImage pesadeloLogo;

public class MainMenu {
  private MenuButton play = new MenuButton(playButton, playHands, 300, 300, 377, GameState.FIRSTMAP.ordinal());
  private MenuButton controls = new MenuButton (controlsButton, controlsHands, 400, 400, 477, GameState.CONTROLSMENU.ordinal());
  private MenuButton credits = new MenuButton (creditsButton, creditsHands, 500, 500, 577, GameState.CREDITSMENU.ordinal());

  private AudioButton sound = new AudioButton(soundButton, 660, 660, 720, isSoundActive, SOUND);
  private AudioButton music = new AudioButton(musicButton, 730, 730, 790, isMusicActive, MUSIC);

  private int stepBackgroundMenu;
  private int tempoSpriteBackgroundMenu;

  void addButtons() {
    buttons.add(play);
    buttons.add(controls);
    buttons.add(credits);
    buttons.add(sound);
    buttons.add(music);
  }

  void display() {
    if (millis() > tempoSpriteBackgroundMenu + 140) {
      spriteBackgroundMenu = backgroundMenu.get(stepBackgroundMenu, 0, 800, 600);
      stepBackgroundMenu = stepBackgroundMenu % 6400 + 800;
      tempoSpriteBackgroundMenu = millis();
    }
    
    if (stepBackgroundMenu == backgroundMenu.width) {
      stepBackgroundMenu = 0;
    }

    background(spriteBackgroundMenu);
    image(pesadeloLogo, 231, 40);

    for (Button b : buttons) {
      b.display();
    }
  }

  void update() {
    for (Button b : buttons) {
      b.setState();
    }
  }

  void destroyComponents() {
    buttons.clear();
  }
}