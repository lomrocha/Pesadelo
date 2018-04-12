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

enum GameState {
  FIRSTMAP, SECONDMAP, THIRDMAP, FIRSTBOSS, SECONDBOSS, THIRDBOSS, MAINMENU, CONTROLSMENU, CREDITSMENU, WIN, GAMEOVER
}

int gameState;
int lastState;

final int[][] ENEMY_POSITIONS_FIRST_MAP = new int [7][4];
final int[][] ENEMY_POSITIONS_SECOND_MAP = new int [7][4];
final int[][] ENEMY_POSITIONS_THIRD_MAP  = new int [7][4];

final int[] ENEMY_MAXIMUM_FIRST_MAP = {2, 2, 3, 4, 5, 0};
final int[] ENEMY_MAXIMUM_SECOND_MAP = {};
final int[] ENEMY_MAXIMUM_THIRD_MAP = {};

final int[] X_VALUES_FIRST_BOSS = {50, 720};
final int[] Y_VALUES_FIRST_BOSS = {380, 380};

final int[] X_VALUES_SECOND_BOSS = {45, 45, 735, 735};
final int[] Y_VALUES_SECOND_BOSS = {200, 358, 200, 358};

final int[] X_VALUES_THIRD_BOSS = {62, 62, 710, 710};
final int[] Y_VALUES_THIRD_BOSS = {249, 401, 249, 401};

boolean ativaBarraEspaco;

boolean isMusicActive = true;
boolean isSoundActive = true;

Handler handler;
MainMenu mm;
Controls ctrl;
Credits cre;

HitpointsLayout playerHP;
HitpointsLayout coveiroHP;
HitpointsLayout fazendeiroHP;
HitpointsLayout padreHP;
HitpointsLayout madPadreHP;

ItemBox ib;

FirstMapEnemiesSpawnManager firstMapEnemiesSpawnManager;

public void setup() {
  

  minim = new Minim (this);

  audioPreLoad();
  imagesPreLoad();

  variablesPreLoad();

  handler = new Handler();

  playerHP = new HitpointsLayout(0);
  coveiroHP = new HitpointsLayout(1);
  fazendeiroHP = new HitpointsLayout(2);
  padreHP = new HitpointsLayout(3);
  madPadreHP = new HitpointsLayout(4);

  ib = new ItemBox();

  coveiro = new Coveiro();
  fazendeiro = new Fazendeiro();
  padre = new Padre();
  
  firstMapEnemiesSpawnManager = new FirstMapEnemiesSpawnManager(ENEMY_MAXIMUM_FIRST_MAP, 2);
}

public void draw() {
  if (gameState >= GameState.FIRSTMAP.ordinal() && gameState <= GameState.THIRDMAP.ordinal()) {
    jogando();
    if (!movementTutorialScreenActive) {
      noCursor();
      //weaponTutorialScreen();
    }
  } else {
    menu();
    cursor(HAND);
  }
}

