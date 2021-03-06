// ----------------------------------------- AUDIO PRE LOAD ---------------------------------------------------

void audioPreLoad() 
{
  temaBoss = minim.loadFile ("temaBoss.mp3");
  temaIgreja = minim.loadFile ("temaIgreja.mp3");
  temaFazenda = minim.loadFile ("temaFazenda.mp3");
  temaCidade = minim.loadFile ("temaCidade.mp3");

  for (int i = 0; i < sonsMorteJLeite.length; i = i + 1) 
  {
    sonsMorteJLeite[i] =  minim.loadFile ("morteJLeite" + i + ".mp3");
  }

  for (int i = 0; i < sonsCoveiroIdle.length; i = i + 1) 
  {
    sonsCoveiroIdle[i] =  minim.loadFile ("coveiroIdle" + i + ".mp3");
  }

  for (int i = 0; i < sonsCoveiroTomandoDano.length; i = i + 1) 
  {
    sonsCoveiroTomandoDano[i] =  minim.loadFile ("coveiroDano" + i + ".mp3");
  }

  somCoveiroFenda = minim.loadFile ("coveiroFenda.mp3");

  for (int i = 0; i < sonsCoveiroEsmaga.length; i = i + 1) 
  {
    sonsCoveiroEsmaga[i] =  minim.loadFile ("coveiroEsmaga" + i + ".mp3");
  }

  somCoveiroMorreu = minim.loadFile ("coveiroMorreu.mp3");

  for (int i = 0; i < sonsFazendeiroIdle.length; i = i + 1) 
  {
    sonsFazendeiroIdle[i] =  minim.loadFile ("fazendeiroIdle" + i + ".mp3");
  }

  for (int i = 0; i < sonsFazendeiroTomandoDano.length; i = i + 1) 
  {
    sonsFazendeiroTomandoDano[i] =  minim.loadFile ("fazendeiroDano" + i + ".mp3");
  }

  for (int i = 0; i < sonsFazendeiroSoltandoMimosa.length; i = i + 1) 
  {
    sonsFazendeiroSoltandoMimosa[i] =  minim.loadFile ("fazendeiroMimosa" + i + ".mp3");
  }

  for (int i = 0; i < sonsMimosaHit.length; i = i + 1) 
  {
    sonsMimosaHit[i] =  minim.loadFile ("fazendeiroMimosaHit" + i + ".mp3");
  }

  somMimosaErra =  minim.loadFile ("fazendeiroMimosaErra.mp3");

  somSoltandoPneu = minim.loadFile ("fazendeiroSoltandoPneu.mp3");

  somAcertouPneuJLeite = minim.loadFile ("fazendeiroAcertouPneuJLeite.mp3");

  somAcertouPneuFazendeiro = minim.loadFile ("fazendeiroAcertouPneuFazendeiro.mp3");

  somFazendeiroMorreu = minim.loadFile ("fazendeiroMorreu.mp3");


  for (int i = 0; i < sonsPadreIdle.length; i = i + 1) 
  {
    sonsPadreIdle[i] =  minim.loadFile ("padreIdle" + i + ".mp3");
  }

  for (int i = 0; i < sonsPadreRaivaIdle.length; i = i + 1) 
  {
    sonsPadreRaivaIdle[i] =  minim.loadFile ("padreRaivaIdle" + i + ".mp3");
  }

  for (int i = 0; i < sonsPadreCaveira.length; i = i + 1) 
  {
    sonsPadreCaveira[i] =  minim.loadFile ("padreCaveira" + i + ".mp3");
  }

  for (int i = 0; i < sonsPadreTomandoDano.length; i = i + 1) 
  {
    sonsPadreTomandoDano[i] =  minim.loadFile ("padreDano" + i + ".mp3");
  }

  for (int i = 0; i < sonsPadreRaivaTomandoDano.length; i = i + 1) 
  {
    sonsPadreRaivaTomandoDano[i] =  minim.loadFile ("padreRaivaDano" + i + ".mp3");
  }

  for (int i = 0; i < sonsPadreLevantem.length; i = i + 1) 
  {
    sonsPadreLevantem[i] =  minim.loadFile ("padreLevantem" + i + ".mp3");
  }

  for (int i = 0; i < sonsPadreImpossivel.length; i = i + 1) 
  {
    sonsPadreImpossivel[i] =  minim.loadFile ("padreImpossivel" + i + ".mp3");
  }

  somPadreRaio = minim.loadFile ("padreRaio.mp3");

  somPadreMorreu = minim.loadFile ("padreMorreu.mp3");
}

