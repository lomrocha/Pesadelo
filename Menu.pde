AudioPlayer temaMenu;

PImage backgroundMenu; 
PImage spriteBackgroundMenu;
PImage pesadeloLogo;
PImage botaoJogar;
PImage jogarMao;
PImage botaoBotoes; 
PImage botoesMao;
PImage botaoCreditos;
PImage creditosMao;
PImage creditos;
PImage botaoSom;
PImage botaoMusica;
PImage botaoX;

PImage imagemControles;

PImage maoApontandoEsquerda;
PImage maoPolegar;

int stepBackgroundMenu;
int tempoSpriteBackgroundMenu;

boolean botaoXAparecendoSom;
boolean botaoXAparecendoMusica;

void menu() {
  if (gameState == GameState.INITIALMENU.ordinal()) {
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

    if (mouseX > 300 && mouseX < 500 && mouseY > 300 && mouseY < 377) {
      image(jogarMao, 271, 300);
      if (mousePressed) {
        setup();
        gameState = GameState.FIRSTMAP.ordinal();
        telaTutorialAndandoAtiva = true;
        cenarios.add(new Cenario(0, 0));
        cenarios.add(new Cenario(-600, 0));
        generateItem(5000);
        generateFood(5000);
        //begone.play();
      }
    } else {
      image(botaoJogar, 300, 300, 200, 77);
    }

    if (mouseX > 300 && mouseX < 500 && mouseY > 400 && mouseY < 477) {
      image(botoesMao, 271, 400);
      if (mousePressed) {
        gameState = GameState.CONTROLSMENU.ordinal();
      }
    } else {
      image(botaoBotoes, 300, 400, 200, 77);
    }

    if (mouseX > 300 && mouseX < 500 && mouseY > 500 && mouseY < 577) {
      image(creditosMao, 271, 500);
      if (mousePressed) {
        gameState = GameState.CREDITSMENU.ordinal();
        timeToMoveClosingCredit = millis();
      }
    } else {
      image(botaoCreditos, 300, 500, 200, 77);
    }

    image(botaoSom, 660, 10);
    image(botaoMusica, 730, 10);

    //MOSTRA O X SOBRE OS BOTÕES DEPOIS QUE O JOGADOR CLICA SOBRE ELES.
    if (botaoXAparecendoSom) {
      image(botaoX, 660, 10);
    }
    if (botaoXAparecendoMusica) {
      image(botaoX, 730, 10);
    }
  }

  //botões.
  if (gameState == GameState.CONTROLSMENU.ordinal()) {
    background(51);

    image(imagemControles, 0, 0);
    if (millis() > tempoSpriteJLeiteMovimento + 75) { 
      spriteJLeiteMovimento = jLeiteMovimento.get(stepJLeiteMovimento, 0, 63, 126); 
      stepJLeiteMovimento = stepJLeiteMovimento % 378 + 63;
      image(spriteJLeiteMovimento, 250, 90); 
      tempoSpriteJLeiteMovimento = millis();
    } else {
      image(spriteJLeiteMovimento, 250, 90);
    }

    if (stepJLeiteMovimento == jLeiteMovimento.width) {
      stepJLeiteMovimento = 0;
    }

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

  //créditos.
  if (gameState == GameState.CREDITSMENU.ordinal()) {
    closingCredit();

    if (closingCredits.size() == 0) {
      closingCredits.add(new ClosingCredit(SECONDCLOSINGCREDITY));
      closingCredits.add(new ClosingCredit(FIRSTCLOSINGCREDITY));
    }
  }

  if (gameState == GameState.FIRSTBOSS.ordinal()) {
    if (musicasAtivas) {
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
    if (musicasAtivas) {
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
    if (musicasAtivas) {
      temaBoss.play();
    }

    background(bossSceneryImages[2]);
    padre();
    armas();
    jLeite();
    playerHitpoints();
    foodAll();
    caixaNumeroItem();
    telaGameOver();
  }
  if (gameState >= GameState.CONTROLSMENU.ordinal() && gameState <= GameState.GAMEOVER.ordinal()) {
    thumb();
  }
}

PImage telaTutorialAndando, telaTutorialPedra, telaTutorialPedraSeta, telaTutorialX;

boolean telaTutorialAndandoAtiva, weaponTutorialScreenActive;

void telaTutorialAndando() {
  image (telaTutorialAndando, 187.5, 119);

  if (millis() > tempoSpriteJLeiteMovimento + 75) { 
    spriteJLeiteMovimento = jLeiteMovimento.get(stepJLeiteMovimento, 0, 63, 126); 
    stepJLeiteMovimento = stepJLeiteMovimento % 378 + 63;
    image(spriteJLeiteMovimento, 470, 260); 
    tempoSpriteJLeiteMovimento = millis();
  } else {
    image(spriteJLeiteMovimento, 470, 260);
  }

  if (stepJLeiteMovimento == jLeiteMovimento.width) {
    stepJLeiteMovimento = 0;
  }

  image(telaTutorialX, 584, 139);
}

void weaponTutorialScreen() {
  noLoop();

  image(telaTutorialPedra, 236, 169);
  image(jLeiteItem, 258.5, 215);
  image(telaTutorialX, 514, 182);
  image(telaTutorialPedraSeta, 705, 456);

  weaponTutorialScreenActive = true;
}

PImage telaVitoria;

void telaVitoria() {
  if (gameState == GameState.WIN.ordinal()) {
    image (telaVitoria, 0, 0);
  }
}

PImage telaGameOver;

void telaGameOver() {
  if (gameState == GameState.GAMEOVER.ordinal()) {
    image(telaGameOver, 0, 0);
  }
}

void thumb() {
  if (mouseX > 20 && mouseX < 125 && mouseY > 520 && mouseY < 573) {
    image(maoPolegar, 20, 520);
    if (mousePressed) {
      gameState = GameState.INITIALMENU.ordinal();
      if (gameState == GameState.CREDITSMENU.ordinal()) {
        for (int i = closingCredits.size() - 1; i >= 0; --i) {
          closingCredits.remove(closingCredits.get(i));
        }
      }
    }
  } else {
    image(maoApontandoEsquerda, 20, 520);
  }
}

public enum GameState{FIRSTMAP, SECONDMAP, THIRDMAP, FIRSTBOSS, SECONDBOSS, THIRDBOSS, INITIALMENU, CONTROLSMENU, CREDITSMENU, WIN, GAMEOVER}