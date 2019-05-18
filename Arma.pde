// -------------------------------------- ITEM ---------------------------------------------------

private class Item extends Geral {
  private int itemIndex;
  private int itemTotal;

  // ITEM_INDEX
  public int getItemIndex() {
    return this.itemIndex;
  }
  protected void setItemIndex(int itemIndex) {
    this.itemIndex = itemIndex;
  }

  // ITEM_TOTAL
  public int getItemTotal() {
    return this.itemTotal;
  }
  protected void setItemTotal(int itemTotal) {
    this.itemTotal = itemTotal;
  }
}

// -------------------------------------- WEAPON ---------------------------------------------------

abstract private class Weapon extends MaisGeral 
{
  private int firstCollisionX;
  private int secondCollisionX;
  private int firstCollisionY;
  private int secondCollisionY;

  private boolean deleteWeapon;
  private boolean damageBoss;

  // FIRST_COLLISION_X
  protected void setFirstCollisionX(int firstCollisionX) 
  {
    this.firstCollisionX = firstCollisionX;
  }

  // SECOND_COLLISION_X
  protected void setSecondCollisionX(int secondCollisionX) 
  {
    this.secondCollisionX = secondCollisionX;
  }

  // FIRST_COLLISION_Y
  protected void setFirstCollisionY(int firstCollisionY) 
  {
    this.firstCollisionY = firstCollisionY;
  }

  // SECOND_COLLISION_Y
  protected void setSecondCollisionY(int secondCollisionY) 
  {
    this.secondCollisionY = secondCollisionY;
  }
  
  // DELETE_WEAPON
  public boolean getDeleteWeapon() 
  {
    return deleteWeapon;
  } 
  protected void setDeleteWeapon(boolean deleteWeapon) 
  {
    this.deleteWeapon = deleteWeapon;
  }
  
  // DAMAGE_BOSS
  public boolean getDamageBoss() 
  {
    return damageBoss;
  }
  protected void setDamageBoss(boolean damageBoss) 
  {
    this.damageBoss = damageBoss;
  }

  void stepHandler() {
    if (getStep() == getSpriteImage().width) 
    {
      this.deleteWeapon = true;
    }
  }

  abstract void update();

  boolean hasHit(Geral g) 
  {
    if (firstCollisionX > g.getX() && secondCollisionX < g.getX() + g.getSpriteWidth() && firstCollisionY > g.getY() && secondCollisionY < g.getY() + g.getSpriteHeight()) {
      hitInimigosMostrando = true;
      return true;
    }

    return false;
  }

  boolean hasHitCoveiro() 
  {
    if (firstCollisionX > coveiroX && secondCollisionX < coveiroX + 169 && firstCollisionY > coveiroY && secondCollisionY < coveiroY + 188) {
      hitBossesMostrando = true;
      hitBosses(coveiroX, coveiroY + 20);
      return true;
    } 

    return false;
  }

  boolean hasHitFazendeiro() 
  {
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

  boolean hasHitPadre() 
  {
    if (firstCollisionX > padreX + 20 && secondCollisionX < padreX + 110 && firstCollisionY > padreY && secondCollisionY < padreY + 152) {
      hitBossesMostrando = true;
      hitBosses(padreX, padreY);
      return true;
    } 

    return false;
  }
}

// -------------------------------------- WHIP ITEM ---------------------------------------------------

PImage whip;
PImage whipShadow;

final int WHIP = 2;
final int WHIPTOTAL = 5;

private class Chicote extends Item {
  Chicote(int x, int y) {
    setValues(x, y, OBJECT_WITHOUT_SHADOW);
  }

  Chicote() {
    setValues(int(random(100, 600)), -50, OBJECT_WITH_SHADOW);
  }

