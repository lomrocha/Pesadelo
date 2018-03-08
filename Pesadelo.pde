import ddf.minim.*;

Minim minim;

AudioPlayer temaBoss;
AudioPlayer temaIgreja;
AudioPlayer temaFazenda;
AudioPlayer temaCidade;

PImage vidaBossesLayoutBackground, vidaBossesBarra;
PImage[] vidaBossesLayoutOsso = new PImage [4];

String estadoJogo;
String ultimoEstado;

int enemyPositionsFirstMap  [][];
int enemyPositionsSecondMap [][];
int enemyPositionsThirdMap  [][];

int[] valoresXMapaCoveiro = {50, 720};
int[] valoresYMapaCoveiro = {380, 380};

int[] valoresXMapaFazendeiro = {45, 45, 735, 735};
int[] valoresYMapaFazendeiro = {200, 358, 200, 358};

int[] valoresXMapaPadre = {62, 62, 710, 710};
int[] valoresYMapaPadre = {249, 401, 249, 401};

boolean ativaBarraEspaco;

boolean musicasAtivas = true;
boolean sonsAtivos = true;

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

  somFazendeiroVidaMetade = minim.loadFile ("fazendeiroLasquera.mp3");

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

  botaoJogar = loadImage ("jogar.png");
  botaoBotoes = loadImage ("botoes.png");
  botaoCreditos = loadImage ("creditos.png");
  jogarMao = loadImage ("jogarMao.png");
  botoesMao = loadImage ("botoesMao.png");
  creditosMao = loadImage ("creditosMao.png");

  botaoSom = loadImage ("botaoSom.png");
  botaoMusica = loadImage ("botaoMusica.png");
  botaoX = loadImage ("botaoX.png");

  imagemControles = loadImage ("controles.png");

  creditos = loadImage ("creditosJogo.png");

  telaTutorialAndando = loadImage ("telaTutorialAndando.png");
  telaTutorialPedra = loadImage ("telaTutorialPedra.png");
  telaTutorialPedraSeta = loadImage ("telaTutorialPedraSeta.png");
  telaTutorialX = loadImage ("telaTutorialX.png");

  maoApontandoEsquerda = loadImage ("maoApontandoEsquerda.png");
  maoPolegar = loadImage ("maoPolegar.png");

  telaGameOver = loadImage ("telaGameOver.png");
  telaVitoria = loadImage ("telaVitoria.png");

  coxinha = loadImage ("coxinha.png");
  brigadeiro = loadImage ("brigadeiro.png");
  queijo = loadImage ("pdqueijo.png");
  foodShadow = loadImage ("sombraComidas.png");

  shovel = loadImage ("pa.png");
  shovelShadow = loadImage ("sombraPaChicote.png");
  paAtaque = loadImage ("paAtaque.png");
  caixaItemPa = loadImage ("caixaItemPa.png");

  stone = loadImage ("pedra.png");
  stoneShadow = loadImage ("sombraPedra.png");
  pedraFogo = loadImage ("pedraFogo.png");

  whip = loadImage ("chicote.png");
  whipShadow = loadImage ("sombraPaChicote.png");
  chicoteAtaque = loadImage ("chicoteAtaque.png");
  caixaItemChicote = loadImage ("caixaItemChicote.png");

  caixaNumeroItem = loadImage ("caixaNumeroItem.png");
  for (int i = 0; i < imagensNumerosItem.length; i = i + 1) {
    imagensNumerosItem[i] = loadImage ("numeroItem" + i + ".png");
  }
  imagemNumeroItemInfinito = loadImage ("numeroItemInfinito.png");

  jLeiteMovimento = loadImage ("joaoleite.png");
  jLeiteIdle = loadImage ("jLeiteIdle.png");
  jLeiteItem = loadImage("joaoleiteitem.png"); 
  jLeiteDanoMovimento = loadImage ("joaoleitedano.png");
  jLeiteDanoIdle = loadImage ("jLeiteDanoIdle.png");
  jLeiteMorte = loadImage ("jLeiteMorte.png");

  sombraJLeite = loadImage ("sombrajoaoleite.png");

  vidaJLeiteLayout = loadImage ("vidaJLeiteLayout.png");
  vidaJLeiteLayoutBackground = loadImage ("vidaJLeiteLayoutBackground.png");
  vidaJLeiteBarra = loadImage ("vidaJLeiteBarra.png");

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

  vidaBossesLayoutBackground = loadImage ("vidaBossesLayoutBackground.png");
  vidaBossesBarra = loadImage ("vidaBossesBarra.png");

  for (int i = 0; i < vidaBossesLayoutOsso.length; i = i + 1) {
    vidaBossesLayoutOsso[i] = loadImage ("vidaBossesLayoutOsso" + i + ".png");
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

  enemyPositionsFirstMap = new int [7][4];
  enemyPositionsSecondMap  = new int [7][4];
  enemyPositionsThirdMap = new int [7][4];

  posicoesEsqueleto();
  posicoesEsqueletoChute();
  posicoesCachorro();
  posicoesEsqueletoRaiva();

  creditosY = 0;
  creditos2Y = 1000;
  movimentoCreditosY = 1;

  estadoJogo = "MenuInicial";

  totalInimigos = 0;

  jLeiteX = 360;
  jLeiteY = 345; 

  vidaJLeiteAtual = 15;
  vidaJleiteMax = 15; 
  vidaJLeiteMin = 0;

  vidaJLeiteBarraX = 115;

  foodIndex = 10;

  vidaCoveiroAtual = 40;
  vidaCoveiroMin = 0;

  vidaCoveiroBarraX = 230;

  indexVidaCoveiroOsso = 3;

  vidaFazendeiroAtual = 40;
  vidaFazendeiroMin = 0;

  vidaFazendeiroBarraX = 230;

  indexVidaFazendeiroOsso = 3;

  vidaPadreAtual = 40;
  vidaPadreMin = 0;

  vidaPadreBarraX = 230;

  vidaPadreRaivaAtual = 40;
  vidaPadreRaivaMin = 0;

  vidaPadreRaivaBarraX = 230;

  indexVidaPadreOsso = 4;

  item = 0;

  totalItem = 0;

  primeiraPedra = 0;

  botaoXAparecendoSom = false;
  sonsAtivos = true;

  botaoXAparecendoMusica = false;
  musicasAtivas = true;

  jLeiteMorreu = false;
  jLeiteMorrendo = false;

  jLeiteUsoItem = false;

  hitInimigosMostrando = true;

  hasIndexChanged = false;
  
  coveiro = new Coveiro();
  fazendeiro = new Fazendeiro();
  padre = new Padre();

  cenarios = new ArrayList<Cenario>();

  pas = new ArrayList<Pa>();
  pasAtaque = new ArrayList<PaAtaque>(); 

  pedras = new ArrayList<Pedra>();
  pedrasAtiradas = new ArrayList<PedraAtirada>();

  chicotes = new ArrayList<Chicote>();
  chicotesAtaque = new ArrayList<ChicoteAtaque>();

  coxinhas = new ArrayList<Coxinha>();
  brigadeiros = new ArrayList<Brigadeiro>();
  queijos = new ArrayList<Queijo>();

  esqueletos = new ArrayList<Esqueleto>();
  esqueletosChute = new ArrayList<EsqueletoChute>();
  cabecasEsqueleto = new ArrayList<CabecaEsqueleto>();
  cachorros = new ArrayList<Cachorro>();
  corvos = new ArrayList<Corvo>();
  esqueletosRaiva = new ArrayList<EsqueletoRaiva>();

  fendas = new ArrayList<Fenda>();
  lapidesAtaque = new ArrayList<LapideAtaque>();
  lapidesCenario = new ArrayList<LapideCenario>();
  pocasCenario = new ArrayList<PocaCenario>();
  aguasPocaCenario = new ArrayList<AguaPocaCenario>();

  mimosas = new ArrayList<Mimosa>();
  pneus = new ArrayList<Pneu>();

  caveirasPadre = new ArrayList<CaveiraPadre>();

  raios = new ArrayList<Raio>();
}

