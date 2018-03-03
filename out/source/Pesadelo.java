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

float millisAvancada, millisAvancadaMapa;

int posicoesInimigosNoPrimeiroMapa[][];
int posicoesInimigosNoSegundoMapa [][];
int posicoesInimigosNoTerceiroMapa[][];

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

  for (int i = 0; i < imagensCenarios.length; i = i + 1) {
    imagensCenarios[i] = loadImage("mapa" + i + ".png");
  }

  porta = loadImage ("porta.png");
  cerca = loadImage ("cerca.png");

  for (int i = 0; i < imagensCenariosBoss.length; i = i + 1) {
    imagensCenariosBoss[i] = loadImage("mapaBoss" + i + ".png");
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
  sombraComidas = loadImage ("sombraComidas.png");

  pa = loadImage ("pa.png");
  sombraPa = loadImage ("sombraPaChicote.png");
  paAtaque = loadImage ("paAtaque.png");
  caixaItemPa = loadImage ("caixaItemPa.png");

  pedra = loadImage ("pedra.png");
  sombraPedra = loadImage ("sombraPedra.png");
  pedraFogo = loadImage ("pedraFogo.png");

  chicote = loadImage ("chicote.png");
  sombraChicote = loadImage ("sombraPaChicote.png");
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

  esqueleto = loadImage ("esqueleto.png");
  sombraEsqueleto = loadImage ("sombraEsqueleto.png");
  esqueletoChuteAtaque = loadImage ("esqueletoChuteAtaque.png");
  esqueletoChuteMovimento = loadImage ("esqueletoChuteMovimento.png");
  cabecaEsqueletoChute = loadImage ("cabecaEsqueletoChute.png");
  sombraEsqueletoChute = loadImage ("sombraEsqueletoChute.png");
  cachorro = loadImage ("cachorro.png");
  sombraCachorro = loadImage ("sombraCachorro.png");
  corvo = loadImage ("corvo.png");
  sombraCorvo = loadImage ("sombraCorvo.png");
  esqueletoRaiva = loadImage ("esqueletoRaiva.png");
  sombraEsqueletoRaiva = loadImage ("sombraEsqueletoRaiva.png");

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

  posicoesInimigosNoPrimeiroMapa = new int [7][4];
  posicoesInimigosNoSegundoMapa  = new int [7][4];
  posicoesInimigosNoTerceiroMapa = new int [7][4];

  posicoesEsqueleto();
  posicoesEsqueletoChute();
  posicoesCachorro();
  posicoesEsqueletoRaiva();

  creditosY = 0;
  creditos2Y = 1000;
  movimentoCreditosY = 1;

  estadoJogo = "MenuInicial";

  millisAvancada = 0;
  millisAvancadaMapa = 0;

  totalCenariosCriados = 0;
  totalInimigos = 0;

  jLeiteX = 360;
  jLeiteY = 345; 

  vidaJLeiteAtual = 15;
  vidaJleiteMax = 15; 
  vidaJLeiteMin = 0;

  vidaJLeiteBarraX = 115;

  indexComida = 10;

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

  comidaGerada = false;

  cenario = new Cenario(0, 0, 58008);
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
  millisAvancada = millisAvancada + 1000 / 60;

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
        millisAvancada = 0;
        telaTutorialAndandoAtiva = false;
        totalCenariosCriados = 0;
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
        millisAvancada = 0;
        telaTutorialAndandoAtiva = false;
        totalCenariosCriados = 0;
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

  if (!telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
    if (!armaGerada) {
      indexArma = PApplet.parseInt(random(0, 10));
      tempoGerarArma = PApplet.parseInt(millisAvancada);
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
      caixaItemPedra = pedra.get(0, 0, 34, 27);
      image(caixaItemPedra, 729, 516);
    } else if (item == 2) {
      image(caixaItemPa, 705, 510);
    } else if (item == 3) {
      image(caixaItemChicote, 705, 510);
    }
    image(imagensNumerosItem[totalItem - 1], 725, 552);
  }
}

PImage pa;
PImage sombraPa;

public class Pa {
  private PImage spritePa;

  private int paX = PApplet.parseInt(random(100, 616));
  private int paY = PApplet.parseInt(random(-300, -1000));

  private int stepPa;
  private int tempoSpritePa;

  public Pa() {
  }

  public Pa(int paX, int paY) {
    this.paX = paX;
    this.paY = paY;
  }

  public void display() {
    image (sombraPa, paX + 1, paY + 85);

    if (millis() > tempoSpritePa + 75) {
      spritePa = pa.get(stepPa, 0, 84, 91); 
      stepPa = stepPa % 504 + 84;
      image(spritePa, paX, paY); 
      tempoSpritePa = millis();
    } else {
      image(spritePa, paX, paY);
    }

    if (stepPa == pa.width) {
      stepPa = 0;
    }
  }

  public void update() {
    paY = paY + 1;
  }

  public boolean apanhado() {
    if (paX + 84 > jLeiteX && paX < jLeiteX + 63 && paY + 91 > jLeiteY && paY < jLeiteY + 126) {
      tempoGerarArma = PApplet.parseInt(millisAvancada);
      item = 2;
      totalItem = 7;
      armaGerada = false;
      return true;
    } else {
      return false;
    }
  }

  public boolean saiuDaTela() {
    if (paY > height) {
      return true;
    } else {
      return false;
    }
  }
}

ArrayList<Pa> pas;

int indexRandomPaMapaBoss;