  private void setValues(int x, int y, int index) {
    this.setSelf(new PVector(x, y));
    
    this.setTypeOfObject(index);

    this.setShadowImage(whipShadow);
    this.setShadowOffset(new PVector(10, 76));

    this.setSpriteImage(whip);
    this.setSpriteInterval(75);
    this.setSpriteWidth(101);
    this.setSpriteHeight(91);
    this.setMotionY(SCENERY_VELOCITY / 2);

    this.setItemIndex(WHIP);
    this.setItemTotal(WHIPTOTAL);
  }
}

// -------------------------------------- WHIP WEAPON ---------------------------------------------------

PImage whipAttack;

private class ChicoteAtaque extends Weapon {
  ChicoteAtaque() {
    this.setSelf(new PVector(playerX - 70, playerY - 140));
    
    this.setTypeOfObject(OBJECT_WITHOUT_SHADOW);

    this.setSpriteImage(whipAttack);
    this.setSpriteInterval(110);
    this.setSpriteWidth(234);
    this.setSpriteHeight(278);

    this.setDeleteWeapon(false);
    this.setDamageBoss(false);

    this.setFirstCollisionX(playerX + 86);
    this.setSecondCollisionX(playerX + 20);
    this.setFirstCollisionY(playerY);
    this.setSecondCollisionY(playerY - 140);
  }

  void update() {
    setX(playerX - 70);
    setY(playerY - 140);
  }
}

// -------------------------------------- SHOVEL ITEM ---------------------------------------------------

PImage shovel;
PImage shovelShadow;

final int SHOVEL = 1;
final int SHOVELTOTAL = 5;

private class Pa extends Item {
  Pa(int x, int y) {
    setValues(x, y, OBJECT_WITHOUT_SHADOW);
  }

  Pa() {
    setValues(int(random(100, 610)), -50, OBJECT_WITH_SHADOW);
  }

  private void setValues(int x, int y, int index) {
    this.setSelf(new PVector(x, y));
    
    this.setTypeOfObject(index);
    
    this.setShadowImage(shovelShadow);
    this.setShadowOffset(new PVector(1, 85));
    
    this.setSpriteImage(shovel);
    this.setSpriteInterval(75);
    this.setSpriteWidth(84);
    this.setSpriteHeight(91);
    this.setMotionY(SCENERY_VELOCITY / 2);

    this.setItemIndex(SHOVEL);
    this.setItemTotal(SHOVELTOTAL);
  }
}

// -------------------------------------- SHOVEL WEAPON ---------------------------------------------------

PImage shovelAttack;

private class PaAtaque extends Weapon {
  PaAtaque() {
    this.setSelf(new PVector(playerX - 70, playerY - 44));

    this.setTypeOfObject(OBJECT_WITHOUT_SHADOW);

    this.setSpriteImage(shovelAttack);
    this.setSpriteInterval(90);
    this.setSpriteWidth(234);
    this.setSpriteHeight(173);

    this.setDeleteWeapon(false);
    this.setDamageBoss(false);

    this.setFirstCollisionX(playerX + 160);
    this.setSecondCollisionX(playerX - 70);
    this.setFirstCollisionY(playerY + 56);
    this.setSecondCollisionY(playerY - 44);
  }

  void update() {
    setX(playerX - 70);
    setY(playerY - 44);
  }
}

// ------------------------------------ ITEM MANAGER -------------------------------------------------

private class ItemManager {
  private void computeItem(ArrayList<Item> items, ItemSpawnManager itemSpawnManager, WeaponSpawnManager weaponSpawnManager) {  
    for (int i = items.size() - 1; i >= 0; i = i - 1) {
      Item it = items.get(i);
      if (gameState >= GameState.FIRST_MAP.getValue() && gameState <= GameState.THIRD_MAP.getValue()) {
        it.update();
      }
      it.display();
      if (it.hasExitScreen() || it.hasCollided()) {
        items.remove(it);
        itemSpawnManager.setSpawnVariables(7000);

        if (it.hasCollided()) {
          weaponSpawnManager.setItemIndex(it.getItemIndex());
          weaponSpawnManager.setWeaponTotal(it.getItemTotal());
        }
      }
    }
  }
}

// ------------------------------------ ITEM SPAWN MANAGER -------------------------------------------------

abstract private class ItemSpawnManager {
  private int itemTotal;
  private int itemIndex = 10;