public void keyPressed() {
  if (key == ESC) {
    key = 0;
    variablesPreLoad();
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
    variablesPreLoad();
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

public void mouseReleased() {
  hasClickedOnce = false;
}
int item;

int weaponTotal;

int itemTotal;
int timeToGenerateItem;
int itemIndex;

int itemRandomMapPositionIndex;

int intervalToGenerateItem;

boolean hasItemIndexChanged;

public void armas() {
  if (weaponTotal == 0 && !jLeiteUsoItem && itens.size() == 0) {
    item = 0;
    itemTotal = 0;
  }

  if (itemTotal == 0 && hasItemIndexChanged && millis() > timeToGenerateItem + intervalToGenerateItem && itens.size() == 0) {
    if (gameState >= GameState.FIRSTMAP.ordinal() && gameState <= GameState.THIRDMAP.ordinal()) {
      addItem();
    } else if (gameState >= GameState.FIRSTBOSS.ordinal() && gameState <= GameState.THIRDBOSS.ordinal()) {
      addItemBoss();
    }
  }

  generateItemIndex();
  item();
  if (armas.size() > 0) {
    arma();
  }

  if (jLeiteUsoItem && armas.size() == 0 && weaponTotal > 0) {
    weapon();
  }
}

public void generateItemIndex() {
  if (!movementTutorialScreenActive) {
    if (!hasItemIndexChanged) {
      itemIndex = PApplet.parseInt(random(0, 10));
      hasItemIndexChanged = true;
    }
  }
}

ArrayList<Arma> armas = new ArrayList<Arma>();

public abstract class Arma extends MaisGeral {
  private int firstCollisionX;
  private int secondCollisionX;
  private int firstCollisionY;
  private int secondCollisionY;

  private boolean deleteWeapon;
  private boolean damageBoss;

  public int getFirstCollisionX() {
    return firstCollisionX;
  }
  protected void setFirstCollisionX(int firstCollisionX) {
    this.firstCollisionX = firstCollisionX;
  }

  public int getSecondCollisionX() {
    return secondCollisionX;
  }
  protected void setSecondCollisionX(int secondCollisionX) {
    this.secondCollisionX = secondCollisionX;
  }

  public int getFirstCollisionY() {
    return firstCollisionY;
  }
  protected void setFirstCollisionY(int firstCollisionY) {
    this.firstCollisionY = firstCollisionY;
  }

  public int getSecondCollisionY() {
    return secondCollisionY;
  }
  protected void setSecondCollisionY(int secondCollisionY) {
    this.secondCollisionY = secondCollisionY;
  }

  public boolean getDeleteWeapon() {
    return deleteWeapon;
  } 
  protected void setDeleteWeapon(boolean deleteWeapon) {
    this.deleteWeapon = deleteWeapon;
  }

  public boolean getDamageBoss() {
    return damageBoss;
  }
  protected void setDamageBoss(boolean damageBoss) {
    this.damageBoss = damageBoss;
  }

  public void stepHandler() {
    if (getStep() == getSpriteImage().width) {
      this.deleteWeapon = true;
    }
  }

  public abstract void update();

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

boolean oneWeapon;

public void weapon() {
  if (!oneWeapon) {
    switch(item) {
    case WHIP: 
      armas.add(new ChicoteAtaque());
      break;
    case SHOVEL:
      armas.add(new PaAtaque());
      break;
    }

    weaponTotal--;
    oneWeapon = true;
  }
}

public void arma() {
  for (int i = armas.size() - 1; i >= 0; i = i - 1) {
    Arma a = armas.get(i);
    a.update();
    a.display();
    if (a.getDeleteWeapon()) {
      armas.remove(a);
    }
    if (gameState == GameState.FIRSTBOSS.ordinal()) {
      if (a.hasHitCoveiro() && !a.getDamageBoss()) {
        if (isSoundActive) {
          indexRandomSomCoveiroTomandoDano = PApplet.parseInt(random(0, sonsCoveiroTomandoDano.length));
          sonsCoveiroTomandoDano[indexRandomSomCoveiroTomandoDano].rewind();
          sonsCoveiroTomandoDano[indexRandomSomCoveiroTomandoDano].play();
        }
        coveiroCurrentHP -= 2;
        a.setDamageBoss(true);
      }
    }
    if (gameState == GameState.SECONDBOSS.ordinal()) {
      if (a.hasHitFazendeiro() && !a.getDamageBoss()) {
        if (isSoundActive) {
          indexRandomSomFazendeiroTomandoDano = PApplet.parseInt(random(0, sonsFazendeiroTomandoDano.length));
          sonsFazendeiroTomandoDano[indexRandomSomFazendeiroTomandoDano].rewind();
          sonsFazendeiroTomandoDano[indexRandomSomFazendeiroTomandoDano].play();
        }
        fazendeiroCurrentHP -= 2;
        a.setDamageBoss(true);
      }
    }
    if (gameState == GameState.THIRDBOSS.ordinal()) {
      if (a.hasHitPadre() && !a.getDamageBoss()) {
        if (padreCurrentHP > 0) {
          if (isSoundActive) {
            indexRandomSomPadreTomandoDano = PApplet.parseInt(random(0, sonsPadreTomandoDano.length));
            sonsPadreTomandoDano[indexRandomSomPadreTomandoDano].rewind();
            sonsPadreTomandoDano[indexRandomSomPadreTomandoDano].play();
          }
          padreCurrentHP -= 2;
          a.setDamageBoss(true);
        } else {
          if (isSoundActive) {
            indexRandomSomPadreTomandoDano = PApplet.parseInt(random(0, sonsPadreRaivaTomandoDano.length));
            sonsPadreRaivaTomandoDano[indexRandomSomPadreTomandoDano].rewind();
            sonsPadreRaivaTomandoDano[indexRandomSomPadreTomandoDano].play();
          }
          madPadreCurrentHP -= 2;
          a.setDamageBoss(true);
        }
      }
    }
  }
}
public class Background extends MaisGeral {
  Background() {
    setX(0);
    setY(0);

    setSpriteImage(backgroundMenu);
    setSpriteInterval(140);
    setSpriteWidth(800);
    setSpriteHeight(600);
  }
}
PImage bossHPBackground;
PImage bossHPBar;
PImage[] bossBonesLayout = new PImage [4];

final int bossHPBackgroundX = 0;
final int bossHPBackgroundY = 0;

final int bossHPBarx = 230;
final int bossHPBarY = 23;
final int bossHPBarXStart = 230;

final int bossHPInterval = 11;

final int bossHPLayoutX = 0;
final int bossHPLayoutY = 0;

final int bossBonesLayoutX = 84;
final int bossBonesLayoutY = 54;
PImage coveiroHPLayout;

int coveiroCurrentHP;
int coveiroHitpointsMinimum;

int coveiroBonesIndex;

public void vidaCoveiro() {
  coveiroHP.update();
  coveiroHP.display();
  image(bossBonesLayout[coveiroBonesIndex], 84, 54);
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
          if (isSoundActive) {
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
          if (isSoundActive) {
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
          if (isSoundActive) {
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
            playerCurrentHP -= 5;
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
    if ((coveiroCurrentHP <= 0 || coveiroBonesIndex == 0) && !coveiroMorreu) {
      coveiroMorreu = true;
      coveiroMorrendo = true;
      if (isSoundActive) {
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
        playerCurrentHP -= 4;
        jLeiteImune = true;
        tempoImune = millis();
      }
      jLeiteLentidao = true;
    } else {
      jLeiteLentidao = false;
    }
  }
}

ArrayList<Fenda> fendas = new ArrayList<Fenda>();

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

ArrayList<LapideAtaque> lapidesAtaque = new ArrayList<LapideAtaque>();

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
      playerCurrentHP -= 5;
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

ArrayList<LapideCenario> lapidesCenario = new ArrayList<LapideCenario>();

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

ArrayList<AguaPocaCenario> aguasPocaCenario = new ArrayList<AguaPocaCenario>();

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
          if (coveiroBonesIndex >= 1) {
            coveiroBonesIndex = coveiroBonesIndex - 1;
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

ArrayList<PocaCenario> pocasCenario = new ArrayList<PocaCenario>();

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
PImage fazendeiroHPLayout;

int fazendeiroCurrentHP;
int fazendeiroHitpointsMinimum;

int fazendeiroBonesIndex;

public void vidaFazendeiro() {
  fazendeiroHP.update();
  fazendeiroHP.display();
  image(bossBonesLayout[fazendeiroBonesIndex], 84, 54);
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
          if (isSoundActive) {
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
          if (isSoundActive) {
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
          if (isSoundActive) {
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
          playerCurrentHP -= 3;
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
    if ((fazendeiroCurrentHP <= 0 || fazendeiroBonesIndex == 0) && !fazendeiroMorreu) {
      fazendeiroMorreu = true;
      fazendeiroMorrendo = true;
      if (isSoundActive) {
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

ArrayList<Mimosa> mimosas = new ArrayList<Mimosa>();

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
        if (isSoundActive) {
          somMimosaErra.rewind();
          somMimosaErra.play();
        }
      }
    }

    if (m.acertouJLeite() && !jLeiteImune) {
      playerCurrentHP -= 2;
      jLeiteImune = true;
      tempoImune = millis();
      if (isSoundActive) {
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
      if (fazendeiroBonesIndex >= 1) {
        fazendeiroBonesIndex = fazendeiroBonesIndex - 1;
      }
      tempoSpriteFazendeiroTomouDanoPneu = millis();
      fazendeiroTomouDanoPneu = true;
      return true;
    } else {
      return false;
    }
  }
}

ArrayList<Pneu> pneus = new ArrayList<Pneu>();

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
      if (isSoundActive) {
        somAcertouPneuJLeite.rewind();
        somAcertouPneuJLeite.play();
      }
      playerCurrentHP -= 5;
      jLeiteImune = true;
      tempoImune = millis();
    }
    if (p.acertouFazendeiro()) {
      if (isSoundActive) {
        somAcertouPneuFazendeiro.rewind();
        somAcertouPneuFazendeiro.play();
      }
    }
  }
}
PImage padreHPLayout;
PImage madPadreHPLayout;

PImage[] vidaPadreLayoutOsso = new PImage [5];

PImage madPadreHPBar;

int padreCurrentHP, madPadreCurrentHP;
int vidaPadreMin, vidaPadreRaivaMin;

int vidaPadreBarraX;
int vidaPadreRaivaBarraX;

int indexVidaPadreOsso;

public void vidaPadre() {
  image(bossHPBackground, 0, 0);

  HitpointsLayout p;
  p = (padre.padreMudouForma) ? madPadreHP : padreHP;
  p.update();
  p.display();
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
          if (isSoundActive) {
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
          if (isSoundActive) {
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
          if (isSoundActive) {
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
            if (isSoundActive) {
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
            if (isSoundActive) {
              sonsPadreLevantem[0].rewind();
              sonsPadreLevantem[0].play();
            }
          }

          if (!padreRaivaCurou) {
            while (madPadreCurrentHP < 40 && amountRecoveredLevantem < 3) {
              amountRecoveredLevantem = amountRecoveredLevantem + 1;
              madPadreCurrentHP = madPadreCurrentHP + 1;
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
            if (isSoundActive) {
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
            if (isSoundActive) {
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
              playerCurrentHP -= 2;
              jLeiteImune = true;
              tempoImune = millis();
            }
          }
        } else {
          if (millis() > tempoDanoCruz + 300) {
            if (!jLeiteImune) {
              hitHitCruzMostrando = true;
              hitCruz(jLeiteX - 30, jLeiteY);
              playerCurrentHP -= 3;
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
    if ((padreCurrentHP <= 0 || indexVidaPadreOsso == 2) && !padreFormaMudada) {
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
    if ((madPadreCurrentHP <= 0 || indexVidaPadreOsso == 0) && !padreMorreu) {
      padreMorreu = true;
      padreMorrendo = true;
      if (isSoundActive) {
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

ArrayList<CaveiraPadre> caveirasPadre = new ArrayList<CaveiraPadre>();

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
            if (isSoundActive) {
              sonsPadreImpossivel[0].rewind();
              sonsPadreImpossivel[0].play();
            }
          } else {
            if (isSoundActive) {
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
      playerCurrentHP -= 4;
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

ArrayList<Raio> raios = new ArrayList<Raio>();

public void raio() {
  if (raios.size() == 0 && padre.padreCarregandoNovoAtaqueRaio) {
    raios.add(new Raio());
  }

  for (int i = raios.size() - 1; i >= 0; i = i - 1) {
    Raio r = raios.get(i);
    r.display();
    if (r.acertouJLeite() && !imortalidade) {
      playerCurrentHP -= 9999999;
    }
    if (r.deletarRaio) {
      raios.remove(r);
    }
  }
}
boolean hasClickedOnce;

public abstract class Button {
  private PImage buttonPlain;

  private PVector button = new PVector();

  private int firstXBoundary;
  private int secondXBoundary;
  private int firstYBoundary;
  private int secondYBoundary;

  public PImage getButtonPlain() {
    return buttonPlain;
  }
  protected void setButtonPlain(PImage buttonPlain) {
    this.buttonPlain = buttonPlain;
  }

  public PVector getButton() {
    return button;
  }
  protected void setButton(int x, int y) { 
    this.button.x = x;
    this.button.y = y;
  }

  public int getFirstXBoundary() {
    return firstXBoundary;
  }
  protected void setFirstXBoundary(int firstXBoundary) {
    this.firstXBoundary = firstXBoundary;
  }

  public int getSecondXBoundary() {
    return secondXBoundary;
  }
  protected void setSecondXBoundary(int secondXBoundary) {
    this.secondXBoundary = secondXBoundary;
  }

  public int getFirstYBoundary() {
    return firstYBoundary;
  }
  protected void setFirstYBoundary(int firstYBoundary) {
    this.firstYBoundary = firstYBoundary;
  }

  public int getSecondYBoundary() {
    return secondYBoundary;
  }
  protected void setSecondYBoundary(int secondYBoundary) {
    this.secondYBoundary = secondYBoundary;
  }

  public abstract void display();

  public abstract void setState();

  public boolean isMouseOver() {
    if (mouseX > firstXBoundary && mouseX < secondXBoundary && mouseY > firstYBoundary && mouseY < secondYBoundary) {
      return true;
    } 

    return false;
  }

  public boolean hasClicked() {
    if (isMouseOver() && mousePressed) {
      return true;
    }

    return false;
  }
}
final int SOUND = 0;
final int MUSIC = 1;

public class AudioButton extends Button {
  private int index;

  private boolean isXActive;

  AudioButton(PImage buttonPlain, int x, int firstXBoundary, int secondXBoundary, boolean isAudioActive, int index) {
    this.setButtonPlain(buttonPlain);
    this.setButton(x, 10);
    this.setFirstXBoundary(firstXBoundary);
    this.setSecondXBoundary(secondXBoundary);
    this.setFirstYBoundary(10);
    this.setSecondYBoundary(60);
    this.isXActive = !isAudioActive;
    this.index = index;
  }

  public void display() {
    image(getButtonPlain(), getButton().x, getButton().y);

    if (isXActive) {
      image(botaoX, getButton().x, getButton().y);
    }
  } 

  public void setBooleans(boolean setter) {
    switch(index) {
    case 0:
      isSoundActive = !setter;
      break;
    case 1:
      isMusicActive = !setter;
      break;
    }
  }

  public void setState() {
    if (hasClicked() && !hasClickedOnce) {
      if (isXActive) {
        isXActive = false;
      } else {
        isXActive = true;
      }

      setBooleans(isXActive);
      hasClickedOnce = true;
    }
  }
}
public class HandsButton extends MenuButton {

  HandsButton(PImage buttonPlain, PImage buttonOther) {
    this.setButtonPlain(buttonPlain);
    this.setButtonOther(buttonOther);
    this.setButton(20, 520);
    this.setFirstXBoundary(20);
    this.setSecondXBoundary(125);
    this.setFirstYBoundary(520);
    this.setSecondYBoundary(573);
    this.setOrdinal(GameState.MAINMENU.ordinal());
    this.setOffsetX(0);
  }
}
public class MenuButton extends Button {
  private PImage buttonOther;

  private int offsetX;
  private int ordinal;

  public PImage getButtonOther() {
    return buttonOther;
  }
  protected void setButtonOther(PImage buttonOther) {
    this.buttonOther = buttonOther;
  }

  protected void setOrdinal(int ordinal) {
    this.ordinal = ordinal;
  }

  protected void setOffsetX(int offsetX) {
    this.offsetX = offsetX;
  }

  MenuButton(PImage buttonPlain, PImage buttonOther, int y, int firstYBoundary, int secondYBoundary, int ordinal) {
    this.setButtonPlain(buttonPlain);
    this.buttonOther = buttonOther;
    this.setButton(271, y);
    this.setFirstXBoundary(300);
    this.setSecondXBoundary(500);
    this.setFirstYBoundary(firstYBoundary);
    this.setSecondYBoundary(secondYBoundary);
    this.ordinal = ordinal;
    this.offsetX = 29;
  }

  MenuButton() {
  };

  public void display() {
    if (isMouseOver()) {
      image(buttonOther, getButton().x, getButton().y);

      return;
    }

    image(getButtonPlain(), getButton().x + offsetX, getButton().y);
  }

  public void setState() {
    if (hasClicked()) {
      gameState = ordinal;
    }
  }
}
PImage brigadeiro;

public class Brigadeiro extends Comida {
  public Brigadeiro(int x, int y) {
    this.setX(x);
    this.setY(y);

    setValues();
  }

  public Brigadeiro() {
    this.setX(PApplet.parseInt(random(200, 500)));
    this.setY(PApplet.parseInt(random(-300, -1000)));

    setValues();
  }

  public void setValues() {
    setSpriteImage(brigadeiro);
    setSpriteInterval(75);
    setSpriteWidth(32);
    setSpriteHeight(31);
    setMovementY(1);

    setAmountHeal(3);
    setAmountRecovered(0);
  }

  public void display() {
    image (foodShadow, getX(), getY() + 20);

    super.display();
  }
}
PImage skeletonHead;

public class CabecaEsqueleto extends Inimigo {
  private int startingX;

  private int movementX;

  private PVector target = new PVector (jLeiteX, jLeiteY);

  public CabecaEsqueleto(int x, int y) {
    this.setX(x);
    this.setY(y);

    startingX = x;
    setSpriteWidth(36);
    setSpriteHeight(89);

    setDamage(2);
    setType(TypeOfEnemy.SKELETON_HEAD.ordinal());
  }

  public void display() {
    image(skeletonHead, getX(), getY());
  }

  public void update() {
    super.update();

    setX(getX() + movementX);
  }

  public void updateMovement() {
    setMovementY(12);
    if (startingX != target.x) {
      movementX = (startingX > target.x) ? -9 : 9;

      return;
    }

    movementX = 0;
  }
}

ArrayList<CabecaEsqueleto> cabecasEsqueleto = new ArrayList<CabecaEsqueleto>();
PImage skeletonDog;
PImage skeletonDogShadow;

final int SKELETON_DOG = 2;

final int[] skeletonDogSpawnPointsSecondBoss = {70, 382, 695};

public class Cachorro extends Inimigo {
  public Cachorro(int x, int y) {
    this.setX(x);
    this.setY(y);

    setSpriteImage(skeletonDog);
    setSpriteInterval(55);
    setSpriteWidth(45);
    setSpriteHeight(83);

    setDamage(2);
    setType(TypeOfEnemy.SKELETON_DOG.ordinal());
  }

  public void display() {
    image (skeletonDogShadow, getX(), getY() + 45);

    super.display();
  }

  public void updateMovement() {
    setMovementY(8);
  }
}

ArrayList<Cachorro> cachorros = new ArrayList<Cachorro>();;

int cachorroC, cachorroL;

int indexRandomCachorroXMapaBoss;

public void cachorro() {
  if (indexInimigos == 2) {
    if (gameState == GameState.SECONDBOSS.ordinal()) {
      if (cachorros.size() == 0 && !fazendeiroTomouDanoPneu && !fazendeiro.fazendeiroMorreu) {
        for (int i = 0; i < 2; i = i + 1) {
          indexRandomCachorroXMapaBoss = PApplet.parseInt(random(0, skeletonDogSpawnPointsSecondBoss.length));
          cachorros.add(new Cachorro(skeletonDogSpawnPointsSecondBoss[indexRandomCachorroXMapaBoss], 0));
        }
      }
    }

    if (gameState == GameState.THIRDBOSS.ordinal()) { 
      if (cachorros.size() == 0 && totalInimigos < maximoInimigosPadre && !padre.padreMorreu) {
        indexRandomCachorroXMapaBoss = PApplet.parseInt(random(0, valoresInimigosXTerceiroMapaBoss.length));
        cachorros.add(new Cachorro(valoresInimigosXTerceiroMapaBoss[indexRandomCachorroXMapaBoss], 0));
        totalInimigos = totalInimigos + 1;
      }
    }

    if (!movementTutorialScreenActive) {
      if (gameState == GameState.SECONDMAP.ordinal() && cachorros.size() < 2 && totalInimigos < 6) {
        cachorroC = PApplet.parseInt(random(0, 7));
        cachorroL = PApplet.parseInt(random(0, 4));

        if (ENEMY_POSITIONS_SECOND_MAP[cachorroC][cachorroL] == SKELETON_DOG) {
          cachorros.add(new Cachorro(100 + (cachorroC * (600 / 7)), -150 - (cachorroL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }

      if (gameState == GameState.THIRDMAP.ordinal() && cachorros.size() < 2 && totalInimigos < 6) {
        cachorroC = PApplet.parseInt(random(0, 7));
        cachorroL = PApplet.parseInt(random(0, 4));

        if (ENEMY_POSITIONS_THIRD_MAP[cachorroC][cachorroL] == SKELETON_DOG) {
          cachorros.add(new Cachorro(100 + (cachorroC * (600 / 7)), -150 - (cachorroL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }
    }
  }

  if (cachorros.size() > 0) {
    computeEnemy(cachorros);
    deleteEnemy(cachorros);
  }
}

public void skeletonDogPositions() {
  ENEMY_POSITIONS_SECOND_MAP [0][0] = SKELETON_DOG;
  ENEMY_POSITIONS_SECOND_MAP [1][1] = SKELETON_DOG;
  ENEMY_POSITIONS_SECOND_MAP [2][2] = SKELETON_DOG;
  ENEMY_POSITIONS_SECOND_MAP [3][0] = SKELETON_DOG;
  ENEMY_POSITIONS_SECOND_MAP [4][3] = SKELETON_DOG;
  ENEMY_POSITIONS_SECOND_MAP [5][2] = SKELETON_DOG;
  ENEMY_POSITIONS_SECOND_MAP [6][2] = SKELETON_DOG;

  ENEMY_POSITIONS_THIRD_MAP  [1][0] = SKELETON_DOG;
  ENEMY_POSITIONS_THIRD_MAP  [3][0] = SKELETON_DOG;
  ENEMY_POSITIONS_THIRD_MAP  [5][2] = SKELETON_DOG;
  ENEMY_POSITIONS_THIRD_MAP  [6][1] = SKELETON_DOG;
}
PImage[] sceneryImages = new PImage [6];
PImage[] bossSceneryImages =  new PImage [3];

PImage door;
PImage fence;

final int SCENERY_MOVEMENT = 2;

int numberOfSceneries;

public class Scenery {
  private PVector scenery = new PVector();
  private int movementY;

  private int sceneryIndex;

  public Scenery(int y, int sceneryIndex) {
    this.scenery.x = 0;
    this.scenery.y = y;
    this.sceneryIndex = sceneryIndex;
  }

  public void display() {
    image (sceneryImages[sceneryIndex], scenery.x, scenery.y);
  }

  public void update() {
    if (scenery.y > height) {
      scenery.y = -600;
      numberOfSceneries++;
    }

    scenery.y += movementY;
  }

  public void updateMovement() {
    movementY = (numberOfSceneries < 30) ? SCENERY_MOVEMENT : 0;
  }
}

ArrayList<Scenery> cenarios = new ArrayList<Scenery>();

public void cenario() {
  for (Scenery c : cenarios) {
    c.updateMovement();
    c.update();
    c.display();
  }
}
PImage whip;
PImage whipShadow;

final int WHIP = 2;
final int WHIPTOTAL = 5;

public class Chicote extends Item {
  public Chicote() {
    setX(PApplet.parseInt(random(100, 599)));
    setY(PApplet.parseInt(random(-300, -1000)));

    setValues();
  }

  public Chicote(int x, int y) {
    this.setX(x);
    this.setY(y);

    setValues();
  }

  public void setValues() {
    setSpriteImage(whip);
    setSpriteInterval(75);
    setSpriteWidth(101);
    setSpriteHeight(91);
    setMovementY(1);

    setItemIndex(WHIP);
    setItemTotal(WHIPTOTAL);
  }

  public void display() {
    image (whipShadow, getX() + 10, getY() + 76);

    super.display();
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

    setFirstCollisionX(jLeiteX + 86);
    setSecondCollisionX(jLeiteX + 20);
    setFirstCollisionY(jLeiteY);
    setSecondCollisionY(jLeiteY - 140);
  }

  public void update() {
    setX(jLeiteX - 70);
    setY(jLeiteY - 140);
  }
}
PImage foodShadow;

int timeToGenerateFood;
int intervalToGenerateFood = 10000;

int foodIndex;

int foodTotal;

int foodRandomMapPositionIndex;

boolean hasFoodIndexChanged;

public void foodAll() {
  generateFoodIndex();

  if (foodTotal == 0 && hasFoodIndexChanged && millis() > timeToGenerateFood + intervalToGenerateFood && comidas.size() == 0) {
    if (gameState >= GameState.FIRSTMAP.ordinal() && gameState <= GameState.THIRDMAP.ordinal()) {
      addFood();
    } else if (gameState >= GameState.FIRSTBOSS.ordinal() && gameState <= GameState.THIRDBOSS.ordinal()) {
      addFoodBoss();
    }
  }

  if (comidas.size() > 0) {
    foods();
  }
}

public void generateFoodIndex() {
  if (!movementTutorialScreenActive) {
    if (!hasFoodIndexChanged) {
      foodIndex = PApplet.parseInt(random(0, 10));
      hasFoodIndexChanged = true;
    }
  }
}

ArrayList<Comida> comidas = new ArrayList<Comida>();

public class Comida extends Geral {
  private int amountHeal;
  private int amountRecovered;

  public int getAmountHeal() {
    return amountHeal;
  }
  protected void setAmountHeal(int amountHeal) {
    this.amountHeal = amountHeal;
  }

  public int getAmountRecovered() {
    return amountRecovered;
  }
  protected void setAmountRecovered(int amountRecovered) {
    this.amountRecovered = amountRecovered;
  }
}

public void generateFood(int timeAmount) {
  if (foodTotal == 1) {
    foodTotal--;
  }

  hasFoodIndexChanged = false;
  timeToGenerateFood = millis();
  intervalToGenerateFood = timeAmount;
}

public void addFood() {
  if (!movementTutorialScreenActive) {
    if (foodIndex >= 0 && foodIndex <= 4) {
      comidas.add(new Brigadeiro());
    } else if (foodIndex >= 5 && foodIndex <=7) {
      comidas.add(new Queijo());
    } else if (foodIndex >= 8 && foodIndex <= 9) { 
      comidas.add(new Coxinha());
    }

    foodTotal++;
  }
}

<Food extends Comida> void x(Food food, ArrayList<Food> foods){
  foods.add(food);
}

public void addFoodBoss() {
  if (gameState == GameState.FIRSTBOSS.ordinal()) {
    foodRandomMapPositionIndex = PApplet.parseInt(random(0, X_VALUES_FIRST_BOSS.length));
    if (foodIndex >= 0 && foodIndex <= 4) {
      comidas.add(new Brigadeiro(X_VALUES_FIRST_BOSS[foodRandomMapPositionIndex], Y_VALUES_FIRST_BOSS[foodRandomMapPositionIndex]));
    } else if (foodIndex >= 5 && foodIndex <=7) {
      comidas.add(new Queijo(X_VALUES_FIRST_BOSS[foodRandomMapPositionIndex], Y_VALUES_FIRST_BOSS[foodRandomMapPositionIndex]));
    } else if (foodIndex >= 8 && foodIndex <= 9) { 
      comidas.add(new Coxinha(X_VALUES_FIRST_BOSS[foodRandomMapPositionIndex], Y_VALUES_FIRST_BOSS[foodRandomMapPositionIndex]));
    }

    foodTotal++;
  }

  if (gameState == GameState.SECONDBOSS.ordinal()) {
    foodRandomMapPositionIndex = PApplet.parseInt(random(0, X_VALUES_SECOND_BOSS.length));
    if (foodIndex >= 0 && foodIndex <= 4) {
      comidas.add(new Brigadeiro(X_VALUES_SECOND_BOSS[foodRandomMapPositionIndex], Y_VALUES_SECOND_BOSS[foodRandomMapPositionIndex]));
    } else if (foodIndex >= 5 && foodIndex <=7) {
      comidas.add(new Queijo(X_VALUES_SECOND_BOSS[foodRandomMapPositionIndex], Y_VALUES_SECOND_BOSS[foodRandomMapPositionIndex]));
    } else if (foodIndex >= 8 && foodIndex <= 9) { 
      comidas.add(new Coxinha(X_VALUES_SECOND_BOSS[foodRandomMapPositionIndex], Y_VALUES_SECOND_BOSS[foodRandomMapPositionIndex]));
    }
    
    foodTotal++;
  }

  if (gameState == GameState.THIRDBOSS.ordinal()) {
    foodRandomMapPositionIndex = PApplet.parseInt(random(0, X_VALUES_THIRD_BOSS.length));
    if (foodIndex >= 0 && foodIndex <= 4) {
      comidas.add(new Brigadeiro(X_VALUES_THIRD_BOSS[foodRandomMapPositionIndex], Y_VALUES_THIRD_BOSS[foodRandomMapPositionIndex]));
    } else if (foodIndex >= 5 && foodIndex <=7) {
      comidas.add(new Queijo(X_VALUES_THIRD_BOSS[foodRandomMapPositionIndex], Y_VALUES_THIRD_BOSS[foodRandomMapPositionIndex]));
    } else if (foodIndex >= 8 && foodIndex <= 9) { 
      comidas.add(new Coxinha(X_VALUES_THIRD_BOSS[foodRandomMapPositionIndex], Y_VALUES_THIRD_BOSS[foodRandomMapPositionIndex]));
    }
    foodTotal++;
  }
}

public void foods() {
  for (int i = comidas.size() - 1; i >= 0; --i) {
    Comida c = comidas.get(i);
    c.display();
    if (gameState >= GameState.FIRSTMAP.ordinal() && gameState <= GameState.THIRDMAP.ordinal()) {
      c.update();
    }
    if (c.hasExitScreen() || c.hasCollided()) {
      comidas.remove(c);

      if (c.hasExitScreen()) {
        generateFood(2500);
      }
      if (c.hasCollided()) {
        heal(c.getAmountHeal(), c);
        generateFood(10000);
      }
    }
  }
}

public void heal(int amount, Comida c) {
  while (playerCurrentHP < prayerHPMaximum && c.amountRecovered < amount) {
    c.amountRecovered++;
    playerCurrentHP++;
  }
}
public class Controls {
  private TutorialSprite walking = new TutorialSprite(250, 90, 0);
  private TutorialSprite attacking = new TutorialSprite(540, 60, 1);

  private HandsButton handButton = new HandsButton(menuThumbsUp, menuPointingBack);

  public void images() {
    image(imagemControles, 0, 0);
  }

  public void sprites() {
    walking.display();
    attacking.display();
  }

  public void button() {
    handButton.display();
    handButton.setState();
  }
}
PImage skeletonCrow;
PImage skeletonCrowShadow;

class Corvo extends Inimigo {
  private PVector target = new PVector(jLeiteX, jLeiteY);
  
  private int movementX;

  private int newTargetInterval;

  private boolean hasNewTarget;

  Corvo() {
    this.setX(360);
    this.setY(PApplet.parseInt(random(-300, -1000)));

    setValues();
  }

  Corvo(int x, int y) {
    this.setX(x);
    this.setY(y);

    setValues();
  }

  private void setValues() {
    this.setSpriteImage(skeletonCrow);
    this.setSpriteInterval(75);
    this.setSpriteWidth(121);
    this.setSpriteHeight(86);
    
    this.setType(TypeOfEnemy.SKELETON_CROW.ordinal());
  }

  public void display() {
    super.display();

    image(skeletonCrowShadow, getX() + 24, getY() + 86);
  } 

  public void update() {
    super.update();

    setX(getX() + movementX);
  }

  public void updateMovement() {
    setMovementY(3);
    if (getX() != target.x) {
      movementX = (getX() < target.x) ? 3 : -3;
      return;
    }

    movementX = 0;
  }

  public void updateTarget() {
    if (getY() > 0) {
      if (!hasNewTarget) {
        target.x = jLeiteX;
        newTargetInterval = millis();
        hasNewTarget = true;
      }

      if (millis() > newTargetInterval + 750) {
        hasNewTarget = false;
      }
    }
  }

  public boolean hasCollided() {
    if (getX() + 95 > jLeiteX && getX() + 25 < jLeiteX + 63 && getY() + 86 > jLeiteY && getY() < jLeiteY + 126) {
      return true;
    }

    return false;
  }
}

ArrayList<Corvo> corvos = new ArrayList<Corvo>();

int indexRandomCorvoXMapaBoss;

public void corvo() {
  if (indexInimigos == 3) {
    if (gameState == GameState.THIRDBOSS.ordinal()) {
      if (corvos.size() == 0 && totalInimigos < maximoInimigosPadre && !padre.padreMorreu) {
        indexRandomCorvoXMapaBoss = PApplet.parseInt(random(0, valoresInimigosXTerceiroMapaBoss.length));
        corvos.add(new Corvo(valoresInimigosXTerceiroMapaBoss[indexRandomCorvoXMapaBoss], 0));
      }
    }

    if (!movementTutorialScreenActive) {
      if (gameState == GameState.SECONDMAP.ordinal() && corvos.size() < 1) {
        corvos.add(new Corvo());
      }

      if (gameState == GameState.THIRDMAP.ordinal() && corvos.size() < 1) {
        corvos.add(new Corvo());
      }
    }
  }

  if (corvos.size() > 0) {
    for (int i = corvos.size() - 1; i >= 0; i = i - 1) {
      Corvo c = corvos.get(i);
      c.updateTarget();
      c.updateMovement();
      c.update();
      c.display();
      if (c.hasExitScreen()) {
        corvos.remove(c);
      }
      if (c.hasCollided()) {
        damage(3);
      }
    }

    deleteEnemy(corvos);
  }
}
PImage coxinha;

public class Coxinha extends Comida {
  public Coxinha(int x, int y) {
    this.setX(x);
    this.setY(y);

    setValues();
  }

  public Coxinha() {
    setX(PApplet.parseInt(random(200, 500)));
    setY(PApplet.parseInt(random(-300, -1000)));

    setValues();
  }

  public void setValues() {
    setSpriteImage(coxinha);
    setSpriteInterval(75);
    setSpriteWidth(28);
    setSpriteHeight(30);
    setMovementY(1);

    setAmountHeal(5);
    setAmountRecovered(0);
  }

  public void display() {
    image (foodShadow, getX(), getY() + 20);

    super.display();
  }
}
final int FIRSTCLOSINGCREDITY = 0;
final int SECONDCLOSINGCREDITY = 1000;
final int CLOSINGCREDITMOVEMENT = 1;

int timeToMoveClosingCredit;

public class ClosingCredit {
  private PVector closingCredit = new PVector();
  private int movementY;

  ClosingCredit(int y) {
    this.closingCredit.x = 0;
    this.closingCredit.y = y;
  }

  public void display() {
    image(creditos, closingCredit.x, closingCredit.y);
  }

  public void update() {
    if (closingCredit.y + 1000 <= 0) {
      closingCredit.y = 1000;
    }

    closingCredit.y -= movementY;
  }

  public void updateMovement() {
    movementY = (millis() > timeToMoveClosingCredit + 500) ? CLOSINGCREDITMOVEMENT : 0;
  }
}
public class Credits {
  private ClosingCredit firstCredit = new ClosingCredit(FIRSTCLOSINGCREDITY);
  private ClosingCredit secondCredit = new ClosingCredit(SECONDCLOSINGCREDITY);

  private HandsButton handButton = new HandsButton(menuThumbsUp, menuPointingBack);

  public void credits() {
    firstCredit.updateMovement();
    firstCredit.update();
    firstCredit.display();
    secondCredit.updateMovement();
    secondCredit.update();
    secondCredit.display();
  }

  public void button() {
    handButton.display();

    if (handButton.hasClicked()) {
      firstCredit.closingCredit.y = FIRSTCLOSINGCREDITY;
      secondCredit.closingCredit.y = SECONDCLOSINGCREDITY;
    }

    handButton.setState();
  }
}
public abstract class EnemiesSpawnManager {
  private int spawnState = 1;

  private int enemiesTotal;
  private int enemiesMaximum;
  private int[] eachEnemyTotal;

  private int[] maximumModifier;

  public int getSpawnstate()
  {
    return this.spawnState;
  }
  public void setSpawnstate(int spawnState)
  {
    this.spawnState = spawnState;
  }

  public int getEnemiesTotal() {
    return this.enemiesTotal;
  }
  public void setEnemiesTotal(int enemiesTotal) {
    this.enemiesTotal = enemiesTotal;
  }

  public int getEnemiesMaximum() {
    return this.enemiesMaximum;
  }
  public void setEnemiesMaximum(int enemiesMaximum) {
    this.enemiesMaximum = enemiesMaximum;
  }

  public int[] getEachEnemyTotal() {
    return this.eachEnemyTotal;
  }
  public void setEachEnemyTotal(int[] eachEnemyTotal) {
    this.eachEnemyTotal = eachEnemyTotal;
  }

  public int[] getMaximumModifier() {
    return this.maximumModifier;
  }
  public void setMaximumModifier(int[] maximumModifier) {
    this.maximumModifier = maximumModifier;
  }

  EnemiesSpawnManager(int[] maximumModifier, int size) {
    this.maximumModifier = maximumModifier;
    this.eachEnemyTotal = new int[size];
  }

  public void setVariables() {
    spawnState = (numberOfSceneries % 5 == 0) ? numberOfSceneries / 5 : spawnState;

    enemiesMaximum = maximumModifier[spawnState - 1];
  }

  public void states() {
    switch (spawnState) {
    case 1:
      firstBatch();
      break;
    case 2:
      secondBatch();
      break;
    case 3:
      thirdBatch();
      break;
    case 4:
      fourthBatch();
      break;
    case 5:
      fifthBatch();
      break;
    case 6:
      sixthBatch();
      break;
    }
  }

  public abstract void firstBatch();

  public abstract void secondBatch();

  public abstract void thirdBatch();

  public abstract void fourthBatch();

  public abstract void fifthBatch();

  public abstract void sixthBatch();
}
PImage skeleton;
PImage skeletonShadow;

final int SKELETON = 0;

final int[] valoresEsqueletoXPrimeiroMapaBoss = {200, 520};

public class Esqueleto extends Inimigo {
  public Esqueleto(int x, int y) {
    this.setX(x);
    this.setY(y);

    setSpriteImage(skeleton);
    setSpriteInterval(155);
    setSpriteWidth(76);
    setSpriteHeight(126);

    setDamage(2);
    setType(TypeOfEnemy.SKELETON.ordinal());
  }

  public void display() {
    image (skeletonShadow, getX() + 16, getY() + 114);

    super.display();
  }

  public void updateMovement() {
    setMovementY(3);
  }
}

ArrayList<Esqueleto> esqueletos = new ArrayList<Esqueleto>();

int esqueletoC, esqueletoL;
int indexRandomEsqueletoXMapaBoss;

public void esqueleto() {
  if (indexInimigos == 0) {
    if (gameState == GameState.FIRSTBOSS.ordinal()) {
      if (esqueletos.size() == 0 && !coveiro.coveiroMorreu && !coveiroTomouDanoAgua) {
        for (int i = 0; i < 2; i = i + 1) {
          indexRandomEsqueletoXMapaBoss = PApplet.parseInt(random(0, 2));
          esqueletos.add(new Esqueleto(valoresEsqueletoXPrimeiroMapaBoss[indexRandomEsqueletoXMapaBoss], 0));
        }
      }
    }

    if (gameState == GameState.THIRDBOSS.ordinal()) { 
      if (esqueletos.size() == 0 && totalInimigos < maximoInimigosPadre && !padre.padreMorreu) {
        indexRandomEsqueletoXMapaBoss = PApplet.parseInt(random(0, valoresInimigosXTerceiroMapaBoss.length));
        esqueletos.add(new Esqueleto(valoresInimigosXTerceiroMapaBoss[indexRandomEsqueletoXMapaBoss], 0));
        totalInimigos = totalInimigos + 1;
      }
    }

    if (!movementTutorialScreenActive) {
      /*if (gameState == GameState.FIRSTMAP.ordinal() && esqueletos.size() < 2 && totalInimigos < 6) {
       esqueletoC = int(random(0, 7));
       esqueletoL = int(random(0, 4));
       
       if (ENEMY_POSITIONS_FIRST_MAP[esqueletoC][esqueletoL] == SKELETON) {
       esqueletos.add(new Esqueleto(100 + (esqueletoC * (600 / 7)), -150 - (esqueletoL * 150)));
       totalInimigos = totalInimigos + 1;
       }
       }*/

      if (gameState == GameState.SECONDMAP.ordinal() && esqueletos.size() < 2 && totalInimigos < 6) {
        esqueletoC = PApplet.parseInt(random(0, 7));
        esqueletoL = PApplet.parseInt(random(0, 4));

        if (ENEMY_POSITIONS_SECOND_MAP[esqueletoC][esqueletoL] == SKELETON) {
          esqueletos.add(new Esqueleto(100 + (esqueletoC * (600 / 7)), -150 - (esqueletoL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }

      if (gameState == GameState.THIRDMAP.ordinal() && esqueletos.size() < 2 && totalInimigos < 6) {
        esqueletoC = PApplet.parseInt(random(0, 7));
        esqueletoL = PApplet.parseInt(random(0, 4));

        if (ENEMY_POSITIONS_THIRD_MAP[esqueletoC][esqueletoL] == SKELETON) {
          esqueletos.add(new Esqueleto(100 + (esqueletoC * (600 / 7)), -150 - (esqueletoL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }
    }
  }

  if (esqueletos.size() > 0) {
    computeEnemy(esqueletos);
    deleteEnemy(esqueletos);
  }
}

final int[][] SKELETON_POSITIONS = new int [5][8];

public void skeletonPositions() {
  SKELETON_POSITIONS  [0][0] = SKELETON;
  SKELETON_POSITIONS  [0][2] = SKELETON;
  SKELETON_POSITIONS  [0][4] = SKELETON;
  SKELETON_POSITIONS  [0][6] = SKELETON;
  SKELETON_POSITIONS  [2][0] = SKELETON;
  SKELETON_POSITIONS  [2][2] = SKELETON;
  SKELETON_POSITIONS  [2][4] = SKELETON;
  SKELETON_POSITIONS  [2][6] = SKELETON;
  SKELETON_POSITIONS  [4][0] = SKELETON;
  SKELETON_POSITIONS  [4][2] = SKELETON;
  SKELETON_POSITIONS  [4][4] = SKELETON;
  SKELETON_POSITIONS  [4][6] = SKELETON;
}
PImage kickingSkeleton;
PImage headlessKickingSkeleton;
PImage kickingSkeletonShadow;

final int KICKING_SKELETON = 1;

public class EsqueletoChute extends Inimigo {
  private PImage kickingSkeletonSprite;

  private int movementX;

  private PVector target = new PVector(jLeiteX, jLeiteY);

  private int changeDirectionDelay;

  private int kickingSkeletonStep;
  private int kickingSkeletonSpriteTime;

  private boolean hasLostHead;
  private boolean kickHeadTrigger, hasKickedHead;

  public EsqueletoChute(int x, int y) {
    this.setX(x);
    this.setY(y);

    this.setSpriteImage(headlessKickingSkeleton);
    this.setSpriteInterval(200);
    this.setSpriteWidth(48);
    this.setSpriteHeight(74);
    
    this.setType(TypeOfEnemy.KICKING_SKELETON.ordinal());
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

      if (kickingSkeletonStep == 196 && !kickHeadTrigger) {
        hasKickedHead = true;
        kickHeadTrigger = true;
      }

      if (kickingSkeletonStep == kickingSkeleton.width) {
        hasLostHead = true;
        kickingSkeletonStep = 0;
      }

      return;
    }

    super.display();
  }

  public void update() {
    super.update();

    setX(getX() + movementX);
  }

  public void updateMovement() {
    if (!hasLostHead) {
      setMovementY(SCENERY_MOVEMENT / 2);
      if (getX() != target.x) { 
        movementX = (getX() < target.x) ? 3 : -3;

        return;
      }

      movementX = 0;

      return;
    } else {
      setMovementY(SCENERY_MOVEMENT + 1);
      if (millis() > changeDirectionDelay + 250) {
        movementX = PApplet.parseInt(random(-5, 5));
        changeDirectionDelay = millis();
      }
    }
  }
}

ArrayList<EsqueletoChute> esqueletosChute = new ArrayList<EsqueletoChute>();

int esqueletoChuteC, esqueletoChuteL;

int indexRandomEsqueletoChuteXMapaBoss;

public void esqueletoChute() {
  if (indexInimigos == 1) {
    if (gameState == GameState.THIRDBOSS.ordinal()) { 
      if (esqueletosChute.size() == 0 && totalInimigos < maximoInimigosPadre && !padre.padreMorreu) {
        indexRandomEsqueletoChuteXMapaBoss = PApplet.parseInt(random(0, valoresInimigosXTerceiroMapaBoss.length));
        esqueletosChute.add(new EsqueletoChute(valoresInimigosXTerceiroMapaBoss[indexRandomEsqueletoChuteXMapaBoss], 0));
        totalInimigos = totalInimigos + 1;
      }
    }

    if (!movementTutorialScreenActive) {
      /*
      if (gameState >= GameState.FIRSTMAP.ordinal() && gameState <= GameState.THIRDMAP.ordinal() && esqueletosChute.size() < 2 && totalInimigos < 6) {
       esqueletoChuteC = int(random(0, 8));
       esqueletoChuteL = int(random(0, 12));
       
       if (KICKING_SKELETON_POSITIONS[esqueletoChuteC][esqueletoChuteL] == KICKING_SKELETON) {
       esqueletosChute.add(new EsqueletoChute(120 + (esqueletoChuteC * 50), -150 - (esqueletoChuteL * 75)));
       totalInimigos = totalInimigos + 1;
       }
       }
       */
    }
  }

  if (esqueletosChute.size() > 0) {
    for (int i = esqueletosChute.size() - 1; i >= 0; i = i - 1) {
      EsqueletoChute e = esqueletosChute.get(i);
      e.updateMovement();
      e.update();
      e.display();
      if (e.hasKickedHead) {
        cabecasEsqueleto.add(new CabecaEsqueleto(e.getX(), e.getY()));
        e.hasKickedHead = false;
      }
      if (e.hasExitScreen()) {
        totalInimigos--;
        esqueletosChute.remove(e);
      }
      if (e.hasCollided()) {
        damage(2);
      }
    }

    deleteEnemy(esqueletosChute);
  }

  if (cabecasEsqueleto.size() > 0) {
    computeEnemy(cabecasEsqueleto);
  }
}

final int[][] KICKING_SKELETON_POSITIONS = new int [8][12];

public void kickingSkeletonPositions() {
  KICKING_SKELETON_POSITIONS [0][0] = KICKING_SKELETON;
  KICKING_SKELETON_POSITIONS [0][3] = KICKING_SKELETON;
  KICKING_SKELETON_POSITIONS [0][6] = KICKING_SKELETON;
  KICKING_SKELETON_POSITIONS [0][9] = KICKING_SKELETON;
  KICKING_SKELETON_POSITIONS [3][0] = KICKING_SKELETON;
  KICKING_SKELETON_POSITIONS [3][3] = KICKING_SKELETON;
  KICKING_SKELETON_POSITIONS [3][6] = KICKING_SKELETON;
  KICKING_SKELETON_POSITIONS [3][9] = KICKING_SKELETON;
  KICKING_SKELETON_POSITIONS [6][0] = KICKING_SKELETON;
  KICKING_SKELETON_POSITIONS [6][3] = KICKING_SKELETON;
  KICKING_SKELETON_POSITIONS [6][6] = KICKING_SKELETON;
  KICKING_SKELETON_POSITIONS [6][9] = KICKING_SKELETON;
}
PImage redSkeleton;
PImage redSkeletonShadow;

final int REDSKELETON = 3;

public class EsqueletoRaiva extends Inimigo {
  private int movementX = 3;

  public EsqueletoRaiva(int x, int y) {
    this.setX(x);
    this.setY(y);

    setSpriteImage(redSkeleton);
    setSpriteInterval(75);
    setSpriteWidth(76);
    setSpriteHeight(126);

    setDamage(3);
    setType(TypeOfEnemy.RED_SKELETON.ordinal());
  }

  public void display() {
    image(redSkeletonShadow, getX() + 16, getY() + 114);

    super.display();
  }

  public void update() {
    super.update();

    setX(getX() + movementX);
  }

  public void updateMovement() {
    if (getX() < 100) {
      movementX = 2;
    }
    if (getX() + 30 > 700) {
      movementX = -2;
    }

    setMovementY(3);
  }
}

ArrayList<EsqueletoRaiva> esqueletosRaiva = new ArrayList<EsqueletoRaiva>();

int esqueletoRaivaC, esqueletoRaivaL;

int indexRandomEsqueletoRaivaXMapaBoss;

public void esqueletoRaiva() {
  if (indexInimigos == 4) {
    if (gameState == GameState.THIRDBOSS.ordinal()) { 
      if (esqueletosRaiva.size() == 0 && totalInimigos < maximoInimigosPadre && !padre.padreMorreu) {
        indexRandomEsqueletoRaivaXMapaBoss = PApplet.parseInt(random(0, valoresInimigosXTerceiroMapaBoss.length));
        esqueletosRaiva.add(new EsqueletoRaiva(valoresInimigosXTerceiroMapaBoss[indexRandomEsqueletoRaivaXMapaBoss], 0));
        totalInimigos = totalInimigos + 1;
      }
    }

    if (!movementTutorialScreenActive) {
      if (gameState == GameState.THIRDMAP.ordinal() && esqueletosRaiva.size() < 2 && totalInimigos < 6) {
        esqueletoRaivaC = PApplet.parseInt(random(0, 7));
        esqueletoRaivaL = PApplet.parseInt(random(0, 4));

        if (ENEMY_POSITIONS_THIRD_MAP[esqueletoRaivaC][esqueletoRaivaL] == REDSKELETON) {
          esqueletosRaiva.add(new EsqueletoRaiva(100 + (esqueletoRaivaC * (600 / 7)), -150 - (esqueletoRaivaL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }
    }
  }
  
  if (esqueletosRaiva.size() > 0) {
    computeEnemy(esqueletosRaiva);
    deleteEnemy(esqueletosRaiva);
  }
}

public void redSkeletonPositions() {
  ENEMY_POSITIONS_THIRD_MAP[0][0] = REDSKELETON;
  ENEMY_POSITIONS_THIRD_MAP[1][2] = REDSKELETON;
  ENEMY_POSITIONS_THIRD_MAP[2][3] = REDSKELETON;
  ENEMY_POSITIONS_THIRD_MAP[3][2] = REDSKELETON;
  ENEMY_POSITIONS_THIRD_MAP[4][1] = REDSKELETON;
  ENEMY_POSITIONS_THIRD_MAP[5][0] = REDSKELETON;
  ENEMY_POSITIONS_THIRD_MAP[6][2] = REDSKELETON;
}
public class MaisGeral {
  private PImage sprite;
  private PImage spriteImage;

  private int x;
  private int y;

  private int step;
  private int spriteTime;
  private int spriteInterval;

  private int spriteWidth;
  private int spriteHeight;

  public PImage getSprite() {
    return sprite;
  }
  protected void setSprite(PImage sprite) {
    this.sprite = sprite;
  }

  public PImage getSpriteImage() {
    return spriteImage;
  }
  protected void setSpriteImage(PImage enemy) {
    this.spriteImage = enemy;
  }

  public int getX() {
    return x;
  }
  protected void setX(int x) {
    this.x = x;
  }

  public int getY() {
    return y;
  }
  protected void setY(int y) {
    this.y = y;
  }

  public int getStep() {
    return step;
  }
  protected void setStep(int step) {
    this.step = step;
  }

  public int getSpriteTime() {
    return spriteTime;
  }
  protected void setSpriteTime(int spriteTime) {
    this.spriteTime = spriteTime;
  }

  public int getSpriteInterval() {
    return spriteInterval;
  }
  protected void setSpriteInterval(int spriteInterval) {
    this.spriteInterval = spriteInterval;
  }

  public int getSpriteWidth() {
    return spriteWidth;
  }
  protected void setSpriteWidth(int spriteWidth) {
    this.spriteWidth = spriteWidth;
  }

  public int getSpriteHeight() {
    return spriteHeight;
  }
  protected void setSpriteHeight(int spriteHeight) {
    this.spriteHeight = spriteHeight;
  }

  public void display() {
    handler.spriteHandler(this);
    stepHandler();
  }

  public void stepHandler() {
    handler.stepHandler(this);
  }
}

public class Geral extends MaisGeral {
  private int movementY;

  public int getMovementY() {
    return movementY;
  }
  protected void setMovementY(int movementY) {
    this.movementY = movementY;
  }

  public void update() {
    setY(getY() + getMovementY());
  }

  public boolean hasCollided() {
    if (getX() + getSpriteWidth() >= jLeiteX && getX() <= jLeiteX + 63 && getY() + getSpriteHeight() >= jLeiteY && getY() <= jLeiteY + 126) {
      return true;
    }

    return false;
  }

  public boolean hasExitScreen() {
    if (getY() > height) {
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

int[] valoresInimigosXTerceiroMapaBoss = {25, 350, 679};

public void inimigosTodos() {
  if (!jLeiteMorreu) {
    if (!movementTutorialScreenActive) {
      if (millis() > tempoGerarInimigo + 250) {
        if (gameState == GameState.FIRSTMAP.ordinal()) {
          indexInimigos = PApplet.parseInt(random(0, 2));
        } 
        if (gameState == GameState.SECONDMAP.ordinal()) {
          indexInimigos = PApplet.parseInt(random(0, 4));
        } 
        if (gameState == GameState.THIRDMAP.ordinal()) {
          indexInimigos = PApplet.parseInt(random(1, 5));
        } 
        if (gameState == GameState.THIRDBOSS.ordinal()) {
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

  println(numberOfSceneries);
  firstMapEnemiesSpawnManager.states();
  esqueleto();
  esqueletoChute();
  cachorro();
  corvo();
  esqueletoRaiva();
}

enum TypeOfEnemy {
  SKELETON, KICKING_SKELETON, SKELETON_HEAD, SKELETON_DOG, SKELETON_CROW, RED_SKELETON
}

public abstract class Inimigo extends Geral {
  private int damage;
  private int type;

  public int getDamage() {
    return damage;
  }
  protected void setDamage(int damage) {
    this.damage = damage;
  }

  public int getType() {
    return type;
  }
  protected void setType(int type) {
    this.type = type;
  }

  public abstract void updateMovement();
}

public void damage(int amount) {
  if (!jLeiteImune) {
    playerCurrentHP -= amount;
    jLeiteImune = true;
    tempoImune = millis();
  }
}

<Enemy extends Inimigo> void computeEnemy(ArrayList<Enemy> inimigos) {
  for (int i = inimigos.size() - 1; i >= 0; i = i - 1) {
    Enemy enemy = inimigos.get(i);
    enemy.updateMovement();
    enemy.update();
    enemy.display();
    if (enemy.hasExitScreen()) {
      inimigos.remove(enemy);
      if (enemy.getType() != 2) {
        totalInimigos--;
      }
    }
    if (enemy.hasCollided()) {
      damage(enemy.getDamage());
    }
  }
}

<Enemy extends Geral> void deleteEnemy(ArrayList<Enemy> inimigos) {
  for (int i = inimigos.size() - 1; i >= 0; i--) {
    Enemy enemy = inimigos.get(i);
    for (int j = armas.size() - 1; j >= 0; j--) {
      Arma arma = armas.get(j);
      if (arma.hasHit(enemy)) {
        totalInimigos--;
        hitInimigos(enemy.getX() - 40, enemy.getY() - 20);
        inimigos.remove(enemy);
      }
    }
  }
}
ArrayList<Item> itens = new ArrayList<Item>();

public class Item extends Geral {
  private int itemIndex;
  private int itemTotal;

  public int getItemIndex() {
    return itemIndex;
  }
  protected void setItemIndex(int itemIndex) {
    this.itemIndex = itemIndex;
  }

  public int getItemTotal() {
    return itemTotal;
  }
  protected void setItemTotal(int itemTotal) {
    this.itemTotal = itemTotal;
  }
}

public void item() {  
  for (int i = itens.size() - 1; i >= 0; i = i - 1) {
    Item it = itens.get(i);
    if (gameState >= GameState.FIRSTMAP.ordinal() && gameState <= GameState.THIRDMAP.ordinal()) {
      it.update();
    }
    it.display();
    if (it.hasExitScreen() || it.hasCollided()) {
      itens.remove(it);

      if (it.hasExitScreen()) {
        generateItem(2500);
      }
      if (it.hasCollided()) {
        item = it.getItemIndex();
        weaponTotal = it.getItemTotal();
      }
    }
  }
}

public void generateItem(int timeAmount) {
  if (itemTotal == 1) {
    itemTotal--;
  }
  
  hasItemIndexChanged = false;
  timeToGenerateItem = millis();
  intervalToGenerateItem = timeAmount;
}

public void addItem() {
  if (!movementTutorialScreenActive) {
    if (itemIndex >= 0 && itemIndex <= 4) {
      itens.add(new Pa());
    } else if (itemIndex >= 5 && itemIndex <= 9) {
      itens.add(new Chicote());
    }

    itemTotal++;
  }
}

public void addItemBoss() {
  if (gameState == GameState.FIRSTBOSS.ordinal()) {
    itemRandomMapPositionIndex = PApplet.parseInt(random(0, X_VALUES_FIRST_BOSS.length));
    if (itemIndex >= 0 && itemIndex <= 4) {
      itens.add(new Pa(X_VALUES_FIRST_BOSS[itemRandomMapPositionIndex], Y_VALUES_FIRST_BOSS[itemRandomMapPositionIndex]));
    } else if (itemIndex >= 5 && itemIndex <= 9) {
      itens.add(new Chicote(X_VALUES_FIRST_BOSS[itemRandomMapPositionIndex], Y_VALUES_FIRST_BOSS[itemRandomMapPositionIndex]));
    }

    itemTotal++;
  }

  if (gameState == GameState.SECONDBOSS.ordinal()) {
    itemRandomMapPositionIndex = PApplet.parseInt(random(0, X_VALUES_SECOND_BOSS.length));
    if (itemIndex >= 0 && itemIndex <= 4) {
      itens.add(new Pa(X_VALUES_SECOND_BOSS[itemRandomMapPositionIndex], Y_VALUES_SECOND_BOSS[itemRandomMapPositionIndex]));
    } else if (itemIndex >= 5 && itemIndex <= 9) {
      itens.add(new Chicote(X_VALUES_SECOND_BOSS[itemRandomMapPositionIndex], Y_VALUES_SECOND_BOSS[itemRandomMapPositionIndex]));
    }

    itemTotal++;
  }

  if (gameState == GameState.THIRDBOSS.ordinal()) {
    itemRandomMapPositionIndex = PApplet.parseInt(random(0, X_VALUES_THIRD_BOSS.length));
    if (itemIndex >= 0 && itemIndex <= 4) {
      itens.add(new Pa(X_VALUES_THIRD_BOSS[itemRandomMapPositionIndex], Y_VALUES_THIRD_BOSS[itemRandomMapPositionIndex]));
    } else if (itemIndex >= 5 && itemIndex <= 9) {
      itens.add(new Chicote(X_VALUES_THIRD_BOSS[itemRandomMapPositionIndex], Y_VALUES_THIRD_BOSS[itemRandomMapPositionIndex]));
    }

    itemTotal++;
  }
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

int playerCurrentHP;
int prayerHPMaximum;
int playerHPMinimum;

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
    playerCurrentHP = 15;
  }

  if (finalMapa) {
    if (jLeiteY + 126 < - 50) {
      if (gameState == GameState.FIRSTMAP.ordinal()) {
        gameState = GameState.FIRSTBOSS.ordinal();
        if (temaIgreja.isPlaying()) {
          temaIgreja.pause();
        }
      }
      if (gameState == GameState.SECONDMAP.ordinal()) {
        gameState = GameState.SECONDBOSS.ordinal();
        if (temaFazenda.isPlaying()) {
          temaFazenda.pause();
        }
      }
      if (gameState == GameState.THIRDMAP.ordinal()) {
        gameState = GameState.THIRDBOSS.ordinal();
        if (temaCidade.isPlaying()) {
          temaCidade.pause();
        }
      }
    }
  }

  if (playerCurrentHP < 0 && !jLeiteMorreu) {
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
    if (gameState == GameState.FIRSTBOSS.ordinal()) {
      if (isSoundActive) {
        sonsMorteJLeite[0].rewind();
        sonsMorteJLeite[0].play();
      }
    }
    if (gameState == GameState.SECONDBOSS.ordinal()) {
      if (isSoundActive) {
        sonsMorteJLeite[1].rewind();
        sonsMorteJLeite[1].play();
      }
    }
    if (gameState == GameState.THIRDBOSS.ordinal()) {
      if (!padre.padreMudouForma) {
        if (isSoundActive) {
          sonsMorteJLeite[2].rewind();
          sonsMorteJLeite[2].play();
        }
      } else {
        if (isSoundActive) {
          sonsMorteJLeite[3].rewind();
          sonsMorteJLeite[3].play();
        }
      }
    }
  }

  if (jLeiteMorreu && millis() > tempoMorto + 2500) {
    if (gameState >= GameState.FIRSTMAP.ordinal() && gameState <= GameState.THIRDMAP.ordinal()) {
      variablesPreLoad();
      gameState = GameState.MAINMENU.ordinal();
    } else if (gameState >= GameState.FIRSTBOSS.ordinal() && gameState <= GameState.THIRDBOSS.ordinal()) {
      lastState = gameState;
      gameState = GameState.GAMEOVER.ordinal();
    }
  }

  if (millis() > tempoImune + 2000) {
    jLeiteImune = false;
  }

  if (!jLeiteMorreu) {
    if (gameState >= GameState.FIRSTMAP.ordinal() && gameState <= GameState.THIRDMAP.ordinal()) {
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

    if (gameState >= GameState.FIRSTBOSS.ordinal() && gameState <= GameState.THIRDBOSS.ordinal()) {
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

    if (gameState >= GameState.FIRSTMAP.ordinal() && gameState <= GameState.THIRDMAP.ordinal()) {
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
boolean isFirstMapSet;

public void jogando() {
  if (gameState == GameState.FIRSTMAP.ordinal()) {
    if (!isFirstMapSet) {
      movementTutorialScreenActive = true;
      cenarios.add(new Scenery(0, 0));
      cenarios.add(new Scenery(-600, 0));
      generateItem(5000);
      generateFood(5000);
      isFirstMapSet = true;
    }
    if (isMusicActive) {
      temaIgreja.play();
    }
  }

  if (gameState == GameState.SECONDMAP.ordinal()) {
    if (isMusicActive) {
      temaFazenda.play();
    }
  }

  if (gameState == GameState.THIRDMAP.ordinal()) {
    if (isMusicActive) {
      temaCidade.play();
    }
  }

  if (millis() > tempoBossMorreu + 3000 && coveiro.coveiroMorreu) {
    gameState = GameState.SECONDMAP.ordinal();
  }

  if (millis() > tempoBossMorreu + 3000 && fazendeiro.fazendeiroMorreu) {
    gameState = GameState.THIRDMAP.ordinal();
  }

  if (millis() > tempoBossMorreu + 7000 && padre.padreMorreu) {
    gameState = GameState.WIN.ordinal();
  }

  cenario();
  inimigosTodos();
  armas(); 
  jLeite(); 
  foodAll();
  playerHitpoints();
  ib.updateItemImage();
  ib.display();
  if (movementTutorialScreenActive) {
    telaTutorialAndando();
  }
}
PImage itemBox;
PImage[] itemNumbers = new PImage [15];

PImage shovelBox;
PImage whipBox;

public class FirstMap {
  Scenery firstScenery;
  Scenery secondScenery;

  TransitionGate door;

  HUD hud;

  Player player;

  FirstMapEnemiesSpawnManager firstMapEnemiesSpawnManager;

  TutorialScreen movement;
  TutorialScreen attack;
}

public class TutorialScreen {
}

public class Player {
}

public class ItemBox {
  private PImage itemImage;

  public void display() {
    image(itemBox, 705, 510);

    if (hasItem()) {
      image(itemImage, 705, 510);
      image(itemNumbers[weaponTotal - 1], 725, 552);
    }
  }

  public void updateItemImage() {
    itemImage = (item == SHOVEL) ? shovelBox : whipBox;
  }

  public boolean hasItem() {
    if (weaponTotal - 1 >= 0) {
      return true;
    }

    return false;
  }
}

public class HUD {
  private HitpointsLayout p;

  public void display() {
    switch(gameState) {
    case 3:
      coveiroHP.update();
      coveiroHP.display();
      break;
    case 4:
      fazendeiroHP.update();
      fazendeiroHP.display();
      break;
    case 5:
      p = (padre.padreMudouForma) ? madPadreHP : padreHP;
      p.update();
      p.display();
      break;
    }

    playerHP.update();
    playerHP.display();
    ib.updateItemImage();
    ib.display();
  }
}

public class HitpointsLayout {
  private PImage layoutBackground;
  private PImage hitpointsLayout;
  private PImage hitpointsBar;

  private PVector background;
  private PVector layout;
  private PVector bar;

  private int barXStart;
  private int interval;

  private int minimumHP;
  private int currentHP;

  private int index;

  HitpointsLayout(int index) {
    this.index = index;

    this.minimumHP = 0;

    if (index == 0) {
      player();
    } else {
      switch (index) {
      case 1:
        this.hitpointsLayout = coveiroHPLayout;

        this.currentHP = coveiroCurrentHP;
        break;
      case 2:
        this.hitpointsLayout = fazendeiroHPLayout;

        this.currentHP = fazendeiroCurrentHP;
        break;
      case 3:
        this.hitpointsLayout = padreHPLayout;

        this.currentHP = padreCurrentHP;
        break;
      case 4:
        this.hitpointsLayout = madPadreHPLayout;

        this.currentHP = madPadreCurrentHP;
        break;
      }
      bosses();
    }
  }

  public void player() {
    this.layoutBackground = playerHPBackground;
    this.hitpointsLayout = playerHPLayout;
    this.hitpointsBar = playerHPBar;

    this.background = new PVector(playerHPBackgroundX, playerHPBackgroundY);
    this.layout = new PVector(playerHPLayoutX, playerHPLayoutY);
    this.bar = new PVector(playerHPBarX, playerHPBarY);

    this.barXStart = playerHPBarXStart;
    this.interval = playerHPInterval;

    this.currentHP = playerCurrentHP;
  }

  public void bosses() {
    this.layoutBackground = bossHPBackground;
    this.hitpointsBar  = (index != 4) ? bossHPBar : madPadreHPBar;

    this.background = new PVector(bossHPBackgroundX, bossHPBackgroundY);
    this.layout = new PVector(bossHPLayoutX, bossHPLayoutY);
    this.bar = new PVector(bossHPBarx, bossHPBarY);

    this.barXStart = bossHPBarXStart;
    this.interval = bossHPInterval;
  }

  public void display() {
    image(layoutBackground, background.x, background.y);

    minimumHP = 0;
    bar.x = barXStart;
    while (minimumHP < currentHP) {
      image (hitpointsBar, bar.x, bar.y);
      bar.x += interval;
      minimumHP++;
    }

    image (hitpointsLayout, layout.x, layout.y);
  }

  public void update() {
    switch(index) {
    case 0:
      currentHP = playerCurrentHP;
      break;
    case 1:
      this.currentHP = coveiroCurrentHP;
      break;
    case 2:
      this.currentHP = fazendeiroCurrentHP;
      break;
    case 3:
      this.currentHP = padreCurrentHP;
      break;
    case 4:
      this.currentHP = madPadreCurrentHP;
      break;
    }
  }
}

PImage playerHPLayout;
PImage playerHPBackground; 
PImage playerHPBar;

final int playerHPBackgroundX = 8;
final int playerHPBackgroundY = 490;

final int playerHPBarX = 115;
final int playerHPBarY = 566;
final int playerHPBarXStart = 115;

final int playerHPInterval = 12;

final int playerHPLayoutX = 8;
final int playerHPLayoutY = 490;

public void playerHitpoints() {
  playerHP.update();
  playerHP.display();
}
public class Handler {
  public void spriteHandler(MaisGeral object) {
    if (millis() > object.getSpriteTime() + object.getSpriteInterval()) {
      object.setSprite(object.getSpriteImage().get(object.getStep(), 0, object.getSpriteWidth(), object.getSpriteHeight()));
      object.setStep(object.getStep() % object.getSpriteImage().width + object.getSpriteWidth());
      object.setSpriteTime(millis());
    }

    image(object.getSprite(), object.getX(), object.getY());
  }

  public void stepHandler(MaisGeral object) {
    if (object.getStep() == object.getSpriteImage().width) {
      object.setStep(0);
    }
  }
}
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

public void menu() {
  winLose();
  if (gameState == GameState.MAINMENU.ordinal()) {
    if (mm == null) {
      mm = new MainMenu();
    } else {
      mm.images();
      mm.buttons();
    }
  }

  // Bot\u00f5es.
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

  // Cr\u00e9ditos
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

public void telaTutorialAndando() {
  image (telaTutorialAndando, 187.5f, 119);

  playerWalkingSprite(470, 260);

  image(telaTutorialX, 584, 139);
}

public void playerWalkingSprite(int spriteX, int spriteY) {
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

public void weaponTutorialScreen() {
  noLoop();

  image(telaTutorialPedra, 236, 169);
  image(jLeiteItem, 258.5f, 215);
  image(telaTutorialX, 514, 182);
  image(telaTutorialPedraSeta, 705, 456);

  weaponTutorialScreenActive = true;
}

public void menuHand() {
  if (mouseX > 20 && mouseX < 125 && mouseY > 520 && mouseY < 573) {
    image(menuThumbsUp, 20, 520);
    if (mousePressed) {
      gameState = GameState.MAINMENU.ordinal();
    }
  } else {
    image(menuPointingBack, 20, 520);
  }
}

public void winLose() {
  switch (gameState) {
  case 9:
    image(telaVitoria, 0, 0);
    break;
  case 10: 
    image(telaGameOver, 0, 0);
    break;
  }
}
PImage backgroundMenu; 
PImage pesadeloLogo;

public class MainMenu {
  private Background background = new Background();

  private MenuButton play = new MenuButton(playButton, playHands, 300, 300, 377, GameState.FIRSTMAP.ordinal());
  private MenuButton controls = new MenuButton (controlsButton, controlsHands, 400, 400, 477, GameState.CONTROLSMENU.ordinal());
  private MenuButton credits = new MenuButton (creditsButton, creditsHands, 500, 500, 577, GameState.CREDITSMENU.ordinal());

  private AudioButton sound = new AudioButton(soundButton, 660, 660, 720, isSoundActive, SOUND);
  private AudioButton music = new AudioButton(musicButton, 730, 730, 790, isMusicActive, MUSIC);

  private Button[] buttons = new Button [5];

  MainMenu() {
    addButtons();
  }

  public void addButtons() {
    buttons[0] = play;
    buttons[1] = controls;
    buttons[2] = credits;
    buttons[3] = sound;
    buttons[4] = music;
  }

  public void images() {
    background.display();

    image(pesadeloLogo, 231, 40);
  }

  public void buttons() {
    for (Button b : buttons) {
      b.display();

      if (b == controls) {
        timeToMoveClosingCredit = millis();
      }

      b.setState();
    }
  }
}
PImage shovel;
PImage shovelShadow;

final int SHOVEL = 1;
final int SHOVELTOTAL = 5;

public class Pa extends Item {
  public Pa() {
    setX(PApplet.parseInt(random(100, 616)));
    setY(PApplet.parseInt(random(-300, -1000)));

    setValues();
  }

  public Pa(int x, int y) {
    this.setX(x);
    this.setY(y);

    setValues();
  }

  public void setValues() {
    setSpriteImage(shovel);
    setSpriteInterval(75);
    setSpriteWidth(84);
    setSpriteHeight(91);
    setMovementY(1);

    setItemIndex(SHOVEL);
    setItemTotal(SHOVELTOTAL);
  }

  public void display() {
    image (shovelShadow, getX() + 1, getY() + 85);

    super.display();
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

  public void update() {
    setX(jLeiteX - 70);
    setY(jLeiteY - 44);
  }
}
public void audioPreLoad() {
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
}

public void imagesPreLoad() {
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

  playerHPLayout = loadImage ("vidaJLeiteLayout.png");
  playerHPBackground = loadImage ("vidaJLeiteLayoutBackground.png");
  playerHPBar = loadImage ("vidaJLeiteBarra.png");

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

  bossHPBackground = loadImage ("vidaBossesLayoutBackground.png");
  bossHPBar = loadImage ("vidaBossesBarra.png");

  for (int i = 0; i < bossBonesLayout.length; i = i + 1) {
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

  for (int i = 0; i < vidaPadreLayoutOsso.length; i = i + 1) {
    vidaPadreLayoutOsso[i] = loadImage ("vidaPadreLayoutOsso" + i + ".png");
  }

  madPadreHPBar = loadImage ("vidaPadreRaivaBarra.png");

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
}

public void variablesPreLoad() {
  skeletonPositions();
  kickingSkeletonPositions();
  skeletonDogPositions();
  redSkeletonPositions();

  gameState = GameState.MAINMENU.ordinal();

  totalInimigos = 0;

  jLeiteX = 360;
  jLeiteY = 345; 

  playerCurrentHP = 15;
  prayerHPMaximum = 15; 
  playerHPMinimum = 0;

  foodIndex = 10;

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

  hasFoodIndexChanged = false;
}
PImage queijo;

public class Queijo extends Comida {
  public Queijo(int x, int y) {
    this.setX(x);
    this.setY(y);

    setValues();
  }

  public Queijo() {
    this.setX(PApplet.parseInt(random(200, 500)));
    this.setY(PApplet.parseInt(random(-300, -1000)));

    setValues();
  }

  public void setValues() {    
    setSpriteImage(queijo);
    setSpriteInterval(75);
    setSpriteWidth(31);
    setSpriteHeight(29);
    setMovementY(1);

    setAmountHeal(4);
    setAmountRecovered(0);
  }

  public void display() {
    image (foodShadow, getX(), getY() + 19);

    super.display();
  }
}
class FirstMapEnemiesSpawnManager extends EnemiesSpawnManager {
  final int[] SKELETON_MAXIMUM = {1, 2, 2, 3};
  final int[] KICKING_SKELETON_MAXIMUM = {1, 1, 2, 2};

  PVector skeletonLastPosition = new PVector(99, 99);
  PVector skeletonCurrentPosition = new PVector(99, 99);
  PVector kickingSkeletonLastPosition = new PVector(99, 99);
  PVector kickingSkeletonCurrentPosition = new PVector(99, 99);

  int skeletonRow = 0;
  int skeletonColumn = 0;
  int kickingSkeletonRow = 0;
  int kickingSkeletonColumn = 0;

  FirstMapEnemiesSpawnManager(int[] maximumModifier, int size) {
    super(maximumModifier, size);
  }

  public void setSkeletonPosition() {
    while (SKELETON_POSITIONS[skeletonRow][skeletonColumn] != SKELETON && skeletonCurrentPosition == skeletonLastPosition) {
      skeletonRow = PApplet.parseInt(random(0, 7));
      skeletonColumn = PApplet.parseInt(random(0, 4));

      skeletonCurrentPosition.x = skeletonRow;
      skeletonCurrentPosition.y = skeletonColumn;
    }
  }

  public void setKickingSkeletonPosition() {
    while (KICKING_SKELETON_POSITIONS[kickingSkeletonRow][kickingSkeletonColumn] != KICKING_SKELETON && kickingSkeletonCurrentPosition == kickingSkeletonLastPosition) {
      kickingSkeletonRow = PApplet.parseInt(random(0, 8));
      kickingSkeletonColumn = PApplet.parseInt(random(0, 12));

      kickingSkeletonCurrentPosition.x = kickingSkeletonRow;
      kickingSkeletonCurrentPosition.y = kickingSkeletonColumn;
    }
  }

  public void firstBatch() {
    int max = getMaximumModifier()[0];

    while (getEnemiesTotal() < max) {
      setSkeletonPosition();

      esqueletos.add(new Esqueleto(100 + (skeletonColumn * 85), -150 - (skeletonRow * 150)));

      skeletonLastPosition.x = skeletonRow;
      skeletonLastPosition.y = skeletonColumn;

      setEnemiesTotal(getEnemiesTotal() + 1);
    }
  }

  public void toBeNamed(int max, int skeletonTotal, int kickingSkeletonTotal, int index) {
    while (getEnemiesTotal() < max) {
      if (skeletonTotal < SKELETON_MAXIMUM[index]) {
        setSkeletonPosition();

        esqueletos.add(new Esqueleto(100 + (skeletonColumn * 85), -150 - (skeletonRow * 150)));

        skeletonLastPosition.x = skeletonRow;
        skeletonLastPosition.y = skeletonColumn;

        skeletonTotal++;
        setEnemiesTotal(getEnemiesTotal() + 1);
      }

      if (getEnemiesTotal() >= max) break;

      if (kickingSkeletonTotal < KICKING_SKELETON_MAXIMUM[index]) {
        setKickingSkeletonPosition();

        esqueletosChute.add(new EsqueletoChute(120 + (kickingSkeletonColumn * 50), -150 - (kickingSkeletonRow * 75)));

        skeletonLastPosition.x = skeletonRow;
        skeletonLastPosition.y = skeletonColumn;

        kickingSkeletonTotal++;
        setEnemiesTotal(getEnemiesTotal() + 1);
      }

      int[] enemiesTotal = {skeletonTotal, kickingSkeletonTotal};
      setEachEnemyTotal(enemiesTotal);
    }
  }

  public void secondBatch() {
    int max = getMaximumModifier()[1];

    int skeletonTotal = getEachEnemyTotal()[0];
    int kickingSkeletonTotal = getEachEnemyTotal()[1];

    toBeNamed(max, skeletonTotal, kickingSkeletonTotal, 0);
  }

  public void thirdBatch() {
    int max = getMaximumModifier()[2];

    int skeletonTotal = getEachEnemyTotal()[0];
    int kickingSkeletonTotal = getEachEnemyTotal()[1];

    toBeNamed(max, skeletonTotal, kickingSkeletonTotal, 1);
  }

  public void fourthBatch() {
    int max = getMaximumModifier()[3];

    int skeletonTotal = getEachEnemyTotal()[0];
    int kickingSkeletonTotal = getEachEnemyTotal()[1];

    toBeNamed(max, skeletonTotal, kickingSkeletonTotal, 2);
  }

  public void fifthBatch() {
    int max = getMaximumModifier()[4];

    int skeletonTotal = getEachEnemyTotal()[0];
    int kickingSkeletonTotal = getEachEnemyTotal()[1];

    toBeNamed(max, skeletonTotal, kickingSkeletonTotal, 3);
  }

  public void sixthBatch() {
  }
}

class SecondMapEnemiesSpawnManager extends EnemiesSpawnManager {

  SecondMapEnemiesSpawnManager(int[] maximumModifier, int size) {
    super(maximumModifier, size);
  }

  public void firstBatch() {
  }

  public void secondBatch() {
  }

  public void thirdBatch() {
  }

  public void fourthBatch() {
  }

  public void fifthBatch() {
  }

  public void sixthBatch() {
  }
}

class ThirdMapEnemiesSpawnManager extends EnemiesSpawnManager {

  ThirdMapEnemiesSpawnManager(int[] maximumModifier, int size) {
    super(maximumModifier, size);
  }

  public void firstBatch() {
  }

  public void secondBatch() {
  }

  public void thirdBatch() {
  }

  public void fourthBatch() {
  }

  public void fifthBatch() {
  }

  public void sixthBatch() {
  }
}
public class TransitionGate extends MaisGeral {
  private boolean hasOpened;

  TransitionGate(int x, int y, int index) {
    this.setX(x); // 230 para porta, 188 para cerca.
    this.setY(y); // cenarioY para porta, cenarioY + 20 para cerca.

    switch (index) {
    case 0:
      this.setSpriteImage(door);
      this.setSpriteWidth(334);
      this.setSpriteHeight(256);
      break;
    case 1:
      this.setSpriteImage(fence);
      this.setSpriteWidth(426);
      this.setSpriteHeight(146);
      break;
    }
    this.setSpriteInterval(350);
  }

  public void display() {
    if (!hasOpened) {
      super.display();
    } else {
      image(getSpriteImage(), getX(), getY());
    }
  }

  public void stepHandler() {
    if (getStep() == getSpriteImage().width) {
      hasOpened = true;
    }
  }
}
public class TutorialSprite extends MaisGeral {
  TutorialSprite(int x, int y, int index) {
    this.setX(x);
    this.setY(y);

    switch (index) {
    case 0:
      this.setSpriteImage(jLeiteMovimento);
      this.setSpriteInterval(75);
      this.setSpriteWidth(63);
      break;
    case 1:
      this.setSpriteImage(jLeiteItem);
      this.setSpriteInterval(150);
      this.setSpriteWidth(94);
      break;
    }
    this.setSpriteHeight(126);
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