void draw() {
  if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
    jogando();
  } else {
    menu();
  }
}

void keyPressed() {
  if (key == ESC) {
    key = 0;
    setup();
    estadoJogo = "MenuInicial";
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
    if (estadoJogo == "PrimeiroMapa") {
      if (telaTutorialAndandoAtiva) {
        telaTutorialAndandoAtiva = false;
      }
    }
    if (estadoJogo == "SegundoMapa") {
      if (telaTutorialPedraAtiva) {
        loop();
        primeiraPedra = primeiraPedra + 1;
        umaPedra = false;
      }
    }
  }

  if (estadoJogo == "MenuInicial") {
    if (key == '1') {
      estadoJogo = "PrimeiroMapa";
    }
    if (key == '2') {
      estadoJogo = "SegundoMapa";
    }
    if (key == '3') {
      estadoJogo = "TerceiroMapa";
    }
    if (key == '4') {
      estadoJogo = "MapaCoveiro";
    }
    if (key == '5') {
      estadoJogo = "MapaFazendeiro";
    }
    if (key == '6') {
      estadoJogo = "MapaPadre";
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

  if (estadoJogo != "GameOver") {
    if (key == ' ' && !ativaBarraEspaco && !jLeiteUsoItemConfirma && !finalMapa) {
      if (item != 0) {
        jLeiteUsoItem = true;
        tempoItem = millis();
        tempoItemAtivo = millis();
        ativaBarraEspaco = true;
        jLeiteUsoItemConfirma = true;
        if (item == 1) {
          tempoPedraAtirada = millis();
          umaPedra = false;
        } else if (item == 2) {
          umaPa = false;
        } else if (item == 3) {
          umChicote = false;
        }
      }
    }
  } else {
    setup();
    estadoJogo = ultimoEstado;
  }

  if (key == 'p' || key == 'P') {
    if (looping) {
      noLoop();
    } else {
      loop();
    }
  }
}

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
  if (estadoJogo == "MenuInicial") {
    if (mouseX > 660 && mouseX < 720 && mouseY > 10 && mouseY < 60) {
      if (!botaoXAparecendoSom) {
        botaoXAparecendoSom = true;
        sonsAtivos = false;
      } else {
        botaoXAparecendoSom = false;
        sonsAtivos = true;
      }
    }
    if (mouseX > 730 && mouseX < 790 && mouseY > 10 && mouseY < 60) {
      if (!botaoXAparecendoMusica) {
        botaoXAparecendoMusica = true;
        musicasAtivas = false;
      } else {
        botaoXAparecendoMusica = false;
        musicasAtivas = true;
      }
    }
  }

  if (estadoJogo == "PrimeiroMapa") {
    if (telaTutorialAndandoAtiva) {
      if (mouseX > 584 && mouseX < 620 && mouseY > 139 && mouseY < 175) {
        telaTutorialAndandoAtiva = false;
      }
    }
  }  

  if (estadoJogo == "SegundoMapa") {
    if (telaTutorialPedraAtiva) {
      if (mouseX > 514 && mouseX < 550 && mouseY > 182 && mouseY < 218) {
        loop();
        primeiraPedra = primeiraPedra + 1;
        umaPedra = false;
      }
    }
  }
}