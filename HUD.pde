// ----------------------------------------- HUD ---------------------------------------------------

private class HUD 
{
  private HitpointsLayout p;

  void display(WeaponSpawnManager weaponSpawnManager) {
    switch(gameState) 
    {
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
    ib.updateItemImage(weaponSpawnManager);
    ib.display(weaponSpawnManager);
  }
}

// ----------------------------------------- ITEM BOX HUD ---------------------------------------------------

PImage itemBoxImage;
PImage[] itemNumbers = new PImage [15];

PImage shovelBoxImage;
PImage whipBoxImage;


private class ItemBox 
{
  private PImage itemImage;

  void display(WeaponSpawnManager weaponSpawnManager) 
  {
    image(itemBoxImage, 705, 510);

    if (hasItem(weaponSpawnManager)) 
    {
      image(itemImage, 715, 520);
      image(itemNumbers[weaponSpawnManager.getWeaponTotal() - 1], 725, 552);
    }
  }

  void updateItemImage(WeaponSpawnManager weaponSpawnManager) 
  {
    itemImage = (weaponSpawnManager.getItemIndex() == SHOVEL) ? shovelBoxImage : whipBoxImage;
  }

  boolean hasItem(WeaponSpawnManager weaponSpawnManager) 
  {
    if (weaponSpawnManager.getWeaponTotal() - 1 >= 0) 
    {
      return true;
    }

    return false;
  }
}

// ----------------------------------------- HITPOINTS HUD ---------------------------------------------------

private class HitpointsLayout {
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

  void player() {
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

  void bosses() {
    this.layoutBackground = bossHPBackground;
    this.hitpointsBar  = (index != 4) ? bossHPBar : madPadreHPBar;

    this.background = new PVector(bossHPBackgroundX, bossHPBackgroundY);
    this.layout = new PVector(bossHPLayoutX, bossHPLayoutY);
    this.bar = new PVector(bossHPBarX, bossHPBarY);

    this.barXStart = bossHPBarXStart;
    this.interval = bossHPInterval;
  }

  void display() {
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

  void update() {
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

// ----------------------------------------- TUTORIAL SCREEN HUD ---------------------------------------------------

//private class TutorialScreen 
//{
//}

// ----------------------------------------- PLAYER HUD ---------------------------------------------------


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
  playerHP.update();
  playerHP.display();
}
