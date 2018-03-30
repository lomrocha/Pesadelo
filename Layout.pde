PImage itemBox;
PImage[] itemNumbers = new PImage [15];

PImage shovelBox;
PImage whipBox;

void caixaNumeroItem() {
  image(itemBox, 705, 510);
  if (weaponTotal - 1 >= 0) {
    switch(item) {
    case SHOVEL:
      image(shovelBox, 705, 510);
      break;
    case WHIP:
      image(whipBox, 705, 510);
      break;
    }

    image(itemNumbers[weaponTotal - 1], 725, 552);
  }
}

public class FirstMap{
  Scenery firstScenery;
  Scenery secondScenery;
  
  TransitionGate door;
  
  HUDOne hud;
  
  Player player;
  
  SpawnManager spawnManager;
  
  TutorialScreen movement;
  TutorialScreen attack;  
}

public class SpawnManager{}

public class TutorialScreen{}

public class Player{}

public class ItemBox{}

public class HUDOne {
  HitpointsLayout player;
  ItemBox itemBox;  
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

  private int hitpointsMininum;
  private int hitpointsCurrent;

  private int index;

  void update() {
    switch(index) {
    case 0:
      hitpointsCurrent = playerHPCurrent;
      break;
    case 1:
      break;
    case 2:
      break;
    case 3:
      break;
    case 4:
      break;
    }
  }

  HitpointsLayout(int index) {
    this.index = index;
    
    this.hitpointsMininum = 0;
    if (index == 0) {
      this.layoutBackground = playerHPBackground;
      this.hitpointsLayout = playerHPLayout;
      this.hitpointsBar = playerHPBar;

      this.background = new PVector(playerHPBackgroundX, playerHPBackgroundY);
      this.layout = new PVector(playerHPLayoutX, playerHPLayoutY);
      this.bar = new PVector(playerHPBarX, playerHPBarY);

      this.barXStart = playerHPBarXStart;
      this.interval = playerHPInterval;

      this.hitpointsCurrent = playerHPCurrent;
    } else {
      switch (index) {
      case 1:
        this.hitpointsLayout = vidaCoveiroLayout;

        this.hitpointsCurrent = coveiroHitpointsCurrent;
        break;
      case 2:
        this.hitpointsLayout = vidaFazendeiroLayout;

        this.hitpointsCurrent = fazendeiroHitpointsCurrent;
        break;
      case 3:
        break;
      case 4:
        break;
      }
      this.layoutBackground = bossHitpointsLayoutBackground;
      this.hitpointsBar = bossHitpointsBar;
      
      this.background = new PVector(bossHPBackgroundX, bossHPBackgroundY);
      this.layout = new PVector(bossHPLayoutX, bossHPLayoutY);
      this.bar = new PVector(bossHPBarx, bossHPBarY);
      
      this.barXStart = bossHPBarXStart;
      this.interval = bossHPInterval;
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

void playerHitpoints() {
  handler.hitpointsLayoutHandler(playerHPBackground, playerHPBackgroundX, playerHPBackgroundY, playerHPMinimum, playerHPBarX, playerHPBarXStart, playerHPCurrent, playerHPBar, playerHPBarY, playerHPInterval, playerHPLayout, playerHPLayoutX, playerHPLayoutY);
}