public void pa() {
  if (totalArmas == 0 && millisAvancada > tempoGerarArma + 15000) {
    if (estadoJogo == "PrimeiroMapa") {
      if (pas.size() == 0 && indexArma >= 0 && indexArma <= 9 && !telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
        pas.add(new Pa());
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "SegundoMapa") {
      if (pas.size() == 0 && indexArma >= 0 && indexArma <= 4 && !telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
        pas.add(new Pa());
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "TerceiroMapa") {
      if (pas.size() == 0 && indexArma >= 0 && indexArma <= 2 && !telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
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
    p.display();
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      p.update();
    }
    if (p.apanhado() || p.saiuDaTela()) {
      pas.remove(p);
    }
  }
}

PImage paAtaque;

public class PaAtaque {
  private PImage spritePaAtaque;

  private int paAtaqueX = jLeiteX - 70;
  private int paAtaqueY = jLeiteY - 44;

  private int stepPaAtaque;
  private int tempoSpritePaAtaque;

  private boolean umDanoBoss;
  private boolean deletarPa;

  public void display() {
    if (millis() > tempoSpritePaAtaque + 90) {
      spritePaAtaque = paAtaque.get(stepPaAtaque, 0, 234, 173);
      stepPaAtaque = stepPaAtaque % 702 + 234;
      image(spritePaAtaque, paAtaqueX, paAtaqueY);
      tempoSpritePaAtaque = millis();
    } else {
      image(spritePaAtaque, paAtaqueX, paAtaqueY);
    }

    if (stepPaAtaque == paAtaque.width) {
      deletarPa = true;
      stepPaAtaque = 0;
    }
  }

  public void update() {
    paAtaqueX = jLeiteX - 70;
    paAtaqueY = jLeiteY - 44;
  }

  public boolean acertouEsqueleto(Esqueleto e) {
    if (jLeiteX + 160 > e.esqueletoX && jLeiteX - 70 < e.esqueletoX + 76 && jLeiteY + 56 > e.esqueletoY && jLeiteY - 44 < e.esqueletoY + 126) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  public boolean acertouEsqueletoChute(EsqueletoChute e) {
    if (jLeiteX + 160 > e.esqueletoChuteX && jLeiteX - 70 < e.esqueletoChuteX + 49 && jLeiteY + 56 > e.esqueletoChuteY && jLeiteY - 44 < e.esqueletoChuteY + 74) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  public boolean acertouCachorro(Cachorro c) {
    if (jLeiteX + 160 > c.cachorroX && jLeiteX - 70 < c.cachorroX + 45 && jLeiteY + 56 > c.cachorroY && jLeiteY - 44 < c.cachorroY + 83) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  public boolean acertouCorvo(Corvo c) {
    if (jLeiteX + 160 > c.corvoX + 45 && jLeiteX - 70 < c.corvoX + 75 && jLeiteY + 56 > c.corvoY && jLeiteY - 44 < c.corvoY + 86) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  public boolean acertouEsqueletoRaiva(EsqueletoRaiva e) {
    if (jLeiteX + 160 > e.esqueletoRaivaX && jLeiteX - 70 < e.esqueletoRaivaX + 76 && jLeiteY + 56 > e.esqueletoRaivaY && jLeiteY - 44 < e.esqueletoRaivaY + 126) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  public boolean acertouCoveiro() {
    if (jLeiteX + 160 > coveiroX && jLeiteX - 70 < coveiroX + 169 && jLeiteY + 56 > coveiroY && jLeiteY - 44 < coveiroY + 188) {
      hitBossesMostrando = true;
      hitBosses(coveiroX, coveiroY + 20);
      return true;
    } else { 
      return false;
    }
  }

  public boolean acertouFazendeiro() {
    if (jLeiteX + 160 > fazendeiroX + 60 && jLeiteX - 70 < fazendeiroX + 188 && jLeiteY + 56 > fazendeiroY && jLeiteY - 44 < fazendeiroY + 125) {
      if (!pneuRolandoPrimeiraVez) {
        hitBossesMostrando = true;
        hitBosses(fazendeiroX + 30, fazendeiroY + 20);
        return true;
      } else {
        hitEscudoMostrando = true;
        hitEscudo(fazendeiroX + 30, fazendeiroY + 20);
        return false;
      }
    } else { 
      return false;
    }
  }

  public boolean acertouPadre() {
    if (jLeiteX + 160 > padreX + 20 && jLeiteX - 70 < padreX + 110 && jLeiteY + 56 > padreY && jLeiteY - 44 < padreY + 152) {
      hitBossesMostrando = true;
      hitBosses(padreX, padreY);
      return true;
    } else { 
      return false;
    }
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
    p.update();
    if (p.deletarPa) {
      pasAtaque.remove(p);
    }
    if (estadoJogo == "MapaCoveiro") {
      if (p.acertouCoveiro() && !p.umDanoBoss) {
        if (sonsAtivos) {
          indexRandomSomCoveiroTomandoDano = PApplet.parseInt(random(0, sonsCoveiroTomandoDano.length));
          sonsCoveiroTomandoDano[indexRandomSomCoveiroTomandoDano].rewind();
          sonsCoveiroTomandoDano[indexRandomSomCoveiroTomandoDano].play();
        }
        vidaCoveiroAtual = vidaCoveiroAtual - 1;
        p.umDanoBoss = true;
      }
    }
    if (estadoJogo == "MapaFazendeiro") {
      if (p.acertouFazendeiro() && !p.umDanoBoss) {
        if (sonsAtivos) {
          indexRandomSomFazendeiroTomandoDano = PApplet.parseInt(random(0, sonsFazendeiroTomandoDano.length));
          sonsFazendeiroTomandoDano[indexRandomSomFazendeiroTomandoDano].rewind();
          sonsFazendeiroTomandoDano[indexRandomSomFazendeiroTomandoDano].play();
        }
        vidaFazendeiroAtual = vidaFazendeiroAtual - 2;
        p.umDanoBoss = true;
      }
    }
    if (estadoJogo == "MapaPadre") {
      if (p.acertouPadre() && !p.umDanoBoss) {
        if (vidaPadreAtual > 0) {
          if (sonsAtivos) {
            indexRandomSomPadreTomandoDano = PApplet.parseInt(random(0, sonsPadreTomandoDano.length));
            sonsPadreTomandoDano[indexRandomSomPadreTomandoDano].rewind();
            sonsPadreTomandoDano[indexRandomSomPadreTomandoDano].play();
          }
          vidaPadreAtual = vidaPadreAtual - 2;
          p.umDanoBoss = true;
        } else {
          if (sonsAtivos) {
            indexRandomSomPadreTomandoDano = PApplet.parseInt(random(0, sonsPadreRaivaTomandoDano.length));
            sonsPadreRaivaTomandoDano[indexRandomSomPadreTomandoDano].rewind();
            sonsPadreRaivaTomandoDano[indexRandomSomPadreTomandoDano].play();
          }
          vidaPadreRaivaAtual = vidaPadreRaivaAtual - 2;
          p.umDanoBoss = true;
        }
      }
    }
  }
}

PImage pedra;
PImage sombraPedra;

public class Pedra {
  private PImage spritePedra;

  private int pedraX = PApplet.parseInt(random(100, 666));
  private int pedraY = PApplet.parseInt(random(-300, -1000));

  private int stepPedra;
  private int tempoSpritePedra;

  public Pedra() {
  }

  public Pedra(int pedraX, int pedraY) {
    this.pedraX = pedraX;
    this.pedraY = pedraY;
  }

  public void display() {
    image (sombraPedra, pedraX, pedraY + 17);

    if (millis() > tempoSpritePedra + 75) {
      spritePedra = pedra.get(stepPedra, 0, 34, 27); 
      stepPedra = stepPedra % 204 + 34;
      image(spritePedra, pedraX, pedraY); 
      tempoSpritePedra = millis();
    } else {
      image(spritePedra, pedraX, pedraY);
    }

    if (stepPedra == pedra.width) {
      stepPedra = 0;
    }
  }

  public void update() {
    pedraY = pedraY + 1;
  }

  public boolean apanhado() {
    if (pedraX + 34 > jLeiteX && pedraX < jLeiteX + 63 && pedraY + 27 > jLeiteY && pedraY < jLeiteY + 126) {
      tempoGerarArma = PApplet.parseInt(millisAvancada);
      primeiraPedra = primeiraPedra + 1;
      item = 1;
      totalItem = 15;
      armaGerada = false;
      return true;
    } else {
      return false;
    }
  }

  public boolean saiuDaTela() {
    if (pedraY > height) {
      return true;
    } else {
      return false;
    }
  }
}

ArrayList<Pedra> pedras;

int indexRandomPedraMapaBoss;

public void pedra() {
  if (totalArmas == 0 && millisAvancada > tempoGerarArma + 15000) {
    if (estadoJogo == "SegundoMapa") {
      if (pedras.size() == 0 && indexArma >= 5 && indexArma <= 9 && !telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
        pedras.add(new Pedra());
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "TerceiroMapa") {
      if (pedras.size() == 0 && indexArma >= 3 && indexArma <= 4 && !telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
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
    p.display();
    if (estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      p.update();
    }
    if (p.apanhado() || p.saiuDaTela()) {
      pedras.remove(p);
    }
  }
}

PImage pedraFogo;

public class PedraAtirada {
  private int pedraFogoX = jLeiteX + 52;
  private int pedraFogoY = jLeiteY + 26;

  private boolean bateuNoEscudo;

  public void display() {
    image(pedraFogo, pedraFogoX, pedraFogoY);
  }

  public void update() {
    pedraFogoY = pedraFogoY - 10;
  }

  public boolean acertouEsqueleto(Esqueleto e) {
    if (pedraFogoX + 16 > e.esqueletoX && pedraFogoX < e.esqueletoX + 76 && pedraFogoY + 26 > e.esqueletoY && pedraFogoY < e.esqueletoY + 126) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  public boolean acertouEsqueletoChute(EsqueletoChute e) {
    if (pedraFogoX + 16 > e.esqueletoChuteX && pedraFogoX < e.esqueletoChuteX + 49 && pedraFogoY + 26 > e.esqueletoChuteY && pedraFogoY < e.esqueletoChuteY + 74) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  public boolean acertouCachorro(Cachorro c) {
    if (pedraFogoX + 16 > c.cachorroX && pedraFogoX < c.cachorroX + 45 && pedraFogoY + 26 > c.cachorroY && pedraFogoY < c.cachorroY + 83) {
      return true;
    } else { 
      return false;
    }
  }

  public boolean acertouCorvo(Corvo c) {
    if (pedraFogoX + 16 > c.corvoX + 45 && pedraFogoX < c.corvoX + 75 && pedraFogoY + 26 > c.corvoY && pedraFogoY < c.corvoY + 86) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  public boolean acertouEsqueletoRaiva(EsqueletoRaiva e) {
    if (pedraFogoX + 16 > e.esqueletoRaivaX && pedraFogoX < e.esqueletoRaivaX + 76 && pedraFogoY + 26 > e.esqueletoRaivaY && pedraFogoY < e.esqueletoRaivaY + 126) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  public boolean acertouFazendeiro() {
    if (pedraFogoX + 16 > fazendeiroX + 60 && pedraFogoX < fazendeiroX + 188 && pedraFogoY + 26 > fazendeiroY && pedraFogoY < fazendeiroY + 125) {
      if (!pneuRolandoPrimeiraVez) {
        hitBossesMostrando = true;
        hitBosses(fazendeiroX + 30, fazendeiroY + 20);
        return true;
      } else {
        hitEscudoMostrando = true;
        hitEscudo(fazendeiroX + 30, fazendeiroY + 20);
        bateuNoEscudo = true;
        return false;
      }
    } else { 
      return false;
    }
  }

  public boolean acertouPadre() {
    if (pedraFogoX + 16 > padreX + 20 && pedraFogoX < padreX + 110 && pedraFogoY + 26 > padreY && pedraFogoY < padreY + 152) {
      hitBossesMostrando = true;
      hitBosses(padreX, padreY);
      return true;
    } else { 
      return false;
    }
  }

  public boolean saiuDaTela() {
    if (pedraFogoY + pedraFogo.height < 0) {
      return true;
    } else {
      return false;
    }
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
    if (p.saiuDaTela() || p.bateuNoEscudo) {
      pedrasAtiradas.remove(p);
    }
    if (estadoJogo == "MapaFazendeiro") {
      if (p.acertouFazendeiro()) {
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
      if (p.acertouPadre()) {
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

PImage chicote;
PImage sombraChicote;

public class Chicote {
  private PImage spriteChicote;

  private int chicoteX = PApplet.parseInt(random(200, 500));
  private int chicoteY = PApplet.parseInt(random(-300, -1000));

  private int stepChicote;
  private int tempoSpriteChicote;

  public Chicote() {
  }

  public Chicote(int chicoteX, int chicoteY) {
    this.chicoteX = chicoteX;
    this.chicoteY = chicoteY;
  }

  public void display() {
    image (sombraChicote, chicoteX + 10, chicoteY + 76);

    if (millis() > tempoSpriteChicote + 75) {
      spriteChicote = chicote.get(stepChicote, 0, 101, 91); 
      stepChicote = stepChicote % 606 + 101;
      image(spriteChicote, chicoteX, chicoteY); 
      tempoSpriteChicote = millis();
    } else {
      image(spriteChicote, chicoteX, chicoteY);
    }

    if (stepChicote == chicote.width) {
      stepChicote = 0;
    }
  }

  public void update() {
    chicoteY = chicoteY + 1;
  }

  public boolean apanhado() {
    if (chicoteX + 101 > jLeiteX && chicoteX < jLeiteX + 63 && chicoteY + 91 > jLeiteY && chicoteY < jLeiteY + 126) {
      tempoGerarArma = PApplet.parseInt(millisAvancada);
      item = 3;
      totalItem = 10;
      armaGerada = false;
      return true;
    } else {
      return false;
    }
  }

  public boolean saiuDaTela() {
    if (chicoteY > height) {
      return true;
    } else {
      return false;
    }
  }
}

ArrayList<Chicote> chicotes;

int indexRandomChicoteMapaBoss;

public void chicote() {
  if (totalArmas == 0 && millisAvancada > tempoGerarArma + 15000) {
    if (estadoJogo == "TerceiroMapa") {
      if (chicotes.size() == 0 && indexArma >= 5 && indexArma <= 9 && !telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
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
    c.display();
    if (estadoJogo == "TerceiroMapa") {
      c.update();
    }
    if (c.apanhado() || c.saiuDaTela()) {
      chicotes.remove(c);
    }
  }
}

PImage chicoteAtaque;

public class ChicoteAtaque {
  private PImage spriteChicoteArma;

  private int chicoteArmaX = jLeiteX - 70;
  private int chicoteArmaY = jLeiteY - 140;

  private int stepChicoteAtaque;
  private int tempoSpriteChiteAtaque;

  private boolean umDanoBoss;
  private boolean deletarChicote;

  public void display() {
    if (millis() > tempoSpriteChiteAtaque + 110) {
      spriteChicoteArma = chicoteAtaque.get(stepChicoteAtaque, 0, 234, 278); 
      stepChicoteAtaque = stepChicoteAtaque % 702 + 234;
      image(spriteChicoteArma, chicoteArmaX, chicoteArmaY); 
      tempoSpriteChiteAtaque = millis();
    } else {
      image(spriteChicoteArma, chicoteArmaX, chicoteArmaY);
    }

    if (stepChicoteAtaque == chicoteAtaque.width) {
      stepChicoteAtaque = 0;
      deletarChicote = true;
    }
  }

  public void update() {
    chicoteArmaX = jLeiteX - 70;
    chicoteArmaY = jLeiteY - 140;
  }

  public boolean acertouEsqueleto(Esqueleto e) {
    if (jLeiteX + 56 > e.esqueletoX && jLeiteX + 50 < e.esqueletoX + 76 && jLeiteY > e.esqueletoY && jLeiteY - 140 < e.esqueletoY + 126) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  public boolean acertouEsqueletoChute(EsqueletoChute e) {
    if (jLeiteX + 56 > e.esqueletoChuteX && jLeiteX + 50 < e.esqueletoChuteX + 49 && jLeiteY > e.esqueletoChuteY && jLeiteY - 140 < e.esqueletoChuteY + 74) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  public boolean acertouCachorro(Cachorro c) {
    if (jLeiteX + 56 > c.cachorroX && jLeiteX + 50 < c.cachorroX + 45 && jLeiteY > c.cachorroY && jLeiteY - 140 < c.cachorroY + 83) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  public boolean acertouCorvo(Corvo c) {
    if (jLeiteX + 56 > c.corvoX + 45 && jLeiteX + 50 < c.corvoX + 75 && jLeiteY > c.corvoY && jLeiteY - 140 < c.corvoY + 86) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  public boolean acertouEsqueletoRaiva(EsqueletoRaiva e) {
    if (jLeiteX + 56 > e.esqueletoRaivaX && jLeiteX + 50 < e.esqueletoRaivaX + 76 && jLeiteY > e.esqueletoRaivaY && jLeiteY - 140 < e.esqueletoRaivaY + 126) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  public boolean acertouPadre() {
    if (jLeiteX + 56 > padreX + 20 && jLeiteX + 50 < padreX + 110 && jLeiteY > padreY && jLeiteY - 140 < padreY + 152) {
      hitBossesMostrando = true;
      hitBosses(padreX, padreY);
      return true;
    } else { 
      return false;
    }
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
    c.update();
    if (c.deletarChicote) {
      chicotesAtaque.remove(c);
    }

    if (estadoJogo == "MapaPadre") {
      if (c.acertouPadre() && !c.umDanoBoss) {
        if (vidaPadreAtual > 0) {
          if (sonsAtivos) {
            indexRandomSomPadreTomandoDano = PApplet.parseInt(random(0, sonsPadreTomandoDano.length));
            sonsPadreTomandoDano[indexRandomSomPadreTomandoDano].rewind();
            sonsPadreTomandoDano[indexRandomSomPadreTomandoDano].play();
          }
          vidaPadreAtual = vidaPadreAtual - 2;
          c.umDanoBoss = true;
        } else {
          if (sonsAtivos) {
            indexRandomSomPadreTomandoDano = PApplet.parseInt(random(0, sonsPadreRaivaTomandoDano.length));
            sonsPadreRaivaTomandoDano[indexRandomSomPadreTomandoDano].rewind();
            sonsPadreRaivaTomandoDano[indexRandomSomPadreTomandoDano].play();
          }
          vidaPadreRaivaAtual = vidaPadreRaivaAtual - 2;
          c.umDanoBoss = true;
        }
      }
    }
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

  private int tempoNovoDestino = PApplet.parseInt(millisAvancada);

  private int tempoNovoAtaquePa, tempoDanoPa;

  private int tempoNovoAtaqueFenda = PApplet.parseInt(millisAvancada);
  private int tempoGatilhoCarregarNovoAtaqueLapide = PApplet.parseInt(millisAvancada), tempoGatilhoNovoAtaqueLapide;

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

        if (millisAvancada > tempoCoveiroTomouDanoAgua + 1000) {
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
        if (PApplet.parseInt(millisAvancada) > tempoNovoDestino + 5000) {
          destinoCoveiroX = valoresCoveiroDestinoX[PApplet.parseInt(random(0, valoresCoveiroDestinoX.length))];
          destinoCoveiroY = valoresCoveiroDestinoY[PApplet.parseInt(random(0, valoresCoveiroDestinoY.length))];
          tempoNovoDestino = PApplet.parseInt(millisAvancada);
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
      if (dist(coveiroX, coveiroY, jLeiteX, jLeiteY) < 200 && !ataquePaLigado && millisAvancada > tempoNovoAtaquePa + 1500) {
        tempoNovoAtaquePa = PApplet.parseInt(millisAvancada);
        tempoDanoPa = PApplet.parseInt(millisAvancada);
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
        if (PApplet.parseInt(millisAvancada) > tempoDanoPa + 775) {
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
          tempoNovoAtaqueFenda = PApplet.parseInt(millisAvancada);
          gatilhoNovoAtaqueFenda = true;
        }
        if (millisAvancada > tempoNovoAtaqueFenda + 1500 && !gatilhoNovoAtaqueFendaAtivo) {
          novoAtaqueFenda = true;
          gatilhoNovoAtaqueFendaAtivo = true;
        }
      }
    }
  }

  public void ataqueCarregandoLapide() {
    if (!novoAtaqueFenda && !coveiroTomouDanoAgua && !coveiroMorreu) {
      if (!gatilhoNovoAtaqueLapide) {
        tempoGatilhoCarregarNovoAtaqueLapide = PApplet.parseInt(millisAvancada);
        gatilhoNovoAtaqueLapide = true;
      }
      if (millisAvancada > tempoGatilhoCarregarNovoAtaqueLapide + 32000 && !gatilhoNovoAtaqueLapideAtivo) {
        carregandoNovoAtaqueLapide = true;
        ataqueLapideAcontecendo = true;
        tempoGatilhoNovoAtaqueLapide = PApplet.parseInt(millisAvancada);
        gatilhoNovoAtaqueLapideAtivo = true;
      }
    }
  }

  public void ataqueLapide() {
    if (millisAvancada > tempoGatilhoNovoAtaqueLapide + 4000 && carregandoNovoAtaqueLapide) {
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
      tempoBossMorreu = PApplet.parseInt(millisAvancada);
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
        tempoFendaAberta = PApplet.parseInt(millisAvancada);
        stepFendaAbrindo = 0;
      } else {
        causouDanoJLeite = true;
      }
    }

    if (fendaAbriu) {
      if (millisAvancada > tempoFendaAberta + 5000) {
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
    if (millisAvancada > coveiro.tempoGatilhoNovoAtaqueLapide + 4375) {
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
    if (millisAvancada > tempoLapideAtiva + 2500) {
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
        tempoLapideAtiva = PApplet.parseInt(millisAvancada);
        lapideAcionada = false;
        stepLapideCenario = 0;
      }
    }
  }

  public void acionarLapide() {
    if (indexLapideAtaque == indexLapideCenario && millisAvancada > coveiro.tempoGatilhoNovoAtaqueLapide + 4000 && !lapideAtaqueSumiu) {
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
      if (l.lapideAcionada && millisAvancada > l.tempoLapideAtiva + 2000 && lapideAtaqueSumiu) {
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

  if (coveiroDelayTomouDanoAgua && millisAvancada > tempoCoveiroDelayTomouDanoAgua + 100) {
    coveiroTomouDanoAgua = true;
    tempoCoveiroTomouDanoAgua = PApplet.parseInt(millisAvancada);
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

  private int tempoNovoDestino = PApplet.parseInt(millisAvancada);

  private int indexRandomSomFazendeiroIdle;
  private int indexRandomSomFazendeiroMimosa;

  private int tempoNovoAtaqueFoice, tempoDanoFoice;

  private int tempoNovoAtaqueMimosa = PApplet.parseInt(millisAvancada);
  private int tempoNovoAtaquePneu = PApplet.parseInt(millisAvancada);

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

        if (stepFazendeiroPneuDano == fazendeiroPneuDano.width && millisAvancada > tempoSpriteFazendeiroTomouDanoPneu + 1400) {
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
      if (PApplet.parseInt(millisAvancada) > tempoNovoDestino + 5000) {
        destinoFazendeiroX = valoresFazendeiroDestinoX[PApplet.parseInt(random(0, valoresFazendeiroDestinoX.length))];
        destinoFazendeiroY = valoresFazendeiroDestinoY[PApplet.parseInt(random(0, valoresFazendeiroDestinoY.length))];
        tempoNovoDestino = PApplet.parseInt(millisAvancada);
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
      if (dist(fazendeiroX, fazendeiroY, jLeiteX, jLeiteY) < 100 && !ataqueFoiceLigado && millisAvancada > tempoNovoAtaqueFoice + 1500) {
        tempoNovoAtaqueFoice = PApplet.parseInt(millisAvancada);
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
          tempoNovoAtaqueMimosa = PApplet.parseInt(millisAvancada);
          gatilhoNovoAtaqueMimosa = true;
        }
        if (millisAvancada > tempoNovoAtaqueMimosa + 1500 && !gatilhoNovoAtaqueMimosaAtivo) {
          novoAtaqueMimosa = true;
          gatilhoNovoAtaqueMimosaAtivo = true;
        }
      }
    }
  }

  public void ataquePneu() {
    if (!ataquePneuAcontecendo && !ataqueMimosaAcontecendo && !fazendeiroMorreu) {
      if (!gatilhoNovoAtaquePneu) {
        tempoNovoAtaquePneu = PApplet.parseInt(millisAvancada);
        gatilhoNovoAtaquePneu = true;
      }
      if (PApplet.parseInt(millisAvancada) > tempoNovoAtaquePneu + 32000 && !gatilhoNovoAtaquePneuAtivo) {
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
      tempoBossMorreu = PApplet.parseInt(millisAvancada);
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
      tempoSpriteFazendeiroTomouDanoPneu = PApplet.parseInt(millisAvancada);
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

  private int tempoNovoDestino = PApplet.parseInt(millisAvancada);

  private int tempoNovoAtaqueCruz, tempoDanoCruz;

  private int tempoNovoAtaqueLevantem = PApplet.parseInt(millisAvancada), tempoDuracaoAtaqueLevantem, totalRecuperadoLevantem;

  private int tempoNovoAtaqueCaveira = PApplet.parseInt(millisAvancada);

  private int tempoSpritePadreTomouDanoCaveira;

  private int tempoSpritePadreCarregandoAtaqueRaio, tempoGatilhoCarregarNovoAtaqueRaio = PApplet.parseInt(millisAvancada);

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

        if (millisAvancada > tempoDuracaoAtaqueLevantem + 5000) {
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
          tempoSpritePadreTomouDanoCaveira = PApplet.parseInt(millisAvancada);
          padreTomouDanoCaveira = true;
        }
      }

      if (padreTomouDanoCaveira) {
        image(padreCaveiraDano[1], padreX + 3, padreY - 47);

        if (millisAvancada > tempoSpritePadreTomouDanoCaveira + 2000) {
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
            while (vidaPadreRaivaAtual < 40 && totalRecuperadoLevantem < 3) {
              totalRecuperadoLevantem = totalRecuperadoLevantem + 1;
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

          if (millisAvancada > tempoDuracaoAtaqueLevantem + 5000) {
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
            tempoSpritePadreTomouDanoCaveira = PApplet.parseInt(millisAvancada);
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

          if (millisAvancada > tempoSpritePadreTomouDanoCaveira + 2000) {
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

          if (millisAvancada > tempoSpritePadreCarregandoAtaqueRaio + 3000) {
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
        if (millisAvancada > tempoNovoDestino + 8000) {
          destinoPadreX = valoresPadreDestinoX[PApplet.parseInt(random(0, valoresPadreDestinoX.length))];
          destinoPadreY = valoresPadreDestinoY[PApplet.parseInt(random(0, valoresPadreDestinoY.length))];
          tempoNovoDestino = PApplet.parseInt(millisAvancada);  
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
      if (dist(padreX, padreY, jLeiteX, jLeiteY) < 100 && !ataqueCruzLigado && millisAvancada > tempoNovoAtaqueCruz + 1500) {
        tempoNovoAtaqueCruz = PApplet.parseInt(millisAvancada);
        tempoDanoCruz = PApplet.parseInt(millisAvancada);
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
          if (PApplet.parseInt(millisAvancada) > tempoDanoCruz + 750) {
            if (!jLeiteImune) {
              hitHitCruzMostrando = true;
              hitCruz(jLeiteX - 30, jLeiteY);
              vidaJLeiteAtual = vidaJLeiteAtual - 2;
              jLeiteImune = true;
              tempoImune = millis();
            }
          }
        } else {
          if (PApplet.parseInt(millisAvancada) > tempoDanoCruz + 300) {
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
          tempoNovoAtaqueLevantem = PApplet.parseInt(millisAvancada);
          gatilhoNovoAtaqueLevantem = true;
          totalRecuperadoLevantem = 0;
          padreRaivaCurou = false;
        }
        if (millisAvancada > tempoNovoAtaqueLevantem + 5000 && !gatilhoNovoAtaqueLevantemAtivo) {
          novoAtaqueLevantem = true;
          gatilhoNovoAtaqueLevantemAtivo = true;
          ataqueLevantemAcontecendo = true;
          tempoDuracaoAtaqueLevantem = PApplet.parseInt(millisAvancada);
        }
      }
    }
  }

  public void ataqueCaveira() {
    if (!novoAtaqueLevantem && !ataqueLevantemAcontecendo && !ataqueCaveiraAcontecendo && !padreCaveiraCaiuCabeca && !padreTomouDanoCaveira && !padreCarregandoNovoAtaqueRaio && !padreMorreu) {
      if (!gatilhoNovoAtaqueCaveira) {
        tempoNovoAtaqueCaveira = PApplet.parseInt(millisAvancada);
        gatilhoNovoAtaqueCaveira = true;
      }
      if (PApplet.parseInt(millisAvancada) > tempoNovoAtaqueCaveira + 40000 && !gatilhoNovoAtaqueCaveiraAtivo) {
        ataqueCaveiraAcontecendo = true;
        novoAtaqueCaveira = true;
        tempoPrimeiraCaveiraAtaque = PApplet.parseInt(millisAvancada);
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
          tempoGatilhoCarregarNovoAtaqueRaio = PApplet.parseInt(millisAvancada);
          gatilhoNovoAtaqueRaio = true;
        }
        if (millisAvancada > tempoGatilhoCarregarNovoAtaqueRaio + 15000 && !gatilhoNovoAtaqueRaioAtivo) {
          tempoSpritePadreCarregandoAtaqueRaio = PApplet.parseInt(millisAvancada);
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
      tempoBossMorreu = PApplet.parseInt(millisAvancada);
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
  if (caveirasPadre.size() > 0 && millisAvancada > tempoPrimeiraCaveiraAtaque + 1000 && !gatilhoNovaCaveiraAtacar) {
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
        padre.tempoNovoAtaqueCaveira = PApplet.parseInt(millisAvancada);
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
PImage[] imagensCenarios = new PImage [6];
PImage[] imagensCenariosBoss =  new PImage [3];

PImage porta;
PImage cerca;

float movimentoCenario = 42;

int indexCenario;

int totalCenariosCriados;

final int totalCenariosPossiveis = 21;

boolean portaAberta, cercaAberta;

public class Cenario {
  private PImage spritePorta;
  private PImage spriteCerca;

  private float cenarioY;
  private float cenarioX;

  private int indexCenarioCriado;
  private int indexCenarioFinal;

  private int stepPorta;
  private int tempoSpritePorta;

  private int stepCerca;
  private int tempoSpriteCerca;

  public Cenario(float cenarioX, float cenarioY, int indexCenarioCriado) {
    this.cenarioX = cenarioX;
    this.cenarioY = cenarioY;
    this.indexCenarioCriado = indexCenarioCriado;
  }

  public Cenario(int indexCenarioCriado, int indexCenarioFinal) {
    cenarioY = -imagensCenarios[0].height;
    this.indexCenarioCriado = indexCenarioCriado;
    this.indexCenarioFinal = indexCenarioFinal;
  }

  public void display() {
    image (imagensCenarios[indexCenarioFinal], 0, cenarioY);
    
    if (indexCenarioCriado == totalCenariosPossiveis) {
      if (estadoJogo == "PrimeiroMapa") {
        if (millis() > tempoSpritePorta + 350 && !portaAberta) { 
          if (!finalMapa) {
            spritePorta = porta.get(0, 0, 334, 256);
          } else {
            if (jLeiteX == 380) {
              spritePorta = porta.get(stepPorta, 0, 334, 256);
              stepPorta = stepPorta % 1338 + 334;
            }
          }
          image(spritePorta, 230, cenarioY); 
          tempoSpritePorta = millis();
        } else {
          image(spritePorta, 230, cenarioY);
        }

        if (stepPorta == porta.width) {
          portaAberta = true;
        }
      }

      if (estadoJogo == "SegundoMapa") {
        if (millis() > tempoSpriteCerca + 350 && !cercaAberta) { 
          if (!finalMapa) {
            spriteCerca = cerca.get(0, 0, 426, 146);
          } else {
            if (jLeiteX == 380) {
              spriteCerca = cerca.get(stepCerca, 0, 426, 146);
              stepCerca = stepCerca % 1704 + 426;
            }
          }
          image(spriteCerca, 188, cenarioY + 20); 
          tempoSpriteCerca = millis();
        } else {
          image(spriteCerca, 188, cenarioY + 20);
        }

        if (stepCerca == cerca.width) {
          cercaAberta = true;
        }
      }
    }
  }

  public void update() {
    if (indexCenarioCriado != totalCenariosPossiveis) {
      cenarioY = cenarioY + movimentoCenario;
    } else {
      if (cenarioY <= 0) {
        cenarioY = cenarioY + movimentoCenario;
      }
    }
  }

  public boolean saiuDaTela() {
    if (cenarioY > height) {
      return true;
    } else {
      return false;
    }
  }
}

Cenario cenario;
ArrayList<Cenario> cenarios;

double tempoCenario;

public void cenario() {
  if (!jLeiteMorreu) {
    movimentoCenario = 2;
  } else {
    movimentoCenario = 0;
  }

  cenario.display();
  cenario.update();

  if (totalCenariosCriados < totalCenariosPossiveis && !jLeiteMorreu) {
    if (cenarios.size() < 1) {
      if (estadoJogo == "PrimeiroMapa") {
        cenarios.add(new Cenario(58008, 0));
      }
      if (estadoJogo == "SegundoMapa") {
        cenarios.add(new Cenario(58008, 2));
      }
      if (estadoJogo == "TerceiroMapa") {
        cenarios.add(new Cenario(58008, 4));
      }
      tempoCenario = millisAvancadaMapa;
    }

    if (cenarios.size() < 2 && millisAvancadaMapa + 200 > tempoCenario + ((imagensCenarios[2].height / (60 * movimentoCenario)) * 1000)) {
      totalCenariosCriados = totalCenariosCriados + 1;
      if (estadoJogo == "PrimeiroMapa") {
        if (totalCenariosCriados != totalCenariosPossiveis) {
          cenarios.add(new Cenario(totalCenariosCriados, 0));
        } else {      
          cenarios.add(new Cenario(totalCenariosCriados, 1));
        }
      }
      if (estadoJogo == "SegundoMapa") {
        if (totalCenariosCriados != totalCenariosPossiveis) {
          cenarios.add(new Cenario(totalCenariosCriados, 2));
        } else {      
          cenarios.add(new Cenario(totalCenariosCriados, 3));
        }
      }
      if (estadoJogo == "TerceiroMapa") {
        if (totalCenariosCriados != totalCenariosPossiveis) {
          cenarios.add(new Cenario(totalCenariosCriados, 4));
        } else {      
          cenarios.add(new Cenario(totalCenariosCriados, 5));
        }
      }
      tempoCenario = millisAvancadaMapa;
    }
  }

  for (int i = cenarios.size() - 1; i >= 0; i = i - 1) {
    Cenario c = cenarios.get(i);
    c.display();
    c.update();
    if (c.saiuDaTela()) {
      cenarios.remove(c);
    }
  }
}
PImage sombraComidas;

int tempoGerarComida;
int indexComida;

int totalRecuperado;

int totalComidas;

boolean comidaGerada;

public void comidaTodos() {
  if (!jLeiteMorreu) {
    if (!telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
      if (millisAvancada > tempoGerarComida + 10000 && !comidaGerada) {
        indexComida = PApplet.parseInt(random(0, 10));
        tempoGerarComida = PApplet.parseInt(millisAvancada);
        comidaGerada = true;
      }
    }
  } else {
    indexComida = 10;
  }

  coxinha();
  brigadeiro();
  queijo();
}

PImage coxinha;

public class Coxinha {
  private PImage spriteCoxinha;

  private int coxinhaX = PApplet.parseInt(random(200, 500));
  private int coxinhaY = PApplet.parseInt(random(-300, -1000));

  private int stepCoxinha;
  private int tempoSpriteCoxinha;

  private int totalRecuperado = 0;

  public Coxinha(int coxinhaX, int coxinhaY) {
    this.coxinhaX = coxinhaX;
    this.coxinhaY = coxinhaY;
  }

  public Coxinha() {
  }

  public void display() {
    image (sombraComidas, coxinhaX, coxinhaY + 20);

    if (millis() > tempoSpriteCoxinha + 75) {
      spriteCoxinha = coxinha.get(stepCoxinha, 0, 28, 30);
      stepCoxinha = stepCoxinha % 168 + 28;
      image(spriteCoxinha, coxinhaX, coxinhaY);
      tempoSpriteCoxinha = millis();
    } else {
      image(spriteCoxinha, coxinhaX, coxinhaY);
    }

    if (stepCoxinha == coxinha.width) {
      stepCoxinha = 0;
    }
  }

  public void update() {
    coxinhaY = coxinhaY + 1;
  }

  public boolean apanhado() {
    if (coxinhaX + 27 > jLeiteX && coxinhaX < jLeiteX + 63 && coxinhaY + 30 > jLeiteY && coxinhaY < jLeiteY + 126) {
      tempoGerarComida = PApplet.parseInt(millisAvancada);
      indexComida = 10;
      comidaGerada = false;
      return true;
    } else {
      return false;
    }
  }

  public boolean saiuDaTela() {
    if (coxinhaY > height) {
      return true;
    } else {
      return false;
    }
  }
}

ArrayList<Coxinha> coxinhas;

int indexRandomCoxinhaMapaBoss;

int coxinhaRecuperacao = 5;

public void coxinha() {
  if (totalComidas < 1) {
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      if (coxinhas.size() == 0 && indexComida >= 8 && indexComida <= 9 && !telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
        coxinhas.add(new Coxinha());
        totalComidas = totalComidas + 1;
      }
    }

    if (estadoJogo == "MapaCoveiro") {
      if (coxinhas.size() == 0 && indexComida >= 8 && indexComida <= 9) {
        indexRandomCoxinhaMapaBoss = PApplet.parseInt(random(0, valoresXMapaCoveiro.length));
        coxinhas.add(new Coxinha(valoresXMapaCoveiro[indexRandomCoxinhaMapaBoss], valoresYMapaCoveiro[indexRandomCoxinhaMapaBoss]));
        totalComidas = totalComidas + 1;
      }
    }

    if (estadoJogo == "MapaFazendeiro") {
      if (coxinhas.size() == 0 && indexComida >= 8 && indexComida <= 9) {
        indexRandomCoxinhaMapaBoss = PApplet.parseInt(random(0, valoresXMapaFazendeiro.length));
        coxinhas.add(new Coxinha(valoresXMapaFazendeiro[indexRandomCoxinhaMapaBoss], valoresYMapaFazendeiro[indexRandomCoxinhaMapaBoss]));
        totalComidas = totalComidas + 1;
      }
    }

    if (estadoJogo == "MapaPadre") {
      if (coxinhas.size() == 0 && indexComida >= 8 && indexComida <= 9) {
        indexRandomCoxinhaMapaBoss = PApplet.parseInt(random(0, valoresXMapaPadre.length));
        coxinhas.add(new Coxinha(valoresXMapaPadre[indexRandomCoxinhaMapaBoss], valoresYMapaPadre[indexRandomCoxinhaMapaBoss]));
        totalComidas = totalComidas + 1;
      }
    }
  }

  for (int i = coxinhas.size() - 1; i >= 0; i = i - 1) {
    Coxinha c = coxinhas.get(i);
    c.display();
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      c.update();
    }
    if (c.saiuDaTela()) {
      totalComidas = totalComidas - 1;
      coxinhas.remove(c);
    }
    if (c.apanhado()) {
      while (vidaJLeiteAtual < vidaJleiteMax && c.totalRecuperado < coxinhaRecuperacao) {
        c.totalRecuperado = c.totalRecuperado + 1;
        vidaJLeiteAtual = vidaJLeiteAtual + 1;
      }
      totalComidas = totalComidas - 1;
      coxinhas.remove(c);
    }
  }
}

PImage brigadeiro;

public class Brigadeiro {
  private PImage spriteBrigadeiro;

  private int brigadeiroX = PApplet.parseInt(random(200, 500));
  private int brigadeiroY = PApplet.parseInt(random(-300, -1000));

  private int stepBrigadeiro;
  private int tempoSpriteBrigadeiro;

  private int totalRecuperado = 0;

  public Brigadeiro(int brigadeiroX, int brigadeiroY) {
    this.brigadeiroX = brigadeiroX;
    this.brigadeiroY = brigadeiroY;
  }

  public Brigadeiro() {
  }

  public void display() {
    image (sombraComidas, brigadeiroX + 2, brigadeiroY + 21);

    if (millis() > tempoSpriteBrigadeiro + 75) {
      spriteBrigadeiro = brigadeiro.get(stepBrigadeiro, 0, 32, 31);
      stepBrigadeiro = stepBrigadeiro % 192 + 32;
      image(spriteBrigadeiro, brigadeiroX, brigadeiroY);
      tempoSpriteBrigadeiro = millis();
    } else {
      image(spriteBrigadeiro, brigadeiroX, brigadeiroY);
    }

    if (stepBrigadeiro == brigadeiro.width) {
      stepBrigadeiro = 0;
    }
  }

  public void update() {
    brigadeiroY = brigadeiroY + 1;
  }

  public boolean apanhado() {
    if (brigadeiroX + 32 > jLeiteX && brigadeiroX < jLeiteX + 63 && brigadeiroY + 31 > jLeiteY && brigadeiroY < jLeiteY + 126) {
      tempoGerarComida = PApplet.parseInt(millisAvancada);
      indexComida = 10;
      comidaGerada = false;
      return true;
    } else {
      return false;
    }
  }

  public boolean saiuDaTela() {
    if (brigadeiroY > height) {
      return true;
    } else {
      return false;
    }
  }
}

ArrayList<Brigadeiro> brigadeiros;

int indexRandomBrigadeiroMapaBoss;

int brigadeiroRecuperacao = 4;

public void brigadeiro() {
  if (totalComidas < 1) {
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      if (brigadeiros.size() == 0 && indexComida >= 0 && indexComida <= 4 && !telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
        brigadeiros.add(new Brigadeiro());
        totalComidas = totalComidas + 1;
      }
    }

    if (estadoJogo == "MapaCoveiro") {
      if (brigadeiros.size() == 0 && indexComida >= 0 && indexComida <= 4) {
        indexRandomBrigadeiroMapaBoss = PApplet.parseInt(random(0, valoresXMapaCoveiro.length));
        brigadeiros.add(new Brigadeiro(valoresXMapaCoveiro[indexRandomBrigadeiroMapaBoss], valoresYMapaCoveiro[indexRandomBrigadeiroMapaBoss]));
        totalComidas = totalComidas + 1;
      }
    }

    if (estadoJogo == "MapaFazendeiro") {
      if (brigadeiros.size() == 0 && indexComida >= 0 && indexComida <= 4) {
        indexRandomBrigadeiroMapaBoss = PApplet.parseInt(random(0, valoresXMapaFazendeiro.length));
        brigadeiros.add(new Brigadeiro(valoresXMapaFazendeiro[indexRandomBrigadeiroMapaBoss], valoresYMapaFazendeiro[indexRandomBrigadeiroMapaBoss]));
        totalComidas = totalComidas + 1;
      }
    }

    if (estadoJogo == "MapaPadre") {
      if (brigadeiros.size() == 0 && indexComida >= 0 && indexComida <= 4) {
        indexRandomBrigadeiroMapaBoss = PApplet.parseInt(random(0, valoresXMapaPadre.length));
        brigadeiros.add(new Brigadeiro(valoresXMapaPadre[indexRandomBrigadeiroMapaBoss], valoresYMapaPadre[indexRandomBrigadeiroMapaBoss]));
        totalComidas = totalComidas + 1;
      }
    }
  }

  for (int i = brigadeiros.size() - 1; i >= 0; i = i - 1) {
    Brigadeiro b = brigadeiros.get(i);
    b.display();
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      b.update();
    }
    if (b.saiuDaTela()) {
      totalComidas = totalComidas - 1;
      brigadeiros.remove(b);
    }
    if (b.apanhado()) {
      while (vidaJLeiteAtual < vidaJleiteMax && b.totalRecuperado < coxinhaRecuperacao) {
        b.totalRecuperado = b.totalRecuperado + 1;
        vidaJLeiteAtual = vidaJLeiteAtual + 1;
      }
      totalComidas = totalComidas - 1;
      brigadeiros.remove(b);
    }
  }
}

PImage queijo;

public class Queijo {
  private PImage spriteQueijo;

  private int queijoX = PApplet.parseInt(random(200, 500));
  private int queijoY = PApplet.parseInt(random(-300, -1000));

  private int stepQueijo;
  private int tempoSpriteQueijo;

  private int totalRecuperado = 0;

  public Queijo(int queijoX, int queijoY) {
    this.queijoX = queijoX;
    this.queijoY = queijoY;
  }

  public Queijo() {
  }

  public void display() {
    image (sombraComidas, queijoX, queijoY + 19);

    if (millis() > tempoSpriteQueijo + 75) { 
      spriteQueijo = queijo.get(stepQueijo, 0, 31, 29); 
      stepQueijo = stepQueijo % 186 + 31;
      image(spriteQueijo, queijoX, queijoY); 
      tempoSpriteQueijo = millis();
    } else {
      image(spriteQueijo, queijoX, queijoY);
    }

    if (stepQueijo == queijo.width) {
      stepQueijo = 0;
    }
  }

  public void update() {
    queijoY = queijoY + 1;
  }

  public boolean apanhado() {
    if (queijoX + 31 > jLeiteX && queijoX < jLeiteX + 63 && queijoY + 29 > jLeiteY && queijoY < jLeiteY + 126) {
      tempoGerarComida = PApplet.parseInt(millisAvancada);
      indexComida = 10;
      comidaGerada = false;
      return true;
    } else {
      return false;
    }
  }

  public boolean saiuDaTela() {
    if (queijoY > height) {
      return true;
    } else {
      return false;
    }
  }
}

ArrayList<Queijo> queijos;

int indexRandomQueijoMapaBoss;

int queijoRecuperacao = 3;

public void queijo() {
  if (totalComidas < 1) {
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      if (queijos.size() == 0 && indexComida >= 5 && indexComida <= 7 && !telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
        queijos.add(new Queijo());
        totalComidas = totalComidas + 1;
      }
    }

    if (estadoJogo == "MapaCoveiro") {
      if (queijos.size() == 0 && indexComida >= 5 && indexComida <= 7) {
        indexRandomQueijoMapaBoss = PApplet.parseInt(random(0, valoresXMapaCoveiro.length));
        queijos.add(new Queijo(valoresXMapaCoveiro[indexRandomQueijoMapaBoss], valoresYMapaCoveiro[indexRandomQueijoMapaBoss]));
        totalComidas = totalComidas + 1;
      }
    }

    if (estadoJogo == "MapaFazendeiro") {
      if (queijos.size() == 0 && indexComida >= 5 && indexComida <= 7) {
        indexRandomQueijoMapaBoss = PApplet.parseInt(random(0, valoresXMapaFazendeiro.length));
        queijos.add(new Queijo(valoresXMapaFazendeiro[indexRandomQueijoMapaBoss], valoresYMapaFazendeiro[indexRandomQueijoMapaBoss]));
        totalComidas = totalComidas + 1;
      }
    }

    if (estadoJogo == "MapaPadre") {
      if (queijos.size() == 0 && indexComida >= 5 && indexComida <= 7) {
        indexRandomQueijoMapaBoss = PApplet.parseInt(random(0, valoresXMapaFazendeiro.length));
        queijos.add(new Queijo(valoresXMapaPadre[indexRandomQueijoMapaBoss], valoresYMapaPadre[indexRandomQueijoMapaBoss]));
        totalComidas = totalComidas + 1;
      }
    }
  }

  for (int i = queijos.size() - 1; i >= 0; i = i - 1) {
    Queijo q = queijos.get(i);
    q.display();
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      q.update();
    }
    if (q.saiuDaTela()) {
      totalComidas = totalComidas - 1;
      queijos.remove(q);
    }
    if (q.apanhado()) {
      while (vidaJLeiteAtual < vidaJleiteMax && q.totalRecuperado < coxinhaRecuperacao) {
        q.totalRecuperado = q.totalRecuperado + 1;
        vidaJLeiteAtual = vidaJLeiteAtual + 1;
      }
      totalComidas = totalComidas - 1;
      queijos.remove(q);
    }
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
    if (!telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
      if (PApplet.parseInt(millisAvancada) > tempoGerarInimigo + 250) {
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
        tempoGerarInimigo = PApplet.parseInt(millisAvancada);
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

PImage esqueleto;
PImage sombraEsqueleto;

final int ESQUELETO = 0;

int[] valoresEsqueletoXMapaCoveiro = {200, 520};

public class Esqueleto {
  private PImage spriteEsqueleto;

  private int esqueletoX;
  private int esqueletoY;

  private int stepEsqueleto;
  private int tempoSpriteEsqueleto;

  public Esqueleto(int esqueletoX, int esqueletoY) {
    this.esqueletoX = esqueletoX;
    this.esqueletoY = esqueletoY;
  }

  public void display() {
    image (sombraEsqueleto, esqueletoX + 16, esqueletoY + 114);

    if (millis() > tempoSpriteEsqueleto + 155) { 
      spriteEsqueleto = esqueleto.get(stepEsqueleto, 0, 76, 126); 
      stepEsqueleto = stepEsqueleto % 228 + 76;
      image(spriteEsqueleto, esqueletoX, esqueletoY); 
      tempoSpriteEsqueleto = millis();
    } else {
      image(spriteEsqueleto, esqueletoX, esqueletoY);
    }

    if (stepEsqueleto == esqueleto.width) {
      stepEsqueleto = 0;
    }
  }

  public void update() {
    esqueletoY = esqueletoY + 3;
  }

  public boolean ataque() {
    if (esqueletoX + 76 > jLeiteX && esqueletoX < jLeiteX + 63 && esqueletoY + 126 > jLeiteY && esqueletoY < jLeiteY + 126) {
      return true;
    } else {
      return false;
    }
  }

  public boolean saiuDaTela() {
    if (esqueletoY > height) {
      return true;
    } else {
      return false;
    }
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

    if (!telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
      if (estadoJogo == "PrimeiroMapa" && esqueletos.size() < 2 && totalInimigos < 6) {
        esqueletoC = PApplet.parseInt(random(0, 7));
        esqueletoL = PApplet.parseInt(random(0, 4));

        if (posicoesInimigosNoPrimeiroMapa[esqueletoC][esqueletoL] == ESQUELETO) {
          esqueletos.add(new Esqueleto(100 + (esqueletoC * (600 / 7)), -150 - (esqueletoL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }

      if (estadoJogo == "SegundoMapa" && esqueletos.size() < 2 && totalInimigos < 6) {
        esqueletoC = PApplet.parseInt(random(0, 7));
        esqueletoL = PApplet.parseInt(random(0, 4));

        if (posicoesInimigosNoSegundoMapa[esqueletoC][esqueletoL] == ESQUELETO) {
          esqueletos.add(new Esqueleto(100 + (esqueletoC * (600 / 7)), -150 - (esqueletoL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }

      if (estadoJogo == "TerceiroMapa" && esqueletos.size() < 2 && totalInimigos < 6) {
        esqueletoC = PApplet.parseInt(random(0, 7));
        esqueletoL = PApplet.parseInt(random(0, 4));

        if (posicoesInimigosNoTerceiroMapa[esqueletoC][esqueletoL] == ESQUELETO) {
          esqueletos.add(new Esqueleto(100 + (esqueletoC * (600 / 7)), -150 - (esqueletoL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }
    }
  }

  for (int i = esqueletos.size() - 1; i >= 0; i = i - 1) {
    Esqueleto e = esqueletos.get(i);
    e.display();
    e.update();
    if (e.saiuDaTela()) {
      totalInimigos = totalInimigos - 1;
      esqueletos.remove(e);
    }
    if (e.ataque() && !jLeiteImune) {
      vidaJLeiteAtual = vidaJLeiteAtual - 2;
      jLeiteImune = true;
      tempoImune = millis();
    }
  }

  for (int i = esqueletos.size() - 1; i >= 0; i = i - 1) {
    Esqueleto e = esqueletos.get(i);
    for (int j = pasAtaque.size() - 1; j >= 0; j = j - 1) {
      PaAtaque p = pasAtaque.get(j);
      if (p.acertouEsqueleto(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.esqueletoX, e.esqueletoY);
        esqueletos.remove(e);
      }
    }
    for (int j = pedrasAtiradas.size() - 1; j >= 0; j = j - 1) {
      PedraAtirada p = pedrasAtiradas.get(j);
      if (p.acertouEsqueleto(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.esqueletoX, e.esqueletoY);
        pedrasAtiradas.remove(p);
        esqueletos.remove(e);
      }
    }
    for (int j = chicotes.size() - 1; j >= 0; j = j - 1) {
      ChicoteAtaque c = chicotesAtaque.get(j);
      if (c.acertouEsqueleto(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.esqueletoX, e.esqueletoY);
        esqueletos.remove(e);
      }
    }
  }
}

public void posicoesEsqueleto() {
  posicoesInimigosNoPrimeiroMapa[0][0] = ESQUELETO;
  posicoesInimigosNoPrimeiroMapa[1][2] = ESQUELETO;
  posicoesInimigosNoPrimeiroMapa[2][0] = ESQUELETO;
  posicoesInimigosNoPrimeiroMapa[3][2] = ESQUELETO;
  posicoesInimigosNoPrimeiroMapa[4][0] = ESQUELETO;
  posicoesInimigosNoPrimeiroMapa[5][2] = ESQUELETO;
  posicoesInimigosNoPrimeiroMapa[6][0] = ESQUELETO;

  posicoesInimigosNoSegundoMapa [0][1] = ESQUELETO;
  posicoesInimigosNoSegundoMapa [1][3] = ESQUELETO;
  posicoesInimigosNoSegundoMapa [2][0] = ESQUELETO;
  posicoesInimigosNoSegundoMapa [3][2] = ESQUELETO;
  posicoesInimigosNoSegundoMapa [4][0] = ESQUELETO;
  posicoesInimigosNoSegundoMapa [5][0] = ESQUELETO;
  posicoesInimigosNoSegundoMapa [6][0] = ESQUELETO;

  posicoesInimigosNoTerceiroMapa[0][3] = ESQUELETO;
  posicoesInimigosNoTerceiroMapa[2][0] = ESQUELETO;
  posicoesInimigosNoTerceiroMapa[4][2] = ESQUELETO;
  posicoesInimigosNoTerceiroMapa[6][3] = ESQUELETO;
}

PImage esqueletoChuteAtaque;
PImage esqueletoChuteMovimento;
PImage sombraEsqueletoChute;

final int ESQUELETOCHUTE = 1;

public class EsqueletoChute {
  private PImage spriteEsqueletoChuteAtaque;
  private PImage spriteEsqueletoChuteMovimento;

  private int esqueletoChuteX;
  private int esqueletoChuteY;

  private int movimentoEsqueletoChuteX;
  private int movimentoEsqueletoChuteY;

  private int tempoTrocaDirecaoEsqueletoChuteX;

  private int stepEsqueletoChuteAtaque;
  private int tempoSpriteEsqueletoChuteAtaque;

  private int stepEsqueletoChuteMovimento;
  private int tempoSpriteEsqueletoChuteMovimento;

  private boolean perdeuCabeca;
  private boolean gatilhoEsqueletoCabeca, esqueletoCabecaSaiu;

  public EsqueletoChute(int esqueletoChuteX, int esqueletoChuteY) {
    this.esqueletoChuteX = esqueletoChuteX;
    this.esqueletoChuteY = esqueletoChuteY;
  }

  public void display() {
    image (sombraEsqueletoChute, esqueletoChuteX + 1, esqueletoChuteY + 50);

    if (!perdeuCabeca) {
      if (millis() > tempoSpriteEsqueletoChuteAtaque + 200) { 
        if (esqueletoChuteY < 0) {
          spriteEsqueletoChuteAtaque = esqueletoChuteAtaque.get(0, 0, 49, 74);
        } else {
          spriteEsqueletoChuteAtaque = esqueletoChuteAtaque.get(stepEsqueletoChuteAtaque, 0, 49, 74); 
          stepEsqueletoChuteAtaque = stepEsqueletoChuteAtaque % 245 + 49;
        }
        image(spriteEsqueletoChuteAtaque, esqueletoChuteX, esqueletoChuteY); 
        tempoSpriteEsqueletoChuteAtaque = millis();
      } else {
        image(spriteEsqueletoChuteAtaque, esqueletoChuteX, esqueletoChuteY);
      }

      if (stepEsqueletoChuteAtaque == 196 && !gatilhoEsqueletoCabeca) {
        esqueletoCabecaSaiu = true;
        gatilhoEsqueletoCabeca = true;
      }

      if (stepEsqueletoChuteAtaque == esqueletoChuteAtaque.width) {
        perdeuCabeca = true;
        stepEsqueletoChuteAtaque = 0;
      }
    } else {
      if (millis() > tempoSpriteEsqueletoChuteMovimento + 200) { 
        spriteEsqueletoChuteMovimento = esqueletoChuteMovimento.get(stepEsqueletoChuteMovimento, 0, 48, 74); 
        stepEsqueletoChuteMovimento = stepEsqueletoChuteMovimento % 192 + 48;
        image(spriteEsqueletoChuteMovimento, esqueletoChuteX, esqueletoChuteY); 
        tempoSpriteEsqueletoChuteMovimento = millis();
      } else {
        image(spriteEsqueletoChuteMovimento, esqueletoChuteX, esqueletoChuteY);
      }

      if (stepEsqueletoChuteMovimento == esqueletoChuteMovimento.width) {
        stepEsqueletoChuteMovimento = 0;
      }
    }
  }

  public void update() {
    esqueletoChuteX = esqueletoChuteX + movimentoEsqueletoChuteX;
    esqueletoChuteY = esqueletoChuteY + movimentoEsqueletoChuteY;

    if (!perdeuCabeca) {
      movimentoEsqueletoChuteY = PApplet.parseInt(movimentoCenario);
      movimentoEsqueletoChuteX = 0;
    } else {
      movimentoEsqueletoChuteY = PApplet.parseInt(movimentoCenario) + 1;
      if (millis() > tempoTrocaDirecaoEsqueletoChuteX + 350) {
        movimentoEsqueletoChuteX = PApplet.parseInt(random(-5, 5));
        tempoTrocaDirecaoEsqueletoChuteX = millis();
      }
    }
  }

  public boolean ataque() {
    if (esqueletoChuteX + 48 > jLeiteX && esqueletoChuteX < jLeiteX + 63 && esqueletoChuteY + 74 > jLeiteY && esqueletoChuteY < jLeiteY + 126) {
      return true;
    } else {
      return false;
    }
  }

  public boolean saiuDaTela() {
    if (esqueletoChuteY > height) {
      return true;
    } else {
      return false;
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

    if (!telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
      if (estadoJogo == "PrimeiroMapa" && esqueletosChute.size() < 2 && totalInimigos < 6) {
        esqueletoChuteC = PApplet.parseInt(random(0, 7));
        esqueletoChuteL = PApplet.parseInt(random(0, 4));

        if (posicoesInimigosNoPrimeiroMapa[esqueletoChuteC][esqueletoChuteL] == ESQUELETOCHUTE) {
          esqueletosChute.add(new EsqueletoChute(100 + (esqueletoChuteC * (600 / 7)), -150 - (esqueletoChuteL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }
      if (estadoJogo == "SegundoMapa" && esqueletosChute.size() < 2 && totalInimigos < 6) {
        esqueletoChuteC = PApplet.parseInt(random(0, 7));
        esqueletoChuteL = PApplet.parseInt(random(0, 4));

        if (posicoesInimigosNoSegundoMapa[esqueletoChuteC][esqueletoChuteL] == ESQUELETOCHUTE) {
          esqueletosChute.add(new EsqueletoChute(100 + (esqueletoChuteC * (600 / 7)), -150 - (esqueletoChuteL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }
      if (estadoJogo == "TerceiroMapa" && esqueletosChute.size() < 2 && totalInimigos < 6) {
        esqueletoChuteC = PApplet.parseInt(random(0, 7));
        esqueletoChuteL = PApplet.parseInt(random(0, 4));

        if (posicoesInimigosNoTerceiroMapa[esqueletoChuteC][esqueletoChuteL] == ESQUELETOCHUTE) {
          esqueletosChute.add(new EsqueletoChute(100 + (esqueletoChuteC * (600 / 7)), -150 - (esqueletoChuteL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }
    }
  }

  for (int i = esqueletosChute.size() - 1; i >= 0; i = i - 1) {
    EsqueletoChute e = esqueletosChute.get(i);
    e.display();
    if (e.esqueletoCabecaSaiu) {
      cabecasEsqueleto.add(new CabecaEsqueleto(e.esqueletoChuteX, e.esqueletoChuteY, jLeiteX));
      e.esqueletoCabecaSaiu = false;
    }
    e.update();
    if (e.saiuDaTela()) {
      totalInimigos = totalInimigos - 1;
      esqueletosChute.remove(e);
    }
    if (e.ataque() && !jLeiteImune) {
      vidaJLeiteAtual = vidaJLeiteAtual - 2;
      jLeiteImune = true;
      tempoImune = millis();
    }
  }

  for (int i = esqueletosChute.size() - 1; i >= 0; i = i - 1) {
    EsqueletoChute e = esqueletosChute.get(i);
    for (int j = pasAtaque.size() - 1; j >= 0; j = j - 1) {
      PaAtaque p = pasAtaque.get(j);
      if (p.acertouEsqueletoChute(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.esqueletoChuteX - 40, e.esqueletoChuteY - 20);
        esqueletosChute.remove(e);
      }
    }
    for (int j = pedrasAtiradas.size() - 1; j >= 0; j = j - 1) {
      PedraAtirada p = pedrasAtiradas.get(j);
      if (p.acertouEsqueletoChute(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.esqueletoChuteX - 40, e.esqueletoChuteY - 20);
        pedrasAtiradas.remove(p);
        esqueletosChute.remove(e);
      }
    }
    for (int j = chicotes.size() - 1; j >= 0; j = j - 1) {
      ChicoteAtaque c = chicotesAtaque.get(j);
      if (c.acertouEsqueletoChute(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.esqueletoChuteX - 40, e.esqueletoChuteY - 20);
        esqueletosChute.remove(e);
      }
    }
  }
}

public void posicoesEsqueletoChute() {
  posicoesInimigosNoPrimeiroMapa[0][2] = ESQUELETOCHUTE;
  posicoesInimigosNoPrimeiroMapa[1][0] = ESQUELETOCHUTE;
  posicoesInimigosNoPrimeiroMapa[2][2] = ESQUELETOCHUTE;
  posicoesInimigosNoPrimeiroMapa[3][0] = ESQUELETOCHUTE;
  posicoesInimigosNoPrimeiroMapa[4][2] = ESQUELETOCHUTE;
  posicoesInimigosNoPrimeiroMapa[5][0] = ESQUELETOCHUTE;
  posicoesInimigosNoPrimeiroMapa[6][2] = ESQUELETOCHUTE;

  posicoesInimigosNoSegundoMapa [0][2] = ESQUELETOCHUTE;
  posicoesInimigosNoSegundoMapa [1][0] = ESQUELETOCHUTE;
  posicoesInimigosNoSegundoMapa [2][3] = ESQUELETOCHUTE;
  posicoesInimigosNoSegundoMapa [3][3] = ESQUELETOCHUTE;
  posicoesInimigosNoSegundoMapa [4][2] = ESQUELETOCHUTE;
  posicoesInimigosNoSegundoMapa [5][3] = ESQUELETOCHUTE;
  posicoesInimigosNoSegundoMapa [6][3] = ESQUELETOCHUTE;

  posicoesInimigosNoTerceiroMapa[0][2] = ESQUELETOCHUTE;
  posicoesInimigosNoTerceiroMapa[1][3] = ESQUELETOCHUTE;
  posicoesInimigosNoTerceiroMapa[2][1] = ESQUELETOCHUTE;
  posicoesInimigosNoTerceiroMapa[4][3] = ESQUELETOCHUTE;
  posicoesInimigosNoTerceiroMapa[5][1] = ESQUELETOCHUTE;
}

PImage cabecaEsqueletoChute;

public class CabecaEsqueleto {
  private float cabecaEsqueletoX;
  private float cabecaEsqueletoY;

  private float movimentoCabecaEsqueletoX;

  private float destinoCabecaEsqueletoX;

  private boolean cabecaEsqueletoReta;

  public CabecaEsqueleto(float cabecaEsqueletoX, float cabecaEsqueletoY, float destinoCabecaEsqueletoX) {
    this.cabecaEsqueletoX = cabecaEsqueletoX;
    this.cabecaEsqueletoY = cabecaEsqueletoY;
    this.destinoCabecaEsqueletoX = destinoCabecaEsqueletoX;
  }

  public void display() {
    image(cabecaEsqueletoChute, cabecaEsqueletoX, cabecaEsqueletoY);
  }

  public void update() {
    cabecaEsqueletoX = cabecaEsqueletoX + movimentoCabecaEsqueletoX;
    if (!cabecaEsqueletoReta) {
      if (cabecaEsqueletoX > destinoCabecaEsqueletoX) {
        movimentoCabecaEsqueletoX = -8;
      } else {
        movimentoCabecaEsqueletoX = 8;
      }
    } else {
      movimentoCabecaEsqueletoX = 0;
    }

    cabecaEsqueletoY = cabecaEsqueletoY + 12;
  }

  public void checaCabecaEsqueletoReta() {
    if (cabecaEsqueletoX < destinoCabecaEsqueletoX) {
      if (destinoCabecaEsqueletoX - cabecaEsqueletoX < 10) {  
        cabecaEsqueletoReta = true;
      } else {
        cabecaEsqueletoReta = false;
      }
    } else {
      if (cabecaEsqueletoX - destinoCabecaEsqueletoX < 10) {  
        cabecaEsqueletoReta = true;
      } else {
        cabecaEsqueletoReta = false;
      }
    }
  }

  public boolean acertouJLeite() {
    if (cabecaEsqueletoX + 36 > jLeiteX && cabecaEsqueletoX < jLeiteX + 63 && cabecaEsqueletoY + 89 > jLeiteY && cabecaEsqueletoY + 50 < jLeiteY + 126) {
      return true;
    } else {
      return false;
    }
  }

  public boolean saiuDaTela() {
    if (cabecaEsqueletoY > height) {
      return true;
    } else {
      return false;
    }
  }
}

ArrayList<CabecaEsqueleto> cabecasEsqueleto;

public void cabecaEsqueleto() {
  for (int i = cabecasEsqueleto.size() - 1; i >= 0; i = i - 1) {
    CabecaEsqueleto c = cabecasEsqueleto.get(i);
    c.display();
    c.update();
    c.checaCabecaEsqueletoReta();
    if (c.saiuDaTela()) {
      cabecasEsqueleto.remove(c);
    }

    if (c.acertouJLeite() && !jLeiteImune) {
      vidaJLeiteAtual = vidaJLeiteAtual - 3;
      jLeiteImune = true;
      tempoImune = millis();
    }
  }
}

PImage cachorro;
PImage sombraCachorro;

final int CACHORRO = 2;

int[] valoresCachorroXMapaFazendeiro = {70, 382, 695};

public class Cachorro {
  private PImage spriteCachorro;

  private int cachorroX;
  private int cachorroY;

  private int stepCachorro;
  private int tempoSpriteCachorro;

  public Cachorro(int cachorroX, int cachorroY) {
    this.cachorroX = cachorroX;
    this.cachorroY = cachorroY;
  }

  public void display() {
    image (sombraCachorro, cachorroX, cachorroY + 45);

    if (millis() > tempoSpriteCachorro + 55) { 
      spriteCachorro = cachorro.get(stepCachorro, 0, 45, 83); 
      stepCachorro = stepCachorro % 270 + 45;
      image(spriteCachorro, cachorroX, cachorroY); 
      tempoSpriteCachorro = millis();
    } else {
      image(spriteCachorro, cachorroX, cachorroY);
    }

    if (stepCachorro == cachorro.width) {
      stepCachorro = 0;
    }
  }

  public void update() {
    cachorroY = cachorroY + 8;
  }

  public boolean ataque() {
    if (cachorroX + 45 > jLeiteX && cachorroX < jLeiteX + 63 && cachorroY + 83 > jLeiteY && cachorroY < jLeiteY) {
      return true;
    } else {
      return false;
    }
  }

  public boolean saiuDaTela() {
    if (cachorroY > height) {
      return true;
    } else {
      return false;
    }
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

    if (!telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
      if (estadoJogo == "SegundoMapa" && cachorros.size() < 2 && totalInimigos < 6) {
        cachorroC = PApplet.parseInt(random(0, 7));
        cachorroL = PApplet.parseInt(random(0, 4));

        if (posicoesInimigosNoSegundoMapa[cachorroC][cachorroL] == CACHORRO) {
          cachorros.add(new Cachorro(100 + (cachorroC * (600 / 7)), -150 - (cachorroL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }

      if (estadoJogo == "TerceiroMapa" && cachorros.size() < 2 && totalInimigos < 6) {
        cachorroC = PApplet.parseInt(random(0, 7));
        cachorroL = PApplet.parseInt(random(0, 4));

        if (posicoesInimigosNoTerceiroMapa[cachorroC][cachorroL] == CACHORRO) {
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
    if (c.saiuDaTela()) {
      totalInimigos = totalInimigos - 1;
      cachorros.remove(c);
    }
    if (c.ataque() && !jLeiteImune) {
      vidaJLeiteAtual = vidaJLeiteAtual - 2;
      jLeiteImune = true;
      tempoImune = millis();
    }
  }

  for (int i = cachorros.size() - 1; i >= 0; i = i - 1) {
    Cachorro c = cachorros.get(i);
    for (int j = pasAtaque.size() - 1; j >= 0; j = j - 1) {
      PaAtaque p = pasAtaque.get(j);
      if (p.acertouCachorro(c)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(c.cachorroX, c.cachorroY);
        cachorros.remove(c);
      }
    }
    for (int j = pedrasAtiradas.size() - 1; j >= 0; j = j - 1) {
      PedraAtirada p = pedrasAtiradas.get(j);
      if (p.acertouCachorro(c)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(c.cachorroX, c.cachorroY);
        pedrasAtiradas.remove(p);
        cachorros.remove(c);
      }
    }
    for (int j = chicotes.size() - 1; j >= 0; j = j - 1) {
      ChicoteAtaque ch = chicotesAtaque.get(j);
      if (ch.acertouCachorro(c)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(c.cachorroX, c.cachorroY);
        cachorros.remove(c);
      }
    }
  }
}

public void posicoesCachorro() {
  posicoesInimigosNoSegundoMapa [0][0] = CACHORRO;
  posicoesInimigosNoSegundoMapa [1][1] = CACHORRO;
  posicoesInimigosNoSegundoMapa [2][2] = CACHORRO;
  posicoesInimigosNoSegundoMapa [3][0] = CACHORRO;
  posicoesInimigosNoSegundoMapa [4][3] = CACHORRO;
  posicoesInimigosNoSegundoMapa [5][2] = CACHORRO;
  posicoesInimigosNoSegundoMapa [6][2] = CACHORRO;

  posicoesInimigosNoTerceiroMapa[1][0] = CACHORRO;
  posicoesInimigosNoTerceiroMapa[3][0] = CACHORRO;
  posicoesInimigosNoTerceiroMapa[5][2] = CACHORRO;
  posicoesInimigosNoTerceiroMapa[6][1] = CACHORRO;
}

PImage corvo;
PImage sombraCorvo;

public class Corvo {
  private PImage spriteCorvo;

  private float corvoX = random(100, width - 163);
  private float corvoY = random(-300, -1000);

  private int destinoCorvoX = jLeiteX;

  private int tempoNovoDestino;
  private int tempoRandom = PApplet.parseInt(random(500, 1201));

  private int stepCorvo;
  private int tempoSpriteCorvo;

  private boolean novoDestino;

  public Corvo() {
  }

  public Corvo(float corvoX, float corvoY) {
    this.corvoX = corvoX;
    this.corvoY = corvoY;
  }

  public void display() {
    if (millis() > tempoSpriteCorvo + 75) { 
      spriteCorvo = corvo.get(stepCorvo, 0, 121, 86); 
      stepCorvo = stepCorvo % 363 + 121;
      image(spriteCorvo, corvoX, corvoY); 
      tempoSpriteCorvo = millis();
    } else {
      image(spriteCorvo, corvoX, corvoY);
    }

    if (stepCorvo == corvo.width) {
      stepCorvo = 0;
    }

    image(sombraCorvo, corvoX + 24, corvoY + 86);
  }  

  public void atualizaAlvo() {
    if (corvoY > 0) {
      if (destinoCorvoX != jLeiteX && !novoDestino) {
        tempoNovoDestino = millis();
        novoDestino = true;
      }
      if (millis() > tempoNovoDestino + tempoRandom) {
        destinoCorvoX = jLeiteX;
        tempoNovoDestino = millis();
        novoDestino = false;
      }
    }
  }

  public void update() {
    if (corvoX < destinoCorvoX) {
      corvoX = corvoX + 2.5f;
    }
    if (corvoX > destinoCorvoX) {
      corvoX = corvoX  - 2.5f;
    }
    corvoY = corvoY + 3.5f;
  }

  public boolean ataque() {
    if (corvoX + 95 > jLeiteX && corvoX + 25 < jLeiteX + 63 && corvoY + 86 > jLeiteY && corvoY < jLeiteY + 126) {
      return true;
    } else {
      return false;
    }
  }

  public boolean saiuDaTela() {
    if (corvoY > height) {
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

    if (!telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
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
    c.display();
    c.atualizaAlvo();
    c.update();
    if (c.saiuDaTela()) {
      corvos.remove(c);
    }
    if (c.ataque() && !jLeiteImune) {
      vidaJLeiteAtual = vidaJLeiteAtual - 3;
      jLeiteImune = true;
      tempoImune = millis();
    }
  }

  for (int i = corvos.size() - 1; i >= 0; i = i - 1) {
    Corvo c = corvos.get(i);
    for (int j = pasAtaque.size() - 1; j >= 0; j = j - 1) {
      PaAtaque p = pasAtaque.get(j);
      if (p.acertouCorvo(c)) {
        hitInimigos(c.corvoX, c.corvoY);
        corvos.remove(c);
      }
    }
    for (int j = pedrasAtiradas.size() - 1; j >= 0; j = j - 1) {
      PedraAtirada p = pedrasAtiradas.get(j);
      if (p.acertouCorvo(c)) {
        hitInimigos(c.corvoX, c.corvoY);
        pedrasAtiradas.remove(p);
        corvos.remove(c);
      }
    }
    for (int j = chicotes.size() - 1; j >= 0; j = j - 1) {
      ChicoteAtaque ch = chicotesAtaque.get(j);
      if (ch.acertouCorvo(c)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(c.corvoX, c.corvoY);
        corvos.remove(c);
      }
    }
  }
}

PImage esqueletoRaiva;
PImage sombraEsqueletoRaiva;

final int ESQUELETORAIVA = 3;

public class EsqueletoRaiva {
  private PImage spriteEsqueletoRaiva;

  private int esqueletoRaivaX;
  private int esqueletoRaivaY;

  private int movimentoEsqueletoRaivaX = 3;

  private int stepEsqueletoRaiva;
  private int tempoSpriteEsqueletoRaiva;

  public EsqueletoRaiva(int esqueletoRaivaX, int esqueletoRaivaY) {
    this.esqueletoRaivaX = esqueletoRaivaX;
    this.esqueletoRaivaY = esqueletoRaivaY;
  }

  public void display() {
    image(sombraEsqueletoRaiva, esqueletoRaivaX + 16, esqueletoRaivaY + 114);

    if (millis() > tempoSpriteEsqueletoRaiva + 75) {
      spriteEsqueletoRaiva = esqueletoRaiva.get(stepEsqueletoRaiva, 0, 76, 126);
      stepEsqueletoRaiva = stepEsqueletoRaiva % 228 + 76;
      image(spriteEsqueletoRaiva, esqueletoRaivaX, esqueletoRaivaY);
      tempoSpriteEsqueletoRaiva = millis();
    } else {
      image(spriteEsqueletoRaiva, esqueletoRaivaX, esqueletoRaivaY);
    }

    if (stepEsqueletoRaiva == esqueletoRaiva.width) {
      stepEsqueletoRaiva = 0;
    }
  }

  public void update() {
    esqueletoRaivaX = esqueletoRaivaX + movimentoEsqueletoRaivaX;

    if (esqueletoRaivaX < 100) {
      movimentoEsqueletoRaivaX = 3;
    }
    if (esqueletoRaivaX + 30 > 700) {
      movimentoEsqueletoRaivaX = -3;
    } 

    esqueletoRaivaY = esqueletoRaivaY + 3;
  }

  public boolean ataque() {
    if (esqueletoRaivaX + 76 > jLeiteX && esqueletoRaivaX < jLeiteX + 63 && esqueletoRaivaY + 126 > jLeiteY && esqueletoRaivaY < jLeiteY + 126) {
      return true;
    } else {
      return false;
    }
  }

  public boolean saiuDaTela() {
    if (esqueletoRaivaY > height) {
      return true;
    } else {
      return false;
    }
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

    if (!telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
      if (estadoJogo == "TerceiroMapa" && esqueletosRaiva.size() < 2 && totalInimigos < 6) {
        esqueletoRaivaC = PApplet.parseInt(random(0, 7));
        esqueletoRaivaL = PApplet.parseInt(random(0, 4));

        if (posicoesInimigosNoTerceiroMapa[esqueletoRaivaC][esqueletoRaivaL] == ESQUELETORAIVA) {
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
    if (e.saiuDaTela()) {
      totalInimigos = totalInimigos - 1;
      esqueletosRaiva.remove(e);
    }
    if (e.ataque() && !jLeiteImune) {
      vidaJLeiteAtual = vidaJLeiteAtual - 3;
      jLeiteImune = true;
      tempoImune = millis();
    }
  }

  for (int i = esqueletosRaiva.size() - 1; i >= 0; i = i - 1) {
    EsqueletoRaiva e = esqueletosRaiva.get(i);
    for (int j = pasAtaque.size() - 1; j >= 0; j = j - 1) {
      PaAtaque p = pasAtaque.get(j);
      if (p.acertouEsqueletoRaiva(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.esqueletoRaivaX, e.esqueletoRaivaY);
        esqueletosRaiva.remove(e);
      }
    }
    for (int j = pedrasAtiradas.size() - 1; j >= 0; j = j - 1) {
      PedraAtirada p = pedrasAtiradas.get(j);
      if (p.acertouEsqueletoRaiva(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.esqueletoRaivaX, e.esqueletoRaivaY);
        pedrasAtiradas.remove(p);
        esqueletosRaiva.remove(e);
      }
    }
    for (int j = chicotes.size() - 1; j >= 0; j = j - 1) {
      ChicoteAtaque ch = chicotesAtaque.get(j);
      if (ch.acertouEsqueletoRaiva(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.esqueletoRaivaX, e.esqueletoRaivaY);
        esqueletosRaiva.remove(e);
      }
    }
  }
}

public void posicoesEsqueletoRaiva() {
  posicoesInimigosNoTerceiroMapa[0][0] = ESQUELETORAIVA;
  posicoesInimigosNoTerceiroMapa[1][2] = ESQUELETORAIVA;
  posicoesInimigosNoTerceiroMapa[2][3] = ESQUELETORAIVA;
  posicoesInimigosNoTerceiroMapa[3][2] = ESQUELETORAIVA;
  posicoesInimigosNoTerceiroMapa[4][1] = ESQUELETORAIVA;
  posicoesInimigosNoTerceiroMapa[5][0] = ESQUELETORAIVA;
  posicoesInimigosNoTerceiroMapa[6][2] = ESQUELETORAIVA;
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

  if (totalCenariosCriados >= totalCenariosPossiveis && finalMapa) {
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

  if (!portaAberta) {
    if (totalCenariosCriados >= totalCenariosPossiveis) {
      if (jLeiteY < 126 && jLeiteY < height) {
        jLeiteY = jLeiteY + 3;
      }
    }
  }

  if (!cercaAberta) {
    if (totalCenariosCriados >= totalCenariosPossiveis) {
      if (jLeiteY < 126 && jLeiteY < height) {
        jLeiteY = jLeiteY + 3;
      }
    }
  }

  for (int i = cenarios.size() - 1; i >= 0; i = i - 1) {
    Cenario c = cenarios.get(i);
    if (c.indexCenarioCriado == totalCenariosPossiveis) {
      if (jLeiteY < c.cenarioY + 474) {
        finalMapa = true;
      }
    }
  }

  if (finalMapa && (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa")) {
    if (jLeiteX != 380) {
      if (jLeiteX < 380) {
        jLeiteX = jLeiteX + 1;
      } else {
        jLeiteX = jLeiteX - 1;
      }
    } else {
      if (estadoJogo == "PrimeiroMapa") {
        if (portaAberta) {
          if (jLeiteY + 126 > -100) {
            jLeiteY = jLeiteY - 2;
          } else {
            jLeiteY = 474;
            estadoJogo = "MapaCoveiro";
            finalMapa = false;
          }
        }
      } else if (estadoJogo == "SegundoMapa") {
        if (cercaAberta) {
          if (jLeiteY + 126 > -100) {
            jLeiteY = jLeiteY - 2;
          } else {
            jLeiteY = 474;
            estadoJogo = "MapaFazendeiro";
            finalMapa = false;
          }
        }
      } else if (estadoJogo == "TerceiroMapa") {
        if (jLeiteY + 126 > -100) {
          jLeiteY = jLeiteY - 2;
        } else {
          jLeiteY = 474;
          estadoJogo = "MapaPadre";
          finalMapa = false;
        }
      }
    }
  }

  if (vidaJLeiteAtual < 0 && !jLeiteMorreu) {
    jLeiteMorreu = true;
    jLeiteMorrendo = true;
    tempoMorto = PApplet.parseInt(millisAvancada);
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

  if (jLeiteMorreu && millisAvancada > tempoMorto + 2500) {
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
  millisAvancadaMapa = millisAvancadaMapa + 1000 / 60;

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

  if (millisAvancada > tempoBossMorreu + 3000 && coveiro.coveiroMorreu) {
    estadoJogo = "SegundoMapa";
  }

  if (millisAvancada > tempoBossMorreu + 3000 && fazendeiro.fazendeiroMorreu) {
    estadoJogo = "TerceiroMapa";
  }

  if (millisAvancada > tempoBossMorreu + 7000 && padre.padreMorreu) {
    estadoJogo = "Vitoria";
  }


  cenario();
  inimigosTodos();
  armas(); 
  jLeite(); 
  comidaTodos();
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
    
    background(imagensCenariosBoss[0]);
    coveiro();
    armas();
    jLeite();
    vida();
    comidaTodos();
    caixaNumeroItem();
    totalCenariosCriados = 0;
  }

  if (estadoJogo == "MapaFazendeiro") {
    if (musicasAtivas) {
      temaBoss.play();
    }
    background(imagensCenariosBoss[1]);
    fazendeiro();
    armas(); 
    jLeite();
    vida();
    comidaTodos();
    caixaNumeroItem();
    totalCenariosCriados = 0;
  }

  if (estadoJogo == "MapaPadre") {
    if (musicasAtivas) {
      temaBoss.play();
    }

    background(imagensCenariosBoss[2]);
    padre();
    armas();
    jLeite();
    vida();
    comidaTodos();
    caixaNumeroItem();
    totalCenariosCriados = 0;
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