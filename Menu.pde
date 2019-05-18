AudioPlayer temaMenu;

PImage playButton;
PImage playHands;

PImage controlsButton; 
PImage controlsHands;

PImage creditsButton;
PImage creditsHands;

PImage creditsImage;

PImage soundButton;
PImage musicButton;
PImage botaoX;

PImage imagemControles;

PImage menuPointingBack;
PImage menuThumbsUp;

PImage telaVitoria;
PImage telaGameOver;

void menu() 
{
  winLose();
  if (gameState == GameState.MAIN_MENU.getValue()) 
  {
    if (mm == null) {
      mm = new MainMenu();
    } else {
      mm.images();
      mm.buttons();
    }
  }

  // Botões.
  if (gameState == GameState.CONTROLS_MENU.getValue()) 
  {
    if (ctrl == null) {
      ctrl = new Controls();
    } else {
      background(51);
      ctrl.images();
      ctrl.sprites();
      ctrl.button();
    }
  }

  // Créditos
  if (gameState == GameState.CREDITS_MENU.getValue()) 
  {
    if (cre == null) {
      cre = new Credits();
    } else {
      cre.credits();
      cre.button();
    }
  }

  // Bosses
  if (gameState == GameState.FIRST_BOSS.getValue()) 
  {
    if (isMusicActive) {
      temaBoss.play();
    }

    background(bossSceneryImages[0]);
    coveiro();
    weapons();
    jLeite();
    playerHitpoints();
    //ib.updateItemImage();
    //ib.display();
  }

  if (gameState == GameState.SECOND_BOSS.getValue()) 
  {
    if (isMusicActive) {
      temaBoss.play();
    }
    background(bossSceneryImages[1]);
    fazendeiro();
    weapons(); 
    jLeite();
    playerHitpoints();
    //ib.updateItemImage();
    //ib.display();
  }

  if (gameState == GameState.THIRD_BOSS.getValue()) 
  {
    if (isMusicActive) {
      temaBoss.play();
    }

    background(bossSceneryImages[2]);
    padre();
    weapons();
    jLeite();
    playerHitpoints();
    //ib.updateItemImage();
    //ib.display();
  }

  if (gameState >= GameState.WIN.getValue() && gameState <= GameState.GAMEOVER.getValue()) 
  {
    menuHand();
  }
}

PImage telaTutorialAndando, telaTutorialPedra, telaTutorialPedraSeta, telaTutorialX;

boolean movementTutorialScreenActive, weaponTutorialScreenActive;

void telaTutorialAndando() 
{
  image (telaTutorialAndando, 187.5, 119);

  playerWalkingSprite(470, 260);

  image(telaTutorialX, 584, 139);
}

void playerWalkingSprite(int spriteX, int spriteY) 
{
  if (millis() > tempoSpriteJLeiteMovimento + 75) 
  { 
    spriteJLeiteMovimento = jLeiteMovimento.get(stepJLeiteMovimento, 0, 63, 126); 
    stepJLeiteMovimento = stepJLeiteMovimento % 378 + 63; 
    tempoSpriteJLeiteMovimento = millis();
  }

  if (stepJLeiteMovimento == jLeiteMovimento.width) 
  {
    stepJLeiteMovimento = 0;
  }

  image(spriteJLeiteMovimento, spriteX, spriteY);
}

void weaponTutorialScreen() 
{
  noLoop();

  image(telaTutorialPedra, 236, 169);
  image(jLeiteItem, 258.5, 215);
  image(telaTutorialX, 514, 182);
  image(telaTutorialPedraSeta, 705, 456);

  weaponTutorialScreenActive = true;
}

void menuHand() 
{
  if (mouseX > 20 && mouseX < 125 && mouseY > 520 && mouseY < 573) {
    image(menuThumbsUp, 20, 520);
    if (mousePressed) 
    {
      gameState = GameState.MAIN_MENU.getValue();
    }
  } else 
  {
    image(menuPointingBack, 20, 520);
  }
}

void winLose() 
{
  switch (gameState) 
  {
  case 9:
    image(telaVitoria, 0, 0);
    break;
  case 10: 
    image(telaGameOver, 0, 0);
    break;
  }
}

// --------------------------------------- MAIN MENU -------------------------------------------------

PImage backgroundMenu; 
PImage pesadeloLogo;

private class MainMenu 
{
  private Background background = new Background();

  private MenuButton play = new MenuButton(playButton, playHands, 300, 300, 377, GameState.FIRST_MAP.getValue());
  private MenuButton controls = new MenuButton (controlsButton, controlsHands, 400, 400, 477, GameState.CONTROLS_MENU.getValue());
  private MenuButton credits = new MenuButton (creditsButton, creditsHands, 500, 500, 577, GameState.CREDITS_MENU.getValue());

