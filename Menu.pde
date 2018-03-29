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
      if (buttons.size() == 0) {
        mm.addButtons();
      }
      mm.display();
      mm.update();
    }
  } else {
    if (buttons.size() != 0) {
      mm.destroyComponents();
    }
    mm = null;
  }

  // Botões.
  if (gameState == GameState.CONTROLSMENU.ordinal()) {
    background(51);

    image(imagemControles, 0, 0);

    playerWalkingSprite(250, 90);

    if (millis() > tempoSpriteJLeiteItem + 150) { 
      spriteJLeiteItem = jLeiteItem.get(stepJLeiteItem, 0, 94, 126); 
      stepJLeiteItem = stepJLeiteItem % 282 + 94;
      image(spriteJLeiteItem, 540, 60); 
      tempoSpriteJLeiteItem = millis();
    } else {
      image(spriteJLeiteItem, 540, 60);
    }

    if (stepJLeiteItem == jLeiteItem.width) {
      stepJLeiteItem = 0;
    }
  }

  // Créditos
  if (gameState == GameState.CREDITSMENU.ordinal()) {
    closingCredit();

    if (closingCredits.size() == 0) {
      timeToMoveClosingCredit = millis();
      closingCredits.add(new ClosingCredit(SECONDCLOSINGCREDITY));
      closingCredits.add(new ClosingCredit(FIRSTCLOSINGCREDITY));
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
    caixaNumeroItem();
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
    caixaNumeroItem();
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
    caixaNumeroItem();
  }

  if (gameState >= GameState.CONTROLSMENU.ordinal() && gameState <= GameState.GAMEOVER.ordinal()) {
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
    image(spriteJLeiteMovimento, spriteX, spriteY); 
    tempoSpriteJLeiteMovimento = millis();
  } else {
    image(spriteJLeiteMovimento, spriteX, spriteY);
  }

  if (stepJLeiteMovimento == jLeiteMovimento.width) {
    stepJLeiteMovimento = 0;
  }
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
      if (gameState == GameState.CREDITSMENU.ordinal()) {
        for (int i = closingCredits.size() - 1; i >= 0; --i) {
          closingCredits.remove(closingCredits.get(i));
        }
      }

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