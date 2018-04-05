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

void menu() {
  winLose();
  if (gameState == GameState.MAINMENU.ordinal()) {
    if (mm == null) {
      mm = new MainMenu();
    } else {
      mm.images();
      mm.buttons();
    }
  }

  // Botões.
  if (gameState == GameState.CONTROLSMENU.ordinal()) {
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
  if (gameState == GameState.CREDITSMENU.ordinal()) {
    if (cre == null) {
      cre = new Credits();
    } else {
      cre.credits();
      cre.button();
    }
  }

  // Bosses
  if (gameState == GameState.FIRSTBOSS.ordinal()) {
    if (isMusicActive) {
      temaBoss.play();
    }

    background(bossSceneryImages[0]);
    coveiro();
    armas();
    jLeite();
    playerHitpoints();
    foodAll();
    ib.updateItemImage();
    ib.display();
  }

  if (gameState == GameState.SECONDBOSS.ordinal()) {
    if (isMusicActive) {
      temaBoss.play();
    }
    background(bossSceneryImages[1]);
    fazendeiro();
    armas(); 
    jLeite();
    playerHitpoints();
    foodAll();
    ib.updateItemImage();
    ib.display();
  }

  if (gameState == GameState.THIRDBOSS.ordinal()) {
    if (isMusicActive) {
      temaBoss.play();
    }

    background(bossSceneryImages[2]);
    padre();
    armas();
    jLeite();
    playerHitpoints();
    foodAll();
    ib.updateItemImage();
    ib.display();
  }

  if (gameState >= GameState.WIN.ordinal() && gameState <= GameState.GAMEOVER.ordinal()) {
    menuHand();
  }
}

PImage telaTutorialAndando, telaTutorialPedra, telaTutorialPedraSeta, telaTutorialX;

boolean movementTutorialScreenActive, weaponTutorialScreenActive;

void telaTutorialAndando() {
  image (telaTutorialAndando, 187.5, 119);

  playerWalkingSprite(470, 260);

  image(telaTutorialX, 584, 139);
}

void playerWalkingSprite(int spriteX, int spriteY) {
  if (millis() > tempoSpriteJLeiteMovimento + 75) { 
    spriteJLeiteMovimento = jLeiteMovimento.get(stepJLeiteMovimento, 0, 63, 126); 
    stepJLeiteMovimento = stepJLeiteMovimento % 378 + 63; 
    tempoSpriteJLeiteMovimento = millis();
  }

  if (stepJLeiteMovimento == jLeiteMovimento.width) {
    stepJLeiteMovimento = 0;
  }

  image(spriteJLeiteMovimento, spriteX, spriteY);
}

void weaponTutorialScreen() {
  noLoop();

  image(telaTutorialPedra, 236, 169);
  image(jLeiteItem, 258.5, 215);
  image(telaTutorialX, 514, 182);
  image(telaTutorialPedraSeta, 705, 456);

  weaponTutorialScreenActive = true;
}

void menuHand() {
  if (mouseX > 20 && mouseX < 125 && mouseY > 520 && mouseY < 573) {
    image(menuThumbsUp, 20, 520);
    if (mousePressed) {
      gameState = GameState.MAINMENU.ordinal();
    }
  } else {
    image(menuPointingBack, 20, 520);
  }
}

void winLose() {
  switch (gameState) {
  case 9:
    image(telaVitoria, 0, 0);
    break;
  case 10: 
    image(telaGameOver, 0, 0);
    break;
  }
}