  private AudioButton sound = new AudioButton(soundButton, 660, 660, 720, isSoundActive, SOUND);
  private AudioButton music = new AudioButton(musicButton, 730, 730, 790, isMusicActive, MUSIC);

  private Button[] buttons = new Button[5];

  MainMenu() 
  {
    addButtons();
  }

  void addButtons() 
  {
    buttons[0] = play;
    buttons[1] = controls;
    buttons[2] = credits;
    buttons[3] = sound;
    buttons[4] = music;
  }

  void images() 
  {
    background.display();

    image(pesadeloLogo, 231, 40);
  }

  void buttons() 
  {
    for (Button b : buttons) 
    {
      b.display();

      if (b == controls) 
      {
        timeToMoveClosingCredit = millis();
      }

      b.setState();
    }
  }
}

// --------------------------------------- CONTROLS MENU -------------------------------------------------

final int WALKING_SPRITE = 0;
final int ATTACKING_SPRITE = 1;

private class Controls {
  private TutorialSprite walking = new TutorialSprite(250, 90, WALKING_SPRITE);
  private TutorialSprite attacking = new TutorialSprite(540, 60, ATTACKING_SPRITE);

  private HandsButton handButton = new HandsButton(menuThumbsUp, menuPointingBack);

  void images() {
    image(imagemControles, 0, 0);
  }

  void sprites() {
    walking.display();
    attacking.display();
  }

  void button() {
    handButton.display();
    handButton.setState();
  }
}

// --------------------------------------- CREDITS MENU -------------------------------------------------

private class Credits 
{
  private ClosingCredit firstCredit = new ClosingCredit(FIRSTCLOSINGCREDITY);
  private ClosingCredit secondCredit = new ClosingCredit(SECONDCLOSINGCREDITY);

  private ClosingCredit[] credits = {firstCredit, secondCredit};

  private HandsButton handButton = new HandsButton(menuThumbsUp, menuPointingBack);

  void credits() 
  {
    for (ClosingCredit cc : credits) 
    {
      cc.updateMovement();
      cc.update();
      cc.display();
    }
  }

  void button() 
  {
    handButton.display();

    if (handButton.hasClicked()) 
    {
      firstCredit.closingCredit.y = FIRSTCLOSINGCREDITY;
      secondCredit.closingCredit.y = SECONDCLOSINGCREDITY;
    }

    handButton.setState();
  }
}

// -------------------------------------- CLOSING CREDITS ---------------------------------------------------

final int FIRSTCLOSINGCREDITY = 0;
final int SECONDCLOSINGCREDITY = 1000;
final int CLOSINGCREDITMOVEMENT = 1;

int timeToMoveClosingCredit;

private class ClosingCredit 
{
  private PVector closingCredit = new PVector();
  private int movementY;

  ClosingCredit(int y) 
  {
    this.closingCredit.x = 0;
    this.closingCredit.y = y;
  }

  void display() 
  {
    image(creditsImage, closingCredit.x, closingCredit.y);
  }

  void update() 
  {
    if (closingCredit.y + 1000 <= 0) 
    {
      closingCredit.y = 1000;
    }

    closingCredit.y -= movementY;
  }

  void updateMovement() 
  {
    movementY = (millis() > timeToMoveClosingCredit + 500) ? CLOSINGCREDITMOVEMENT : 0;
  }
}

// -------------------------------------- BACKGROUND MENU ---------------------------------------------------

private class Background extends BaseStill 
{
  Background() 
  {
    this.setSelf(new PVector(0, 0));

    this.setTypeOfObject(OBJECT_WITHOUT_SHADOW);

    this.setSpriteImage(backgroundMenu);
    this.setSpriteInterval(140);
    this.setSpriteWidth(800);
    this.setSpriteHeight(600);
  }
}

// -------------------------------------- TUTORIAL SPRITE ---------------------------------------------------

private class TutorialSprite extends BaseStill
{
  TutorialSprite(int x, int y, int index)
  {
    this.setSelf(new PVector(x, y));

    this.setTypeOfObject(OBJECT_WITHOUT_SHADOW);

    switch (index)
    {
    case WALKING_SPRITE:
      this.setSpriteImage(jLeiteMovimento);
      this.setSpriteInterval(75);
      this.setSpriteWidth(63);
      break;
    case ATTACKING_SPRITE:
      this.setSpriteImage(jLeiteItem);
      this.setSpriteInterval(150);
      this.setSpriteWidth(94);
      break;
    }
    this.setSpriteHeight(126);
  }
}