  private int timeToGenerateItem;
  private int intervalToGenerateItem = 10000;

  private boolean hasItemIndexChanged;

  // ITEM_TOTAL
  public int getItemTotal() {
    return this.itemTotal;
  }
  public void setItemTotal(int itemTotal) {
    this.itemTotal = itemTotal;
  }

  // ITEM_INDEX
  public int getItemIndex() {
    return this.itemIndex;
  }

  // TIME_TO_GENERATE_ITEM
  public int getTimeToGenerateItem() {
    return this.timeToGenerateItem;
  }

  // INTERVAL_TO_GENERATE_ITEM
  public int getIntervalToGenerateItem() {
    return this.intervalToGenerateItem;
  }

  // HAS_ITEM_INDEX_CHANGED
  public boolean getHasItemIndexChanged() {
    return this.hasItemIndexChanged;
  }

  abstract protected void addItem();

  void randomizeItemIndex() {
    if (!hasItemIndexChanged) {
      itemIndex = (int)random(0, 10);
      hasItemIndexChanged = true;
    }
  }

  void setSpawnVariables(int timeAmount) {
    itemTotal = (itemTotal == 1) ? itemTotal-- : itemTotal;

    hasItemIndexChanged = false;
    timeToGenerateItem = millis();
    intervalToGenerateItem = timeAmount;
  }
}

// ------------------------------- REGULAR MAP ITEM SPAWN MANAGER -------------------------------------

private class RegularMapItemSpawnManager extends ItemSpawnManager {
  private ArrayList<Item> items = new ArrayList<Item>();

  protected void addItem() {
    if (getItemTotal() == 0 && getHasItemIndexChanged() && millis() > getTimeToGenerateItem() + getIntervalToGenerateItem() && items.size() == 0) {
      if (getItemIndex() >= 0 && getItemIndex() <= 4) {
        items.add(new Pa());
      } else if (getItemIndex() >=5 && getItemIndex() <= 9) {
        items.add(new Chicote());
      }

      setItemTotal(getItemTotal() + 1);
    }
  }
}

// ------------------------------- BOSS MAP ITEM SPAWN MANAGER -------------------------------------

private class BossMapItemSpawnManager extends ItemSpawnManager {
  private ArrayList<Item> items = new ArrayList<Item>();

  protected void addItem() {
    switch(gameState) {
    case 3:
      setItem(X_VALUES_FIRST_BOSS, Y_VALUES_FIRST_BOSS);
      break;
    case 4:
      setItem(X_VALUES_SECOND_BOSS, Y_VALUES_SECOND_BOSS);
      break;
    case 5:
      setItem(X_VALUES_THIRD_BOSS, Y_VALUES_THIRD_BOSS);
      break;
    }
  }

  private void setItem(int[] xValues, int[] yValues) {
    int itemRandomMapPositionIndex = (int)random(0, xValues.length);
    if (getItemIndex() >= 0 && getItemIndex() <= 4) {
      items.add(new Pa(xValues[itemRandomMapPositionIndex], yValues[itemRandomMapPositionIndex]));
    } else if (getItemIndex() >= 5 && getItemIndex() <= 9) {
      items.add(new Chicote(xValues[itemRandomMapPositionIndex], yValues[itemRandomMapPositionIndex]));
    }

    setItemTotal(getItemTotal() + 1);
  }
}

// -------------------------------------- WEAPON MANAGER ---------------------------------------------------

private class WeaponManager {
  void computeWeapon(ArrayList<Weapon> weapons, WeaponSpawnManager weaponSpawnManager) {
    for (int i = weapons.size() - 1; i >= 0; i = i - 1) {
      Weapon a = weapons.get(i);
      a.update();
      a.display();
      if (a.getDeleteWeapon()) {
        weapons.remove(a);
      }
    }
  }
}

// ----------------------------------- WEAPON SPAWN MANAGER ----------------------------------------------

private class WeaponSpawnManager {
  private ArrayList<Weapon> weapons = new ArrayList<Weapon>();

