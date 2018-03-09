import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import ddf.minim.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Pesadelo extends PApplet {



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

public void setup() {
  

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
  shovelAttack = loadImage ("paAtaque.png");
  caixaItemPa = loadImage ("caixaItemPa.png");

  stone = loadImage ("pedra.png");
  stoneShadow = loadImage ("sombraPedra.png");
  stoneAttack = loadImage ("pedraFogo.png");

  whip = loadImage ("chicote.png");
  whipShadow = loadImage ("sombraPaChicote.png");
  whipAttack = loadImage ("chicoteAtaque.png");
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

  skeletonPositions();
  kickingSkeletonPositions();
  skeletonDogPositions();
  redSkeletonPositions();

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

public void draw() {
  if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
    jogando();
  } else {
    menu();
  }
}

public void keyPressed() {
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
      cenarios.add(new Cenario(0, 0, 2));
      cenarios.add(new Cenario(0, -600, 2));
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

public void keyReleased() {
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

public void mouseClicked() {
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
int item;

int totalItem;
int primeiraPedra;

int tempoGerarArma;
int indexArma;

int totalArmas;

boolean armaGerada;

public void armas() {
  if (totalItem == 0 && !jLeiteUsoItem && pedras.size() == 0 && pas.size() == 0 && chicotes.size() == 0) {
    item = 0;
    totalArmas = 0;
  }

  if (!telaTutorialAndandoAtiva) {
    if (!armaGerada) {
      indexArma = PApplet.parseInt(random(0, 10));
      tempoGerarArma = millis();
      armaGerada = true;
    }
  }

  pa();
  paAtaque();
  pedra();
  pedraAtirada();
  chicote();
  chicoteAtaque();
}

PImage caixaNumeroItem;
PImage[] imagensNumerosItem = new PImage [15];
PImage imagemNumeroItemInfinito;

PImage caixaItemPa;
PImage caixaItemPedra;
PImage caixaItemChicote;

public void caixaNumeroItem() {
  image(caixaNumeroItem, 705, 510);
  if (totalItem - 1 >= 0) {
    if (item == 1) {
      caixaItemPedra = stone.get(0, 0, 34, 27);
      image(caixaItemPedra, 729, 516);
    } else if (item == 2) {
      image(caixaItemPa, 705, 510);
    } else if (item == 3) {
      image(caixaItemChicote, 705, 510);
    }
    image(imagensNumerosItem[totalItem - 1], 725, 552);
  }
}

public class Arma {
  private PImage sprite;
  private PImage spriteImage;

  private int x;
  private int y;

  private int step;
  private int spriteTime;
  private int spriteInterval;

  private int spriteWidth;
  private int spriteHeight;

  private boolean deleteWeapon;
  private boolean damageBoss;

  private int firstCollisionX;
  private int secondCollisionX;
  private int firstCollisionY;
  private int secondCollisionY;

  public PImage getSprite() {
    return sprite;
  }

  public void setSprite(PImage sprite) {
    this.sprite = sprite;
  }

  public PImage getSpriteImage() {
    return spriteImage;
  }

  public void setSpriteImage(PImage enemy) {
    this.spriteImage = enemy;
  }

  public int getX() {
    return x;
  }

  public void setX(int x) {
    this.x = x;
  }

  public int getY() {
    return y;
  }

  public void setY(int y) {
    this.y = y;
  }

  public int getStep() {
    return step;
  }

  public void setStep(int step) {
    this.step = step;
  }

  public int getSpriteTime() {
    return spriteTime;
  }

  public void setSpriteTime(int spriteTime) {
    this.spriteTime = spriteTime;
  }

  public int getSpriteInterval() {
    return spriteInterval;
  }

  public void setSpriteInterval(int spriteInterval) {
    this.spriteInterval = spriteInterval;
  }

  public int getSpriteWidth() {
    return spriteWidth;
  }

  public void setSpriteWidth(int spriteWidth) {
    this.spriteWidth = spriteWidth;
  }

  public int getSpriteHeight() {
    return spriteHeight;
  }

  public void setSpriteHeight(int spriteHeight) {
    this.spriteHeight = spriteHeight;
  }

  public boolean getDeleteWeapon() {
    return deleteWeapon;
  }

  public void setDeleteWeapon(boolean deleteWeapon) {
    this.deleteWeapon = deleteWeapon;
  }

    public boolean getDamageBoss() {
    return damageBoss;
  }

  public void setDamageBoss(boolean damageBoss) {
    this.damageBoss = damageBoss;
  }

  public int getFirstCollisionX() {
    return firstCollisionX;
  }

  public void setFirstCollisionX(int firstCollisionX) {
    this.firstCollisionX = firstCollisionX;
  }

  public int getSecondCollisionX() {
    return secondCollisionX;
  }

  public void setSecondCollisionX(int secondCollisionX) {
    this.secondCollisionX = secondCollisionX;
  }

  public int getFirstCollisionY() {
    return firstCollisionY;
  }

  public void setFirstCollisionY(int firstCollisionY) {
    this.firstCollisionY = firstCollisionY;
  }

  public int getSecondCollisionY() {
    return secondCollisionY;
  }

  public void setSecondCollisionY(int secondCollisionY) {
    this.secondCollisionY = secondCollisionY;
  }

  public void display() {
    if (millis() > spriteTime + spriteInterval) {
      sprite = spriteImage.get(step, 0, spriteWidth, spriteHeight);
      step = step % spriteImage.width + spriteWidth;
      image(sprite, x, y);
      spriteTime = millis();
    } else {
      image(sprite, x, y);
    }

    if (step == spriteImage.width) {
      step = 0;
      deleteWeapon = true;
    }
  }

  public boolean hasHit(Geral g) {
    if (firstCollisionX > g.getX() && secondCollisionX < g.getX() + g.getSpriteWidth() && firstCollisionY > g.getY() && secondCollisionY < g.getY() + g.getSpriteHeight()) {
      hitInimigosMostrando = true;
      return true;
    }

    return false;
  }

  public boolean hasHitCrow(Corvo c) {
    if (firstCollisionX > c.getX() + 45 && secondCollisionX < c.getX() + 75 && firstCollisionY > c.getY() && secondCollisionY < c.getY() + 86) {
      hitInimigosMostrando = true;
      return true;
    }

    return false;
  }

  public boolean hasHitCoveiro() {
    if (firstCollisionX > coveiroX && secondCollisionX < coveiroX + 169 && firstCollisionY > coveiroY && secondCollisionY < coveiroY + 188) {
      hitBossesMostrando = true;
      hitBosses(coveiroX, coveiroY + 20);
      return true;
    } 

    return false;
  }

  public boolean hasHitFazendeiro() {
    if (firstCollisionX > fazendeiroX + 60 && secondCollisionX < fazendeiroX + 188 && firstCollisionY > fazendeiroY && secondCollisionY < fazendeiroY + 125) {
      if (!pneuRolandoPrimeiraVez) {
        hitBossesMostrando = true;
        hitBosses(fazendeiroX + 30, fazendeiroY + 20);
        return true;
      } else {
        hitEscudoMostrando = true;
        hitEscudo(fazendeiroX + 30, fazendeiroY + 20);
        return false;
      }
    } 

    return false;
  }

  public boolean hasHitPadre() {
    if (firstCollisionX > padreX + 20 && secondCollisionX < padreX + 110 && firstCollisionY > padreY && secondCollisionY < padreY + 152) {
      hitBossesMostrando = true;
      hitBosses(padreX, padreY);
      return true;
    } 

    return false;
  }
}
PImage vidaCoveiroLayout;

int vidaCoveiroAtual;
int vidaCoveiroMin;

int vidaCoveiroBarraX;

int indexVidaCoveiroOsso;

public void vidaCoveiro() {
  image(vidaBossesLayoutBackground, 0, 0);

  vidaCoveiroMin = 0;
  vidaCoveiroBarraX = 230;
  while (vidaCoveiroMin < vidaCoveiroAtual) {
    image(vidaBossesBarra, vidaCoveiroBarraX, 23);
    vidaCoveiroBarraX = vidaCoveiroBarraX + 11;
    vidaCoveiroMin = vidaCoveiroMin + 1;
  }

  image(vidaCoveiroLayout, 0, 0);
  image(vidaBossesLayoutOsso[indexVidaCoveiroOsso], 84, 54);
}

AudioPlayer[] sonsCoveiroIdle = new AudioPlayer [3];
AudioPlayer[] sonsCoveiroTomandoDano = new AudioPlayer [8];
AudioPlayer somCoveiroFenda;
AudioPlayer[] sonsCoveiroEsmaga = new AudioPlayer [3];
AudioPlayer somCoveiroMorreu;

PImage coveiroIdle;
PImage coveiroMovimento;
PImage coveiroPa;
PImage coveiroPaFenda;
PImage coveiroCarregandoLapide;
PImage coveiroLapide;
PImage coveiroLapideDano;
PImage coveiroMorte;

PImage sombraCoveiro;

int[] valoresCoveiroDestinoX = {27, 42, 57, 72, 87, 102, 117, 132, 147, 162, 177, 192, 207, 222, 237, 252, 267, 282, 297, 312, 327, 342, 357, 372, 387, 402, 417, 432, 447, 462, 477, 492, 507, 522, 537, 552, 567, 582, 597, 612};
int[] valoresCoveiroDestinoY = {75, 78, 81, 84, 87, 90, 93, 96, 99, 102, 105, 108, 111, 114, 117, 120, 123, 126, 129, 132, 135, 138, 141, 144, 147, 150, 153, 156, 159, 162, 165, 168, 171, 174, 177, 180, 183};

int coveiroX = valoresCoveiroDestinoX[PApplet.parseInt(random(0, valoresCoveiroDestinoX.length))];
int coveiroY = valoresCoveiroDestinoY[PApplet.parseInt(random(0, valoresCoveiroDestinoY.length))];

int indexRandomSomCoveiroTomandoDano;

int tempoCoveiroTomouDanoAgua, tempoCoveiroDelayTomouDanoAgua;

boolean abriuFenda, ataqueFendaAcontecendo;
boolean ataqueLapideAcontecendo, coveiroTomouDanoAgua, coveiroDelayTomouDanoAgua;

public class Coveiro {
  private PImage spriteCoveiroIdle;
  private PImage spriteCoveiroMovimento;
  private PImage spriteCoveiroPa;
  private PImage spriteCoveiroCarregandoLapide;
  private PImage spriteCoveiroLapide;
  private PImage spriteCoveiroPaFenda;
  private PImage spriteCoveiroMorte;

  private int destinoCoveiroX = valoresCoveiroDestinoX[PApplet.parseInt(random(0, valoresCoveiroDestinoX.length))];
  private int destinoCoveiroY = valoresCoveiroDestinoY[PApplet.parseInt(random(0, valoresCoveiroDestinoY.length))];

  private int stepCoveiroIdle;
  private int tempoSpriteCoveiroIdle;

  private int stepCoveiroMovimento;
  private int tempoSpriteCoveiroMovimento;

  private int stepCoveiroPa;
  private int tempoSpriteCoveiroPa;

  private int stepCoveiroPaFenda;
  private int tempoSpriteCoveiroPaFenda;

  private int stepCoveiroCarregandoLapide;
  private int tempoSpriteCoveiroCarregandoLapide;

  private int stepCoveiroLapide;
  private int tempoSpriteCoveiroLapide;

  private int stepCoveiroMorte;
  private int tempoSpriteCoveiroMorte;

  private int indexRandomSomCoveiroIdle;
  private int indexRandomSomCoveiroEsmaga;

  private int tempoNovoDestino = millis();

  private int tempoNovoAtaquePa, tempoDanoPa;

  private int tempoNovoAtaqueFenda = millis();
  private int tempoGatilhoCarregarNovoAtaqueLapide = millis(), tempoGatilhoNovoAtaqueLapide;

  private boolean somCoveiroIdleTocando;

  private boolean andando;
  private boolean ataquePa, ataquePaLigado, ataquePaAcontecendo;
  private boolean novoAtaqueFenda, gatilhoNovoAtaqueFendaAtivo, gatilhoNovoAtaqueFenda;  
  private boolean carregandoNovoAtaqueLapide, novoAtaqueLapide, gatilhoNovoAtaqueLapideAtivo, gatilhoNovoAtaqueLapide, coveiroSocoChao;  
  private boolean coveiroMorreu, coveiroMorrendo;

  public void display() {
    if (!coveiroMorreu) {
      image(sombraCoveiro, coveiroX + 2, coveiroY + 125);

      if (!andando && !ataquePa && !novoAtaqueFenda && !carregandoNovoAtaqueLapide && !novoAtaqueLapide && !coveiroTomouDanoAgua) {
        if (!somCoveiroIdleTocando) {
          if (sonsAtivos) {
            indexRandomSomCoveiroIdle = PApplet.parseInt(random(0, sonsCoveiroIdle.length));
            sonsCoveiroIdle[indexRandomSomCoveiroIdle].rewind();
            sonsCoveiroIdle[indexRandomSomCoveiroIdle].play();
            somCoveiroIdleTocando = true;
          }
        }

        if (millis() > tempoSpriteCoveiroIdle + 250) {
          spriteCoveiroIdle = coveiroIdle.get(stepCoveiroIdle, 0, 160, 188);
          stepCoveiroIdle = stepCoveiroIdle % 640 + 160;
          image(spriteCoveiroIdle, coveiroX, coveiroY);
          tempoSpriteCoveiroIdle = millis();
        } else {
          image(spriteCoveiroIdle, coveiroX, coveiroY);
        }

        if (stepCoveiroIdle == coveiroIdle.width) {
          stepCoveiroIdle = 0;
        }
      }

      if (andando && !ataquePa && !novoAtaqueFenda && !carregandoNovoAtaqueLapide && !novoAtaqueLapide && !coveiroTomouDanoAgua) {
        if (millis() > tempoSpriteCoveiroMovimento + 250) {
          spriteCoveiroMovimento = coveiroMovimento.get(stepCoveiroMovimento, 0, 160, 188);
          stepCoveiroMovimento = stepCoveiroMovimento % 640 + 160;
          image(spriteCoveiroMovimento, coveiroX, coveiroY);
          tempoSpriteCoveiroMovimento = millis();
        } else {
          image(spriteCoveiroMovimento, coveiroX, coveiroY);
        }

        if (stepCoveiroMovimento == coveiroMovimento.width) {
          stepCoveiroMovimento = 0;
        }
      }

      if (ataquePa && !novoAtaqueFenda && !carregandoNovoAtaqueLapide && !novoAtaqueLapide && !coveiroTomouDanoAgua) {
        if (millis() > tempoSpriteCoveiroPa + 155) {
          spriteCoveiroPa = coveiroPa.get(stepCoveiroPa, 0, 169, 272);
          stepCoveiroPa = stepCoveiroPa % 1014 + 169;
          image(spriteCoveiroPa, coveiroX - 5, coveiroY - 55);
          tempoSpriteCoveiroPa = millis();
        } else {
          image(spriteCoveiroPa, coveiroX - 5, coveiroY - 55);
        }

        if (stepCoveiroPa == coveiroPa.width) {
          ataquePa = false;
          ataquePaAcontecendo = false;
          stepCoveiroPa = 0;
        }
      }

      if (novoAtaqueFenda && !carregandoNovoAtaqueLapide && !novoAtaqueLapide && !coveiroTomouDanoAgua) {
        if (millis() > tempoSpriteCoveiroPaFenda + 275) {
          spriteCoveiroPaFenda = coveiroPaFenda.get(stepCoveiroPaFenda, 0, 242, 253);
          stepCoveiroPaFenda = stepCoveiroPaFenda % 1694 + 242;
          image(spriteCoveiroPaFenda, coveiroX - 59, coveiroY - 27);
          tempoSpriteCoveiroPaFenda = millis();
        } else {
          image(spriteCoveiroPaFenda, coveiroX - 59, coveiroY - 27);
        }

        if (stepCoveiroPaFenda == 1452) {
          if (sonsAtivos) {
            somCoveiroFenda.rewind();
            somCoveiroFenda.play();
          }
          abriuFenda = true;
          ataqueFendaAcontecendo = true;
        }

        if (stepCoveiroPaFenda == coveiroPaFenda.width) {
          novoAtaqueFenda = false;
          stepCoveiroPaFenda = 0;
        }
      }

      if (carregandoNovoAtaqueLapide && !novoAtaqueLapide && !coveiroTomouDanoAgua) {
        if (millis() > tempoSpriteCoveiroCarregandoLapide + 125) {
          spriteCoveiroCarregandoLapide = coveiroCarregandoLapide.get(stepCoveiroCarregandoLapide, 0, 190, 177);
          stepCoveiroCarregandoLapide = stepCoveiroCarregandoLapide % 3040 + 190;
          image(spriteCoveiroCarregandoLapide, coveiroX - 30, coveiroY);
          tempoSpriteCoveiroCarregandoLapide = millis();
        } else {
          image(spriteCoveiroCarregandoLapide, coveiroX - 30, coveiroY);
        }

        if (stepCoveiroCarregandoLapide == coveiroCarregandoLapide.width) {
          stepCoveiroCarregandoLapide = 0;
        }
      }

      if (novoAtaqueLapide && !coveiroTomouDanoAgua) {
        if (stepCoveiroLapide == 760) {
          if (sonsAtivos) {
            indexRandomSomCoveiroEsmaga = PApplet.parseInt(random(0, sonsCoveiroEsmaga.length));
            sonsCoveiroEsmaga[indexRandomSomCoveiroEsmaga].rewind();
            sonsCoveiroEsmaga[indexRandomSomCoveiroEsmaga].play();
          }
        }
        if (stepCoveiroLapide > 725) {
          coveiroSocoChao = true;
        }

        if (millis() > tempoSpriteCoveiroLapide + 125) {
          spriteCoveiroLapide = coveiroLapide.get(stepCoveiroLapide, 0, 190, 177);
          stepCoveiroLapide = stepCoveiroLapide % 1520 + 190;
          image(spriteCoveiroLapide, coveiroX - 30, coveiroY);
          tempoSpriteCoveiroLapide = millis();
        } else {
          image(spriteCoveiroLapide, coveiroX - 30, coveiroY);
        }

        if (stepCoveiroLapide == coveiroLapide.width) {
          novoAtaqueLapide = false;  
          gatilhoNovoAtaqueLapide = false;
          coveiroSocoChao = false;
          stepCoveiroLapide = 0;
        }
      }

      if (coveiroTomouDanoAgua) {
        image(coveiroLapideDano, coveiroX, coveiroY);

        if (millis() > tempoCoveiroTomouDanoAgua + 1000) {
          coveiroTomouDanoAgua = false;
        }
      }
    } else {
      if (coveiroMorrendo) {
        if (millis() > tempoSpriteCoveiroMorte + 105) {
          spriteCoveiroMorte = coveiroMorte.get(stepCoveiroMorte, 0, 180, 181);
          stepCoveiroMorte = stepCoveiroMorte % 1440 + 180;
          image(spriteCoveiroMorte, coveiroX, coveiroY);
          tempoSpriteCoveiroMorte = millis();
        } else {
          image(spriteCoveiroMorte, coveiroX, coveiroY);
        }

        if (stepCoveiroMorte == coveiroMorte.width) {
          stepCoveiroLapide = 0;
          coveiroMorrendo = false;
        }
      } else {
        spriteCoveiroMorte = coveiroMorte.get(1260, 0, 1440, 181);
        image(spriteCoveiroMorte, coveiroX, coveiroY);
      }
    }
  }

  public void update() {
    if (!novoAtaqueFenda && !coveiroDelayTomouDanoAgua && !coveiroTomouDanoAgua && !coveiroMorreu) {
      if (!carregandoNovoAtaqueLapide && !novoAtaqueLapide) {
        if (millis() > tempoNovoDestino + 5000) {
          destinoCoveiroX = valoresCoveiroDestinoX[PApplet.parseInt(random(0, valoresCoveiroDestinoX.length))];
          destinoCoveiroY = valoresCoveiroDestinoY[PApplet.parseInt(random(0, valoresCoveiroDestinoY.length))];
          tempoNovoDestino = millis();
          gatilhoNovoAtaqueFenda = false;
          gatilhoNovoAtaqueFendaAtivo = false;
          gatilhoNovoAtaqueLapideAtivo = false;
          somCoveiroIdleTocando = false;
        }

        if (coveiroX == destinoCoveiroX && coveiroY == destinoCoveiroY) {
          andando = false;
        }

        if (coveiroX < destinoCoveiroX) {
          andando = true;
          coveiroX = coveiroX + 3;
        }
        if (coveiroX > destinoCoveiroX) {
          andando = true;
          coveiroX = coveiroX - 3;
        }

        if (coveiroY < destinoCoveiroY) {
          andando = true;
          coveiroY = coveiroY + 3;
        }
        if (coveiroY > destinoCoveiroY) {      
          andando = true;
          coveiroY = coveiroY - 3;
        }
      } else {
        if (carregandoNovoAtaqueLapide) {
          if (coveiroX < jLeiteX - 38) {
            coveiroX = coveiroX + 3;
          }
          if (coveiroX > jLeiteX - 38) {
            coveiroX = coveiroX - 3;
          }
          if (coveiroY < 184) {
            coveiroY = coveiroY + 3;
          }
        }
      }
    }
  }

  public void ataquePa() {
    if (!novoAtaqueFenda && !carregandoNovoAtaqueLapide && !novoAtaqueLapide && !coveiroDelayTomouDanoAgua && !coveiroTomouDanoAgua && !coveiroMorreu) {
      if (dist(coveiroX, coveiroY, jLeiteX, jLeiteY) < 200 && !ataquePaLigado && millis() > tempoNovoAtaquePa + 1500) {
        tempoNovoAtaquePa = millis();
        tempoDanoPa = millis();
        ataquePa = true;
        ataquePaLigado = true;
        ataquePaAcontecendo = true;
      } else {
        ataquePaLigado = false;
      }
    }
  }

  public void colisaoPa() {
    if (!novoAtaqueFenda && !carregandoNovoAtaqueLapide && !novoAtaqueLapide && !coveiroDelayTomouDanoAgua && !coveiroTomouDanoAgua && !coveiroMorreu) {
      if (ataquePaAcontecendo && dist(coveiroX, coveiroY, jLeiteX, jLeiteY) < 200) {
        if (millis() > tempoDanoPa + 775) {
          if (!jLeiteImune) {
            vidaJLeiteAtual = vidaJLeiteAtual - 5;
            jLeiteImune = true;
            tempoImune = millis();
          }
        }
      }
    }
  }

  public void ataqueFenda() {
    if (!novoAtaqueFenda && !ataqueFendaAcontecendo && !novoAtaqueLapide && !coveiroDelayTomouDanoAgua && !coveiroTomouDanoAgua && !coveiroMorreu) {
      if (coveiroX == destinoCoveiroX && coveiroY == destinoCoveiroY) {
        if (!gatilhoNovoAtaqueFenda) {
          tempoNovoAtaqueFenda = millis();
          gatilhoNovoAtaqueFenda = true;
        }
        if (millis() > tempoNovoAtaqueFenda + 1500 && !gatilhoNovoAtaqueFendaAtivo) {
          novoAtaqueFenda = true;
          gatilhoNovoAtaqueFendaAtivo = true;
        }
      }
    }
  }

  public void ataqueCarregandoLapide() {
    if (!novoAtaqueFenda && !coveiroTomouDanoAgua && !coveiroMorreu) {
      if (!gatilhoNovoAtaqueLapide) {
        tempoGatilhoCarregarNovoAtaqueLapide = millis();
        gatilhoNovoAtaqueLapide = true;
      }
      if (millis() > tempoGatilhoCarregarNovoAtaqueLapide + 32000 && !gatilhoNovoAtaqueLapideAtivo) {
        carregandoNovoAtaqueLapide = true;
        ataqueLapideAcontecendo = true;
        tempoGatilhoNovoAtaqueLapide = millis();
        gatilhoNovoAtaqueLapideAtivo = true;
      }
    }
  }

  public void ataqueLapide() {
    if (millis() > tempoGatilhoNovoAtaqueLapide + 4000 && carregandoNovoAtaqueLapide) {
      carregandoNovoAtaqueLapide = false;
      novoAtaqueLapide = true;
      lapideAtaqueSumiu = false;
      ataquePaAcontecendo = false;
    }
  }

  public void coveiroMorte() {
    if ((vidaCoveiroAtual <= 0 || indexVidaCoveiroOsso == 0) && !coveiroMorreu) {
      coveiroMorreu = true;
      coveiroMorrendo = true;
      if (sonsAtivos) {
        somCoveiroMorreu.rewind();
        somCoveiroMorreu.play();
      }
      tempoBossMorreu = millis();
    }
  }
}

Coveiro coveiro;

public void coveiro() {
  lapideAtaque();
  lapideCenario();
  vidaCoveiro();
  pocaCenario();
  esqueleto();
  fenda();
  coveiro.display();
  coveiro.update();
  coveiro.ataquePa();
  coveiro.colisaoPa();
  coveiro.ataqueFenda();
  coveiro.ataqueCarregandoLapide();
  coveiro.ataqueLapide();
  coveiro.coveiroMorte();
  aguaPocaCenario();
}

PImage fendaAbrindo;
PImage fendaAberta;
PImage fendaFechando;

public class Fenda {
  private PImage spriteFendaAbrindo;
  private PImage spriteFendaFechando;

  private int fendaX = coveiroX - 50;
  private int fendaY = coveiroY + 130;

  private int stepFendaAbrindo;
  private int tempoSpriteFendaAbrindo;

  private int stepFendaFechando;
  private int tempoSpriteFendaFechando;

  private int tempoFendaAberta = millis();

  private boolean fendaAbriu;
  private boolean fendaFechou;

  private boolean causouDanoJLeite;

  public void display() {
    if (abriuFenda) {
      if (millis() > tempoSpriteFendaAbrindo + 85) {
        spriteFendaAbrindo = fendaAbrindo.get(stepFendaAbrindo, 0, 251, 612);
        stepFendaAbrindo = stepFendaAbrindo % 1715 + 251;
        image(spriteFendaAbrindo, fendaX, fendaY);
        tempoSpriteFendaAbrindo = millis();
      } else {
        image(spriteFendaAbrindo, fendaX, fendaY);
      }

      if (stepFendaAbrindo == fendaAbrindo.width) {
        abriuFenda = false;
        causouDanoJLeite = false;
        fendaAbriu = true;
        tempoFendaAberta = millis();
        stepFendaAbrindo = 0;
      } else {
        causouDanoJLeite = true;
      }
    }

    if (fendaAbriu) {
      if (millis() > tempoFendaAberta + 5000) {
        if (millis() > tempoSpriteFendaFechando + 250) {
          spriteFendaFechando = fendaFechando.get(stepFendaFechando, 0, 251, 612);
          stepFendaFechando = stepFendaFechando % 1715 + 251;
          image(spriteFendaFechando, fendaX, fendaY);
          tempoSpriteFendaFechando = millis();
        } else {
          image(spriteFendaFechando, fendaX, fendaY);
        }

        if (stepFendaFechando == fendaFechando.width) {
          fendaFechou = true;
          ataqueFendaAcontecendo = false;
          stepFendaFechando = 0;
        }
      } else {
        image(fendaAberta, fendaX, fendaY);
      }
    }
  }

  public void colisao() {
    if (jLeiteX + 63 > fendaX + 40 && jLeiteX < fendaX + 220 && jLeiteY > fendaY - 50) {
      if (causouDanoJLeite && !jLeiteImune) {
        vidaJLeiteAtual = vidaJLeiteAtual - 4;
        jLeiteImune = true;
        tempoImune = millis();
      }
      jLeiteLentidao = true;
    } else {
      jLeiteLentidao = false;
    }
  }
}

ArrayList<Fenda> fendas;

public void fenda() {
  if (fendas.size() == 0 && abriuFenda) {
    fendas.add(new Fenda());
  }

  for (int i = fendas.size() - 1; i >= 0; i = i - 1) {
    Fenda f = fendas.get(i);
    f.display();
    f.colisao();
    if (f.fendaFechou) {
      jLeiteLentidao = false;
      fendas.remove(f);
    }
  }
}

PImage[] imagensLapidesAtaque = new PImage [3];

int indexLapideAtaque;

boolean lapideAtaqueSumiu = true;

public class LapideAtaque {
  private PImage spriteLapideAtaque;

  private int lapideX = coveiroX;
  private int lapideY = jLeiteY;

  private int destinoX = coveiroX;
  private int destinoY = jLeiteY - 40;

  private int stepLapideAtaque;
  private int tempoSpriteLapideAtaque;

  private boolean lapideDeletar;

  public void display() {
    if (millis() > tempoSpriteLapideAtaque + 125) { 
      spriteLapideAtaque = imagensLapidesAtaque[indexLapideAtaque].get(stepLapideAtaque, 0, 144, 188); 
      stepLapideAtaque = stepLapideAtaque % 5760 + 144;
      image(spriteLapideAtaque, lapideX, lapideY); 
      tempoSpriteLapideAtaque = millis();
    } else {
      image(spriteLapideAtaque, lapideX, lapideY);
    }

    if (stepLapideAtaque == imagensLapidesAtaque[0].width) {
      lapideDeletar = true;
      stepLapideAtaque = 0;
    }
  }

  public void update() {
    destinoX = coveiroX;
    destinoY = jLeiteY - 40;

    lapideX = destinoX;
    lapideY = destinoY;
  }

  public boolean acertouJLeite() {
    if (millis() > coveiro.tempoGatilhoNovoAtaqueLapide + 4375) {
      if (lapideX + 94 > jLeiteX && lapideX + 50 < jLeiteX + 63 && lapideY < jLeiteY + 126 && lapideY + 188 > jLeiteY) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}

ArrayList<LapideAtaque> lapidesAtaque;

public void lapideAtaque() {
  if (ataqueLapideAcontecendo && lapidesAtaque.size() == 0) {
    indexLapideAtaque = PApplet.parseInt(random(0, 3));
    lapidesAtaque.add(new LapideAtaque());
  }

  for (int i = lapidesAtaque.size() - 1; i >= 0; i = i - 1) {
    LapideAtaque l = lapidesAtaque.get(i);
    l.display();
    l.update();
    if (l.lapideDeletar || coveiro.coveiroMorreu) {
      ataqueLapideAcontecendo = false;
      lapideAtaqueSumiu = true;
      lapidesAtaque.remove(l);
    }

    if (l.acertouJLeite() && !jLeiteImune) {
      vidaJLeiteAtual = vidaJLeiteAtual - 5;
      jLeiteImune = true;
      tempoImune = millis();
    }
  }
}

PImage[] imagensLapidesCenario = new PImage [3];

public class LapideCenario {
  private PImage spriteLapideCenario;

  private int lapideX;
  private int lapideY;

  private int stepLapideCenario;
  private int tempoSpriteLapideCenario;

  private int indexLapideCenario;

  private int tempoLapideAtiva = - 6000;

  private boolean lapideAcionada;

  public LapideCenario(int lapideX, int lapideY, int indexLapideCenario) {
    this.lapideX = lapideX;
    this.lapideY = lapideY;
    this.indexLapideCenario = indexLapideCenario;
  }

  public void display() {
    if (millis() > tempoLapideAtiva + 2500) {
      if (millis() > tempoSpriteLapideCenario + 125) { 
        if (!lapideAcionada) {
          spriteLapideCenario = imagensLapidesCenario[indexLapideCenario].get(0, 0, 145, 183);
        } else {
          spriteLapideCenario = imagensLapidesCenario[indexLapideCenario].get(stepLapideCenario, 0, 145, 183);
          stepLapideCenario = stepLapideCenario % 725 + 145;
        }
        image(spriteLapideCenario, lapideX, lapideY); 
        tempoSpriteLapideCenario = millis();
      } else {
        image(spriteLapideCenario, lapideX, lapideY);
      }

      if (stepLapideCenario == imagensLapidesCenario[0].width) {
        tempoLapideAtiva = millis();
        lapideAcionada = false;
        stepLapideCenario = 0;
      }
    }
  }

  public void acionarLapide() {
    if (indexLapideAtaque == indexLapideCenario && millis() > coveiro.tempoGatilhoNovoAtaqueLapide + 4000 && !lapideAtaqueSumiu) {
      lapideAcionada = true;
    }
  }
}

ArrayList<LapideCenario> lapidesCenario;

public void lapideCenario() {
  if (lapidesCenario.size() == 0) {
    lapidesCenario.add(new LapideCenario(24, 8, 0));
    lapidesCenario.add(new LapideCenario(324, 8, 1));
    lapidesCenario.add(new LapideCenario(624, 8, 2));
  }

  for (int i = lapidesCenario.size() - 1; i >= 0; i = i - 1) {
    LapideCenario l = lapidesCenario.get(i);
    l.display();
    if (!coveiro.coveiroMorreu) {
      l.acionarLapide();
      if (l.lapideAcionada && millis() > l.tempoLapideAtiva + 2000 && lapideAtaqueSumiu) {
        l.lapideAcionada = false;
      }
    }
  }
}

PImage aguaPoca;

public class AguaPocaCenario {
  private PImage spriteAguaPoca;

  private float aguaPocaX;
  private float aguaPocaY = coveiroY;

  private int stepAguaPoca;
  private int tempoSpriteAguaPoca;

  private boolean aguaEvaporou;

  public AguaPocaCenario(float aguaPocaX) {
    this.aguaPocaX = aguaPocaX;
  }

  public void display() {
    if (millis() > tempoSpriteAguaPoca + 75) { 
      spriteAguaPoca = aguaPoca.get(stepAguaPoca, 0, 168, 187); 
      stepAguaPoca = stepAguaPoca % 504 + 168;
      image(spriteAguaPoca, aguaPocaX, aguaPocaY); 
      tempoSpriteAguaPoca = millis();
    } else {
      image(spriteAguaPoca, aguaPocaX, aguaPocaY);
    }

    if (stepAguaPoca == aguaPoca.width) {
      aguaEvaporou = true;
      stepAguaPoca = 0;
    }
  }
}

ArrayList<AguaPocaCenario> aguasPocaCenario;

public void aguaPocaCenario() {
  for (int i = aguasPocaCenario.size() - 1; i >= 0; i = i - 1) {
    AguaPocaCenario a = aguasPocaCenario.get(i);
    a.display();
    if (a.aguaEvaporou) {
      aguasPocaCenario.remove(a);
    }
  }
}

PImage[] imagensPocaCenarioCheia = new PImage [3];
PImage[] imagensPocaCenarioVazia = new PImage [3];

public class PocaCenario {
  private float pocaCenarioX;
  private float pocaCenarioY;

  private int indexImagem;

  private int ximira;

  private boolean pocaEsvaziou;

  public PocaCenario(float pocaCenarioX, float pocaCenarioY, int indexImagem) {
    this.pocaCenarioX = pocaCenarioX;
    this.pocaCenarioY = pocaCenarioY;
    this.indexImagem = indexImagem;
  }

  public void display() {
    if (!pocaEsvaziou) {
      image(imagensPocaCenarioCheia[indexImagem], pocaCenarioX, pocaCenarioY);
      ximira = 1;
    } else {
      image(imagensPocaCenarioVazia[indexImagem], pocaCenarioX, pocaCenarioY);
      ximira = 2;
    }
  }

  public boolean coveiroAcertou() {
    if (coveiro.coveiroSocoChao) {
      if (coveiroX > pocaCenarioX && coveiroX < pocaCenarioX + 160 && coveiroY + 200 > pocaCenarioY) {
        if (!pocaEsvaziou) {
          if (indexVidaCoveiroOsso >= 1) {
            indexVidaCoveiroOsso = indexVidaCoveiroOsso - 1;
          }
        }
        coveiro.coveiroSocoChao = false;
        pocaEsvaziou = true;
        tempoCoveiroDelayTomouDanoAgua = millis();
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}

ArrayList<PocaCenario> pocasCenario;

public void pocaCenario() {
  if (pocasCenario.size() == 0) {
    pocasCenario.add(new PocaCenario(124.5f, 338, 0));
    pocasCenario.add(new PocaCenario(320.0f, 338, 1));
    pocasCenario.add(new PocaCenario(515.5f, 338, 2));
  }

  for (int i = pocasCenario.size() - 1; i >= 0; i = i - 1) {
    PocaCenario p = pocasCenario.get(i);
    p.display();
    if (p.coveiroAcertou() && p.ximira == 1) {
      aguasPocaCenario.add(new AguaPocaCenario(p.pocaCenarioX - 8));
      coveiroDelayTomouDanoAgua = true;
    }
  }

  if (coveiroDelayTomouDanoAgua && millis() > tempoCoveiroDelayTomouDanoAgua + 100) {
    coveiroTomouDanoAgua = true;
    tempoCoveiroTomouDanoAgua = millis();
    coveiroDelayTomouDanoAgua = false;
  }
}
AudioPlayer somFazendeiroVidaMetade;

PImage vidaFazendeiroLayout;

int vidaFazendeiroAtual;
int vidaFazendeiroMin;

int vidaFazendeiroBarraX;

int indexVidaFazendeiroOsso;

public void vidaFazendeiro() {
  image(vidaBossesLayoutBackground, 0, 0);

  vidaFazendeiroMin = 0;
  vidaFazendeiroBarraX = 230;
  while (vidaFazendeiroMin < vidaFazendeiroAtual) {
    image(vidaBossesBarra, vidaFazendeiroBarraX, 23);
    vidaFazendeiroBarraX = vidaFazendeiroBarraX + 11;
    vidaFazendeiroMin = vidaFazendeiroMin + 1;
  }

  image(vidaFazendeiroLayout, 0, 0);
  image(vidaBossesLayoutOsso[indexVidaFazendeiroOsso], 84, 54);

  if (vidaFazendeiroAtual == 20) {
    if (sonsAtivos) {
      somFazendeiroVidaMetade.rewind();
      somFazendeiroVidaMetade.play();
    }
  }
}

AudioPlayer[] sonsFazendeiroIdle = new AudioPlayer [3];
AudioPlayer[] sonsFazendeiroTomandoDano = new AudioPlayer [4];
AudioPlayer[] sonsFazendeiroSoltandoMimosa = new AudioPlayer [5];
AudioPlayer somSoltandoPneu;
AudioPlayer somFazendeiroMorreu;

PImage fazendeiroIdle;
PImage fazendeiroMovimento;
PImage fazendeiroFoice;
PImage fazendeiroMimosa;
PImage fazendeiroIdleMimosa;
PImage fazendeiroPneu;
PImage fazendeiroPneuEscudo;
PImage fazendeiroPneuDano;
PImage fazendeiroIdlePneu;
PImage fazendeiroMorte;

PImage sombraFazendeiro;

int[] valoresFazendeiroDestinoX = {25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 105, 110, 115, 120, 125, 130, 135, 140, 145, 150, 155, 160, 165, 170, 175, 180, 185, 190, 195, 200, 205, 210, 215, 220, 225, 230, 235, 240, 245, 250, 255, 260, 265, 270, 275, 280, 285, 290, 295, 300, 305, 310, 315, 320, 325, 330, 335, 340, 345, 350, 355, 360, 365, 370, 375, 380, 385, 390, 400, 405, 410, 415, 420, 425, 430, 435, 440, 445, 450, 455, 460, 465, 470, 475, 480, 485, 490, 500, 505, 510, 515, 520, 525, 530, 535, 540, 545, 550, 555, 560, 565, 570, 575, 580, 585}; 
int[] valoresFazendeiroDestinoY = {75, 80, 85, 90, 95, 100, 105, 110, 115, 120, 130, 135, 140, 145, 150, 155};

int fazendeiroX = valoresFazendeiroDestinoX[PApplet.parseInt(random(0, valoresFazendeiroDestinoX.length))];
int fazendeiroY = valoresFazendeiroDestinoY[PApplet.parseInt(random(0, valoresFazendeiroDestinoY.length))];

int indexRandomSomFazendeiroTomandoDano;

int tempoSpriteFazendeiroTomouDanoPneu;

int tempoBossMorreu;

boolean ataqueMimosaAcontecendo;
boolean soltouPneu, ataquePneuAcontecendo, fazendeiroTomouDanoPneu;

public class Fazendeiro {
  private PImage spriteFazendeiroIdle;
  private PImage spriteFazendeiroMovimento;
  private PImage spriteFazendeiroFoice;
  private PImage spriteFazendeiroMimosa;
  private PImage spriteFazendeiroIdleMimosa;
  private PImage spriteFazendeiroPneu;
  private PImage spriteFazendeiroPneuEscudo;
  private PImage spriteFazendeiroPneuDano;
  private PImage spriteFazendeiroIdlePneu;
  private PImage spriteFazendeiroMorte;

  private int destinoFazendeiroX = valoresFazendeiroDestinoX[PApplet.parseInt(random(0, valoresFazendeiroDestinoX.length))];
  private int destinoFazendeiroY = valoresFazendeiroDestinoY[PApplet.parseInt(random(0, valoresFazendeiroDestinoY.length))];

  private int stepFazendeiroIdle;
  private int tempoSpriteFazendeiroIdle;

  private int stepFazendeiroMovimento;
  private int tempoSpriteFazendeiroMovimento;

  private int stepFazendeiroFoice;
  private int tempoSpriteFazendeiroFoice;

  private int stepFazendeiroMimosa;
  private int tempoSpriteFazendeiroMimosa;

  private int stepFazendeiroIdleMimosa;
  private int tempoSpriteFazendeiroIdleMimosa;

  private int stepFazendeiroPneu;
  private int tempoSpriteFazendeiroPneu;

  private int stepFazendeiroPneuEscudo;
  private int tempoSpriteFazendeiroPneuEscudo;

  private int stepFazendeiroPneuDano;
  private int tempoSpriteFazendeiroPneuDano;

  private int stepFazendeiroIdlePneu;
  private int tempoSpriteFazendeiroIdlePneu;

  private int stepFazendeiroMorte;
  private int tempoSpriteFazendeiroMorte;

  private int tempoNovoDestino = millis();

  private int indexRandomSomFazendeiroIdle;
  private int indexRandomSomFazendeiroMimosa;

  private int tempoNovoAtaqueFoice, tempoDanoFoice;

  private int tempoNovoAtaqueMimosa = millis();
  private int tempoNovoAtaquePneu = millis();

  private boolean somFazendeiroIdleTocando;

  private boolean andando;
  private boolean ataqueFoice, ataqueFoiceLigado, ataqueFoiceAcontecendo;
  private boolean novoAtaqueMimosa, gatilhoNovoAtaqueMimosaAtivo, gatilhoNovoAtaqueMimosa;                                               
  private boolean novoAtaquePneu, gatilhoNovoAtaquePneuAtivo, gatilhoNovoAtaquePneu; 
  private boolean fazendeiroMorreu, fazendeiroMorrendo;

  public void display() {
    image(sombraFazendeiro, fazendeiroX + 48, fazendeiroY + 113);
    if (!fazendeiroMorreu) {
      if (!andando && !ataqueFoice && !novoAtaqueMimosa && !ataqueMimosaAcontecendo && !novoAtaquePneu && !ataquePneuAcontecendo && !fazendeiroTomouDanoPneu) {
        if (!somFazendeiroIdleTocando) {
          if (sonsAtivos) {
            indexRandomSomFazendeiroIdle = PApplet.parseInt(random(0, sonsFazendeiroIdle.length));
            sonsFazendeiroIdle[indexRandomSomFazendeiroIdle].rewind();
            sonsFazendeiroIdle[indexRandomSomFazendeiroIdle].play();
            somFazendeiroIdleTocando = true;
          }
        }

        if (millis() > tempoSpriteFazendeiroIdle + 175) {
          spriteFazendeiroIdle = fazendeiroIdle.get(stepFazendeiroIdle, 0, 188, 125);
          stepFazendeiroIdle = stepFazendeiroIdle % 752 + 188;
          image(spriteFazendeiroIdle, fazendeiroX, fazendeiroY);
          tempoSpriteFazendeiroIdle = millis();
        } else {
          image(spriteFazendeiroIdle, fazendeiroX, fazendeiroY);
        }

        if (stepFazendeiroIdle == fazendeiroIdle.width) {
          stepFazendeiroIdle = 0;
        }
      }

      if (andando && !ataqueFoice && !novoAtaqueMimosa && !ataqueMimosaAcontecendo && !novoAtaquePneu && !ataquePneuAcontecendo && !fazendeiroTomouDanoPneu) {
        if (millis() > tempoSpriteFazendeiroMovimento + 75) {
          spriteFazendeiroMovimento = fazendeiroMovimento.get(stepFazendeiroMovimento, 0, 188, 125);
          stepFazendeiroMovimento = stepFazendeiroMovimento % 752 + 188;
          image(spriteFazendeiroMovimento, fazendeiroX, fazendeiroY);
          tempoSpriteFazendeiroMovimento = millis();
        } else {
          image(spriteFazendeiroMovimento, fazendeiroX, fazendeiroY);
        }

        if (stepFazendeiroMovimento == fazendeiroMovimento.width) {
          stepFazendeiroMovimento = 0;
        }
      } 

      if (ataqueFoice && !novoAtaqueMimosa && !ataqueMimosaAcontecendo && !novoAtaquePneu && !ataquePneuAcontecendo && !fazendeiroTomouDanoPneu) {
        if (millis() > tempoSpriteFazendeiroFoice + 155) {
          spriteFazendeiroFoice = fazendeiroFoice.get(stepFazendeiroFoice, 0, 248, 192);
          stepFazendeiroFoice = stepFazendeiroFoice % 1240 + 248;
          image (spriteFazendeiroFoice, fazendeiroX - 44, fazendeiroY - 35);
          tempoSpriteFazendeiroFoice = millis();
        } else {
          image(spriteFazendeiroFoice, fazendeiroX - 44, fazendeiroY - 35);
        }

        if (stepFazendeiroFoice == fazendeiroFoice.width) {
          ataqueFoice = false;
          ataqueFoiceAcontecendo = false;
          stepFazendeiroFoice = 0;
        }
      }

      if (novoAtaqueMimosa && !ataqueMimosaAcontecendo && !novoAtaquePneu && !ataquePneuAcontecendo && !fazendeiroTomouDanoPneu) {
        if (stepFazendeiroMimosa == 0) {
          if (sonsAtivos) {
            indexRandomSomFazendeiroMimosa = PApplet.parseInt(random(0, sonsFazendeiroSoltandoMimosa.length));
            sonsFazendeiroSoltandoMimosa[indexRandomSomFazendeiroMimosa].rewind();
            sonsFazendeiroSoltandoMimosa[indexRandomSomFazendeiroMimosa].play();
          }
        }

        if (millis() > tempoSpriteFazendeiroMimosa + 75) {
          spriteFazendeiroMimosa = fazendeiroMimosa.get(stepFazendeiroMimosa, 0, 191, 131);
          stepFazendeiroMimosa = stepFazendeiroMimosa % 1910 + 191;
          image(spriteFazendeiroMimosa, fazendeiroX + 10, fazendeiroY + 5);
          tempoSpriteFazendeiroMimosa = millis();
        } else {
          image(spriteFazendeiroMimosa, fazendeiroX + 10, fazendeiroY + 5);
        }

        if (stepFazendeiroMimosa == fazendeiroMimosa.width) {
          novoAtaqueMimosa = false;
          ataqueMimosaAcontecendo = true;
          stepFazendeiroMimosa = 0;
        }
      }

      if (ataqueMimosaAcontecendo && !novoAtaquePneu && !ataquePneuAcontecendo && !fazendeiroTomouDanoPneu) {
        if (millis() > tempoSpriteFazendeiroIdleMimosa + 175) {
          spriteFazendeiroIdleMimosa = fazendeiroIdleMimosa.get(stepFazendeiroIdleMimosa, 0, 188, 125);
          stepFazendeiroIdleMimosa = stepFazendeiroIdleMimosa % 752 + 188;
          image(spriteFazendeiroIdleMimosa, fazendeiroX, fazendeiroY);
          tempoSpriteFazendeiroIdleMimosa = millis();
        } else {
          image(spriteFazendeiroIdleMimosa, fazendeiroX, fazendeiroY);
        }

        if (stepFazendeiroIdleMimosa == fazendeiroIdleMimosa.width) {
          stepFazendeiroIdleMimosa = 0;
        }
      }

      if (novoAtaquePneu && !ataquePneuAcontecendo && !ataqueMimosaAcontecendo && !fazendeiroTomouDanoPneu) {
        if (stepFazendeiroPneu == 0) {
          if (sonsAtivos) {
            somSoltandoPneu.rewind();
            somSoltandoPneu.play();
          }
        }
        if (millis() > tempoSpriteFazendeiroPneu + 175) {
          spriteFazendeiroPneu = fazendeiroPneu.get(stepFazendeiroPneu, 0, 157, 132);
          stepFazendeiroPneu = stepFazendeiroPneu % 1413 + 157;
          image(spriteFazendeiroPneu, fazendeiroX + 40, fazendeiroY);
          tempoSpriteFazendeiroPneu = millis();
        } else {
          image(spriteFazendeiroPneu, fazendeiroX + 40, fazendeiroY);
        }

        if (stepFazendeiroPneu == 1099) {
          soltouPneu = true;
          pneuRolandoPrimeiraVez = true;
        }

        if (stepFazendeiroPneu == fazendeiroPneu.width) {
          novoAtaquePneu = false;
          ataquePneuAcontecendo = true;
          gatilhoNovoAtaquePneu = false;
          stepFazendeiroPneu = 0;
        }
      }

      if (pneuRolandoPrimeiraVez && ataquePneuAcontecendo && !ataqueMimosaAcontecendo && !fazendeiroTomouDanoPneu) {
        if (millis() > tempoSpriteFazendeiroPneuEscudo + 175) {
          spriteFazendeiroPneuEscudo = fazendeiroPneuEscudo.get(stepFazendeiroPneuEscudo, 0, 188, 125);
          stepFazendeiroPneuEscudo = stepFazendeiroPneuEscudo % 752 + 188;
          image(spriteFazendeiroPneuEscudo, fazendeiroX, fazendeiroY);
          tempoSpriteFazendeiroPneuEscudo = millis();
        } else {
          image(spriteFazendeiroPneuEscudo, fazendeiroX, fazendeiroY);
        }

        if (stepFazendeiroPneuEscudo == fazendeiroPneuEscudo.width) {
          stepFazendeiroPneuEscudo = 0;
        }
      }

      if (!pneuRolandoPrimeiraVez && ataquePneuAcontecendo && !ataqueMimosaAcontecendo && !fazendeiroTomouDanoPneu) {
        if (millis() > tempoSpriteFazendeiroIdlePneu + 175) {
          spriteFazendeiroIdlePneu = fazendeiroIdlePneu.get(stepFazendeiroIdlePneu, 0, 188, 125);
          stepFazendeiroIdlePneu = stepFazendeiroIdlePneu % 752 + 188;
          image(spriteFazendeiroIdlePneu, fazendeiroX, fazendeiroY);
          tempoSpriteFazendeiroIdlePneu = millis();
        } else {
          image(spriteFazendeiroIdlePneu, fazendeiroX, fazendeiroY);
        }

        if (stepFazendeiroIdlePneu == fazendeiroIdlePneu.width) {
          stepFazendeiroIdlePneu = 0;
        }
      }

      if (fazendeiroTomouDanoPneu && !ataqueMimosaAcontecendo) {
        if (millis() > tempoSpriteFazendeiroPneuDano + 175) {
          spriteFazendeiroPneuDano = fazendeiroPneuDano.get(stepFazendeiroPneuDano, 0, 188, 125);
          stepFazendeiroPneuDano = stepFazendeiroPneuDano % 752 + 188;
          image(spriteFazendeiroPneuDano, fazendeiroX, fazendeiroY);
          tempoSpriteFazendeiroPneuDano = millis();
        } else {
          image(spriteFazendeiroPneuDano, fazendeiroX, fazendeiroY);
        }

        if (stepFazendeiroPneuDano == fazendeiroPneuDano.width && millis() > tempoSpriteFazendeiroTomouDanoPneu + 1400) {
          fazendeiroTomouDanoPneu = false;
        }

        if (stepFazendeiroPneuDano == fazendeiroPneuDano.width) {
          stepFazendeiroPneuDano = 0;
        }
      }
    } else {
      if (fazendeiroMorrendo) {
        if (millis() > tempoSpriteFazendeiroMorte + 450) {
          spriteFazendeiroMorte = fazendeiroMorte.get(stepFazendeiroMorte, 0, 196, 155);
          stepFazendeiroMorte = stepFazendeiroMorte % 980 + 196;
          image(spriteFazendeiroMorte, fazendeiroX, fazendeiroY);
          tempoSpriteFazendeiroMorte = millis();
        } else {
          image(spriteFazendeiroMorte, fazendeiroX, fazendeiroY);
        }

        if (stepFazendeiroMorte == fazendeiroMorte.width) {
          stepFazendeiroMorte = 0;
          fazendeiroMorrendo = false;
        }
      } else {
        spriteFazendeiroMorte = fazendeiroMorte.get(784, 0, 980, 155);
        image(spriteFazendeiroMorte, fazendeiroX, fazendeiroY);
      }
    }
  }

  public void update() {
    if (!ataquePneuAcontecendo && !fazendeiroTomouDanoPneu && !fazendeiroMorreu) {
      if (millis() > tempoNovoDestino + 5000) {
        destinoFazendeiroX = valoresFazendeiroDestinoX[PApplet.parseInt(random(0, valoresFazendeiroDestinoX.length))];
        destinoFazendeiroY = valoresFazendeiroDestinoY[PApplet.parseInt(random(0, valoresFazendeiroDestinoY.length))];
        tempoNovoDestino = millis();
        gatilhoNovoAtaqueMimosa = false;
        gatilhoNovoAtaqueMimosaAtivo = false;
        gatilhoNovoAtaquePneuAtivo = false;
        somFazendeiroIdleTocando = false;
      }

      if (fazendeiroX == destinoFazendeiroX && fazendeiroY == destinoFazendeiroY) {
        andando = false;
      }

      if (fazendeiroX < destinoFazendeiroX) {
        andando = true;
        fazendeiroX = fazendeiroX + 5;
      }
      if (fazendeiroX > destinoFazendeiroX) {
        andando = true;
        fazendeiroX = fazendeiroX - 5;
      }

      if (fazendeiroY < destinoFazendeiroY) {
        andando = true;
        fazendeiroY = fazendeiroY + 5;
      }
      if (fazendeiroY > destinoFazendeiroY) {      
        andando = true;
        fazendeiroY = fazendeiroY - 5;
      }
    }
  }

  public void ataqueFoice() {
    if (!ataqueMimosaAcontecendo && !ataquePneuAcontecendo && !fazendeiroTomouDanoPneu && !fazendeiroMorreu) {
      if (dist(fazendeiroX, fazendeiroY, jLeiteX, jLeiteY) < 100 && !ataqueFoiceLigado && millis() > tempoNovoAtaqueFoice + 1500) {
        tempoNovoAtaqueFoice = millis();
        tempoDanoFoice = millis();
        ataqueFoice = true;
        ataqueFoiceLigado = true;
        ataqueFoiceAcontecendo = true;
      } else {
        ataqueFoiceLigado = false;
      }
    }
  }

  public void colisaoFoice() {
    if (ataqueFoiceAcontecendo && dist(fazendeiroX, fazendeiroY, jLeiteX, jLeiteY) < 100) {
      if (millis() > tempoDanoFoice + 310) {
        if (!jLeiteImune) {
          vidaJLeiteAtual = vidaJLeiteAtual - 3;
          jLeiteImune = true;
          tempoImune = millis();
        }
      }
    }
  }

  public void ataqueMimosa() {
    if (!ataquePneuAcontecendo && !fazendeiroTomouDanoPneu && !fazendeiroMorreu) {
      if (fazendeiroX == destinoFazendeiroX && fazendeiroY == destinoFazendeiroY) {
        if (!gatilhoNovoAtaqueMimosa) {
          tempoNovoAtaqueMimosa = millis();
          gatilhoNovoAtaqueMimosa = true;
        }
        if (millis() > tempoNovoAtaqueMimosa + 1500 && !gatilhoNovoAtaqueMimosaAtivo) {
          novoAtaqueMimosa = true;
          gatilhoNovoAtaqueMimosaAtivo = true;
        }
      }
    }
  }

  public void ataquePneu() {
    if (!ataquePneuAcontecendo && !ataqueMimosaAcontecendo && !fazendeiroMorreu) {
      if (!gatilhoNovoAtaquePneu) {
        tempoNovoAtaquePneu = millis();
        gatilhoNovoAtaquePneu = true;
      }
      if (millis() > tempoNovoAtaquePneu + 32000 && !gatilhoNovoAtaquePneuAtivo) {
        novoAtaquePneu = true;
        gatilhoNovoAtaquePneuAtivo = true;
      }
    }
  }

  public void fazendeiroMorte() {
    if ((vidaFazendeiroAtual <= 0 || indexVidaFazendeiroOsso == 0) && !fazendeiroMorreu) {
      fazendeiroMorreu = true;
      fazendeiroMorrendo = true;
      if (sonsAtivos) {
        somFazendeiroMorreu.rewind();
        somFazendeiroMorreu.play();
      }
      tempoBossMorreu = millis();
    }
  }
}

Fazendeiro fazendeiro;

public void fazendeiro() {
  cachorro();
  vidaFazendeiro();
  pneu();
  mimosa();
  fazendeiro.display();
  fazendeiro.update();
  fazendeiro.ataqueFoice();
  fazendeiro.colisaoFoice();
  fazendeiro.ataqueMimosa();
  fazendeiro.ataquePneu();
  fazendeiro.fazendeiroMorte();
}

AudioPlayer[] sonsMimosaHit = new AudioPlayer [2];
AudioPlayer somMimosaErra;

PImage mimosa, mimosaDireita, mimosaEsquerda;

public class Mimosa {
  private PImage spriteMimosa;

  private int mimosaX = fazendeiroX + 66;
  private int mimosaY = fazendeiroY + 30;

  private int movimentoMimosaX;

  private int destinoX = jLeiteX;

  private int stepMimosa;
  private int tempoSpriteMimosa;

  private boolean mimosaReta;

  private boolean acertouJLeite;

  public void display() {
    if (millis() > tempoSpriteMimosa + 70) { 
      if (!mimosaReta) {
        if (mimosaX > destinoX) {
          spriteMimosa = mimosaEsquerda.get(stepMimosa, 0, 94, 101);
        } else {
          spriteMimosa = mimosaDireita.get(stepMimosa, 0, 94, 101);
        }
      } else {
        spriteMimosa = mimosa.get(stepMimosa, 0, 94, 101);
      }
      stepMimosa = stepMimosa % 188 + 94;
      image(spriteMimosa, mimosaX, mimosaY);
      tempoSpriteMimosa = millis();
    } else {
      image(spriteMimosa, mimosaX, mimosaY);
    }

    if (stepMimosa == mimosa.width) {
      stepMimosa = 0;
    }
  }

  public void update() {
    mimosaX = mimosaX + movimentoMimosaX;
    mimosaY = mimosaY + 8;
    if (!mimosaReta) {
      if (mimosaX > destinoX) {
        movimentoMimosaX = -8;
      } 
      if (mimosaX < destinoX) {
        movimentoMimosaX = 8;
      }
    } else {
      movimentoMimosaX = 0;
    }
  }

  public void checaMimosaReta() {
    if (mimosaX < destinoX) {
      if (destinoX - mimosaX < 10) {  
        mimosaReta = true;
      } else {
        mimosaReta = false;
      }
    } else {
      if (mimosaX - destinoX < 8) {  
        mimosaReta = true;
      } else {
        mimosaReta = false;
      }
    }
  }

  public boolean acertouJLeite() {
    if (mimosaX + 94 > jLeiteX && mimosaX < jLeiteX + 63 && mimosaY + 101 > jLeiteY && mimosaY < jLeiteY + 126) {
      acertouJLeite = true;
      return true;
    } else {
      return false;
    }
  }

  public boolean saiuDaTela() {
    if (mimosaY > height) {
      ataqueMimosaAcontecendo = false;
      return true;
    } else {
      return false;
    }
  }
}

ArrayList<Mimosa> mimosas;

public void mimosa() {
  if (ataqueMimosaAcontecendo && mimosas.size() == 0) {
    mimosas.add(new Mimosa());
  }

  for (int i = mimosas.size() - 1; i >= 0; i = i - 1) {
    Mimosa m = mimosas.get(i);
    m.display();
    m.update();
    m.checaMimosaReta();
    if (m.saiuDaTela()) {
      mimosas.remove(m);
      if (!m.acertouJLeite) {
        if (sonsAtivos) {
          somMimosaErra.rewind();
          somMimosaErra.play();
        }
      }
    }

    if (m.acertouJLeite() && !jLeiteImune) {
      vidaJLeiteAtual = vidaJLeiteAtual - 2;
      jLeiteImune = true;
      tempoImune = millis();
      if (sonsAtivos) {
        sonsMimosaHit[PApplet.parseInt(random(0, 2))].rewind();
        sonsMimosaHit[PApplet.parseInt(random(0, 2))].play();
      }
    }
  }
}

AudioPlayer somAcertouPneuJLeite, somAcertouPneuFazendeiro;

PImage pneuEsquerdaDesce, pneuEsquerdaSobe, pneuDireitaDesce, pneuDireitaSobe;

boolean pneuRolandoPrimeiraVez;

public class Pneu {
  private PImage spritePneu;

  private int pneuX = fazendeiroX - 30;
  private int pneuY = fazendeiroY + 70;

  private int destinoPneuX = 25;
  private int destinoPneuY = 300;

  private int movimentoPneuX = 1;
  private int movimentoPneuY = 1;

  private int totalRebatidasRestantes = 6;
  private int totalSprites = 7;

  private int stepPneu;
  private int tempoSpritePneu;

  private boolean novoDestinoPneu;

  private boolean acertarFazendeiro;

  public void display() {
    if (millis() > tempoSpritePneu + 40) { 
      if (totalSprites == 7 || totalSprites == 3) {
        spritePneu = pneuEsquerdaDesce.get(stepPneu, 0, 116, 84);
      }
      if (totalSprites == 4 || totalSprites == 0) {
        spritePneu = pneuEsquerdaSobe.get(stepPneu, 0, 116, 84);
      }
      if (totalSprites == 6 || totalSprites == 2) {
        spritePneu = pneuDireitaDesce.get(stepPneu, 0, 116, 84);
      }
      if (totalSprites == 5 || totalSprites == 1) {
        spritePneu = pneuDireitaSobe.get(stepPneu, 0, 116, 84);
      }
      stepPneu = stepPneu % 232 + 116;
      image(spritePneu, pneuX, pneuY);
      tempoSpritePneu = millis();
    } else {
      image(spritePneu, pneuX, pneuY);
    }

    if (stepPneu == 232) {
      stepPneu = 0;
    }
  }

  public void update() {
    pneuX = pneuX + movimentoPneuX;
    pneuY = pneuY + movimentoPneuY;

    if (dist(pneuX, pneuY, destinoPneuX, destinoPneuY) < 10) {
      novoDestinoPneu = true;
    }

    if (novoDestinoPneu) {
      if (totalRebatidasRestantes == 6) {
        if (jLeiteY > 300) {
          destinoPneuX = jLeiteX;
          destinoPneuY = jLeiteY;
        } else {
          destinoPneuX = 300;
          destinoPneuY = 515;
        }
        totalSprites = 6;
      }

      if (totalRebatidasRestantes == 5) {
        destinoPneuX = 659;
        destinoPneuY = 300;
        totalSprites = 5;
      }

      if (totalRebatidasRestantes == 4) {
        destinoPneuX = 300;
        destinoPneuY = 75;
        totalSprites = 4;
      }

      if (totalRebatidasRestantes == 3) {
        pneuRolandoPrimeiraVez = false;
        destinoPneuX = 25;
        destinoPneuY = 300;
        totalSprites = 3;
      }

      if (totalRebatidasRestantes == 2) {
        if (jLeiteY > 300) {
          destinoPneuX = jLeiteX;
          destinoPneuY = jLeiteY;
        } else {
          destinoPneuX = 300;
          destinoPneuY = 515;
        }
        totalSprites = 2;
      }

      if (totalRebatidasRestantes == 1) {
        destinoPneuX = 659;
        destinoPneuY = 300;
        totalSprites = 1;
      }

      if (totalRebatidasRestantes == 0) {
        destinoPneuX = fazendeiroX;
        destinoPneuY = fazendeiroY;
        acertarFazendeiro = true;
        totalSprites = 0;
      }

      totalRebatidasRestantes = totalRebatidasRestantes - 1;
      novoDestinoPneu = false;
    }

    if (pneuX > destinoPneuX) {
      movimentoPneuX = -5;
    }
    if (pneuX < destinoPneuX) {
      movimentoPneuX = 5;
    }

    if (pneuY > destinoPneuY) {
      movimentoPneuY = -5;
    } 
    if (pneuY < destinoPneuY) {      
      movimentoPneuY = 5;
    }
  }

  public boolean acertouJoaoLeite() {
    if (pneuX + 66 > jLeiteX && pneuX < jLeiteX + 63 && pneuY + 69 > jLeiteY && pneuY < jLeiteY + 123) {
      return true;
    } else {
      return false;
    }
  }

  public boolean acertouFazendeiro() {
    if (pneuX + 116 > fazendeiroX && pneuX < fazendeiroX + 188 && pneuY + 84 > fazendeiroY && pneuY < fazendeiroY + 125 && acertarFazendeiro) {
      if (indexVidaFazendeiroOsso >= 1) {
        indexVidaFazendeiroOsso = indexVidaFazendeiroOsso - 1;
      }
      tempoSpriteFazendeiroTomouDanoPneu = millis();
      fazendeiroTomouDanoPneu = true;
      return true;
    } else {
      return false;
    }
  }
}

ArrayList<Pneu> pneus;

public void pneu() {
  if (pneus.size() == 0) {
    pneuRolandoPrimeiraVez = false;
    ataquePneuAcontecendo = false;
  }

  if (soltouPneu && pneus.size() == 0) {
    pneus.add(new Pneu());
  }

  for (int i = pneus.size() - 1; i >= 0; i = i - 1) {
    Pneu p = pneus.get(i);
    p.display();
    p.update();
    if (p.acertouJoaoLeite() || p.acertouFazendeiro()) {   
      soltouPneu = false;
      pneus.remove(p);
    }
    if (p.acertouJoaoLeite() && !jLeiteImune) {
      if (sonsAtivos) {
        somAcertouPneuJLeite.rewind();
        somAcertouPneuJLeite.play();
      }
      vidaJLeiteAtual = vidaJLeiteAtual - 5;
      jLeiteImune = true;
      tempoImune = millis();
    }
    if (p.acertouFazendeiro()) {
      if (sonsAtivos) {
        somAcertouPneuFazendeiro.rewind();
        somAcertouPneuFazendeiro.play();
      }
    }
  }
}
PImage vidaPadreLayout;
PImage vidaPadreRaivaLayout;

PImage[] vidaPadreLayoutOsso = new PImage [5];

PImage vidaPadreRaivaBarra;

int vidaPadreAtual, vidaPadreRaivaAtual;
int vidaPadreMin, vidaPadreRaivaMin;

int vidaPadreBarraX;
int vidaPadreRaivaBarraX;

int indexVidaPadreOsso;

public void vidaPadre() {
  image(vidaBossesLayoutBackground, 0, 0);

  vidaPadreRaivaMin = 0;
  vidaPadreRaivaBarraX = 230;
  while (vidaPadreRaivaMin < vidaPadreRaivaAtual) {
    image(vidaPadreRaivaBarra, vidaPadreRaivaBarraX, 23);
    vidaPadreRaivaBarraX = vidaPadreRaivaBarraX + 11;
    vidaPadreRaivaMin = vidaPadreRaivaMin + 1;
  }

  vidaPadreMin = 0;
  vidaPadreBarraX = 230;
  while (vidaPadreMin < vidaPadreAtual) {
    image(vidaBossesBarra, vidaPadreBarraX, 23);
    vidaPadreBarraX = vidaPadreBarraX + 11;
    vidaPadreMin = vidaPadreMin + 1;
  }

  if (!padre.padreMudouForma) {
    image(vidaPadreLayout, 0, 0);
  } else {
    image(vidaPadreRaivaLayout, 0, 0);
  }
  image(vidaPadreLayoutOsso[indexVidaPadreOsso], 84, 54);
}

AudioPlayer[] sonsPadreIdle = new AudioPlayer [2];
AudioPlayer[] sonsPadreRaivaIdle = new AudioPlayer [4];
AudioPlayer[] sonsPadreCaveira = new AudioPlayer [2];
AudioPlayer[] sonsPadreTomandoDano = new AudioPlayer [3];
AudioPlayer[] sonsPadreRaivaTomandoDano = new AudioPlayer [3];
AudioPlayer[] sonsPadreLevantem = new AudioPlayer [2];
AudioPlayer[] sonsPadreImpossivel = new AudioPlayer [2];
AudioPlayer somPadreRaio;
AudioPlayer somPadreMorreu;

PImage padreMovimentoIdle;
PImage padreCruz;
PImage padreLevantem;
PImage padreCaveiraAparecendo;
PImage padreCaveira;
PImage[] padreCaveiraDano = new PImage [2];
PImage padreRaivaMovimentoIdle;
PImage padreRaivaCruz;
PImage padreRaivaLevantem;
PImage padreRaivaCaveiraAparecendo;
PImage padreRaivaCaveira;
PImage[] padreRaivaCaveiraDano = new PImage [2];
PImage padreRaivaRaio;
PImage padreMorte;

PImage sombraPadre;

int[] valoresPadreDestinoX = {27, 30, 33, 36, 39, 42, 45, 48, 51, 54, 57, 60, 63, 66, 69, 72, 75, 78, 81, 84, 87, 90, 93, 96, 99, 102, 105, 108, 111, 114, 117, 120, 123, 126, 129, 132, 135, 138, 141, 144, 147, 150, 153, 156, 159, 162, 165, 168, 171, 174, 177, 180, 183, 186, 189, 192, 207, 222, 237, 252, 267, 282, 297, 312, 327, 342, 357, 372, 387, 402, 417, 432, 447, 462, 477, 492, 507, 522, 537, 552, 567, 582, 597, 612};
int[] valoresPadreDestinoY = {75, 78, 81, 84, 87, 90, 93, 96, 99, 102, 105, 108, 111, 114, 117, 120, 123, 126, 129, 132, 135, 138, 141};

int padreX = valoresPadreDestinoX[PApplet.parseInt(random(0, valoresPadreDestinoX.length))];
int padreY = valoresPadreDestinoY[PApplet.parseInt(random(0, valoresPadreDestinoY.length))];

int indexRandomSomPadreTomandoDano;

boolean ataqueLevantemAcontecendo;
boolean ataqueCaveiraAcontecendo, padreCaveiraCaiuCabeca, umOsso = true;

public class Padre {
  private PImage spritePadreMovimentoIdle;
  private PImage spritePadreCruz;
  private PImage spritePadreLevantem;
  private PImage spritePadreCaveiraAparecendo;
  private PImage spritePadreCaveira;
  private PImage spritePadreCaveiraDano;
  private PImage spritePadreRaivaMovimentoIdle;
  private PImage spritePadreRaivaCruz;
  private PImage spritePadreRaivaLevantem;
  private PImage spritePadreRaivaCaveiraAparecendo;
  private PImage spritePadreRaivaCaveira;
  private PImage spritePadreRaivaCaveiraDano;
  private PImage spritePadreRaivaCaveiraDano2; 
  private PImage spritePadreRaivaRaio;
  private PImage spritePadreMorte;

  private int destinoPadreX = valoresPadreDestinoX[PApplet.parseInt(random(0, valoresPadreDestinoX.length))];
  private int destinoPadreY = valoresPadreDestinoY[PApplet.parseInt(random(0, valoresPadreDestinoY.length))];

  private int stepPadreMovimentoIdle;
  private int tempoSpritePadreMovimentoIdle;

  private int stepPadreCruz;
  private int tempoSpritePadreCruz;

  private int stepPadreLevantem;
  private int tempoSpritePadreLevantem;

  private int stepPadreCaveiraAparecendo;
  private int tempoSpritePadreCaveiraAparecendo;

  private int stepPadreCaveira;
  private int tempoSpritePadreCaveira;

  private int stepPadreCaveiraDano;
  private int tempoSpritePadreCaveiraDano;

  private int stepPadreRaivaMovimentoIdle;
  private int tempoSpritePadreRaivaMovimentoIdle;

  private int stepPadreRaivaCruz;
  private int tempoSpritePadreRaivaCruz;

  private int stepPadreRaivaLevantem;
  private int tempoSpritePadreRaivaLevantem;

  private int stepPadreRaivaCaveiraAparecendo;
  private int tempoSpritePadreRaivaCaveiraAparecendo;

  private int stepPadreRaivaCaveira;
  private int tempoSpritePadreRaivaCaveira;

  private int stepPadreRaivaCaveiraDano;
  private int tempoSpritePadreRaivaCaveiraDano;

  private int stepPadreRaivaCaveiraDano2;
  private int tempoSpritePadreRaivaCaveiraDano2;

  private int stepPadreRaivaRaio;
  private int tempoSpritePadreRaivaRaio;

  private int stepPadreMorte;
  private int tempoSpritePadreMorte;

  private int indexRandomSomPadreIdle;

  private int tempoNovoDestino = millis();

  private int tempoNovoAtaqueCruz, tempoDanoCruz;

  private int tempoNovoAtaqueLevantem = millis(), tempoDuracaoAtaqueLevantem, amountRecoveredLevantem;

  private int tempoNovoAtaqueCaveira = millis();

  private int tempoSpritePadreTomouDanoCaveira;

  private int tempoSpritePadreCarregandoAtaqueRaio, tempoGatilhoCarregarNovoAtaqueRaio = millis();

  private boolean somPadreIdleTocando;

  private boolean ataqueCruz, ataqueCruzLigado, ataqueCruzAcontecendo;
  private boolean novoAtaqueLevantem, gatilhoNovoAtaqueLevantemAtivo, gatilhoNovoAtaqueLevantem, padreRaivaCurou;  
  private boolean novoAtaqueCaveira, caveiraApareceu, gatilhoNovoAtaqueCaveiraAtivo, gatilhoNovoAtaqueCaveira, padreTomouDanoCaveira;
  private boolean padreMudouForma, padreFormaMudada;
  private boolean padreCarregandoNovoAtaqueRaio, gatilhoNovoAtaqueRaioAtivo, gatilhoNovoAtaqueRaio, padreParouCarregarRaio;  
  private boolean padreMorreu, padreMorrendo;

  public void display() {
    if (!padreMudouForma && !novoAtaqueLevantem) {
      image(sombraPadre, padreX + 30, padreY + 145);
    }

    if (!padreMudouForma) {
      if (!ataqueCruz && !novoAtaqueLevantem && !novoAtaqueCaveira && !caveiraApareceu && !padreCaveiraCaiuCabeca && !padreTomouDanoCaveira) {
        if (!somPadreIdleTocando) {
          if (sonsAtivos) {
            indexRandomSomPadreIdle = PApplet.parseInt(random(0, sonsPadreIdle.length));
            sonsPadreIdle[indexRandomSomPadreIdle].rewind();
            sonsPadreIdle[indexRandomSomPadreIdle].play();
            somPadreIdleTocando = true;
          }
        }

        if (millis() > tempoSpritePadreMovimentoIdle + 150) { 
          spritePadreMovimentoIdle = padreMovimentoIdle.get(stepPadreMovimentoIdle, 0, 110, 152); 
          stepPadreMovimentoIdle = stepPadreMovimentoIdle % 220 + 110;
          image(spritePadreMovimentoIdle, padreX, padreY); 
          tempoSpritePadreMovimentoIdle = millis();
        } else {
          image(spritePadreMovimentoIdle, padreX, padreY);
        }

        if (stepPadreMovimentoIdle == padreMovimentoIdle.width) {
          stepPadreMovimentoIdle = 0;
        }
      }

      if (ataqueCruz && !novoAtaqueLevantem && !novoAtaqueCaveira && !caveiraApareceu && !padreCaveiraCaiuCabeca && !padreTomouDanoCaveira) {
        if (millis() > tempoSpritePadreCruz + 150) { 
          spritePadreCruz = padreCruz.get(stepPadreCruz, 0, 113, 201); 
          stepPadreCruz = stepPadreCruz % 678 + 113;
          image(spritePadreCruz, padreX + 3, padreY - 47); 
          tempoSpritePadreCruz = millis();
        } else {
          image(spritePadreCruz, padreX + 3, padreY - 47);
        }

        if (stepPadreCruz == padreCruz.width) {
          ataqueCruz = false;
          ataqueCruzAcontecendo = false;
          ataqueCruzLigado = false;
          stepPadreCruz = 0;
        }
      }

      if (novoAtaqueLevantem && !novoAtaqueCaveira && !caveiraApareceu && !padreCaveiraCaiuCabeca && !padreTomouDanoCaveira) {
        if (stepPadreLevantem == 0) {
          if (sonsAtivos) {
            sonsPadreLevantem[0].rewind();
            sonsPadreLevantem[0].play();
          }
        }

        if (millis() > tempoSpritePadreLevantem + 150) { 
          spritePadreLevantem = padreLevantem.get(stepPadreLevantem, 0, 110, 153); 
          stepPadreLevantem = stepPadreLevantem % 220 + 110;
          image(spritePadreLevantem, padreX, padreY); 
          tempoSpritePadreLevantem = millis();
        } else {
          image(spritePadreLevantem, padreX, padreY);
        }

        if (stepPadreLevantem == padreLevantem.width) {
          stepPadreLevantem = 0;
        }

        if (millis() > tempoDuracaoAtaqueLevantem + 5000) {
          novoAtaqueLevantem = false;
          ataqueLevantemAcontecendo = false;
        }
      }

      if (novoAtaqueCaveira && !caveiraApareceu && !padreCaveiraCaiuCabeca && !padreTomouDanoCaveira) {
        if (millis() > tempoSpritePadreCaveiraAparecendo + 150) { 
          spritePadreCaveiraAparecendo = padreCaveiraAparecendo.get(stepPadreCaveiraAparecendo, 0, 113, 199); 
          stepPadreCaveiraAparecendo = stepPadreCaveiraAparecendo % 678 + 113;
          image(spritePadreCaveiraAparecendo, padreX + 3, padreY - 47); 
          tempoSpritePadreCaveiraAparecendo = millis();
        } else {
          image(spritePadreCaveiraAparecendo, padreX + 3, padreY - 47);
        }

        if (stepPadreCaveiraAparecendo == padreCaveiraAparecendo.width) {
          stepPadreCaveiraAparecendo = 0;
          caveiraApareceu = true;
          novoAtaqueCaveira = false;
          gatilhoNovoAtaqueCaveira = false;
        }
      }

      if (caveiraApareceu && !padreCaveiraCaiuCabeca && !padreTomouDanoCaveira) {
        if (stepPadreCaveira == 0) {
          if (sonsAtivos) {
            sonsPadreCaveira[0].rewind();
            sonsPadreCaveira[0].play();
          }
        }

        if (millis() > tempoSpritePadreCaveira + 150) { 
          spritePadreCaveira = padreCaveira.get(stepPadreCaveira, 0, 113, 199); 
          stepPadreCaveira = stepPadreCaveira % 678 + 113;
          image(spritePadreCaveira, padreX + 3, padreY - 47); 
          tempoSpritePadreCaveira = millis();
        } else {
          image(spritePadreCaveira, padreX + 3, padreY - 47);
        }

        if (stepPadreCaveira == padreCaveira.width) {
          stepPadreCaveira = 0;
        }
      }

      if (padreCaveiraCaiuCabeca && !padreTomouDanoCaveira) {
        if (millis() > tempoSpritePadreCaveiraDano + 150) { 
          spritePadreCaveiraDano = padreCaveiraDano[0].get(stepPadreCaveiraDano, 0, 113, 199); 
          stepPadreCaveiraDano = stepPadreCaveiraDano % 678 + 113;
          image(spritePadreCaveiraDano, padreX + 3, padreY - 47); 
          tempoSpritePadreCaveiraDano = millis();
        } else {
          image(spritePadreCaveiraDano, padreX + 3, padreY - 47);
        }

        if (stepPadreCaveiraDano == padreCaveiraDano[0].width) {
          stepPadreCaveiraDano = 0;
          padreCaveiraCaiuCabeca = false;
          tempoSpritePadreTomouDanoCaveira = millis();
          padreTomouDanoCaveira = true;
        }
      }

      if (padreTomouDanoCaveira) {
        image(padreCaveiraDano[1], padreX + 3, padreY - 47);

        if (millis() > tempoSpritePadreTomouDanoCaveira + 2000) {
          padreTomouDanoCaveira = false;
        }
      }
    } else {
      if (!padreMorreu) {
        if (!ataqueCruz && !novoAtaqueLevantem && !novoAtaqueCaveira && !caveiraApareceu && !padreCaveiraCaiuCabeca && !padreTomouDanoCaveira && !padreCarregandoNovoAtaqueRaio) {
          if (!somPadreIdleTocando) {
            if (sonsAtivos) {
              indexRandomSomPadreIdle = PApplet.parseInt(random(0, sonsPadreRaivaIdle.length));
              sonsPadreRaivaIdle[indexRandomSomPadreIdle].rewind();
              sonsPadreRaivaIdle[indexRandomSomPadreIdle].play();
              somPadreIdleTocando = true;
            }
          }

          if (millis() > tempoSpritePadreRaivaMovimentoIdle + 150) { 
            spritePadreRaivaMovimentoIdle = padreRaivaMovimentoIdle.get(stepPadreRaivaMovimentoIdle, 0, 126, 156); 
            stepPadreRaivaMovimentoIdle = stepPadreRaivaMovimentoIdle % 378 + 126;
            image(spritePadreRaivaMovimentoIdle, padreX, padreY); 
            tempoSpritePadreRaivaMovimentoIdle = millis();
          } else {
            image(spritePadreRaivaMovimentoIdle, padreX, padreY);
          }

          if (stepPadreRaivaMovimentoIdle == padreRaivaMovimentoIdle.width) {
            stepPadreRaivaMovimentoIdle = 0;
          }
        }

        if (ataqueCruz && !novoAtaqueLevantem && !novoAtaqueCaveira && !caveiraApareceu && !padreCaveiraCaiuCabeca && !padreTomouDanoCaveira && !padreCarregandoNovoAtaqueRaio) {
          if (millis() > tempoSpritePadreRaivaCruz + 150) { 
            spritePadreRaivaCruz = padreRaivaCruz.get(stepPadreCruz, 0, 126, 156); 
            stepPadreRaivaCruz = stepPadreRaivaCruz % 378 + 126;
            image(spritePadreRaivaCruz, padreX, padreY); 
            tempoSpritePadreRaivaCruz = millis();
          } else {
            image(spritePadreRaivaCruz, padreX, padreY);
          }

          if (stepPadreRaivaCruz == padreRaivaCruz.width) {
            ataqueCruz = false;
            ataqueCruzAcontecendo = false;
            ataqueCruzLigado = false;
            stepPadreRaivaCruz = 0;
          }
        }

        if (novoAtaqueLevantem && !novoAtaqueCaveira && !caveiraApareceu && !padreCaveiraCaiuCabeca && !padreTomouDanoCaveira && !padreCarregandoNovoAtaqueRaio) {
          if (stepPadreRaivaLevantem == 0) {
            if (sonsAtivos) {
              sonsPadreLevantem[0].rewind();
              sonsPadreLevantem[0].play();
            }
          }

          if (!padreRaivaCurou) {
            while (vidaPadreRaivaAtual < 40 && amountRecoveredLevantem < 3) {
              amountRecoveredLevantem = amountRecoveredLevantem + 1;
              vidaPadreRaivaAtual = vidaPadreRaivaAtual + 1;
            }
            padreRaivaCurou = true;
          }
          if (millis() > tempoSpritePadreRaivaLevantem + 150) { 
            spritePadreRaivaLevantem = padreRaivaLevantem.get(stepPadreRaivaLevantem, 0, 126, 163); 
            stepPadreRaivaLevantem = stepPadreRaivaLevantem % 378 + 126;
            image(spritePadreRaivaLevantem, padreX, padreY); 
            tempoSpritePadreRaivaLevantem = millis();
          } else {
            image(spritePadreRaivaLevantem, padreX, padreY);
          }

          if (stepPadreRaivaLevantem == padreRaivaLevantem.width) {
            stepPadreRaivaLevantem = 0;
          }

          if (millis() > tempoDuracaoAtaqueLevantem + 5000) {
            novoAtaqueLevantem = false;
            ataqueLevantemAcontecendo = false;
          }
        }

        if (novoAtaqueCaveira && !caveiraApareceu && !padreCaveiraCaiuCabeca && !padreTomouDanoCaveira && !padreCarregandoNovoAtaqueRaio) {
          if (millis() > tempoSpritePadreRaivaCaveiraAparecendo + 150) { 
            spritePadreRaivaCaveiraAparecendo = padreRaivaCaveiraAparecendo.get(stepPadreRaivaCaveiraAparecendo, 0, 129, 203); 
            stepPadreRaivaCaveiraAparecendo = stepPadreRaivaCaveiraAparecendo % 774 + 129;
            image(spritePadreRaivaCaveiraAparecendo, padreX + 3, padreY - 47); 
            tempoSpritePadreRaivaCaveiraAparecendo = millis();
          } else {
            image(spritePadreRaivaCaveiraAparecendo, padreX + 3, padreY - 47);
          }

          if (stepPadreRaivaCaveiraAparecendo == padreRaivaCaveiraAparecendo.width) {
            stepPadreRaivaCaveiraAparecendo = 0;
            caveiraApareceu = true;
            novoAtaqueCaveira = false;
          }
        }

        if (caveiraApareceu && !padreCaveiraCaiuCabeca && !padreTomouDanoCaveira && !padreCarregandoNovoAtaqueRaio) {
          if (stepPadreRaivaCaveira == 0) {
            if (sonsAtivos) {
              sonsPadreCaveira[1].rewind();
              sonsPadreCaveira[1].play();
            }
          }

          if (millis() > tempoSpritePadreRaivaCaveira + 150) { 
            spritePadreRaivaCaveira = padreRaivaCaveira.get(stepPadreRaivaCaveira, 0, 129, 203); 
            stepPadreRaivaCaveira = stepPadreRaivaCaveira % 774 + 129;
            image(spritePadreRaivaCaveira, padreX + 3, padreY - 47); 
            tempoSpritePadreRaivaCaveira = millis();
          } else {
            image(spritePadreRaivaCaveira, padreX + 3, padreY - 47);
          }

          if (stepPadreRaivaCaveira == padreRaivaCaveira.width) {
            stepPadreRaivaCaveira = 0;
          }
        }

        if (padreCaveiraCaiuCabeca && !padreTomouDanoCaveira && !padreCarregandoNovoAtaqueRaio) {
          if (millis() > tempoSpritePadreRaivaCaveiraDano + 150) { 
            spritePadreRaivaCaveiraDano = padreRaivaCaveiraDano[0].get(stepPadreRaivaCaveiraDano, 0, 129, 203); 
            stepPadreRaivaCaveiraDano = stepPadreRaivaCaveiraDano % 774 + 129;
            image(spritePadreRaivaCaveiraDano, padreX + 3, padreY - 47); 
            tempoSpritePadreRaivaCaveiraDano = millis();
          } else {
            image(spritePadreRaivaCaveiraDano, padreX + 3, padreY - 47);
          }

          if (stepPadreRaivaCaveiraDano == padreRaivaCaveiraDano[0].width) {
            stepPadreRaivaCaveiraDano = 0;
            padreCaveiraCaiuCabeca = false;
            padreTomouDanoCaveira = true;
            tempoSpritePadreTomouDanoCaveira = millis();
          }
        }

        if (padreTomouDanoCaveira && !padreCarregandoNovoAtaqueRaio) {
          if (millis() > tempoSpritePadreRaivaCaveiraDano2 + 150) { 
            spritePadreRaivaCaveiraDano2 = padreRaivaCaveiraDano[1].get(stepPadreRaivaCaveiraDano2, 0, 126, 156); 
            stepPadreRaivaCaveiraDano2 = stepPadreRaivaCaveiraDano2 % 378 + 126;
            image(spritePadreRaivaCaveiraDano2, padreX, padreY); 
            tempoSpritePadreRaivaCaveiraDano2 = millis();
          } else {
            image(spritePadreRaivaCaveiraDano2, padreX, padreY);
          }

          if (stepPadreRaivaCaveiraDano2 == padreRaivaCaveiraDano[1].width) {
            stepPadreRaivaCaveiraDano2 = 0;
          }

          if (millis() > tempoSpritePadreTomouDanoCaveira + 2000) {
            padreTomouDanoCaveira = false;
          }
        }

        if (padreCarregandoNovoAtaqueRaio) {
          if (millis() > tempoSpritePadreRaivaRaio + 150) { 
            spritePadreRaivaRaio = padreRaivaRaio.get(stepPadreRaivaRaio, 0, 126, 156); 
            stepPadreRaivaRaio = stepPadreRaivaRaio % 378 + 126;
            image(spritePadreRaivaRaio, padreX, padreY); 
            tempoSpritePadreRaivaRaio = millis();
          } else {
            image(spritePadreRaivaRaio, padreX, padreY);
          }

          if (stepPadreRaivaRaio == padreRaivaRaio.width) {
            stepPadreRaivaRaio = 0;
          }

          if (millis() > tempoSpritePadreCarregandoAtaqueRaio + 3000) {
            padreCarregandoNovoAtaqueRaio = false;
            padreParouCarregarRaio = true;
            gatilhoNovoAtaqueRaio = false;
            if (sonsAtivos) {
              somPadreRaio.rewind();
              somPadreRaio.play();
            }
          }
        }
      } else {
        if (padreMorrendo) {
          if (millis() > tempoSpritePadreMorte + 100) {
            spritePadreMorte = padreMorte.get(stepPadreMorte, 0, 492, 531);
            stepPadreMorte = stepPadreMorte % 8364 + 492;
            image(spritePadreMorte, padreX, padreY);
            tempoSpritePadreMorte = millis();
          } else {
            image(spritePadreMorte, padreX - 168, padreY - 181);
          }

          if (stepPadreMorte == padreMorte.width) {
            stepPadreMorte = 0;
            padreMorrendo = false;
          }
        } else {
          spritePadreMorte = padreMorte.get(7872, 0, 8364, 531);
          image(spritePadreMorte, padreX - 168, padreY - 181);
        }
      }
    }
  }

  public void update() {
    if (!padreMudouForma || padreMudouForma) {
      if (!novoAtaqueLevantem && !ataqueLevantemAcontecendo && !ataqueCaveiraAcontecendo && !padreCaveiraCaiuCabeca && !padreTomouDanoCaveira && !padreCarregandoNovoAtaqueRaio && !padreMorreu) {
        if (millis() > tempoNovoDestino + 8000) {
          destinoPadreX = valoresPadreDestinoX[PApplet.parseInt(random(0, valoresPadreDestinoX.length))];
          destinoPadreY = valoresPadreDestinoY[PApplet.parseInt(random(0, valoresPadreDestinoY.length))];
          tempoNovoDestino = millis();  
          gatilhoNovoAtaqueRaioAtivo = false;
          gatilhoNovoAtaqueCaveiraAtivo = false;
          gatilhoNovoAtaqueLevantem = false;
          gatilhoNovoAtaqueLevantemAtivo = false;
          somPadreIdleTocando = false;
        }

        if (padreX < destinoPadreX) {
          padreX = padreX + 3;
        }
        if (padreX > destinoPadreX) {
          padreX = padreX - 3;
        }

        if (padreY < destinoPadreY) {
          padreY = padreY + 3;
        }
        if (padreY > destinoPadreY) {      
          padreY = padreY - 3;
        }
      }
    }
  }

  public void ataqueCruz() {
    if (!novoAtaqueLevantem && !ataqueLevantemAcontecendo && !ataqueCaveiraAcontecendo && !padreCaveiraCaiuCabeca && !padreTomouDanoCaveira && !padreCarregandoNovoAtaqueRaio && !padreMorreu) {
      if (dist(padreX, padreY, jLeiteX, jLeiteY) < 100 && !ataqueCruzLigado && millis() > tempoNovoAtaqueCruz + 1500) {
        tempoNovoAtaqueCruz = millis();
        tempoDanoCruz = millis();
        ataqueCruz = true;
        ataqueCruzLigado = true;
        ataqueCruzAcontecendo = true;
      }
    }
  }

  public void colisaoCruz() {
    if (!novoAtaqueLevantem && !ataqueLevantemAcontecendo && !ataqueCaveiraAcontecendo && !padreCaveiraCaiuCabeca && !padreTomouDanoCaveira && !padreCarregandoNovoAtaqueRaio && !padreMorreu) {
      if (ataqueCruzAcontecendo) {
        if (!padreMudouForma) {
          if (millis() > tempoDanoCruz + 750) {
            if (!jLeiteImune) {
              hitHitCruzMostrando = true;
              hitCruz(jLeiteX - 30, jLeiteY);
              vidaJLeiteAtual = vidaJLeiteAtual - 2;
              jLeiteImune = true;
              tempoImune = millis();
            }
          }
        } else {
          if (millis() > tempoDanoCruz + 300) {
            if (!jLeiteImune) {
              hitHitCruzMostrando = true;
              hitCruz(jLeiteX - 30, jLeiteY);
              vidaJLeiteAtual = vidaJLeiteAtual - 3;
              jLeiteImune = true;
              tempoImune = millis();
            }
          }
        }
      }
    }
  }

  public void ataqueLevantem() {
    if (!novoAtaqueLevantem && !ataqueLevantemAcontecendo && !ataqueCaveiraAcontecendo && !padreCaveiraCaiuCabeca && !padreTomouDanoCaveira && !padreCarregandoNovoAtaqueRaio && !padreMorreu) {
      if (padreX == destinoPadreX && padreY == destinoPadreY) {
        if (!gatilhoNovoAtaqueLevantem) {
          tempoNovoAtaqueLevantem = millis();
          gatilhoNovoAtaqueLevantem = true;
          amountRecoveredLevantem = 0;
          padreRaivaCurou = false;
        }
        if (millis() > tempoNovoAtaqueLevantem + 5000 && !gatilhoNovoAtaqueLevantemAtivo) {
          novoAtaqueLevantem = true;
          gatilhoNovoAtaqueLevantemAtivo = true;
          ataqueLevantemAcontecendo = true;
          tempoDuracaoAtaqueLevantem = millis();
        }
      }
    }
  }

  public void ataqueCaveira() {
    if (!novoAtaqueLevantem && !ataqueLevantemAcontecendo && !ataqueCaveiraAcontecendo && !padreCaveiraCaiuCabeca && !padreTomouDanoCaveira && !padreCarregandoNovoAtaqueRaio && !padreMorreu) {
      if (!gatilhoNovoAtaqueCaveira) {
        tempoNovoAtaqueCaveira = millis();
        gatilhoNovoAtaqueCaveira = true;
      }
      if (millis() > tempoNovoAtaqueCaveira + 40000 && !gatilhoNovoAtaqueCaveiraAtivo) {
        ataqueCaveiraAcontecendo = true;
        novoAtaqueCaveira = true;
        tempoPrimeiraCaveiraAtaque = millis();
        gatilhoNovoAtaqueCaveiraAtivo = true;
        umOsso = true;
      }
    }
  }

  public void padreMudarForma() {
    if ((vidaPadreAtual <= 0 || indexVidaPadreOsso == 2) && !padreFormaMudada) {
      padreMudouForma = true;
      padreFormaMudada = true;
    }
  }

  public void ataqueCarregandoRaio() {
    if (padreMudouForma) {
      if (!novoAtaqueLevantem && !ataqueLevantemAcontecendo && !ataqueCaveiraAcontecendo && !padreCaveiraCaiuCabeca && !padreTomouDanoCaveira && !padreCarregandoNovoAtaqueRaio && !padreMorreu) {
        if (!gatilhoNovoAtaqueRaio) {
          tempoGatilhoCarregarNovoAtaqueRaio = millis();
          gatilhoNovoAtaqueRaio = true;
        }
        if (millis() > tempoGatilhoCarregarNovoAtaqueRaio + 15000 && !gatilhoNovoAtaqueRaioAtivo) {
          tempoSpritePadreCarregandoAtaqueRaio = millis();
          padreCarregandoNovoAtaqueRaio = true;
          gatilhoNovoAtaqueRaioAtivo = true;
        }
      }
    }
  }

  public void padreMorte() {
    if ((vidaPadreRaivaAtual <= 0 || indexVidaPadreOsso == 0) && !padreMorreu) {
      padreMorreu = true;
      padreMorrendo = true;
      if (sonsAtivos) {
        somPadreMorreu.rewind();
        somPadreMorreu.play();
      }
      tempoBossMorreu = millis();
    }
  }
}

Padre padre;

public void padre() {
  inimigosTodos();
  vidaPadre();
  padre.display();
  padre.update();
  padre.ataqueCruz();
  padre.colisaoCruz();
  padre.ataqueLevantem();
  padre.ataqueCaveira();
  caveiraPadre();
  padre.padreMudarForma();
  padre.ataqueCarregandoRaio();
  padre.padreMorte();
  raio();
}

PImage caveiraPadreAparecendo;
PImage caveiraPadreFlutuando;
PImage caveiraPadreAtaque;
PImage caveiraPadreRaivaAparecendo;
PImage caveiraPadreRaivaFlutuando;
PImage caveiraPadreRaivaAtaque;

public class CaveiraPadre {
  private PImage spriteCaveiraPadreAparecendo;
  private PImage spriteCaveiraPadreFlutuando;
  private PImage spriteCaveiraPadreRaivaAparecendo;
  private PImage spriteCaveiraPadreRaivaFlutuando;

  private float caveiraPadreX;
  private float caveiraPadreY;

  private float destinoCaveiraPadreX;

  private int movimentoCaveiraPadreX;
  private int movimentoCaveiraPadreY;

  private int indexCaveiraPadre;

  private int stepCaveiraPadreAparecendo;
  private int tempoSpriteCaveiraPadreAparecendo;

  private int stepCaveiraPadreFlutuando;
  private int tempoSpriteCaveiraPadreFlutuando;

  private int stepCaveiraPadreRaivaAparecendo;
  private int tempoSpriteCaveiraPadreRaivaAparecendo;

  private int stepCaveiraPadreRaivaFlutuando;
  private int tempoSpriteCaveiraPadreRaivaFlutuando;

  private boolean caveiraAtaqueAtivo;
  private boolean novoDestinoCaveiraPadreX;

  private boolean caveiraPadreReta;

  public CaveiraPadre(float caveiraPadreX, float caveiraPadreY, int indexCaveiraPadre, int movimentoCaveiraPadreY) {
    this.caveiraPadreX = caveiraPadreX;
    this.caveiraPadreY = caveiraPadreY;
    this.indexCaveiraPadre = indexCaveiraPadre;
    this.movimentoCaveiraPadreY = movimentoCaveiraPadreY;
  }

  public void display() {
    if (!padre.padreMudouForma) {
      if (!caveiraAtaqueAtivo) {
        if (padre.novoAtaqueCaveira && !padre.caveiraApareceu) {
          if (millis() > tempoSpriteCaveiraPadreAparecendo + 150) {
            spriteCaveiraPadreAparecendo = caveiraPadreAparecendo.get(stepCaveiraPadreAparecendo, 0, 52, 76);
            stepCaveiraPadreAparecendo = stepCaveiraPadreAparecendo % 312 + 52;
            image(spriteCaveiraPadreAparecendo, caveiraPadreX, caveiraPadreY);
            tempoSpriteCaveiraPadreAparecendo = millis();
          } else {
            image(spriteCaveiraPadreAparecendo, caveiraPadreX, caveiraPadreY);
          }

          if (stepCaveiraPadreAparecendo == caveiraPadreAparecendo.width) {
            stepCaveiraPadreAparecendo = 0;
          }
        }

        if (padre.caveiraApareceu) {
          if (millis() > tempoSpriteCaveiraPadreFlutuando + 150) {
            spriteCaveiraPadreFlutuando = caveiraPadreFlutuando.get(stepCaveiraPadreFlutuando, 0, 52, 76);
            stepCaveiraPadreFlutuando = stepCaveiraPadreFlutuando % 312 + 52;
            image(spriteCaveiraPadreFlutuando, caveiraPadreX, caveiraPadreY);
            tempoSpriteCaveiraPadreFlutuando = millis();
          } else {
            image(spriteCaveiraPadreFlutuando, caveiraPadreX, caveiraPadreY);
          }

          if (stepCaveiraPadreFlutuando == caveiraPadreFlutuando.width) {
            stepCaveiraPadreFlutuando = 0;
          }
        }
      } else {
        image(caveiraPadreAtaque, caveiraPadreX, caveiraPadreY);
      }
    } else {
      if (!caveiraAtaqueAtivo) {
        if (padre.novoAtaqueCaveira && !padre.caveiraApareceu) {
          if (millis() > tempoSpriteCaveiraPadreRaivaAparecendo + 150) {
            spriteCaveiraPadreRaivaAparecendo = caveiraPadreRaivaAparecendo.get(stepCaveiraPadreRaivaAparecendo, 0, 52, 76);
            stepCaveiraPadreRaivaAparecendo = stepCaveiraPadreRaivaAparecendo % 312 + 52;
            image(spriteCaveiraPadreRaivaAparecendo, caveiraPadreX, caveiraPadreY);
            tempoSpriteCaveiraPadreRaivaAparecendo = millis();
          } else {
            image(spriteCaveiraPadreRaivaAparecendo, caveiraPadreX, caveiraPadreY);
          }

          if (stepCaveiraPadreRaivaAparecendo == caveiraPadreRaivaAparecendo.width) {
            stepCaveiraPadreRaivaAparecendo = 0;
          }
        }

        if (padre.caveiraApareceu) {
          if (millis() > tempoSpriteCaveiraPadreRaivaFlutuando + 150) {
            spriteCaveiraPadreRaivaFlutuando = caveiraPadreRaivaFlutuando.get(stepCaveiraPadreRaivaFlutuando, 0, 52, 76);
            stepCaveiraPadreRaivaFlutuando = stepCaveiraPadreRaivaFlutuando % 312 + 52;
            image(spriteCaveiraPadreRaivaFlutuando, caveiraPadreX, caveiraPadreY);
            tempoSpriteCaveiraPadreRaivaFlutuando = millis();
          } else {
            image(spriteCaveiraPadreRaivaFlutuando, caveiraPadreX, caveiraPadreY);
          }

          if (stepCaveiraPadreRaivaFlutuando == caveiraPadreRaivaFlutuando.width) {
            stepCaveiraPadreRaivaFlutuando = 0;
          }
        }
      } else {
        image(caveiraPadreRaivaAtaque, caveiraPadreX, caveiraPadreY);
      }
    }
  }

  public void update() {
    if (indexCaveiraPadre == randomIndexCaveiraPadre && padre.caveiraApareceu) {
      if (!novoDestinoCaveiraPadreX) {
        destinoCaveiraPadreX = jLeiteX;
        novoDestinoCaveiraPadreX = true;
      }

      caveiraAtaqueAtivo = true;
      caveiraPadreX = caveiraPadreX + movimentoCaveiraPadreX;

      if (!caveiraPadreReta) {
        if (caveiraPadreX > destinoCaveiraPadreX) {
          movimentoCaveiraPadreX = -8;
        } else {
          movimentoCaveiraPadreX = 8;
        }
      } else {
        movimentoCaveiraPadreX = 0;
      }

      caveiraPadreY = caveiraPadreY + movimentoCaveiraPadreY;
    }
  }

  public void checaCaveiraPadreReta() {
    if (caveiraPadreX < destinoCaveiraPadreX) {
      if (destinoCaveiraPadreX - caveiraPadreX < 10) {  
        caveiraPadreReta = true;
      } else {
        caveiraPadreReta = false;
      }
    } else {
      if (caveiraPadreX - destinoCaveiraPadreX < 10) {  
        caveiraPadreReta = true;
      } else {
        caveiraPadreReta = false;
      }
    }
  }

  public boolean acertouJLeite() {
    if (caveiraPadreX + 48 > jLeiteX && caveiraPadreX < jLeiteX + 63 && caveiraPadreY + 70 > jLeiteY && caveiraPadreY < jLeiteY + 126) {
      return true;
    } else {
      return false;
    }
  }

  public boolean saiuDaTela() {
    if (caveiraPadreY > height) {
      return true;
    } else {
      return false;
    }
  }
}

ArrayList<CaveiraPadre> caveirasPadre;

int tempoPrimeiraCaveiraAtaque;
int randomIndexCaveiraPadre = 4;

int[] valoresIndexDeletados = new int [3];

boolean gatilhoNovaCaveiraAtacar;

public void caveiraPadre() {   
  if (caveirasPadre.size() > 0 && millis() > tempoPrimeiraCaveiraAtaque + 1000 && !gatilhoNovaCaveiraAtacar) {
    randomIndexCaveiraPadre = PApplet.parseInt(random(0, 4));
    gatilhoNovaCaveiraAtacar = true;
  }

  for (int i = 0; i < valoresIndexDeletados.length; i = i + 1) {
    if (randomIndexCaveiraPadre == valoresIndexDeletados[i]) {
      gatilhoNovaCaveiraAtacar = false;
    }
  }

  if (caveirasPadre.size() == 0 && padre.novoAtaqueCaveira) {
    caveirasPadre.add(new CaveiraPadre(padreX + 005, padreY + 033, 0, PApplet.parseInt(random(9, 11))));  
    caveirasPadre.add(new CaveiraPadre(padreX + 015, padreY + 113, 1, PApplet.parseInt(random(4, 12))));
    caveirasPadre.add(new CaveiraPadre(padreX + 105, padreY + 033, 2, PApplet.parseInt(random(5, 13))));
    caveirasPadre.add(new CaveiraPadre(padreX + 110, padreY + 113, 3, PApplet.parseInt(random(8, 10))));
  }

  if (caveirasPadre.size() == 0) {
    ataqueCaveiraAcontecendo = false;
    padre.caveiraApareceu = false;
  }

  for (int i = caveirasPadre.size() - 1; i >= 0; i = i - 1) {
    CaveiraPadre c = caveirasPadre.get(i);
    c.display();
    c.update();
    c.checaCaveiraPadreReta();
    if (c.saiuDaTela()) {
      if (caveirasPadre.size() > 1) {
        valoresIndexDeletados[4 - caveirasPadre.size()] = c.indexCaveiraPadre;
      } else {
        padre.caveiraApareceu = false;
        padre.tempoNovoAtaqueCaveira = millis();
        padreCaveiraCaiuCabeca = true;
        if (indexVidaPadreOsso >= 1 && umOsso) {
          if (!padre.padreMudouForma) {
            if (sonsAtivos) {
              sonsPadreImpossivel[0].rewind();
              sonsPadreImpossivel[0].play();
            }
          } else {
            if (sonsAtivos) {
              sonsPadreImpossivel[1].rewind();
              sonsPadreImpossivel[1].play();
            }
          }
          indexVidaPadreOsso = indexVidaPadreOsso - 1;
          umOsso = false;
        }
      }
      gatilhoNovaCaveiraAtacar = false;
      caveirasPadre.remove(c);
    }

    if (c.acertouJLeite() && !jLeiteImune) {
      vidaJLeiteAtual = vidaJLeiteAtual - 4;
      jLeiteImune = true;
      tempoImune = millis();
      ataqueCaveiraAcontecendo = false;
      padre.caveiraApareceu = false;
    }

    if (!ataqueCaveiraAcontecendo) {
      caveirasPadre.remove(c);
    }
  }
}

PImage raioPadre;

public class Raio {
  private PImage spriteRaioPadre;

  private int raioX = 145;
  private int raioY = -120;

  private int stepRaioPadre;
  private int tempoSpriteRaioPadre;

  private boolean danoJLeite;
  private boolean deletarRaio;

  public void display() {
    if (millis() > tempoSpriteRaioPadre + 150) {
      if (padre.padreCarregandoNovoAtaqueRaio) {
        spriteRaioPadre = raioPadre.get(0, 0, 509, 720);
      } else {
        if (padre.padreParouCarregarRaio) {
          spriteRaioPadre = raioPadre.get(stepRaioPadre, 0, 509, 720);
          stepRaioPadre = stepRaioPadre % 6108 + 509;
        }
      }
      image(spriteRaioPadre, raioX, raioY);
      tempoSpriteRaioPadre = millis();
    } else {
      image(spriteRaioPadre, raioX, raioY);
    }

    if (stepRaioPadre >= 2545) {
      danoJLeite = true;
    }

    if (stepRaioPadre == raioPadre.width) {
      stepRaioPadre = 0;
      deletarRaio = true;
    }
  }

  public boolean acertouJLeite() {
    if (danoJLeite) {
      if (jLeiteX + 63 > raioX && jLeiteX < raioX + 509 && jLeiteY + 126 > raioY + 550 && jLeiteY < raioY + 720) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}

ArrayList<Raio> raios;

public void raio() {
  if (raios.size() == 0 && padre.padreCarregandoNovoAtaqueRaio) {
    raios.add(new Raio());
  }

  for (int i = raios.size() - 1; i >= 0; i = i - 1) {
    Raio r = raios.get(i);
    r.display();
    if (r.acertouJLeite() && !imortalidade) {
      vidaJLeiteAtual = vidaJLeiteAtual - 9999999;
    }
    if (r.deletarRaio) {
      raios.remove(r);
    }
  }
}
PImage brigadeiro;

public class Brigadeiro extends Comida {
  public Brigadeiro(int x, int y) {
    this.setX(x);
    this.setY(y);

    setSpriteImage(brigadeiro);
    setSpriteInterval(75);
    setSpriteWidth(32);
    setSpriteHeight(31);
    setMovementY(1);

    setAmountRecovered(0);
  }

  public Brigadeiro() {
    this.setX(PApplet.parseInt(random(200, 500)));
    this.setY(PApplet.parseInt(random(-300, -1000)));

    setSpriteImage(brigadeiro);
    setSpriteInterval(75);
    setSpriteWidth(32);
    setSpriteHeight(31);
    setMovementY(1);

    setAmountRecovered(0);
  }

  public void display() {
    image (foodShadow, getX(), getY() + 20);

    super.display();
  }
}

ArrayList<Brigadeiro> brigadeiros;

int indexRandomBrigadeiroMapaBoss;

int amountHealBrigadeiro = 3;

public void brigadeiro() {
  if (totalFood < 1 && hasIndexChanged && millis() > timeToGenerateFood + 10000) {
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      if (brigadeiros.size() == 0 && foodIndex >= 0 && foodIndex <= 4 && !telaTutorialAndandoAtiva) {
        brigadeiros.add(new Brigadeiro());
        totalFood += 1;
      }
    }

    if (estadoJogo == "MapaCoveiro") {
      if (brigadeiros.size() == 0 && foodIndex >= 0 && foodIndex <= 4) {
        indexRandomBrigadeiroMapaBoss = PApplet.parseInt(random(0, valoresXMapaCoveiro.length));
        brigadeiros.add(new Brigadeiro(valoresXMapaCoveiro[indexRandomBrigadeiroMapaBoss], valoresYMapaCoveiro[indexRandomBrigadeiroMapaBoss]));
        totalFood += 1;
      }
    }

    if (estadoJogo == "MapaFazendeiro") {
      if (brigadeiros.size() == 0 && foodIndex >= 0 && foodIndex <= 4) {
        indexRandomBrigadeiroMapaBoss = PApplet.parseInt(random(0, valoresXMapaFazendeiro.length));
        brigadeiros.add(new Brigadeiro(valoresXMapaFazendeiro[indexRandomBrigadeiroMapaBoss], valoresYMapaFazendeiro[indexRandomBrigadeiroMapaBoss]));
        totalFood += 1;
      }
    }

    if (estadoJogo == "MapaPadre") {
      if (brigadeiros.size() == 0 && foodIndex >= 0 && foodIndex <= 4) {
        indexRandomBrigadeiroMapaBoss = PApplet.parseInt(random(0, valoresXMapaPadre.length));
        brigadeiros.add(new Brigadeiro(valoresXMapaPadre[indexRandomBrigadeiroMapaBoss], valoresYMapaPadre[indexRandomBrigadeiroMapaBoss]));
        totalFood += 1;
      }
    }
  }

  for (int i = brigadeiros.size() - 1; i >= 0; i = i - 1) {
    Brigadeiro b = brigadeiros.get(i);
    b.display();
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      b.update();
    }
    if (b.hasExitScreen() || b.hasCollided()) {
      brigadeiros.remove(b);
      totalFood -= 1;
      hasIndexChanged = false;
      timeToGenerateFood = millis();
    }
    if (b.hasCollided()) {
      heal(amountHealBrigadeiro, b);
    }
  }
}
PImage skeletonHead;

public class CabecaEsqueleto extends Geral {
  private int movementX;

  private int skeletonHeadTarget;

  private boolean isHeadStraight;

  public CabecaEsqueleto(int x, int y, int skeletonHeadTarget) {
    this.setX(x);
    this.setY(y);
    this.skeletonHeadTarget = skeletonHeadTarget;
    
    setSpriteWidth(36);
    setSpriteHeight(89);
    setMovementY(12);
  }

  public void display() {
    image(skeletonHead, getX(), getY());
  }

  public void update() {
    setX(getX() + movementX);
    if (!isHeadStraight) {
      if (getX() > skeletonHeadTarget) {
        movementX = -8;
      } else {
        movementX = 8;
      }
    } else {
      movementX = 0;
    }

    setY(getY() + getMovementY());
  }

  public void checaCabecaEsqueletoReta() {
    if (getX() < skeletonHeadTarget) {
      if (skeletonHeadTarget - getX() < 10) {  
        isHeadStraight = true;
      } else {
        isHeadStraight = false;
      }
    } else {
      if (getX() - skeletonHeadTarget < 10) {  
        isHeadStraight = true;
      } else {
        isHeadStraight = false;
      }
    }
  }
}

ArrayList<CabecaEsqueleto> cabecasEsqueleto;

public void cabecaEsqueleto() {
  for (int i = cabecasEsqueleto.size() - 1; i >= 0; i = i - 1) {
    CabecaEsqueleto c = cabecasEsqueleto.get(i);
    c.update();
    c.display();
    c.checaCabecaEsqueletoReta();
    if (c.hasExitScreen()) {
      cabecasEsqueleto.remove(c);
    }
    if (c.hasCollided()) {
      damage(2);
    }
  }
}
PImage skeletonDog;
PImage skeletonDogShadow;

final int SKELETONDOG = 2;

int[] valoresCachorroXMapaFazendeiro = {70, 382, 695};

public class Cachorro extends Geral {
  public Cachorro(int x, int y) {
    this.setX(x);
    this.setY(y);

    setSpriteImage(skeletonDog);
    setSpriteInterval(55);
    setSpriteWidth(45);
    setSpriteHeight(83);
    setMovementY(8);
  }

  public void display() {
    image (skeletonDogShadow, getX(), getY() + 45);

    super.display();
  }
}

ArrayList<Cachorro> cachorros;

int cachorroC, cachorroL;

int indexRandomCachorroXMapaBoss;

public void cachorro() {
  if (indexInimigos == 2) {
    if (estadoJogo == "MapaFazendeiro") {
      if (cachorros.size() == 0 && !fazendeiroTomouDanoPneu && !fazendeiro.fazendeiroMorreu) {
        for (int i = 0; i < 2; i = i + 1) {
          indexRandomCachorroXMapaBoss = PApplet.parseInt(random(0, valoresCachorroXMapaFazendeiro.length));
          cachorros.add(new Cachorro(valoresCachorroXMapaFazendeiro[indexRandomCachorroXMapaBoss], 0));
        }
      }
    }

    if (estadoJogo == "MapaPadre") { 
      if (cachorros.size() == 0 && totalInimigos < maximoInimigosPadre && !padre.padreMorreu) {
        indexRandomCachorroXMapaBoss = PApplet.parseInt(random(0, valoresInimigosXMapaPadre.length));
        cachorros.add(new Cachorro(valoresInimigosXMapaPadre[indexRandomCachorroXMapaBoss], 0));
        totalInimigos = totalInimigos + 1;
      }
    }

    if (!telaTutorialAndandoAtiva) {
      if (estadoJogo == "SegundoMapa" && cachorros.size() < 2 && totalInimigos < 6) {
        cachorroC = PApplet.parseInt(random(0, 7));
        cachorroL = PApplet.parseInt(random(0, 4));

        if (enemyPositionsSecondMap[cachorroC][cachorroL] == SKELETONDOG) {
          cachorros.add(new Cachorro(100 + (cachorroC * (600 / 7)), -150 - (cachorroL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }

      if (estadoJogo == "TerceiroMapa" && cachorros.size() < 2 && totalInimigos < 6) {
        cachorroC = PApplet.parseInt(random(0, 7));
        cachorroL = PApplet.parseInt(random(0, 4));

        if (enemyPositionsThirdMap[cachorroC][cachorroL] == SKELETONDOG) {
          cachorros.add(new Cachorro(100 + (cachorroC * (600 / 7)), -150 - (cachorroL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }
    }
  }

  for (int i = cachorros.size() - 1; i >= 0; i = i - 1) {
    Cachorro c = cachorros.get(i);
    c.display();
    c.update();
    if (c.hasExitScreen()) {
      totalInimigos = totalInimigos - 1;
      cachorros.remove(c);
    }
    if (c.hasCollided()) {
      damage(2);
    }
  }

  for (int i = cachorros.size() - 1; i >= 0; i = i - 1) {
    Cachorro c = cachorros.get(i);
    for (int j = pasAtaque.size() - 1; j >= 0; j = j - 1) {
      PaAtaque p = pasAtaque.get(j);
      if (p.hasHit(c)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(c.getX(), c.getY());
        cachorros.remove(c);
      }
    }
    for (int j = pedrasAtiradas.size() - 1; j >= 0; j = j - 1) {
      PedraAtirada p = pedrasAtiradas.get(j);
      if (p.hasHit(c)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(c.getX(), c.getY());
        pedrasAtiradas.remove(p);
        cachorros.remove(c);
      }
    }
    for (int j = chicotes.size() - 1; j >= 0; j = j - 1) {
      ChicoteAtaque ch = chicotesAtaque.get(j);
      if (ch.hasHit(c)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(c.getX(), c.getY());
        cachorros.remove(c);
      }
    }
  }
}

public void skeletonDogPositions() {
  enemyPositionsSecondMap [0][0] = SKELETONDOG;
  enemyPositionsSecondMap [1][1] = SKELETONDOG;
  enemyPositionsSecondMap [2][2] = SKELETONDOG;
  enemyPositionsSecondMap [3][0] = SKELETONDOG;
  enemyPositionsSecondMap [4][3] = SKELETONDOG;
  enemyPositionsSecondMap [5][2] = SKELETONDOG;
  enemyPositionsSecondMap [6][2] = SKELETONDOG;

  enemyPositionsThirdMap  [1][0] = SKELETONDOG;
  enemyPositionsThirdMap  [3][0] = SKELETONDOG;
  enemyPositionsThirdMap  [5][2] = SKELETONDOG;
  enemyPositionsThirdMap  [6][1] = SKELETONDOG;
}
PImage[] sceneryImages = new PImage [6];
PImage[] bossSceneryImages =  new PImage [3];

PImage door;
PImage fence;

int sceneryMovement = 2;

public class Cenario {
  private int sceneryX;
  private int sceneryY;

  private int sceneryIndex;

  public Cenario(int sceneryX, int sceneryY, int sceneryIndex) {
    this.sceneryX = sceneryX;
    this.sceneryY = sceneryY;
    this.sceneryIndex = sceneryIndex;
  }

  public void display() {
    image (sceneryImages[sceneryIndex], sceneryX, sceneryY);
  }

  public void update() {
    if (sceneryY > height) {
      sceneryY = -600;
    }
    
    sceneryY = sceneryY + sceneryMovement;
  }
}

ArrayList<Cenario> cenarios;

public void cenario() {
  for (Cenario c : cenarios) {
    c.update();
    c.display();
  }
}
PImage whip;
PImage whipShadow;

public class Chicote extends Geral {
  public Chicote() {
    setX(PApplet.parseInt(random(100, 599)));
    setY(PApplet.parseInt(random(-300, -1000)));

    setSpriteImage(whip);
    setSpriteInterval(75);
    setSpriteWidth(101);
    setSpriteHeight(91);
    setMovementY(sceneryMovement);
  }

  public Chicote(int x, int y) {
    this.setX(x);
    this.setY(y);

    setSpriteImage(whip);
    setSpriteInterval(75);
    setSpriteWidth(101);
    setSpriteHeight(91);
    setMovementY(sceneryMovement);
  }

  public void display() {
    image (whipShadow, getX() + 10, getY() + 76);

    super.display();
  }
}

ArrayList<Chicote> chicotes;

int indexRandomChicoteMapaBoss;

public void chicote() {
  if (totalArmas == 0 && millis() > tempoGerarArma + 15000) {
    if (estadoJogo == "TerceiroMapa") {
      if (chicotes.size() == 0 && indexArma >= 5 && indexArma <= 9 && !telaTutorialAndandoAtiva) {
        chicotes.add(new Chicote());
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "MapaPadre") {
      if (chicotes.size() == 0 && indexArma >= 5 && indexArma <= 9) {
        indexRandomChicoteMapaBoss = PApplet.parseInt(random(0, valoresXMapaPadre.length));
        chicotes.add(new Chicote(valoresXMapaPadre[indexRandomChicoteMapaBoss], valoresYMapaPadre[indexRandomChicoteMapaBoss]));
        totalArmas = totalArmas + 1;
      }
    }
  }

  for (int i = chicotes.size() - 1; i >= 0; i = i - 1) {
    Chicote c = chicotes.get(i);
    if (estadoJogo == "TerceiroMapa") {
      c.update();
    }
    c.display();
    if (c.hasExitScreen() || c.hasCollided()) {
      chicotes.remove(c);
    }
    if (c.hasCollided()) {
      tempoGerarArma = millis();
      item = 3;
      totalItem = 10;
      armaGerada = false;
    }
  }
}
PImage whipAttack;

public class ChicoteAtaque extends Arma {
  public ChicoteAtaque() {
    setX(jLeiteX - 70);
    setY(jLeiteY - 140);

    setSpriteImage(whipAttack);
    setSpriteInterval(110);
    setSpriteWidth(234);
    setSpriteHeight(278);

    setDeleteWeapon(false);
    setDamageBoss(false);

    setFirstCollisionX(jLeiteX + 56);
    setSecondCollisionX(jLeiteX + 50);
    setFirstCollisionY(jLeiteY);
    setSecondCollisionY(jLeiteY - 140);
  }
}

ArrayList<ChicoteAtaque> chicotesAtaque;

boolean umChicote;

public void chicoteAtaque() {
  if (jLeiteUsoItem) {
    if (chicotesAtaque.size() == 0 && item == 3 && totalItem > 0 && !umChicote) {
      chicotesAtaque.add(new ChicoteAtaque());
      totalItem = totalItem - 1;
      umChicote = true;
    }
  }

  for (int i = chicotesAtaque.size() - 1; i >= 0; i = i - 1) {
    ChicoteAtaque c = chicotesAtaque.get(i);
    c.display();
    if (c.getDeleteWeapon()) {
      chicotesAtaque.remove(c);
    }

    if (estadoJogo == "MapaPadre") {
      if (c.hasHitPadre() && !c.getDamageBoss()) {
        if (vidaPadreAtual > 0) {
          if (sonsAtivos) {
            indexRandomSomPadreTomandoDano = PApplet.parseInt(random(0, sonsPadreTomandoDano.length));
            sonsPadreTomandoDano[indexRandomSomPadreTomandoDano].rewind();
            sonsPadreTomandoDano[indexRandomSomPadreTomandoDano].play();
          }
          vidaPadreAtual = vidaPadreAtual - 2;
          c.setDamageBoss(true);
        } else {
          if (sonsAtivos) {
            indexRandomSomPadreTomandoDano = PApplet.parseInt(random(0, sonsPadreRaivaTomandoDano.length));
            sonsPadreRaivaTomandoDano[indexRandomSomPadreTomandoDano].rewind();
            sonsPadreRaivaTomandoDano[indexRandomSomPadreTomandoDano].play();
          }
          vidaPadreRaivaAtual = vidaPadreRaivaAtual - 2;
          c.setDamageBoss(true);
        }
      }
    }
  }
}
PImage foodShadow;

int timeToGenerateFood;
int foodIndex;

int totalFood;

boolean hasIndexChanged;

public void foodAll() {
  generateIndex();
  coxinha();
  brigadeiro();
  queijo();
}

public void generateIndex() {
  if (!telaTutorialAndandoAtiva) {
    if (!hasIndexChanged) {
      foodIndex = PApplet.parseInt(random(0, 10));
      hasIndexChanged = true;
    }
  }
}

public class Comida extends Geral {
  private int amountRecovered = 0;
  
  public int getAmountRecovered(){
    return amountRecovered;
  }
  
  public void setAmountRecovered(int amountRecovered){
    this.amountRecovered = amountRecovered;
  }
}

public void heal(int amount, Comida c) {
  while (vidaJLeiteAtual < vidaJleiteMax && c.amountRecovered < amount) {
    c.amountRecovered += 1;
    vidaJLeiteAtual += 1;
  }
}
PImage skeletonCrow;
PImage skeletonCrowShadow;

public class Corvo extends Geral {
  private int targetX = jLeiteX;

  private int newTargetInterval;

  private boolean hasNewTarget;

  public Corvo() {
    setX(PApplet.parseInt(random(100, width - 163)));
    setY(PApplet.parseInt(random(-300, -1000)));

    setSpriteImage(skeletonCrow);
    setSpriteInterval(75);
    setSpriteWidth(121);
    setSpriteHeight(86);
    setMovementY(3);
  }

  public Corvo(int x, int y) {
    this.setX(x);
    this.setY(y);

    setSpriteImage(skeletonCrow);
    setSpriteInterval(75);
    setSpriteWidth(121);
    setSpriteHeight(86);
    setMovementY(4);
  }

  public void display() {
    super.display();

    image(skeletonCrowShadow, getX() + 24, getY() + 86);
  }  

  public void updateTarget() {
    if (getY() > 0) {
      if (!hasNewTarget) {
        targetX = jLeiteX;
        newTargetInterval = millis();
        hasNewTarget = true;
      }

      if (millis() > newTargetInterval + 750) {
        hasNewTarget = false;
      }
    }
  }

  public void update() {
    if (getX() < targetX) {
      setX(getX() + 3);
    }
    if (getX() > targetX) {
      setX(getX() - 3);
    }

    super.update();
  }

  public boolean hasCollided() {
    if (getX() + 95 > jLeiteX && getX() + 25 < jLeiteX + 63 && getY() + 86 > jLeiteY && getY() < jLeiteY + 126) {
      return true;
    } else {
      return false;
    }
  }
}

ArrayList<Corvo> corvos;

int indexRandomCorvoXMapaBoss;

public void corvo() {
  if (indexInimigos == 3) {
    if (estadoJogo == "MapaPadre") {
      if (corvos.size() == 0 && totalInimigos < maximoInimigosPadre && !padre.padreMorreu) {
        indexRandomCorvoXMapaBoss = PApplet.parseInt(random(0, valoresInimigosXMapaPadre.length));
        corvos.add(new Corvo(valoresInimigosXMapaPadre[indexRandomCorvoXMapaBoss], 0));
      }
    }

    if (!telaTutorialAndandoAtiva) {
      if (estadoJogo == "SegundoMapa" && corvos.size() < 2) {
        corvos.add(new Corvo());
      }

      if (estadoJogo == "TerceiroMapa" && corvos.size() < 2) {
        corvos.add(new Corvo());
      }
    }
  }

  for (int i = corvos.size() - 1; i >= 0; i = i - 1) {
    Corvo c = corvos.get(i);
    c.updateTarget();
    c.update();
    c.display();
    if (c.hasExitScreen()) {
      corvos.remove(c);
    }
    if (c.hasCollided()) {
      damage(3);
    }
  }

  for (int i = corvos.size() - 1; i >= 0; i = i - 1) {
    Corvo c = corvos.get(i);
    for (int j = pasAtaque.size() - 1; j >= 0; j = j - 1) {
      PaAtaque p = pasAtaque.get(j);
      if (p.hasHitCrow(c)) {
        hitInimigos(c.getX(), c.getY());
        corvos.remove(c);
      }
    }
    for (int j = pedrasAtiradas.size() - 1; j >= 0; j = j - 1) {
      PedraAtirada p = pedrasAtiradas.get(j);
      if (p.hasHit(c)) {
        hitInimigos(c.getX(), c.getY());
        pedrasAtiradas.remove(p);
        corvos.remove(c);
      }
    }
    for (int j = chicotes.size() - 1; j >= 0; j = j - 1) {
      ChicoteAtaque ch = chicotesAtaque.get(j);
      if (ch.hasHit(c)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(c.getX(), c.getY());
        corvos.remove(c);
      }
    }
  }
}
PImage coxinha;

public class Coxinha extends Comida {
  public Coxinha(int x, int y) {
    this.setX(x);
    this.setY(y);

    setSpriteImage(coxinha);
    setSpriteInterval(75);
    setSpriteWidth(28);
    setSpriteHeight(30);
    setMovementY(1);

    setAmountRecovered(0);
  }

  public Coxinha() {
    setX(PApplet.parseInt(random(200, 500)));
    setY(PApplet.parseInt(random(-300, -1000)));

    setSpriteImage(coxinha);
    setSpriteInterval(75);
    setSpriteWidth(28);
    setSpriteHeight(30);
    setMovementY(1);

    setAmountRecovered(0);
  }

  public void display() {
    image (foodShadow, getX(), getY() + 20);

    super.display();
  }
}

ArrayList<Coxinha> coxinhas;

int indexRandomCoxinhaMapaBoss;

int amountHealCoxinha = 5;

public void coxinha() {
  if (totalFood < 1 && hasIndexChanged && millis() > timeToGenerateFood + 10000) {
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      if (coxinhas.size() == 0 && foodIndex >= 8 && foodIndex <= 9 && !telaTutorialAndandoAtiva) {
        coxinhas.add(new Coxinha());
        totalFood += 1;
      }
    }

    if (estadoJogo == "MapaCoveiro") {
      if (coxinhas.size() == 0 && foodIndex >= 8 && foodIndex <= 9) {
        indexRandomCoxinhaMapaBoss = PApplet.parseInt(random(0, valoresXMapaCoveiro.length));
        coxinhas.add(new Coxinha(valoresXMapaCoveiro[indexRandomCoxinhaMapaBoss], valoresYMapaCoveiro[indexRandomCoxinhaMapaBoss]));
        totalFood += 1;
      }
    }

    if (estadoJogo == "MapaFazendeiro") {
      if (coxinhas.size() == 0 && foodIndex >= 8 && foodIndex <= 9) {
        indexRandomCoxinhaMapaBoss = PApplet.parseInt(random(0, valoresXMapaFazendeiro.length));
        coxinhas.add(new Coxinha(valoresXMapaFazendeiro[indexRandomCoxinhaMapaBoss], valoresYMapaFazendeiro[indexRandomCoxinhaMapaBoss]));
        totalFood += 1;
      }
    }

    if (estadoJogo == "MapaPadre") {
      if (coxinhas.size() == 0 && foodIndex >= 8 && foodIndex <= 9) {
        indexRandomCoxinhaMapaBoss = PApplet.parseInt(random(0, valoresXMapaPadre.length));
        coxinhas.add(new Coxinha(valoresXMapaPadre[indexRandomCoxinhaMapaBoss], valoresYMapaPadre[indexRandomCoxinhaMapaBoss]));
        totalFood += 1;
      }
    }
  }

  for (int i = coxinhas.size() - 1; i >= 0; i = i - 1) {
    Coxinha c = coxinhas.get(i);
    c.display();
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      c.update();
    }
    if (c.hasExitScreen() || c.hasCollided()) {
      coxinhas.remove(c);
      totalFood -= 1;
      hasIndexChanged = false;
      timeToGenerateFood = millis();
    }
    if (c.hasCollided()) {
      heal(amountHealCoxinha, c);
    }
  }
}
PImage skeleton;
PImage skeletonShadow;

final int SKELETON = 0;

int[] valoresEsqueletoXMapaCoveiro = {200, 520};

public class Esqueleto extends Geral {
  public Esqueleto(int x, int y) {
    this.setX(x);
    this.setY(y);

    setSpriteImage(skeleton);
    setSpriteInterval(155);
    setSpriteWidth(76);
    setSpriteHeight(126);
    setMovementY(3);
  }

  public void display() {
    image (skeletonShadow, getX() + 16, getY() + 114);

    super.display();
  }
}

ArrayList<Esqueleto> esqueletos;

int esqueletoC, esqueletoL;

int indexRandomEsqueletoXMapaBoss;

public void esqueleto() {
  if (indexInimigos == 0) {
    if (estadoJogo == "MapaCoveiro") {
      if (esqueletos.size() == 0 && !coveiro.coveiroMorreu && !coveiroTomouDanoAgua) {
        for (int i = 0; i < 2; i = i + 1) {
          indexRandomEsqueletoXMapaBoss = PApplet.parseInt(random(0, 2));
          esqueletos.add(new Esqueleto(valoresEsqueletoXMapaCoveiro[indexRandomEsqueletoXMapaBoss], 0));
        }
      }
    }

    if (estadoJogo == "MapaPadre") { 
      if (esqueletos.size() == 0 && totalInimigos < maximoInimigosPadre && !padre.padreMorreu) {
        indexRandomEsqueletoXMapaBoss = PApplet.parseInt(random(0, valoresInimigosXMapaPadre.length));
        esqueletos.add(new Esqueleto(valoresInimigosXMapaPadre[indexRandomEsqueletoXMapaBoss], 0));
        totalInimigos = totalInimigos + 1;
      }
    }

    if (!telaTutorialAndandoAtiva) {
      if (estadoJogo == "PrimeiroMapa" && esqueletos.size() < 2 && totalInimigos < 6) {
        esqueletoC = PApplet.parseInt(random(0, 7));
        esqueletoL = PApplet.parseInt(random(0, 4));

        if (enemyPositionsFirstMap[esqueletoC][esqueletoL] == SKELETON) {
          esqueletos.add(new Esqueleto(100 + (esqueletoC * (600 / 7)), -150 - (esqueletoL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }

      if (estadoJogo == "SegundoMapa" && esqueletos.size() < 2 && totalInimigos < 6) {
        esqueletoC = PApplet.parseInt(random(0, 7));
        esqueletoL = PApplet.parseInt(random(0, 4));

        if (enemyPositionsSecondMap[esqueletoC][esqueletoL] == SKELETON) {
          esqueletos.add(new Esqueleto(100 + (esqueletoC * (600 / 7)), -150 - (esqueletoL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }

      if (estadoJogo == "TerceiroMapa" && esqueletos.size() < 2 && totalInimigos < 6) {
        esqueletoC = PApplet.parseInt(random(0, 7));
        esqueletoL = PApplet.parseInt(random(0, 4));

        if (enemyPositionsThirdMap[esqueletoC][esqueletoL] == SKELETON) {
          esqueletos.add(new Esqueleto(100 + (esqueletoC * (600 / 7)), -150 - (esqueletoL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }
    }
  }

  for (int i = esqueletos.size() - 1; i >= 0; i = i - 1) {
    Esqueleto e = esqueletos.get(i);
    e.update();
    e.display();
    if (e.hasExitScreen()) {
      totalInimigos = totalInimigos - 1;
      esqueletos.remove(e);
    }
    if (e.hasCollided()) {
      damage(2);
    }
  }

  for (int i = esqueletos.size() - 1; i >= 0; i = i - 1) {
    Esqueleto e = esqueletos.get(i);
    for (int j = pasAtaque.size() - 1; j >= 0; j = j - 1) {
      PaAtaque p = pasAtaque.get(j);
      if (p.hasHit(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.getX(), e.getY());
        esqueletos.remove(e);
      }
    }
    for (int j = pedrasAtiradas.size() - 1; j >= 0; j = j - 1) {
      PedraAtirada p = pedrasAtiradas.get(j);
      if (p.hasHit(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.getX(), e.getY());
        pedrasAtiradas.remove(p);
        esqueletos.remove(e);
      }
    }
    for (int j = chicotes.size() - 1; j >= 0; j = j - 1) {
      ChicoteAtaque c = chicotesAtaque.get(j);
      if (c.hasHit(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.getX(), e.getY());
        esqueletos.remove(e);
      }
    }
  }
}

public void skeletonPositions() {
  enemyPositionsFirstMap  [0][0] = SKELETON;
  enemyPositionsFirstMap  [1][2] = SKELETON;
  enemyPositionsFirstMap  [2][0] = SKELETON;
  enemyPositionsFirstMap  [3][2] = SKELETON;
  enemyPositionsFirstMap  [4][0] = SKELETON;
  enemyPositionsFirstMap  [5][2] = SKELETON;
  enemyPositionsFirstMap  [6][0] = SKELETON;

  enemyPositionsSecondMap [0][1] = SKELETON;
  enemyPositionsSecondMap [1][3] = SKELETON;
  enemyPositionsSecondMap [2][0] = SKELETON;
  enemyPositionsSecondMap [3][2] = SKELETON;
  enemyPositionsSecondMap [4][0] = SKELETON;
  enemyPositionsSecondMap [5][0] = SKELETON;
  enemyPositionsSecondMap [6][0] = SKELETON;

  enemyPositionsThirdMap  [0][3] = SKELETON;
  enemyPositionsThirdMap  [2][0] = SKELETON;
  enemyPositionsThirdMap  [4][2] = SKELETON;
  enemyPositionsThirdMap  [6][3] = SKELETON;
}
PImage kickingSkeleton;
PImage headlessKickingSkeleton;
PImage kickingSkeletonShadow;

final int KICKINGSKELETON = 1;

public class EsqueletoChute extends Geral {
  private PImage kickingSkeletonSprite;

  private int movementX;

  private int changeDirectionDelay;

  private int kickingSkeletonStep;
  private int kickingSkeletonSpriteTime;

  private boolean hasLostHead;
  private boolean gatilhoEsqueletoCabeca, esqueletoCabecaSaiu;

  public EsqueletoChute(int x, int y) {
    this.setX(x);
    this.setY(y);

    setSpriteImage(headlessKickingSkeleton);
    setSpriteInterval(200);
    setSpriteWidth(48);
    setSpriteHeight(74);
  }

  public void display() {
    image (kickingSkeletonShadow, getX() + 1, getY() + 50);

    if (!hasLostHead) {
      if (millis() > kickingSkeletonSpriteTime + 200) { 
        if (getY() < 0) {
          kickingSkeletonSprite = kickingSkeleton.get(0, 0, 49, 74);
        } else {
          kickingSkeletonSprite = kickingSkeleton.get(kickingSkeletonStep, 0, 49, 74); 
          kickingSkeletonStep = kickingSkeletonStep % 245 + 49;
        }
        image(kickingSkeletonSprite, getX(), getY()); 
        kickingSkeletonSpriteTime = millis();
      } else {
        image(kickingSkeletonSprite, getX(), getY());
      }

      if (kickingSkeletonStep == 196) {
        esqueletoCabecaSaiu = true;
        gatilhoEsqueletoCabeca = true;
      }

      if (kickingSkeletonStep == kickingSkeleton.width) {
        hasLostHead = true;
        kickingSkeletonStep = 0;
      }
    } else {
      super.display();
    }
  }

  public void update() {
    setX(getX() + movementX);
    setY(getY() + getMovementY());
  }

  public void updateMovement() {
    if (!hasLostHead) {
      setMovementY(PApplet.parseInt(sceneryMovement));
      movementX = 0;
    } else {
      setMovementY(PApplet.parseInt(sceneryMovement) + 1);
      if (millis() > changeDirectionDelay + 250) {
        movementX = PApplet.parseInt(random(-5, 5));
        changeDirectionDelay = millis();
      }
    }
  }
}

ArrayList<EsqueletoChute> esqueletosChute;

int esqueletoChuteC, esqueletoChuteL;

int indexRandomEsqueletoChuteXMapaBoss;

public void esqueletoChute() {
  if (indexInimigos == 1) {
    if (estadoJogo == "MapaPadre") { 
      if (esqueletosChute.size() == 0 && totalInimigos < maximoInimigosPadre && !padre.padreMorreu) {
        indexRandomEsqueletoChuteXMapaBoss = PApplet.parseInt(random(0, valoresInimigosXMapaPadre.length));
        esqueletosChute.add(new EsqueletoChute(valoresInimigosXMapaPadre[indexRandomEsqueletoChuteXMapaBoss], 0));
        totalInimigos = totalInimigos + 1;
      }
    }

    if (!telaTutorialAndandoAtiva) {
      if (estadoJogo == "PrimeiroMapa" && esqueletosChute.size() < 2 && totalInimigos < 6) {
        esqueletoChuteC = PApplet.parseInt(random(0, 7));
        esqueletoChuteL = PApplet.parseInt(random(0, 4));

        if (enemyPositionsFirstMap[esqueletoChuteC][esqueletoChuteL] == KICKINGSKELETON) {
          esqueletosChute.add(new EsqueletoChute(100 + (esqueletoChuteC * (600 / 7)), -150 - (esqueletoChuteL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }
      if (estadoJogo == "SegundoMapa" && esqueletosChute.size() < 2 && totalInimigos < 6) {
        esqueletoChuteC = PApplet.parseInt(random(0, 7));
        esqueletoChuteL = PApplet.parseInt(random(0, 4));

        if (enemyPositionsSecondMap[esqueletoChuteC][esqueletoChuteL] == KICKINGSKELETON) {
          esqueletosChute.add(new EsqueletoChute(100 + (esqueletoChuteC * (600 / 7)), -150 - (esqueletoChuteL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }
      if (estadoJogo == "TerceiroMapa" && esqueletosChute.size() < 2 && totalInimigos < 6) {
        esqueletoChuteC = PApplet.parseInt(random(0, 7));
        esqueletoChuteL = PApplet.parseInt(random(0, 4));

        if (enemyPositionsThirdMap[esqueletoChuteC][esqueletoChuteL] == KICKINGSKELETON) {
          esqueletosChute.add(new EsqueletoChute(100 + (esqueletoChuteC * (600 / 7)), -150 - (esqueletoChuteL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }
    }
  }

  for (int i = esqueletosChute.size() - 1; i >= 0; i = i - 1) {
    EsqueletoChute e = esqueletosChute.get(i);
    e.updateMovement();
    e.update();
    e.display();
    if (e.esqueletoCabecaSaiu) {
      cabecasEsqueleto.add(new CabecaEsqueleto(e.getX(), e.getY(), jLeiteX));
      e.esqueletoCabecaSaiu = false;
    }
    if (e.hasExitScreen()) {
      totalInimigos = totalInimigos - 1;
      esqueletosChute.remove(e);
    }
    if (e.hasCollided()) {
      damage(2);
    }
  }

  for (int i = esqueletosChute.size() - 1; i >= 0; i = i - 1) {
    EsqueletoChute e = esqueletosChute.get(i);
    for (int j = pasAtaque.size() - 1; j >= 0; j = j - 1) {
      PaAtaque p = pasAtaque.get(j);
      if (p.hasHit(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.getX() - 40, e.getY() - 20);
        esqueletosChute.remove(e);
      }
    }
    for (int j = pedrasAtiradas.size() - 1; j >= 0; j = j - 1) {
      PedraAtirada p = pedrasAtiradas.get(j);
      if (p.hasHit(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.getX() - 40, e.getY() - 20);
        pedrasAtiradas.remove(p);
        esqueletosChute.remove(e);
      }
    }
    for (int j = chicotes.size() - 1; j >= 0; j = j - 1) {
      ChicoteAtaque c = chicotesAtaque.get(j);
      if (c.hasHit(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.getX() - 40, e.getY() - 20);
        esqueletosChute.remove(e);
      }
    }
  }
}

public void kickingSkeletonPositions() {
  enemyPositionsFirstMap  [0][2] = KICKINGSKELETON;
  enemyPositionsFirstMap  [1][0] = KICKINGSKELETON;
  enemyPositionsFirstMap  [2][2] = KICKINGSKELETON;
  enemyPositionsFirstMap  [3][0] = KICKINGSKELETON;
  enemyPositionsFirstMap  [4][2] = KICKINGSKELETON;
  enemyPositionsFirstMap  [5][0] = KICKINGSKELETON;
  enemyPositionsFirstMap  [6][2] = KICKINGSKELETON;

  enemyPositionsSecondMap [0][2] = KICKINGSKELETON;
  enemyPositionsSecondMap [1][0] = KICKINGSKELETON;
  enemyPositionsSecondMap [2][3] = KICKINGSKELETON;
  enemyPositionsSecondMap [3][3] = KICKINGSKELETON;
  enemyPositionsSecondMap [4][2] = KICKINGSKELETON;
  enemyPositionsSecondMap [5][3] = KICKINGSKELETON;
  enemyPositionsSecondMap [6][3] = KICKINGSKELETON;

  enemyPositionsThirdMap  [0][2] = KICKINGSKELETON;
  enemyPositionsThirdMap  [1][3] = KICKINGSKELETON;
  enemyPositionsThirdMap  [2][1] = KICKINGSKELETON;
  enemyPositionsThirdMap  [4][3] = KICKINGSKELETON;
  enemyPositionsThirdMap  [5][1] = KICKINGSKELETON;
}
PImage redSkeleton;
PImage redSkeletonShadow;

final int REDSKELETON = 3;

public class EsqueletoRaiva extends Geral {
  private int movementX = 3;

  public EsqueletoRaiva(int x, int y) {
    this.setX(x);
    this.setY(y);

    setSpriteImage(redSkeleton);
    setSpriteInterval(75);
    setSpriteWidth(76);
    setSpriteHeight(126);
    setMovementY(3);
  }

  public void display() {
    image(redSkeletonShadow, getX() + 16, getY() + 114);

    super.display();
  }

  public void update() {
    setX(getX() + movementX);

    if (getX() < 100) {
      movementX = 3;
    }
    if (getX() + 30 > 700) {
      movementX = -3;
    } 

    super.update();
  }
}

ArrayList<EsqueletoRaiva> esqueletosRaiva;

int esqueletoRaivaC, esqueletoRaivaL;

int indexRandomEsqueletoRaivaXMapaBoss;

public void esqueletoRaiva() {
  if (indexInimigos == 4) {
    if (estadoJogo == "MapaPadre") { 
      if (esqueletosRaiva.size() == 0 && totalInimigos < maximoInimigosPadre && !padre.padreMorreu) {
        indexRandomEsqueletoRaivaXMapaBoss = PApplet.parseInt(random(0, valoresInimigosXMapaPadre.length));
        esqueletosRaiva.add(new EsqueletoRaiva(valoresInimigosXMapaPadre[indexRandomEsqueletoRaivaXMapaBoss], 0));
        totalInimigos = totalInimigos + 1;
      }
    }

    if (!telaTutorialAndandoAtiva) {
      if (estadoJogo == "TerceiroMapa" && esqueletosRaiva.size() < 2 && totalInimigos < 6) {
        esqueletoRaivaC = PApplet.parseInt(random(0, 7));
        esqueletoRaivaL = PApplet.parseInt(random(0, 4));

        if (enemyPositionsThirdMap[esqueletoRaivaC][esqueletoRaivaL] == REDSKELETON) {
          esqueletosRaiva.add(new EsqueletoRaiva(100 + (esqueletoRaivaC * (600 / 7)), -150 - (esqueletoRaivaL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }
    }
  }


  for (int i = esqueletosRaiva.size() - 1; i >= 0; i = i - 1) {
    EsqueletoRaiva e = esqueletosRaiva.get(i);
    e.display();
    e.update();
    if (e.hasExitScreen()) {
      totalInimigos = totalInimigos - 1;
      esqueletosRaiva.remove(e);
    }
    if (e.hasCollided()) {
      damage(3);
    }
  }
  for (int i = esqueletosRaiva.size() - 1; i >= 0; i = i - 1) {
    EsqueletoRaiva e = esqueletosRaiva.get(i);
    for (int j = pasAtaque.size() - 1; j >= 0; j = j - 1) {
      PaAtaque p = pasAtaque.get(j);
      if (p.hasHit(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.getX(), e.getY());
        esqueletosRaiva.remove(e);
      }
    }
    for (int j = pedrasAtiradas.size() - 1; j >= 0; j = j - 1) {
      PedraAtirada p = pedrasAtiradas.get(j);
      if (p.hasHit(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.getX(), e.getY());
        pedrasAtiradas.remove(p);
        esqueletosRaiva.remove(e);
      }
    }
    for (int j = chicotes.size() - 1; j >= 0; j = j - 1) {
      ChicoteAtaque ch = chicotesAtaque.get(j);
      if (ch.hasHit(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.getX(), e.getY());
        esqueletosRaiva.remove(e);
      }
    }
  }
}

public void redSkeletonPositions() {
  enemyPositionsThirdMap[0][0] = REDSKELETON;
  enemyPositionsThirdMap[1][2] = REDSKELETON;
  enemyPositionsThirdMap[2][3] = REDSKELETON;
  enemyPositionsThirdMap[3][2] = REDSKELETON;
  enemyPositionsThirdMap[4][1] = REDSKELETON;
  enemyPositionsThirdMap[5][0] = REDSKELETON;
  enemyPositionsThirdMap[6][2] = REDSKELETON;
}
public class Geral {
  private PImage sprite;
  private PImage spriteImage;

  private int x;
  private int y;
  private int movementY;

  private int step;
  private int spriteTime;
  private int spriteInterval;

  private int spriteWidth;
  private int spriteHeight;

  public PImage getSprite() {
    return sprite;
  }

  public void setSprite(PImage sprite) {
    this.sprite = sprite;
  }

  public PImage getSpriteImage() {
    return spriteImage;
  }

  public void setSpriteImage(PImage enemy) {
    this.spriteImage = enemy;
  }

  public int getX() {
    return x;
  }

  public void setX(int x) {
    this.x = x;
  }

  public int getY() {
    return y;
  }

  public void setY(int y) {
    this.y = y;
  }

  public int getMovementY() {
    return movementY;
  }

  public void setMovementY(int movementY) {
    this.movementY = movementY;
  }

  public int getStep() {
    return step;
  }

  public void setStep(int step) {
    this.step = step;
  }

  public int getSpriteTime() {
    return spriteTime;
  }

  public void setSpriteTime(int spriteTime) {
    this.spriteTime = spriteTime;
  }

  public int getSpriteInterval() {
    return spriteInterval;
  }

  public void setSpriteInterval(int spriteInterval) {
    this.spriteInterval = spriteInterval;
  }

  public int getSpriteWidth() {
    return spriteWidth;
  }

  public void setSpriteWidth(int spriteWidth) {
    this.spriteWidth = spriteWidth;
  }

  public int getSpriteHeight() {
    return spriteHeight;
  }

  public void setSpriteHeight(int spriteHeight) {
    this.spriteHeight = spriteHeight;
  }

  public void display() {
    if (millis() > spriteTime + spriteInterval) {
      sprite = spriteImage.get(step, 0, spriteWidth, spriteHeight);
      step = step % spriteImage.width + spriteWidth;
      image(sprite, x, y);
      spriteTime = millis();
    } else {
      image(sprite, x, y);
    }

    if (step == spriteImage.width) {
      step = 0;
    }
  }

  public void update() {
    y = y + movementY;
  }

  public boolean hasCollided() {
    if (x + spriteWidth >= jLeiteX && x <= jLeiteX + 63 && y + spriteHeight >= jLeiteY && y <= jLeiteY + 126) {
      return true;
    }

    return false;
  }

  public boolean hasExitScreen() {
    if (y > height) {
      return true;
    }

    return false;
  }
}
PImage hitInimigos, spriteHitInimigos;

int stepHitInimigos;
int tempoSpriteHitInimigos;

boolean hitInimigosMostrando;

public void hitInimigos(float X, float Y) {
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

public void hitBosses(float X, float Y) {
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

public void hitEscudo(float X, float Y) {
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

public void hitCruz(float X, float Y) {
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
int tempoGerarInimigo;
int indexInimigos;

int totalInimigos;
int maximoInimigosPadre = 2;

int[] valoresInimigosXMapaPadre = {25, 350, 679};

public void inimigosTodos() {
  if (!jLeiteMorreu) {
    if (!telaTutorialAndandoAtiva) {
      if (millis() > tempoGerarInimigo + 250) {
        if (estadoJogo == "PrimeiroMapa") {
          indexInimigos = PApplet.parseInt(random(0, 2));
        } 
        if (estadoJogo == "SegundoMapa") {
          indexInimigos = PApplet.parseInt(random(0, 4));
        } 
        if (estadoJogo == "TerceiroMapa") {
          indexInimigos = PApplet.parseInt(random(1, 5));
        } 
        if (estadoJogo == "MapaPadre") {
          indexInimigos = PApplet.parseInt(random(0, 5));
          if (!ataqueLevantemAcontecendo) {
            maximoInimigosPadre = 2;
          } else {
            maximoInimigosPadre = 4;
          }
        }
        tempoGerarInimigo = millis();
      }
    }
  } else {
    indexInimigos = 6;
  }

  esqueleto();
  esqueletoChute();
  cabecaEsqueleto();
  cachorro();
  corvo();
  esqueletoRaiva();
}

public void damage(int amount) {
  if (!jLeiteImune) {
    vidaJLeiteAtual -= amount;
    jLeiteImune = true;
    tempoImune = millis();
  }
}
PImage vidaJLeiteLayout, vidaJLeiteLayoutBackground, vidaJLeiteBarra;

int vidaJLeiteAtual;
int vidaJleiteMax;
int vidaJLeiteMin;

int vidaJLeiteBarraX;

public void vida() {
  image(vidaJLeiteLayoutBackground, 8, 490);

  vidaJLeiteMin = 0;
  vidaJLeiteBarraX = 115;
  while (vidaJLeiteMin < vidaJLeiteAtual) {
    image (vidaJLeiteBarra, vidaJLeiteBarraX, 566);
    vidaJLeiteBarraX = vidaJLeiteBarraX + 12;
    vidaJLeiteMin = vidaJLeiteMin + 1;
  }

  image(vidaJLeiteLayout, 8, 490);
}

AudioPlayer[] sonsMorteJLeite = new AudioPlayer [4];

PImage jLeiteMovimento, spriteJLeiteMovimento; 
PImage jLeiteIdle, spriteJLeiteIdle;
PImage jLeiteItem, spriteJLeiteItem;
PImage jLeiteDanoMovimento, spriteJLeiteDanoMovimento;
PImage jLeiteDanoIdle, spriteJLeiteDanoIdle;
PImage jLeiteMorte, spriteJLeiteMorte;

PImage sombraJLeite;

float tempoItem;
float tempoItemAtivo;

int jLeiteX, jLeiteY; 

int stepJLeiteMovimento, stepJLeiteIdle, stepJLeiteItem, stepJLeiteDanoMovimento, stepJLeiteDanoIdle, stepJLeiteMorte;
int tempoSpriteJLeiteMovimento, tempoSpriteJLeiteIdle, tempoSpriteJLeiteItem, tempoSpriteJLeiteDanoMovimento, tempoSpriteJLeiteDanoIdle, tempoSpriteJLeiteMorte;

int tempoImune;

int tempoMorto;

boolean jLeiteImune;
boolean jLeiteLentidao;

boolean jLeiteDireita, jLeiteEsquerda, jLeiteCima, jLeiteBaixo;

boolean jLeiteUsoItem;
boolean jLeiteUsoItemConfirma;
boolean jLeiteUsoItemContinua;

boolean jLeiteMorreu;
boolean jLeiteMorrendo;

boolean finalMapa;

boolean imortalidade;

public void jLeite() {
  if (imortalidade) {
    vidaJLeiteAtual = 15;
  }

  if (finalMapa) {
    if (jLeiteY + 126 < - 50) {
      if (estadoJogo == "PrimeiroMapa") {
        estadoJogo = ("MapaCoveiro");
        if (temaIgreja.isPlaying()) {
          temaIgreja.pause();
        }
      }
      if (estadoJogo == "SegundoMapa") {
        estadoJogo = ("MapaFazendeiro");
        if (temaFazenda.isPlaying()) {
          temaFazenda.pause();
        }
      }
      if (estadoJogo == "TerceiroMapa") {
        estadoJogo = ("MapaPadre");
        if (temaCidade.isPlaying()) {
          temaCidade.pause();
        }
      }
    }
  }

  if (vidaJLeiteAtual < 0 && !jLeiteMorreu) {
    jLeiteMorreu = true;
    jLeiteMorrendo = true;
    tempoMorto = millis();
    if (temaBoss.isPlaying()) {
      temaCidade.pause();
    }
    if (temaIgreja.isPlaying()) {
      temaCidade.pause();
    }
    if (temaFazenda.isPlaying()) {
      temaCidade.pause();
    }
    if (temaCidade.isPlaying()) {
      temaCidade.pause();
    }
    if (estadoJogo == "MapaCoveiro") {
      if (sonsAtivos) {
        sonsMorteJLeite[0].rewind();
        sonsMorteJLeite[0].play();
      }
    }
    if (estadoJogo == "MapaFazendeiro") {
      if (sonsAtivos) {
        sonsMorteJLeite[1].rewind();
        sonsMorteJLeite[1].play();
      }
    }
    if (estadoJogo == "MapaPadre") {
      if (!padre.padreMudouForma) {
        if (sonsAtivos) {
          sonsMorteJLeite[2].rewind();
          sonsMorteJLeite[2].play();
        }
      } else {
        if (sonsAtivos) {
          sonsMorteJLeite[3].rewind();
          sonsMorteJLeite[3].play();
        }
      }
    }
  }

  if (jLeiteMorreu && millis() > tempoMorto + 2500) {
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      setup();
      estadoJogo = "MenuInicial";
    } else if (estadoJogo == "MapaCoveiro" || estadoJogo == "MapaFazendeiro" || estadoJogo == "MapaPadre") {
      ultimoEstado = estadoJogo;
      estadoJogo = "GameOver";
    }
  }

  if (millis() > tempoImune + 2000) {
    jLeiteImune = false;
  }

  if (!jLeiteMorreu) {
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      if (jLeiteDireita && jLeiteX < width - 163) { 
        jLeiteX = jLeiteX + 3;
      }
      if (jLeiteEsquerda && jLeiteX > 100) {
        jLeiteX = jLeiteX - 3;
      }

      if (!finalMapa) {
        if (jLeiteCima && jLeiteY > 0) {
          jLeiteY = jLeiteY - 3;
        }
      } else {
        if (jLeiteCima) {
          jLeiteY = jLeiteY - 3;
        }
      }

      if (jLeiteBaixo && jLeiteY < height - 126) {
        jLeiteY = jLeiteY + 3;
      }
    }

    if (estadoJogo == "MapaCoveiro" || estadoJogo == "MapaFazendeiro"|| estadoJogo == "MapaPadre") {
      if (!jLeiteLentidao) {
        if (jLeiteDireita && jLeiteX < width - 88) { 
          jLeiteX = jLeiteX + 3;
        }

        if (jLeiteEsquerda && jLeiteX > 25) {
          jLeiteX = jLeiteX - 3;
        }

        if (jLeiteCima && jLeiteY > 75) {
          jLeiteY = jLeiteY - 3;
        }

        if (jLeiteBaixo && jLeiteY < height - 126) {
          jLeiteY = jLeiteY + 3;
        }
      } else {
        if (jLeiteDireita && jLeiteX < width - 88) { 
          jLeiteX = jLeiteX + 1;
        }

        if (jLeiteEsquerda && jLeiteX > 25) {
          jLeiteX = jLeiteX - 1;
        }

        if (jLeiteCima && jLeiteY > 75) {
          jLeiteY = jLeiteY - 1;
        }

        if (jLeiteBaixo && jLeiteY < height - 126) {
          jLeiteY = jLeiteY + 1;
        }
      }
    }

    image(sombraJLeite, jLeiteX + 7, jLeiteY + 112);

    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      if (!jLeiteUsoItem && !jLeiteImune) {
        if (millis() > tempoSpriteJLeiteMovimento + 75) { 
          spriteJLeiteMovimento = jLeiteMovimento.get(stepJLeiteMovimento, 0, 63, 126); 
          stepJLeiteMovimento = stepJLeiteMovimento % 378 + 63;
          image(spriteJLeiteMovimento, jLeiteX, jLeiteY); 
          tempoSpriteJLeiteMovimento = millis();
        } else {
          image(spriteJLeiteMovimento, jLeiteX, jLeiteY);
        }
        if (stepJLeiteMovimento == jLeiteMovimento.width) {
          stepJLeiteMovimento = 0;
        }
      }

      if (jLeiteImune && !jLeiteUsoItem) {
        if (millis() > tempoSpriteJLeiteDanoMovimento + 90) { 
          spriteJLeiteDanoMovimento = jLeiteDanoMovimento.get(stepJLeiteDanoMovimento, 0, 63, 126); 
          stepJLeiteDanoMovimento = stepJLeiteDanoMovimento % 378 + 63;
          image(spriteJLeiteDanoMovimento, jLeiteX, jLeiteY); 
          tempoSpriteJLeiteDanoMovimento = millis();
        } else {
          image(spriteJLeiteDanoMovimento, jLeiteX, jLeiteY);
        }

        if (stepJLeiteDanoMovimento == jLeiteDanoMovimento.width) {
          stepJLeiteDanoMovimento = 0;
        }
      }
    } else {
      if (jLeiteDireita || jLeiteEsquerda || jLeiteCima || jLeiteBaixo) {
        if (!jLeiteUsoItem && !jLeiteImune) {
          if (millis() > tempoSpriteJLeiteMovimento + 75) { 
            spriteJLeiteMovimento = jLeiteMovimento.get(stepJLeiteMovimento, 0, 63, 126); 
            stepJLeiteMovimento = stepJLeiteMovimento % 378 + 63;
            image(spriteJLeiteMovimento, jLeiteX, jLeiteY); 
            tempoSpriteJLeiteMovimento = millis();
          } else {
            image(spriteJLeiteMovimento, jLeiteX, jLeiteY);
          }
          if (stepJLeiteMovimento == jLeiteMovimento.width) {
            stepJLeiteMovimento = 0;
          }
        }

        if (jLeiteImune && !jLeiteUsoItem) {
          if (millis() > tempoSpriteJLeiteDanoMovimento + 90) { 
            spriteJLeiteDanoMovimento = jLeiteDanoMovimento.get(stepJLeiteDanoMovimento, 0, 63, 126); 
            stepJLeiteDanoMovimento = stepJLeiteDanoMovimento % 378 + 63;
            image(spriteJLeiteDanoMovimento, jLeiteX, jLeiteY); 
            tempoSpriteJLeiteDanoMovimento = millis();
          } else {
            image(spriteJLeiteDanoMovimento, jLeiteX, jLeiteY);
          }

          if (stepJLeiteDanoMovimento == jLeiteDanoMovimento.width) {
            stepJLeiteDanoMovimento = 0;
          }
        }
      } else {
        if (!jLeiteUsoItem && !jLeiteImune) {
          if (millis() > tempoSpriteJLeiteIdle + 75) { 
            spriteJLeiteIdle = jLeiteIdle.get(stepJLeiteIdle, 0, 63, 126); 
            stepJLeiteIdle = stepJLeiteIdle % 378 + 63;
            image(spriteJLeiteIdle, jLeiteX, jLeiteY); 
            tempoSpriteJLeiteIdle = millis();
          } else {
            image(spriteJLeiteIdle, jLeiteX, jLeiteY);
          }
          if (stepJLeiteIdle == jLeiteIdle.width) {
            stepJLeiteIdle = 0;
          }
        }

        if (jLeiteImune && !jLeiteUsoItem) {
          if (millis() > tempoSpriteJLeiteDanoIdle + 90) { 
            spriteJLeiteDanoIdle = jLeiteDanoIdle.get(stepJLeiteDanoIdle, 0, 63, 126); 
            stepJLeiteDanoIdle = stepJLeiteDanoIdle % 378 + 63;
            image(spriteJLeiteDanoIdle, jLeiteX, jLeiteY); 
            tempoSpriteJLeiteDanoIdle = millis();
          } else {
            image(spriteJLeiteDanoIdle, jLeiteX, jLeiteY);
          }

          if (stepJLeiteDanoIdle == jLeiteDanoIdle.width) {
            stepJLeiteDanoIdle = 0;
          }
        }
      }
    }

    if (jLeiteUsoItem) {
      if (item != 0) {
        if (millis() > tempoSpriteJLeiteItem + 90) { 
          spriteJLeiteItem = jLeiteItem.get(stepJLeiteItem, 0, 94, 126); 
          stepJLeiteItem = stepJLeiteItem % 282 + 94;
          image(spriteJLeiteItem, jLeiteX, jLeiteY); 
          tempoSpriteJLeiteItem = millis();
        } else {
          image(spriteJLeiteItem, jLeiteX, jLeiteY);
        }

        if (stepJLeiteItem == jLeiteItem.width) {
          stepJLeiteItem = 0;
        }

        jLeiteUsoItemContinua = true;
      }
    }

    if (jLeiteUsoItemContinua && millis() > tempoItem + 270) {
      jLeiteUsoItem = false;
      if (millis() > tempoItemAtivo + 870) {
        jLeiteUsoItemConfirma = false;
        jLeiteUsoItemContinua = false;
      }
    }
  } else {
    if (jLeiteMorrendo) {
      if (millis() > tempoSpriteJLeiteMorte + 450) {
        spriteJLeiteMorte = jLeiteMorte.get(stepJLeiteMorte, 0, 126, 126);
        stepJLeiteMorte = stepJLeiteMorte % 378 + 126;
        image(spriteJLeiteMorte, jLeiteX - 31, jLeiteY);
        tempoSpriteJLeiteMorte = millis();
      } else {
        image(spriteJLeiteMorte, jLeiteX - 31, jLeiteY);
      }

      if (stepJLeiteMorte == jLeiteMorte.width) {
        stepJLeiteMorte = 0;
        jLeiteMorrendo = false;
      }
    } else {
      spriteJLeiteMorte = jLeiteMorte.get(252, 0, 378, 125);
      image(spriteJLeiteMorte, jLeiteX - 31, jLeiteY);
    }
  }
}
public void jogando() {
  if (estadoJogo == "PrimeiroMapa") {
    if (musicasAtivas) {
      temaIgreja.play();
    }
  }

  if (estadoJogo == "SegundoMapa") {
    if (musicasAtivas) {
      temaFazenda.play();
    }
  }

  if (estadoJogo == "TerceiroMapa") {
    if (musicasAtivas) {
      temaCidade.play();
    }
  }

  if (millis() > tempoBossMorreu + 3000 && coveiro.coveiroMorreu) {
    estadoJogo = "SegundoMapa";
  }

  if (millis() > tempoBossMorreu + 3000 && fazendeiro.fazendeiroMorreu) {
    estadoJogo = "TerceiroMapa";
  }

  if (millis() > tempoBossMorreu + 7000 && padre.padreMorreu) {
    estadoJogo = "Vitoria";
  }


  cenario();
  inimigosTodos();
  armas(); 
  jLeite(); 
  foodAll();
  vida();
  caixaNumeroItem();
  if (telaTutorialAndandoAtiva) {
    telaTutorialAndando();
  }
  if (primeiraPedra == 1) {
    telaTutorialPedra();
  }
  telaGameOver();
  telaVitoria();
}
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

public void menu() {
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
        estadoJogo = "Instru\u00e7\u00f5esBot\u00f5es";
      }
    } else {
      image(botaoBotoes, 300, 400, 200, 77);
    }

    if (mouseX > 300 && mouseX < 500 && mouseY > 500 && mouseY < 577) {
      image(creditosMao, 271, 500);
      if (mousePressed) {
        estadoJogo = "Cr\u00e9ditos";
      }
    } else {
      image(botaoCreditos, 300, 500, 200, 77);
    }

    image(botaoSom, 660, 10);
    image(botaoMusica, 730, 10);

    //MOSTRA O X SOBRE OS BOT\u00d5ES DEPOIS QUE O JOGADOR CLICA SOBRE ELES.
    if (botaoXAparecendoSom) {
      image(botaoX, 660, 10);
    }
    if (botaoXAparecendoMusica) {
      image(botaoX, 730, 10);
    }
  }

  //bot\u00f5es.
  if (estadoJogo == "Instru\u00e7\u00f5esBot\u00f5es") {
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

  //cr\u00e9ditos.
  if (estadoJogo == "Cr\u00e9ditos") {
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

public void telaTutorialAndando() {
  image (telaTutorialAndando, 187.5f, 119);

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

public void telaTutorialPedra() {
  noLoop();

  image(telaTutorialPedra, 236, 169);
  image(jLeiteItem, 258.5f, 215);
  image(telaTutorialX, 514, 182);
  image(telaTutorialPedraSeta, 705, 456);

  telaTutorialPedraAtiva = true;
}

PImage telaVitoria;

public void telaVitoria() {
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

public void telaGameOver() {
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
PImage shovel;
PImage shovelShadow;

public class Pa extends Geral {
  public Pa() {
    setX(PApplet.parseInt(random(100, 616)));
    setY(PApplet.parseInt(random(-300, -1000)));

    setSpriteImage(shovel);
    setSpriteInterval(75);
    setSpriteWidth(84);
    setSpriteHeight(91);
    setMovementY(sceneryMovement);
  }

  public Pa(int x, int y) {
    this.setX(x);
    this.setY(y);

    setSpriteImage(shovel);
    setSpriteInterval(75);
    setSpriteWidth(84);
    setSpriteHeight(91);
    setMovementY(sceneryMovement);
  }

  public void display() {
    image (shovelShadow, getX() + 1, getY() + 85);

    super.display();
  }
}

ArrayList<Pa> pas;

int indexRandomPaMapaBoss;

public void pa() {
  if (totalArmas == 0 && millis() > tempoGerarArma + 15000) {
    if (estadoJogo == "PrimeiroMapa") {
      if (pas.size() == 0 && indexArma >= 0 && indexArma <= 9 && !telaTutorialAndandoAtiva) {
        pas.add(new Pa());
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "SegundoMapa") {
      if (pas.size() == 0 && indexArma >= 0 && indexArma <= 4 && !telaTutorialAndandoAtiva) {
        pas.add(new Pa());
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "TerceiroMapa") {
      if (pas.size() == 0 && indexArma >= 0 && indexArma <= 2 && !telaTutorialAndandoAtiva) {
        pas.add(new Pa());
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "MapaCoveiro") {
      if (pas.size() == 0 && indexArma >= 0 && indexArma <= 9) {
        indexRandomPaMapaBoss = PApplet.parseInt(random(0, valoresXMapaCoveiro.length));
        pas.add(new Pa(valoresXMapaCoveiro[indexRandomPaMapaBoss], valoresYMapaCoveiro[indexRandomPaMapaBoss]));
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "MapaFazendeiro") {
      if (pas.size() == 0 && indexArma >= 0 && indexArma <= 4) {
        indexRandomPaMapaBoss = PApplet.parseInt(random(0, valoresXMapaFazendeiro.length));
        pas.add(new Pa(valoresXMapaFazendeiro[indexRandomPaMapaBoss], valoresYMapaFazendeiro[indexRandomPaMapaBoss]));
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "MapaPadre") {
      if (pas.size() == 0 && indexArma >= 0 && indexArma <= 2) {
        indexRandomPaMapaBoss = PApplet.parseInt(random(0, valoresXMapaPadre.length));
        pas.add(new Pa(valoresXMapaPadre[indexRandomPaMapaBoss], valoresYMapaPadre[indexRandomPaMapaBoss]));
        totalArmas = totalArmas + 1;
      }
    }
  }

  for (int i = pas.size() - 1; i >= 0; i = i - 1) {
    Pa p = pas.get(i);
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      p.update();
    }
    p.display();
    if (p.hasExitScreen() || p.hasCollided()) {
      pas.remove(p);
    }
    if (p.hasCollided()) {
      tempoGerarArma = millis();
      item = 2;
      totalItem = 7;
      armaGerada = false;
    }
  }
}
PImage shovelAttack;

public class PaAtaque extends Arma {
  public PaAtaque() {
    setX(jLeiteX - 70);
    setY(jLeiteY - 44);

    setSpriteImage(shovelAttack);
    setSpriteInterval(90);
    setSpriteWidth(234);
    setSpriteHeight(173);

    setDeleteWeapon(false);
    setDamageBoss(false);

    setFirstCollisionX(jLeiteX + 160);
    setSecondCollisionX(jLeiteX - 70);
    setFirstCollisionY(jLeiteY + 56);
    setSecondCollisionY(jLeiteY - 44);
  }
}

ArrayList<PaAtaque> pasAtaque;

boolean umaPa;

public void paAtaque() {
  if (jLeiteUsoItem) {
    if (pasAtaque.size() == 0 && item == 2 && totalItem > 0 && !umaPa) {
      pasAtaque.add(new PaAtaque());
      totalItem = totalItem - 1;
      umaPa = true;
    }
  }

  for (int i = pasAtaque.size() - 1; i >= 0; i = i - 1) {
    PaAtaque p = pasAtaque.get(i);
    p.display();
    if (p.getDeleteWeapon()) {
      pasAtaque.remove(p);
    }
    if (estadoJogo == "MapaCoveiro") {
      if (p.hasHitCoveiro() && !p.getDamageBoss()) {
        if (sonsAtivos) {
          indexRandomSomCoveiroTomandoDano = PApplet.parseInt(random(0, sonsCoveiroTomandoDano.length));
          sonsCoveiroTomandoDano[indexRandomSomCoveiroTomandoDano].rewind();
          sonsCoveiroTomandoDano[indexRandomSomCoveiroTomandoDano].play();
        }
        vidaCoveiroAtual = vidaCoveiroAtual - 1;
        p.setDamageBoss(true);
      }
    }
    if (estadoJogo == "MapaFazendeiro") {
      if (p.hasHitFazendeiro() && !p.getDamageBoss()) {
        if (sonsAtivos) {
          indexRandomSomFazendeiroTomandoDano = PApplet.parseInt(random(0, sonsFazendeiroTomandoDano.length));
          sonsFazendeiroTomandoDano[indexRandomSomFazendeiroTomandoDano].rewind();
          sonsFazendeiroTomandoDano[indexRandomSomFazendeiroTomandoDano].play();
        }
        vidaFazendeiroAtual = vidaFazendeiroAtual - 2;
        p.setDamageBoss(true);
      }
    }
    if (estadoJogo == "MapaPadre") {
      if (p.hasHitPadre() && !p.getDamageBoss()) {
        if (vidaPadreAtual > 0) {
          if (sonsAtivos) {
            indexRandomSomPadreTomandoDano = PApplet.parseInt(random(0, sonsPadreTomandoDano.length));
            sonsPadreTomandoDano[indexRandomSomPadreTomandoDano].rewind();
            sonsPadreTomandoDano[indexRandomSomPadreTomandoDano].play();
          }
          vidaPadreAtual = vidaPadreAtual - 2;
          p.setDamageBoss(true);
        } else {
          if (sonsAtivos) {
            indexRandomSomPadreTomandoDano = PApplet.parseInt(random(0, sonsPadreRaivaTomandoDano.length));
            sonsPadreRaivaTomandoDano[indexRandomSomPadreTomandoDano].rewind();
            sonsPadreRaivaTomandoDano[indexRandomSomPadreTomandoDano].play();
          }
          vidaPadreRaivaAtual = vidaPadreRaivaAtual - 2;
          p.setDamageBoss(true);
        }
      }
    }
  }
}
PImage stone;
PImage stoneShadow;

public class Pedra extends Geral {
  public Pedra() {
    setX(PApplet.parseInt(random(100, 666)));
    setY(PApplet.parseInt(random(-300, -1000)));

    setSpriteImage(stone);
    setSpriteInterval(75);
    setSpriteWidth(34);
    setSpriteHeight(27);
    setMovementY(sceneryMovement);
  }

  public Pedra(int x, int y) {
    this.setX(x);
    this.setY(y);

    setSpriteImage(stone);
    setSpriteInterval(75);
    setSpriteWidth(34);
    setSpriteHeight(27);
    setMovementY(sceneryMovement);
  }

  public void display() {
    image (stoneShadow, getX(), getY() + 17);

    super.display();
  }
}

ArrayList<Pedra> pedras;

int indexRandomPedraMapaBoss;

public void pedra() {
  if (totalArmas == 0 && millis() > tempoGerarArma + 15000) {
    if (estadoJogo == "SegundoMapa") {
      if (pedras.size() == 0 && indexArma >= 5 && indexArma <= 9 && !telaTutorialAndandoAtiva) {
        pedras.add(new Pedra());
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "TerceiroMapa") {
      if (pedras.size() == 0 && indexArma >= 3 && indexArma <= 4 && !telaTutorialAndandoAtiva) {
        pedras.add(new Pedra());
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "MapaFazendeiro") {
      if (pas.size() == 0 && indexArma >= 5 && indexArma <= 9) {
        indexRandomPedraMapaBoss = PApplet.parseInt(random(0, valoresXMapaFazendeiro.length));
        pedras.add(new Pedra(valoresXMapaFazendeiro[indexRandomPedraMapaBoss], valoresYMapaFazendeiro[indexRandomPedraMapaBoss]));
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "MapaPadre") {
      if (pas.size() == 0 && indexArma >= 3 && indexArma <= 4) {
        indexRandomPedraMapaBoss = PApplet.parseInt(random(0, valoresXMapaPadre.length));
        pedras.add(new Pedra(valoresXMapaPadre[indexRandomPedraMapaBoss], valoresYMapaPadre[indexRandomPedraMapaBoss]));
        totalArmas = totalArmas + 1;
      }
    }
  }

  for (int i = pedras.size() - 1; i >= 0; i = i - 1) {
    Pedra p = pedras.get(i);
    if (estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      p.update();
    }
    p.display();
    if (p.hasExitScreen() || p.hasCollided()) {
      pedras.remove(p);
    }
    if (p.hasCollided()) {
      tempoGerarArma = millis();
      primeiraPedra = primeiraPedra + 1;
      item = 1;
      totalItem = 15;
      armaGerada = false;
    }
  }
}
PImage stoneAttack;

public class PedraAtirada extends Arma {
  private boolean hasHitShield;

  public PedraAtirada() {
    setX(jLeiteX + 52);
    setY(jLeiteY + 26);

    setSpriteImage(stoneAttack);
    setSpriteInterval(90);
    setSpriteWidth(16);
    setSpriteHeight(26);

    setFirstCollisionX(getX() + 16);
    setSecondCollisionX(getX());
    setFirstCollisionY(getY() + 26);
    setSecondCollisionY(getY());
  }

  public void display() {
    image(stoneAttack, getX(), getY());
  }

  public void update() {
    setY(getY() - 10);
  }

  public boolean hasHitFazendeiro() {
    if (getFirstCollisionX() > fazendeiroX + 60 && getSecondCollisionX() < fazendeiroX + 188 && getFirstCollisionY() > fazendeiroY && getSecondCollisionY() < fazendeiroY + 125) {
      if (!pneuRolandoPrimeiraVez) {
        hitBossesMostrando = true;
        hitBosses(fazendeiroX + 30, fazendeiroY + 20);
        return true;
      } else {
        hitEscudoMostrando = true;
        hitEscudo(fazendeiroX + 30, fazendeiroY + 20);
        hasHitShield = true;
        return false;
      }
    } 

    return false;
  }

  public boolean hasExitScreen() {
    if (getX() + stoneAttack.height < 0) {
      return true;
    } 

    return false;
  }
}

ArrayList<PedraAtirada> pedrasAtiradas;

int tempoPedraAtirada;

boolean umaPedra;

public void pedraAtirada() {
  if (jLeiteUsoItem) {
    if (pedrasAtiradas.size() == 0 && item == 1 && totalItem > 0 && millis() > tempoPedraAtirada + 135 && !umaPedra) {
      pedrasAtiradas.add(new PedraAtirada());
      totalItem = totalItem - 1;
      umaPedra = true;
    }
  }

  for (int i = pedrasAtiradas.size() - 1; i >= 0; i = i - 1) {
    PedraAtirada p = pedrasAtiradas.get(i);
    p.display();
    p.update();
    if (p.hasExitScreen() || p.hasHitShield) {
      pedrasAtiradas.remove(p);
    }
    if (estadoJogo == "MapaFazendeiro") {
      if (p.hasHitFazendeiro()) {
        if (sonsAtivos) {
          indexRandomSomFazendeiroTomandoDano = PApplet.parseInt(random(0, 4));
          sonsFazendeiroTomandoDano[indexRandomSomFazendeiroTomandoDano].rewind();
          sonsFazendeiroTomandoDano[indexRandomSomFazendeiroTomandoDano].play();
        }
        vidaFazendeiroAtual = vidaFazendeiroAtual - 2;
        pedrasAtiradas.remove(p);
      }
    }
    if (estadoJogo == "MapaPadre") {
      if (p.hasHitPadre()) {
        if (vidaPadreAtual > 0) {
          if (sonsAtivos) {
            indexRandomSomPadreTomandoDano = PApplet.parseInt(random(0, sonsPadreTomandoDano.length));
            sonsPadreTomandoDano[indexRandomSomPadreTomandoDano].rewind();
            sonsPadreTomandoDano[indexRandomSomPadreTomandoDano].play();
          }
          vidaPadreAtual = vidaPadreAtual - 2;
        } else {
          if (sonsAtivos) {
            indexRandomSomPadreTomandoDano = PApplet.parseInt(random(0, sonsPadreRaivaTomandoDano.length));
            sonsPadreRaivaTomandoDano[indexRandomSomPadreTomandoDano].rewind();
            sonsPadreRaivaTomandoDano[indexRandomSomPadreTomandoDano].play();
          }
          vidaPadreRaivaAtual = vidaPadreRaivaAtual - 2;
        }
        pedrasAtiradas.remove(p);
      }
    }
  }
}
PImage queijo;

public class Queijo extends Comida {
  public Queijo(int x, int y) {
    this.setX(x);
    this.setY(y);

    setSpriteImage(queijo);
    setSpriteInterval(75);
    setSpriteWidth(31);
    setSpriteHeight(29);
    setMovementY(1);

    setAmountRecovered(0);
  }

  public Queijo() {
    this.setX(PApplet.parseInt(random(200, 500)));
    this.setY(PApplet.parseInt(random(-300, -1000)));

    setSpriteImage(queijo);
    setSpriteInterval(75);
    setSpriteWidth(31);
    setSpriteHeight(29);
    setMovementY(1);

    setAmountRecovered(0);
  }

  public void display() {
    image (foodShadow, getX(), getY() + 19);

    super.display();
  }
}

ArrayList<Queijo> queijos;

int indexRandomQueijoMapaBoss;

int amountHealQueijo = 4;

public void queijo() {
  if (totalFood < 1 && hasIndexChanged && millis() > timeToGenerateFood + 10000) {
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      if (queijos.size() == 0 && foodIndex >= 5 && foodIndex <= 7 && !telaTutorialAndandoAtiva) {
        queijos.add(new Queijo());
        totalFood += 1;
      }
    }

    if (estadoJogo == "MapaCoveiro") {
      if (queijos.size() == 0 && foodIndex >= 5 && foodIndex <= 7) {
        indexRandomQueijoMapaBoss = PApplet.parseInt(random(0, valoresXMapaCoveiro.length));
        queijos.add(new Queijo(valoresXMapaCoveiro[indexRandomQueijoMapaBoss], valoresYMapaCoveiro[indexRandomQueijoMapaBoss]));
        totalFood += 1;
      }
    }

    if (estadoJogo == "MapaFazendeiro") {
      if (queijos.size() == 0 && foodIndex >= 5 && foodIndex <= 7) {
        indexRandomQueijoMapaBoss = PApplet.parseInt(random(0, valoresXMapaFazendeiro.length));
        queijos.add(new Queijo(valoresXMapaFazendeiro[indexRandomQueijoMapaBoss], valoresYMapaFazendeiro[indexRandomQueijoMapaBoss]));
        totalFood += 1;
      }
    }

    if (estadoJogo == "MapaPadre") {
      if (queijos.size() == 0 && foodIndex >= 5 && foodIndex <= 7) {
        indexRandomQueijoMapaBoss = PApplet.parseInt(random(0, valoresXMapaFazendeiro.length));
        queijos.add(new Queijo(valoresXMapaPadre[indexRandomQueijoMapaBoss], valoresYMapaPadre[indexRandomQueijoMapaBoss]));
        totalFood += 1;
      }
    }
  }

  for (int i = queijos.size() - 1; i >= 0; i = i - 1) {
    Queijo q = queijos.get(i);
    q.display();
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      q.update();
    }
    if (q.hasExitScreen() || q.hasCollided()) {
      queijos.remove(q);
      totalFood -= 1;
      hasIndexChanged = false;
      timeToGenerateFood = millis();
    }
    if (q.hasCollided()) {
      heal(amountHealQueijo, q);
    }
  }
}
  public void settings() {  size(800, 600); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Pesadelo" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
