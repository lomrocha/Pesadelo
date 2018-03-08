AudioPlayer temaMenu;

PImage backgroundMenu, spriteBackgroundMenu;
PImage pesadeloLogo;
PImage botaoJogar, jogarMao;
PImage botaoBotoes, botoesMao;
PImage botaoCreditos, creditosMao, creditos;
PImage botaoSom, botaoMusica;
PImage botaoX;

PImage imagemControles;

PImage maoApontandoEsquerda, maoPolegar;

int stepBackgroundMenu;
int tempoSpriteBackgroundMenu;

int creditosY, creditos2Y;
int movimentoCreditosY;

boolean botaoXAparecendoSom;
boolean botaoXAparecendoMusica;

void menu() {
  if (estadoJogo == "MenuInicial") {
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
        estadoJogo = "PrimeiroMapa";
        telaTutorialAndandoAtiva = true;
        cenarios.add(new Cenario(0, 0, 0));
        cenarios.add(new Cenario(0, -600, 0));
        //begone.play();
      }
    } else {
      image(botaoJogar, 300, 300, 200, 77);
    }

    if (mouseX > 300 && mouseX < 500 && mouseY > 400 && mouseY < 477) {
      image(botoesMao, 271, 400);
      if (mousePressed) {
        estadoJogo = "InstruçõesBotões";
      }
    } else {
      image(botaoBotoes, 300, 400, 200, 77);
    }

    if (mouseX > 300 && mouseX < 500 && mouseY > 500 && mouseY < 577) {
      image(creditosMao, 271, 500);
      if (mousePressed) {
        estadoJogo = "Créditos";
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
  if (estadoJogo == "InstruçõesBotões") {
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

    if (mouseX > 20 && mouseX < 125 && mouseY > 520 && mouseY < 573) {
      image(maoPolegar, 20, 520);
      if (mousePressed) {
        estadoJogo = "MenuInicial";
      }
    } else {
      image(maoApontandoEsquerda, 20, 520);
    }
  }

  //créditos.
  if (estadoJogo == "Créditos") {
    creditos2Y = creditos2Y - movimentoCreditosY;
    creditosY = creditosY - movimentoCreditosY;
    image(creditos, 0, creditos2Y);
    image(creditos, 0, creditosY);
    if (creditosY + 1000 <= 0) {
      creditosY = 1000;
    }
    if (creditos2Y + 1000 <= 0) {
      creditos2Y = 1000;
    }

    if (mouseX > 20 && mouseX < 125 && mouseY > 520 && mouseY < 573) {
      image(maoPolegar, 20, 520);
      if (mousePressed) {
        estadoJogo = "MenuInicial";
      }
    } else {
      image(maoApontandoEsquerda, 20, 520);
    }
  }

  if (estadoJogo == "MapaCoveiro") {
    if (musicasAtivas) {
      temaBoss.play();
    }

    background(bossSceneryImages[0]);
    coveiro();
    armas();
    jLeite();
    vida();
    foodAll();
    caixaNumeroItem();
  }

  if (estadoJogo == "MapaFazendeiro") {
    if (musicasAtivas) {
      temaBoss.play();
    }
    background(bossSceneryImages[1]);
    fazendeiro();
    armas(); 
    jLeite();
    vida();
    foodAll();
    caixaNumeroItem();
  }

  if (estadoJogo == "MapaPadre") {
    if (musicasAtivas) {
      temaBoss.play();
    }

    background(bossSceneryImages[2]);
    padre();
    armas();
    jLeite();
    vida();
    foodAll();
    caixaNumeroItem();
    telaGameOver();
  }
}

PImage telaTutorialAndando, telaTutorialPedra, telaTutorialPedraSeta, telaTutorialX;

boolean telaTutorialAndandoAtiva, telaTutorialPedraAtiva;

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

void telaTutorialPedra() {
  noLoop();

  image(telaTutorialPedra, 236, 169);
  image(jLeiteItem, 258.5, 215);
  image(telaTutorialX, 514, 182);
  image(telaTutorialPedraSeta, 705, 456);

  telaTutorialPedraAtiva = true;
}

PImage telaVitoria;

void telaVitoria() {
  if (estadoJogo == "Vitoria") {
    image (telaVitoria, 0, 0);

    if (mouseX > 20 && mouseX < 125 && mouseY > 520 && mouseY < 573) {
      image(maoPolegar, 20, 520);
      if (mousePressed) {
        estadoJogo = "MenuInicial";
      }
    } else {
      image(maoApontandoEsquerda, 20, 520);
    }
  }
}

PImage telaGameOver;

void telaGameOver() {
  if (estadoJogo == "GameOver") {
    image(telaGameOver, 0, 0);

    if (mouseX > 20 && mouseX < 125 && mouseY > 520 && mouseY < 573) {
      image(maoPolegar, 20, 520);
      if (mousePressed) {
        estadoJogo = "MenuInicial";
      }
    } else {
      image(maoApontandoEsquerda, 20, 520);
    }
  }
}