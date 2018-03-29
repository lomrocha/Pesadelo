import ddf.minim.*;

Minim minim;

AudioPlayer temaBoss;
AudioPlayer temaIgreja;
AudioPlayer temaFazenda;
AudioPlayer temaCidade;

public enum GameState {
  FIRSTMAP, SECONDMAP, THIRDMAP, FIRSTBOSS, SECONDBOSS, THIRDBOSS, MAINMENU, CONTROLSMENU, CREDITSMENU, WIN, GAMEOVER
}

int gameState;
int lastState;

final int[][] enemyPositionsFirstMap = new int [7][4];
final int[][] enemyPositionsSecondMap = new int [7][4];
final int[][] enemyPositionsThirdMap  = new int [7][4];

int[] valoresXPrimeiroMapaBoss = {50, 720};
int[] valoresYPrimeiroMapaBoss = {380, 380};

int[] valoresXSegundoMapaBoss = {45, 45, 735, 735};
int[] valoresYSegundoMapaBoss = {200, 358, 200, 358};

int[] valoresXTerceiroMapaBoss = {62, 62, 710, 710};
int[] valoresYTerceiroMapaBoss = {249, 401, 249, 401};

boolean ativaBarraEspaco;

boolean isMusicActive = true;
boolean isSoundActive = true;

MainMenu mm;