// ----------------------------------------- IMAGES PRE LOAD ---------------------------------------------------

void imagesPreLoad() 
{
  backgroundMenu = loadImage ("backgroundMenu.png");

  for (int i = 0; i < sceneryImages.length; i = i + 1) 
  {
    sceneryImages[i] = loadImage("mapa" + i + ".png");
  }

  door = loadImage ("porta.png");
  fence = loadImage ("cerca.png");

  for (int i = 0; i < bossSceneryImages.length; i = i + 1) 
  {
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

  creditsImage = loadImage ("creditsImage.png");

  telaTutorialAndando = loadImage ("telaTutorialAndando.png");
  telaTutorialPedra = loadImage ("telaTutorialPedra.png");
  telaTutorialPedraSeta = loadImage ("telaTutorialPedraSeta.png");
  telaTutorialX = loadImage ("telaTutorialX.png");

  menuPointingBack = loadImage ("maoApontandoEsquerda.png");
  menuThumbsUp = loadImage ("maoPolegar.png");

  telaGameOver = loadImage ("telaGameOver.png");
  telaVitoria = loadImage ("telaVitoria.png");

  coxinhaImage    = loadImage ("coxinhaImage.png");
  brigadeiroImage = loadImage ("brigadeiroImage.png");
  queijoImage     = loadImage ("queijoImage.png");
  foodShadow      = loadImage ("foodShadow.png");

  shovelItemImage   = loadImage ("shovelItemImage.png");
  shovelShadow      = loadImage ("shovelShadow.png");
  shovelWeaponImage = loadImage ("shovelWeaponImage.png");
  shovelBoxImage    = loadImage ("shovelBoxImage.png");

  whipItemImage   = loadImage ("whipItemImage.png");
  whipShadow      = loadImage ("whipShadow.png");
  whipWeaponImage = loadImage ("whipWeaponImage.png");
  whipBoxImage    = loadImage ("whipBoxImage.png");

  itemBoxImage = loadImage ("itemBoxImage.png");
  for (int i = 0; i < itemNumbers.length; ++i) 
  {
    itemNumbers[i] = loadImage ("itemNumber" + i + ".png");
  }

  jLeiteMovimento = loadImage ("joaoleite.png");
  jLeiteIdle = loadImage ("jLeiteIdle.png");
  jLeiteItem = loadImage("joaoleiteitem.png"); 
  jLeiteDanoMovimento = loadImage ("joaoleitedano.png");
  jLeiteDanoIdle = loadImage ("jLeiteDanoIdle.png");
  jLeiteMorte = loadImage ("jLeiteMorte.png");

  sombraJLeite = loadImage ("sombrajoaoleite.png");

  playerHPLayout = loadImage ("vidaJLeiteLayout.png");
  playerHPBackground = loadImage ("vidaJLeiteLayoutBackground.png");
  playerHPBar = loadImage ("vidaJLeiteBarra.png");

  skeletonImage  = loadImage ("skeletonImage.png");
  skeletonShadow = loadImage ("skeletonShadow.png");
  
  headlessSkeletonHeadImage     = loadImage ("headlessSkeletonHeadImage.png");
  headlessSkeletonKickingImage  = loadImage ("headlessSkeletonKickingImage.png");
  headlessSkeletonMovementImage = loadImage ("headlessSkeletonMovementImage.png");
  headlessSkeletonShadow        = loadImage ("headlessSkeletonShadow.png");
  
  dogSkeletonImage  = loadImage ("dogSkeletonImage.png");
  dogSkeletonShadow = loadImage ("dogSkeletonShadow.png");
  
  crowSkeletonImage  = loadImage ("crowSkeletonImage.png");
  crowSkeletonShadow = loadImage ("crowSkeletonShadow.png");
  
  redSkeletonImage  = loadImage ("redSkeletonImage.png");
  redSkeletonShadow = loadImage ("redSkeletonShadow.png");

  hitInimigos = loadImage ("hitInimigos.png");

  bossHPBackground = loadImage ("vidaBossesLayoutBackground.png");
  bossHPBar = loadImage ("vidaBossesBarra.png");

  for (int i = 0; i < bossBonesLayout.length; i = i + 1) 
  {
    bossBonesLayout[i] = loadImage ("vidaBossesLayoutOsso" + i + ".png");
  }

  coveiroHPLayout = loadImage ("vidaCoveiroLayout.png");

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

  for (int i = 0; i < imagensLapidesAtaque.length; i = i + 1) 
  {
    imagensLapidesAtaque[i] = loadImage ("lapideAtaque" + i + ".png");
  }

  for (int i = 0; i < imagensLapidesCenario.length; i = i + 1) 
  {
    imagensLapidesCenario[i] = loadImage ("lapideCenario" + i + ".png");
  }

  aguaPoca = loadImage("aguaPoca.png"); 

  for (int i = 0; i < imagensPocaCenarioCheia.length; i = i + 1) 
  {
    imagensPocaCenarioCheia[i] = loadImage("pocaCheia" + i + ".png");
  }

  for (int i = 0; i < imagensPocaCenarioVazia.length; i = i + 1) 
  {
    imagensPocaCenarioVazia[i] = loadImage("pocaVazia" + i + ".png");
  }

  fazendeiroHPLayout = loadImage ("vidaFazendeiroLayout.png");

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

  padreHPLayout = loadImage ("vidaPadreLayout.png");
  madPadreHPLayout = loadImage ("vidaPadreRaivaLayout.png");

  for (int i = 0; i < vidaPadreLayoutOsso.length; i = i + 1) 
  {
    vidaPadreLayoutOsso[i] = loadImage ("vidaPadreLayoutOsso" + i + ".png");
  }

  madPadreHPBar = loadImage ("vidaPadreRaivaBarra.png");

  padreMovimentoIdle = loadImage ("padreMovimentoIdle.png");
  padreCruz = loadImage ("padreCruz.png");
  padreLevantem = loadImage ("padreLevantem.png");
  padreCaveiraAparecendo = loadImage ("padreCaveiraAparecendo.png");
  padreCaveira = loadImage ("padreCaveira.png");
  for (int i = 0; i < padreCaveiraDano.length; i = i + 1) 
  {
    padreCaveiraDano[i] = loadImage ("padreCaveiraDano" + i + ".png");
  }

  padreRaivaMovimentoIdle = loadImage ("padreRaivaMovimentoIdle.png");
  padreRaivaCruz = loadImage ("padreRaivaCruz.png");
  padreRaivaLevantem = loadImage ("padreRaivaLevantem.png");
  padreRaivaCaveiraAparecendo = loadImage ("padreRaivaCaveiraAparecendo.png");
  padreRaivaCaveira = loadImage ("padreRaivaCaveira.png");
  for (int i = 0; i < padreRaivaCaveiraDano.length; i = i + 1) 
  {
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
}

// ----------------------------------------- VARIABLES PRE LOAD ---------------------------------------------------

void variablesPreLoad() 
{
 gameState = GameState.MAIN_MENU.getValue();
  playerX = 360;
  playerY = 345; 

  playerCurrentHP = 15;
  playerHPMaximum = 15; 
  playerHPMinimum = 0;

  coveiroCurrentHP = 40;
  coveiroHitpointsMinimum = 0;
  coveiroBonesIndex = 3;

  fazendeiroCurrentHP = 40;
  fazendeiroHitpointsMinimum = 0;
  fazendeiroBonesIndex = 3;

  padreCurrentHP = 40;
  vidaPadreMin = 0;

  madPadreCurrentHP = 40;
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
}

// ----------------------------------------- GAMESTATE ---------------------------------------------------

private enum GameState
{
  FIRST_MAP(0), 
    SECOND_MAP(1), 
    THIRD_MAP(2), 
    FIRST_BOSS(3), 
    SECOND_BOSS(4), 
    THIRD_BOSS(5), 
    MAIN_MENU(6), 
    CONTROLS_MENU(7), 
    CREDITS_MENU(8), 
    WIN(9), 
    GAMEOVER(10);

  private int value;

  private GameState(final int value) 
  {
    this.value = value;
  }

  public int getValue() 
  {
    return this.value;
  }
}

// ----------------------------------------- HIT ---------------------------------------------------

PImage hitInimigos, spriteHitInimigos;

int stepHitInimigos;
int tempoSpriteHitInimigos;

boolean hitInimigosMostrando;

void hitInimigos(float X, float Y) {
  if (hitInimigosMostrando) {
    if (millis() > tempoSpriteHitInimigos + 45) {
      spriteHitInimigos = hitInimigos.get(stepHitInimigos, 0, 126, 126); 
      stepHitInimigos = stepHitInimigos % 378 + 126;
      image(spriteHitInimigos, X, Y); 
      tempoSpriteHitInimigos = millis();
    } else {
      image(spriteHitInimigos, X, Y);
    }

    if (stepHitInimigos == hitInimigos.width) {
      stepHitInimigos = 0;
      hitInimigosMostrando = false;
    }
  }
}

PImage hitBosses, spriteHitBosses;

int stepHitBosses;
int tempoSpriteHitBosses;

boolean hitBossesMostrando;

void hitBosses(float X, float Y) {
  if (hitBossesMostrando) {
    if (millis() > tempoSpriteHitBosses + 45) {
      spriteHitBosses = hitBosses.get(stepHitBosses, 0, 144, 126); 
      stepHitBosses = stepHitBosses % 432 + 144;
      image(spriteHitBosses, X, Y); 
      tempoSpriteHitBosses = millis();
    } else {
      image(spriteHitBosses, X, Y);
    }

    if (stepHitBosses == hitBosses.width) {
      stepHitBosses = 0;
      hitBossesMostrando = false;
    }
  }
}

PImage hitEscudo, spriteHitEscudo;

int stepHitEscudo;
int tempoSpriteHitEscudo;

boolean hitEscudoMostrando;

void hitEscudo(float X, float Y) {
  if (hitEscudoMostrando) {
    if (millis() > tempoSpriteHitEscudo + 45) {
      spriteHitEscudo = hitEscudo.get(stepHitEscudo, 0, 144, 126); 
      stepHitEscudo = stepHitEscudo % 432 + 144;
      image(spriteHitEscudo, X, Y); 
      tempoSpriteHitEscudo = millis();
    } else {
      image(spriteHitEscudo, X, Y);
    }

    if (stepHitEscudo == hitEscudo.width) {
      stepHitEscudo = 0;
      hitEscudoMostrando = false;
    }
  }
}

PImage hitCruz;
PImage hitRaivaCruz;

PImage spriteHitCruz;

int stepHitCruz;
int tempoSpriteHitCruz;

boolean hitHitCruzMostrando;

void hitCruz(float X, float Y) {
  if (hitHitCruzMostrando) {
    if (millis() > tempoSpriteHitCruz + 145) {
      if (!padre.padreMudouForma) {
        spriteHitEscudo = hitCruz.get(stepHitCruz, 0, 126, 126);
      } else {
        spriteHitEscudo = hitRaivaCruz.get(stepHitCruz, 0, 126, 126);
      }
      stepHitCruz = stepHitCruz % 378 + 126;
      image(spriteHitEscudo, X, Y); 
      tempoSpriteHitCruz = millis();
    } else {
      image(spriteHitEscudo, X, Y);
    }

    if (stepHitCruz == hitCruz.width) {
      stepHitCruz = 0;
      hitHitCruzMostrando = false;
    }
  }
}