  private int itemIndex;
  private int weaponTotal;

  // ITEM_INDEX
  public void setItemIndex(int itemIndex) {
    this.itemIndex = itemIndex;
  }

  // WEAPON_TOTAL
  public int getWeaponTotal() {
    return this.weaponTotal;
  }
  public void setWeaponTotal(int weaponTotal) {
    this.weaponTotal = weaponTotal;
  }

  private void addWeapon() {
    if (!oneWeapon) {
      switch (itemIndex) {
        case WHIP:
          weapons.add(new ChicoteAtaque());
          break;	
        case SHOVEL:
          weapons.add(new PaAtaque());
          break;
      }

      weaponTotal--;
      oneWeapon = true;
    }
  }
}

// -------------------------------------- EXTRA ---------------------------------------------------

boolean oneWeapon;

void weapon() 
{
  if (!oneWeapon) 
  {
    switch(item) 
    {
    case WHIP: 
      weapons.add(new ChicoteAtaque());
      break;
    case SHOVEL:
      weapons.add(new PaAtaque());
      break;
    }

    weaponTotal--;
    oneWeapon = true;
  }
}

int item;

int weaponTotal;

int itemTotal;
int timeToGenerateItem;
int itemIndex;

int itemRandomMapPositionIndex;

int intervalToGenerateItem;

boolean hasItemIndexChanged;

void weapons() {
  //if (weaponTotal == 0 && !jLeiteUsoItem && itens.size() == 0) {
  //  item = 0;
  //  itemTotal = 0;
  //}

  if (weapons.size() > 0) {
    arma();
  }

  if (jLeiteUsoItem && weapons.size() == 0 && weaponTotal > 0) {
    weapon();
  }
}

ArrayList<Weapon> weapons = new ArrayList<Weapon>();


void arma() 
{
  for (int i = weapons.size() - 1; i >= 0; i = i - 1) 
  {
    Weapon a = weapons.get(i);
    a.update();
    a.display();
    if (a.getDeleteWeapon()) 
    {
      weapons.remove(a);
    }
    if (gameState == GameState.FIRST_BOSS.getValue()) 
    {
      if (a.hasHitCoveiro() && !a.getDamageBoss()) 
      {
        if (isSoundActive) 
        {
          indexRandomSomCoveiroTomandoDano = int(random(0, sonsCoveiroTomandoDano.length));
          sonsCoveiroTomandoDano[indexRandomSomCoveiroTomandoDano].rewind();
          sonsCoveiroTomandoDano[indexRandomSomCoveiroTomandoDano].play();
        }
        coveiroCurrentHP -= 2;
        a.setDamageBoss(true);
      }
    }
    if (gameState == GameState.SECOND_BOSS.getValue()) 
    {
      if (a.hasHitFazendeiro() && !a.getDamageBoss()) 
      {
        if (isSoundActive) 
        {
          indexRandomSomFazendeiroTomandoDano = int(random(0, sonsFazendeiroTomandoDano.length));
          sonsFazendeiroTomandoDano[indexRandomSomFazendeiroTomandoDano].rewind();
          sonsFazendeiroTomandoDano[indexRandomSomFazendeiroTomandoDano].play();
        }
        fazendeiroCurrentHP -= 2;
        a.setDamageBoss(true);
      }
    }
    if (gameState == GameState.THIRD_BOSS.getValue()) 
    {
      if (a.hasHitPadre() && !a.getDamageBoss()) 
      {
        if (padreCurrentHP > 0) {
          if (isSoundActive) 
          {
            indexRandomSomPadreTomandoDano = int(random(0, sonsPadreTomandoDano.length));
            sonsPadreTomandoDano[indexRandomSomPadreTomandoDano].rewind();
            sonsPadreTomandoDano[indexRandomSomPadreTomandoDano].play();
          }
          padreCurrentHP -= 2;
          a.setDamageBoss(true);
        } else {
          if (isSoundActive) 
          {
            indexRandomSomPadreTomandoDano = int(random(0, sonsPadreRaivaTomandoDano.length));
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