void setup() {
  size(800, 600);

  minim = new Minim (this);

  temaBoss = minim.loadFile ("temaBoss.mp3");
  temaIgreja = minim.loadFile ("temaIgreja.mp3");
  temaFazenda = minim.loadFile ("temaFazenda.mp3");
  temaCidade = minim.loadFile ("temaCidade.mp3");

  for (int i = 0; i < sonsMorteJLeite.length; i = i + 1) {
    sonsMorteJLeite[i] =  minim.loadFile ("morteJLeite" + i + ".mp3");
  }

  for (int i = 0; i < sonsCoveiroIdle.length; i = i + 1) {
    sonsCoveiroIdle[i] =  minim.loadFile ("coveiroIdle" + i + ".mp3");
  }

  for (int i = 0; i < sonsCoveiroTomandoDano.length; i = i + 1) {
    sonsCoveiroTomandoDano[i] =  minim.loadFile ("coveiroDano" + i + ".mp3");
  }

  somCoveiroFenda = minim.loadFile ("coveiroFenda.mp3");

  for (int i = 0; i < sonsCoveiroEsmaga.length; i = i + 1) {
    sonsCoveiroEsmaga[i] =  minim.loadFile ("coveiroEsmaga" + i + ".mp3");
  }

  somCoveiroMorreu = minim.loadFile ("coveiroMorreu.mp3");

  for (int i = 0; i < sonsFazendeiroIdle.length; i = i + 1) {
    sonsFazendeiroIdle[i] =  minim.loadFile ("fazendeiroIdle" + i + ".mp3");
  }

  for (int i = 0; i < sonsFazendeiroTomandoDano.length; i = i + 1) {
    sonsFazendeiroTomandoDano[i] =  minim.loadFile ("fazendeiroDano" + i + ".mp3");
  }

  for (int i = 0; i < sonsFazendeiroSoltandoMimosa.length; i = i + 1) {
    sonsFazendeiroSoltandoMimosa[i] =  minim.loadFile ("fazendeiroMimosa" + i + ".mp3");
  }

  for (int i = 0; i < sonsMimosaHit.length; i = i + 1) {
    sonsMimosaHit[i] =  minim.loadFile ("fazendeiroMimosaHit" + i + ".mp3");
  }

  somMimosaErra =  minim.loadFile ("fazendeiroMimosaErra.mp3");

  somSoltandoPneu = minim.loadFile ("fazendeiroSoltandoPneu.mp3");

  somAcertouPneuJLeite = minim.loadFile ("fazendeiroAcertouPneuJLeite.mp3");

  somAcertouPneuFazendeiro = minim.loadFile ("fazendeiroAcertouPneuFazendeiro.mp3");

  somFazendeiroMorreu = minim.loadFile ("fazendeiroMorreu.mp3");


  for (int i = 0; i < sonsPadreIdle.length; i = i + 1) {
    sonsPadreIdle[i] =  minim.loadFile ("padreIdle" + i + ".mp3");
  }

  for (int i = 0; i < sonsPadreRaivaIdle.length; i = i + 1) {
    sonsPadreRaivaIdle[i] =  minim.loadFile ("padreRaivaIdle" + i + ".mp3");
  }

  for (int i = 0; i < sonsPadreCaveira.length; i = i + 1) {
    sonsPadreCaveira[i] =  minim.loadFile ("padreCaveira" + i + ".mp3");
  }

  for (int i = 0; i < sonsPadreTomandoDano.length; i = i + 1) {
    sonsPadreTomandoDano[i] =  minim.loadFile ("padreDano" + i + ".mp3");
  }

  for (int i = 0; i < sonsPadreRaivaTomandoDano.length; i = i + 1) {
    sonsPadreRaivaTomandoDano[i] =  minim.loadFile ("padreRaivaDano" + i + ".mp3");
  }

  for (int i = 0; i < sonsPadreLevantem.length; i = i + 1) {
    sonsPadreLevantem[i] =  minim.loadFile ("padreLevantem" + i + ".mp3");
  }

  for (int i = 0; i < sonsPadreImpossivel.length; i = i + 1) {
    sonsPadreImpossivel[i] =  minim.loadFile ("padreImpossivel" + i + ".mp3");
  }

  somPadreRaio = minim.loadFile ("padreRaio.mp3");

  somPadreMorreu = minim.loadFile ("padreMorreu.mp3");

  backgroundMenu = loadImage ("backgroundMenu.png");

  for (int i = 0; i < sceneryImages.length; i = i + 1) {
    sceneryImages[i] = loadImage("mapa" + i + ".png");
  }

  door = loadImage ("porta.png");
  fence = loadImage ("cerca.png");

  for (int i = 0; i < bossSceneryImages.length; i = i + 1) {
    bossSceneryImages[i] = loadImage("mapaBoss" + i + ".png");
  }

  pesadeloLogo = loadImage ("pesadeloLogo.png");

  playButton = loadImage ("jogar.png");
  controlsButton = loadImage ("botoes.png");
  creditsButton = loadImage ("creditos.png");
  playHands = loadImage ("jogarMao.png");
  controlsHands = loadImage ("botoesMao.png");
  creditsHands = loadImage ("creditosMao.png");

  soundButton = loadImage ("botaoSom.png");
  musicButton = loadImage ("botaoMusica.png");
  botaoX = loadImage ("botaoX.png");

  imagemControles = loadImage ("controles.png");

  creditos = loadImage ("creditosJogo.png");

  telaTutorialAndando = loadImage ("telaTutorialAndando.png");
  telaTutorialPedra = loadImage ("telaTutorialPedra.png");
  telaTutorialPedraSeta = loadImage ("telaTutorialPedraSeta.png");
  telaTutorialX = loadImage ("telaTutorialX.png");

  menuPointingBack = loadImage ("maoApontandoEsquerda.png");
  menuThumbsUp = loadImage ("maoPolegar.png");

  telaGameOver = loadImage ("telaGameOver.png");
  telaVitoria = loadImage ("telaVitoria.png");

  coxinha = loadImage ("coxinha.png");
  brigadeiro = loadImage ("brigadeiro.png");
  queijo = loadImage ("pdqueijo.png");
  foodShadow = loadImage ("sombraComidas.png");

  shovel = loadImage ("pa.png");
  shovelShadow = loadImage ("sombraPaChicote.png");
  shovelAttack = loadImage ("paAtaque.png");
  shovelBox = loadImage ("caixaItemPa.png");

  whip = loadImage ("chicote.png");
  whipShadow = loadImage ("sombraPaChicote.png");
  whipAttack = loadImage ("chicoteAtaque.png");
  whipBox = loadImage ("caixaItemChicote.png");

  itemBox = loadImage ("caixaNumeroItem.png");
  for (int i = 0; i < itemNumbers.length; i = i + 1) {
    itemNumbers[i] = loadImage ("numeroItem" + i + ".png");
  }

  jLeiteMovimento = loadImage ("joaoleite.png");
  jLeiteIdle = loadImage ("jLeiteIdle.png");
  jLeiteItem = loadImage("joaoleiteitem.png"); 
  jLeiteDanoMovimento = loadImage ("joaoleitedano.png");
  jLeiteDanoIdle = loadImage ("jLeiteDanoIdle.png");
  jLeiteMorte = loadImage ("jLeiteMorte.png");

  sombraJLeite = loadImage ("sombrajoaoleite.png");

  playerHitpointsLayout = loadImage ("vidaJLeiteLayout.png");
  playerHitpointsLayoutBackground = loadImage ("vidaJLeiteLayoutBackground.png");
  playerHitpointsBar = loadImage ("vidaJLeiteBarra.png");

  skeleton = loadImage ("esqueleto.png");
  skeletonShadow = loadImage ("sombraEsqueleto.png");
  kickingSkeleton = loadImage ("esqueletoChuteAtaque.png");
  headlessKickingSkeleton = loadImage ("esqueletoChuteMovimento.png");
  skeletonHead = loadImage ("cabecaEsqueletoChute.png");
  kickingSkeletonShadow = loadImage ("sombraEsqueletoChute.png");
  skeletonDog = loadImage ("cachorro.png");
  skeletonDogShadow = loadImage ("sombraCachorro.png");
  skeletonCrow = loadImage ("corvo.png");
  skeletonCrowShadow = loadImage ("sombraCorvo.png");
  redSkeleton = loadImage ("esqueletoRaiva.png");
  redSkeletonShadow = loadImage ("sombraEsqueletoRaiva.png");

  hitInimigos = loadImage ("hitInimigos.png");

  bossHitpointsLayoutBackground = loadImage ("vidaBossesLayoutBackground.png");
  bossHitpointsBar = loadImage ("vidaBossesBarra.png");

  for (int i = 0; i < bossBonesLayout.length; i = i + 1) {
    bossBonesLayout[i] = loadImage ("vidaBossesLayoutOsso" + i + ".png");
  }

  vidaCoveiroLayout = loadImage ("vidaCoveiroLayout.png");

  coveiroIdle = loadImage ("coveiroIdle.png");
  coveiroMovimento = loadImage ("coveiroMovimento.png");
  coveiroPa = loadImage ("coveiroPa.png");
  coveiroCarregandoLapide = loadImage ("coveiroCarregandoLapide.png");
  coveiroPaFenda = loadImage ("coveiroPaFenda.png");
  coveiroLapide = loadImage ("coveiroLapide.png");
  coveiroLapideDano = loadImage ("coveiroDanoAgua.png");
  coveiroMorte = loadImage ("coveiroMorte.png");
  sombraCoveiro = loadImage ("sombraCoveiro.png");

  fendaAbrindo = loadImage ("fendaAbrindo.png");
  fendaAberta = loadImage ("fendaAberta.png");
  fendaFechando = loadImage ("fendaFechando.png");

  for (int i = 0; i < imagensLapidesAtaque.length; i = i + 1) {
    imagensLapidesAtaque[i] = loadImage ("lapideAtaque" + i + ".png");
  }

  for (int i = 0; i < imagensLapidesCenario.length; i = i + 1) {
    imagensLapidesCenario[i] = loadImage ("lapideCenario" + i + ".png");
  }

  aguaPoca = loadImage("aguaPoca.png"); 

  for (int i = 0; i < imagensPocaCenarioCheia.length; i = i + 1) {
    imagensPocaCenarioCheia[i] = loadImage("pocaCheia" + i + ".png");
  }

  for (int i = 0; i < imagensPocaCenarioVazia.length; i = i + 1) {
    imagensPocaCenarioVazia[i] = loadImage("pocaVazia" + i + ".png");
  }

  vidaFazendeiroLayout = loadImage ("vidaFazendeiroLayout.png");

  fazendeiroIdle = loadImage ("fazendeiroIdle.png");
  fazendeiroMovimento = loadImage ("fazendeiroMovimento.png");
  fazendeiroFoice = loadImage ("fazendeiroFoice.png");
  fazendeiroMimosa = loadImage ("fazendeiroMimosa.png");
  fazendeiroIdleMimosa = loadImage ("fazendeiroIdleMimosa.png");
  fazendeiroPneu = loadImage ("fazendeiroPneu.png");
  fazendeiroPneuEscudo = loadImage ("fazendeiroPneuEscudo.png");
  fazendeiroPneuDano = loadImage ("fazendeiroPneuDano.png");
  fazendeiroIdlePneu = loadImage ("fazendeiroIdlePneu.png");
  fazendeiroMorte = loadImage ("fazendeiroMorte.png");
  sombraFazendeiro = loadImage ("sombraFazendeiro.png");

  mimosa = loadImage ("mimosa.png");
  mimosaDireita = loadImage ("mimosaDireita.png");
  mimosaEsquerda = loadImage ("mimosaEsquerda.png");

  pneuEsquerdaDesce = loadImage ("pneuEsquerdaDesce.png");
  pneuEsquerdaSobe = loadImage ("pneuEsquerdaSobe.png");
  pneuDireitaDesce = loadImage ("pneuDireitaDesce.png");
  pneuDireitaSobe = loadImage ("pneuDireitaSobe.png");

  vidaPadreLayout = loadImage ("vidaPadreLayout.png");
  vidaPadreRaivaLayout = loadImage ("vidaPadreRaivaLayout.png");

  for (int i = 0; i < vidaPadreLayoutOsso.length; i = i + 1) {
    vidaPadreLayoutOsso[i] = loadImage ("vidaPadreLayoutOsso" + i + ".png");
  }

  vidaPadreRaivaBarra = loadImage ("vidaPadreRaivaBarra.png");

  padreMovimentoIdle = loadImage ("padreMovimentoIdle.png");
  padreCruz = loadImage ("padreCruz.png");
  padreLevantem = loadImage ("padreLevantem.png");
  padreCaveiraAparecendo = loadImage ("padreCaveiraAparecendo.png");
  padreCaveira = loadImage ("padreCaveira.png");
  for (int i = 0; i < padreCaveiraDano.length; i = i + 1) {
    padreCaveiraDano[i] = loadImage ("padreCaveiraDano" + i + ".png");
  }

  padreRaivaMovimentoIdle = loadImage ("padreRaivaMovimentoIdle.png");
  padreRaivaCruz = loadImage ("padreRaivaCruz.png");
  padreRaivaLevantem = loadImage ("padreRaivaLevantem.png");
  padreRaivaCaveiraAparecendo = loadImage ("padreRaivaCaveiraAparecendo.png");
  padreRaivaCaveira = loadImage ("padreRaivaCaveira.png");
  for (int i = 0; i < padreRaivaCaveiraDano.length; i = i + 1) {
    padreRaivaCaveiraDano[i] = loadImage ("padreRaivaCaveiraDano" + i + ".png");
  }
  padreRaivaRaio = loadImage ("padreRaivaRaio.png");
  padreMorte = loadImage ("padreMorte.png");

  sombraPadre = loadImage ("sombraPadre.png");

  hitCruz = loadImage ("hitCruz.png");
  hitRaivaCruz = loadImage ("hitRaivaCruz.png");

  caveiraPadreAparecendo = loadImage ("caveiraPadreAparecendo.png");
  caveiraPadreFlutuando = loadImage ("caveiraPadreFlutuando.png");
  caveiraPadreAtaque = loadImage ("caveiraPadreAtaque.png");
  caveiraPadreRaivaAparecendo = loadImage ("caveiraPadreRaivaAparecendo.png");
  caveiraPadreRaivaFlutuando = loadImage ("caveiraPadreRaivaFlutuando.png");
  caveiraPadreRaivaAtaque = loadImage ("caveiraPadreRaivaAtaque.png");

  raioPadre = loadImage ("raioPadre.png");

  hitBosses = loadImage ("hitBosses.png");
  hitEscudo = loadImage ("hitEscudo.png");

  skeletonPositions();
  kickingSkeletonPositions();
  skeletonDogPositions();
  redSkeletonPositions();

  gameState = GameState.MAINMENU.ordinal();

  totalInimigos = 0;

  jLeiteX = 360;
  jLeiteY = 345; 

  playerHitpointsCurrent = 15;
  prayerHitpointsMaximum = 15; 
  playerHitpointsMinimum = 0;

  foodIndex = 10;

  coveiroHitpointsCurrent = 40;
  coveiroHitpointsMinimum = 0;
  coveiroBonesIndex = 3;

  fazendeiroHitpointsCurrent = 40;
  fazendeiroHitpointsMinimum = 0;
  fazendeiroBonesIndex = 3;

  vidaPadreAtual = 40;
  vidaPadreMin = 0;

  vidaPadreRaivaAtual = 40;
  vidaPadreRaivaMin = 0;

  indexVidaPadreOsso = 4;

  item = 0;

  weaponTotal = 0;

  isSoundActive = true;

  isMusicActive = true;

  jLeiteMorreu = false;
  jLeiteMorrendo = false;

  jLeiteUsoItem = false;

  hitInimigosMostrando = true;

  hasFoodIndexChanged = false;

  coveiro = new Coveiro();
  fazendeiro = new Fazendeiro();
  padre = new Padre();
  
  mm = new MainMenu();
}

