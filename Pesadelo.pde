import ddf.minim.*;

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

void setup() {
  size(800, 600);

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
  
  firstMapEnemiesSpawnManager = new FirstMapEnemiesSpawnManager(ENEMY_MAXIMUM_FIRST_MAP);
}

void draw() {
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

void keyPressed() {
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