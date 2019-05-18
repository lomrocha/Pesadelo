AudioPlayer temaMenu;

PImage playButton;
PImage playHands;

PImage controlsButton; 
PImage controlsHands;

PImage creditsButton;
PImage creditsHands;

PImage creditos;

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
    ib.updateItemImage();
    ib.display();
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
    ib.updateItemImage();
    ib.display();
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
    ib.updateItemImage();
    ib.display();
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
  } 
  else 
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