void draw() {
  println(buttons.size());
  if (gameState >= GameState.FIRSTMAP.ordinal() && gameState <= GameState.THIRDMAP.ordinal()) {
    jogando();
  } else {
    menu();
  }
}

void keyPressed() {
  if (key == ESC) {
    key = 0;
    setup();
    gameState = GameState.MAINMENU.ordinal();
    if (temaBoss.isPlaying()) {
      temaBoss.pause();
    }
    if (temaIgreja.isPlaying()) {
      temaIgreja.pause();
    }
    if (temaFazenda.isPlaying()) {
      temaFazenda.pause();
    }
    if (temaCidade.isPlaying()) {
      temaCidade.pause();
    }
  }

  if (key == 'i') {
    if (!imortalidade) {
      imortalidade = true;
    } else {
      imortalidade = false;
    }
  }

  if (key == ENTER) {
    if (gameState == GameState.FIRSTMAP.ordinal()) {
      if (movementTutorialScreenActive) {
        movementTutorialScreenActive = false;
      }
    }
    if (gameState == GameState.FIRSTMAP.ordinal()) {
      if (weaponTutorialScreenActive) {
        loop();
      }
    }
  }

  if (gameState == GameState.MAINMENU.ordinal()) {
    switch(key) {
    case '1':
      gameState = GameState.FIRSTMAP.ordinal();
      break;
    case '2':
      gameState = GameState.SECONDMAP.ordinal();
      break;
    case '3':
      gameState = GameState.THIRDMAP.ordinal();
      break;
    case '4':
      gameState = GameState.FIRSTBOSS.ordinal();
      break;
    case '5':
      gameState = GameState.SECONDBOSS.ordinal();
      break;
    case '6':
      gameState = GameState.THIRDBOSS.ordinal();
      break;
    }
  }

  if (keyCode == RIGHT || key == 'd' || key == 'D') { 
    jLeiteDireita = true;
  }
  if (keyCode == LEFT || key == 'a' || key == 'A') { 
    jLeiteEsquerda = true;
  }
  if (keyCode == UP || key == 'w' || key == 'W') { 
    jLeiteCima = true;
  }
  if (keyCode == DOWN || key == 's' || key == 'S') {
    jLeiteBaixo = true;
  }

  if (gameState != GameState.GAMEOVER.ordinal()) {
    if (key == ' ' && !ativaBarraEspaco && !jLeiteUsoItemConfirma && !finalMapa) {
      if (item != 0) {
        jLeiteUsoItem = true;
        tempoItem = millis();
        tempoItemAtivo = millis();
        ativaBarraEspaco = true;
        jLeiteUsoItemConfirma = true;
        oneWeapon = false;
        if (weaponTotal == 1) {
          generateItem(15000);
        }
      }
    }
  } else {
    setup();
    gameState = lastState;
  }

  if (key == 'p' || key == 'P') {
    if (looping) {
      noLoop();
      timeRemainingFood = (timeToGenerateFood + intervalToGenerateFood) - millis();
      timeRemainingItem = (timeToGenerateItem + intervalToGenerateItem) - millis();
    } else {
      loop();
      if (comidas.size() == 0) {
        generateFood(timeRemainingFood);
      }
      if (itens.size() == 0 && item == 0) {
        generateItem(timeRemainingItem);
      }
    }
  }
}

int timeRemainingFood;
int timeRemainingItem;

void keyReleased() {
  if (keyCode == RIGHT || key == 'd' || key == 'D') {
    jLeiteDireita = false;
  }
  if (keyCode == LEFT || key == 'a' || key == 'A') {
    jLeiteEsquerda=false;
  }
  if (keyCode == UP || key == 'w' || key == 'W') {
    jLeiteCima=false;
  }
  if (keyCode == DOWN || key == 's' || key == 'S') {
    jLeiteBaixo=false;
  }

  if (key == ' ') {
    ativaBarraEspaco = false;
  }
}

void mouseClicked() {
  if (gameState == GameState.FIRSTMAP.ordinal()) {
    if (movementTutorialScreenActive) {
      if (mouseX > 584 && mouseX < 620 && mouseY > 139 && mouseY < 175) {
        movementTutorialScreenActive = false;
      }
    }

    if (weaponTutorialScreenActive) {
      if (mouseX > 514 && mouseX < 550 && mouseY > 182 && mouseY < 218) {
        loop();
      }
    }
  }
}

void mouseReleased() {
  hasClickedOnce = false;
}