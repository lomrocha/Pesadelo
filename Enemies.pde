// -------------------------------------- ENEMY ---------------------------------------------------

final int[] ENEMIES_SPAWN_X_POSITIONS = {102, 204, 300, 402, 504, 600};

abstract private class Enemy extends BaseMovement
{
  private PVector target = new PVector();

  private int damage;
  private int type;

  private boolean isDisabled;

  // TARGET
  protected void setTarget(PVector target)
  {
    this.target = target;
  }

  public int getTargetX()
  {
    return (int)this.target.x;
  }
  protected void setTargetX(int x)
  {
    this.target.x = x;
  }

  public int getTargetY()
  {
    return (int)this.target.y;
  }

  // DAMAGE
  public int getDamage()
  {
    return this.damage;
  }
  protected void setDamage(int damage)
  {
    this.damage = damage;
  }

  // TYPE
  public int getType()
  {
    return this.type;
  }
  protected void setType(int type)
  {
    this.type = type;
  }

  // IS DISABLED
  public boolean getIsDisabled()
  {
    return this.isDisabled;
  }
  protected void setIsDisabled(boolean isDisabled)
  {
    this.isDisabled = isDisabled;
  }

  abstract void updateMovement();

  abstract void updateTarget();

  boolean isOnScreen()
  {
    if (getY() > 0)
    {
      return true;
    }

    return false;
  }

  void resetVariables(int x)
  {
    setSelf(new PVector(x, -200));
    setIsDisabled(true);
  }
}

// -------------------------------------- SKELETON ---------------------------------------------------

PImage skeletonImage;
PImage skeletonShadow;

final int SKELETON = 1;

final int[] valoresEsqueletoXPrimeiroMapaBoss = {200, 520};

private class Skeleton extends Enemy
{
  Skeleton(int x, int y)
  {
    this.setSelf(new PVector(x, y));

    this.setTypeOfObject(OBJECT_WITH_SHADOW);

    this.setShadowImage(skeletonShadow);
    this.setShadowOffset(new PVector(16, 114));

    this.setSpriteImage(skeletonImage);
    this.setSpriteInterval(155);
    this.setSpriteWidth(76);
    this.setSpriteHeight(126);

    this.setDamage(2);
    this.setType(SKELETON);

    this.setIsDisabled(true);
  }

  void updateMovement()
  {
    setMotionY(3);
  }

  void updateTarget()
  {
    // do nothing.
  }
}

// -------------------------------------- HEADLESS SKELETON ------------------------------------------

PImage headlessSkeletonKickingImage;
PImage headlessSkeletonMovementImage;
PImage headlessSkeletonShadow;

final int HEADLESS_SKELETON = 2;

private class HeadlessSkeleton extends Enemy
{
  private PImage headlessSkeletonSprite;

  private int headlessSkeletonStep;
  private int headlessSkeletonSpriteTime;

  private boolean hasLostHead;
  private boolean kickHeadTrigger;

  private boolean hasNewTarget;

  private boolean headlessSkeletonHasKicked;

  // HEADLESS SKELETON HAS KICKED
  public boolean getHeadlessSkeletonHasKicked()
  {
    return this.headlessSkeletonHasKicked;
  }
  public void setHeadlessSkeletonHasKicked(boolean headlessSkeletonHasKicked)
  {
    this.headlessSkeletonHasKicked = headlessSkeletonHasKicked;
  }

  public HeadlessSkeleton(int x, int y)
  {
    this.setSelf(new PVector(x, y));

    this.setTypeOfObject(OBJECT_WITH_SHADOW);

    this.setShadowImage(headlessSkeletonShadow);
    this.setShadowOffset(new PVector(1, 50));

    this.setSpriteImage(headlessSkeletonMovementImage);
    this.setSpriteInterval(200);
    this.setSpriteWidth(48);
    this.setSpriteHeight(74);

    this.setTarget(new PVector(0, 0));

    this.setDamage(2);
    this.setType(HEADLESS_SKELETON);

    this.setIsDisabled(true);
  }

  void display()
  {
    if (!hasLostHead) {
      if (millis() > headlessSkeletonSpriteTime + 200)
      { 
        if (!isOnScreen())
        {
          headlessSkeletonSprite = headlessSkeletonKickingImage.get(0, 0, 49, 74);
        } else
        {
          headlessSkeletonSprite = headlessSkeletonKickingImage.get(headlessSkeletonStep, 0, 49, 74); 
          headlessSkeletonStep = headlessSkeletonStep % 245 + 49;
        }
        headlessSkeletonSpriteTime = millis();
      }

      image(headlessSkeletonSprite, getX(), getY());

      if (headlessSkeletonStep == 196 && !kickHeadTrigger)
      {
        setHeadlessSkeletonHasKicked(true);
        kickHeadTrigger = true;
      }

      if (headlessSkeletonStep == headlessSkeletonKickingImage.width)
      {
        hasLostHead = true;
        headlessSkeletonStep = 0;
      }

      return;
    }

    super.display();
  }

  void updateMovement()
  {
    if (!hasLostHead)
    {
      setMotionY((!isOnScreen()) ? SCENERY_VELOCITY * 2 : SCENERY_VELOCITY / 2);
      setMotionX(0);
    } else
    {
      setMotionY(SCENERY_VELOCITY);
      setMotionX((getX() < getTargetX()) ? SCENERY_VELOCITY : -SCENERY_VELOCITY);
    }
  }

  void updateTarget()
  {
    if (getX() == getTargetX())
    {
      hasNewTarget = false;
    }

    if (!hasNewTarget)
    {
      PVector random = new PVector(1, getTargetY() + 16);
      while (random.x % 2 != 0)
      {
        random.x = (int)random(getX() - 100, getX() + 100);

        boolean isInBounds = random.x > 120 && random.x < 652;
        if (random.x % 2 == 0 && isInBounds)
        {
          setTarget(random);
          hasNewTarget = true;
        }
      }
    }
  }

  void resetVariables(int x)
  {
    super.resetVariables(x);

    headlessSkeletonStep = 0;

    hasLostHead = false;
    kickHeadTrigger = false;

    hasNewTarget = false;
    setTarget(new PVector(0, 0));

    setHeadlessSkeletonHasKicked(false);
  }
}

// -------------------------------------- SKELETON HEAD ----------------------------------------------

PImage headlessSkeletonHeadImage;

final int HEADLESS_SKELETON_HEAD = 3;

private class HeadlessSkeletonHead extends Projectile 
{
  HeadlessSkeletonHead(int x, int y) 
  {
    this.setSelf(new PVector(x, y));
    this.setTarget(new PVector(playerX, playerY));

    this.setTypeOfObject(OBJECT_WITHOUT_SHADOW);

    this.setStart(new PVector(x, y));
    this.setVelocity(new PVector(0, 0));

    this.setSpriteImage(headlessSkeletonHeadImage);
    this.setSpriteWidth(36);
    this.setSpriteHeight(89);

    this.setDamage(2);
    this.setType(HEADLESS_SKELETON_HEAD);
  }
}

// -------------------------------------- PROJECTILE -------------------------------------------------

private class Projectile extends Enemy 
{
  private PVector start    = new PVector();
  private PVector velocity = new PVector();
  private PVector distance = new PVector();

  // START
  public void setStart(PVector start) 
  {
    this.start = start;
  }

  // VELOCITY
  public void setVelocity(PVector velocity) 
  {
    this.velocity = velocity;
  }

  void display() 
  {
    image(getSpriteImage(), getX(), getY());
  }

  void updateMovement() 
  {
    setMotionY((int)velocity.y);
    if (start.x != getTargetX()) 
    {
      setMotionX((start.x < getTargetX()) ? (int)velocity.x : -(int)velocity.x);

      return;
    }

    setMotionX(0);
  }

  void updateTarget() 
  {
    // Calcula a distância entre o esqueleto e o jogador nos eixos 'x' e 'y'.
    distance.x = (getTargetX() > start.x) ? getTargetX() - (int)start.x : (int)start.x - getTargetX();
    distance.y = getTargetY() - (int)start.y;

    // Baseado na distância calculada acima, a velocidade do projétil é mapeada.
    velocity.x = (int)map(distance.x, 0, 500, 1, 12);
    velocity.y = (int)map(distance.y, 75, 474, 4, 12);
  }

  void resetVariables(int x)
  {
  }
}

// -------------------------------------- DOG SKELETON -----------------------------------------------

PImage dogSkeletonImage;
PImage dogSkeletonShadow;

final PVector DOG_SKELETON_VELOCITY = new PVector(0, 4);
final int DOG_SKELETON = 4;

private class DogSkeleton extends Enemy 
{
  private PVector velocity = new PVector(DOG_SKELETON_VELOCITY.x, DOG_SKELETON_VELOCITY.y);

  private int timeToMove = 0;
  private int numberOfStops;

  private boolean hasNewTarget;

  DogSkeleton(int x, int y) 
  {
    this.setSelf(new PVector(x, y));
    this.setTarget(new PVector(x, height));

    this.setTypeOfObject(OBJECT_WITH_SHADOW);

    this.setShadowImage(dogSkeletonShadow);
    this.setShadowOffset(new PVector(0, 45));

    this.setSpriteImage(dogSkeletonImage);
    this.setSpriteInterval(55);
    this.setSpriteWidth(45);
    this.setSpriteHeight(83);

    this.setDamage(2);
    this.setType(DOG_SKELETON);
    
    this.setIsDisabled(true);
  }

  void updateMovement() 
  {
    setMotionY((!hasNewTarget) ? (int)velocity.y + (int)(numberOfStops * 2) : SCENERY_VELOCITY);
  }

  void updateTarget() {
    if (isOnScreen() && getY() > 15) 
    {
      if (!hasNewTarget && millis() > timeToMove + 1550) 
      {
        numberOfStops++;
        timeToMove = millis();
        hasNewTarget = true;
      }

      if (millis() > timeToMove + 750) 
      {
        hasNewTarget = false;
      }
    }
  }

  void resetVariables(int x)
  {
    super.resetVariables(x);
    
    timeToMove = 0;
    numberOfStops = 0;
    
    hasNewTarget = false;
    setTarget(new PVector(0, 0));
  }
}

// -------------------------------------- CROW SKELETON ----------------------------------------------

PImage crowSkeletonImage;
PImage crowSkeletonShadow;

final int CROW_SKELETON = 5;

private class CrowSkeleton extends Enemy 
{
  private int newTargetInterval;

  private boolean hasNewTarget;

  CrowSkeleton(int x, int y) 
  {
    setValues(x, y);
  }

  private void setValues(int x, int y) 
  {
    this.setSelf(new PVector(x, y));
    this.setTarget(new PVector(playerX, playerY));

    this.setTypeOfObject(OBJECT_WITH_SHADOW);

    this.setShadowImage(crowSkeletonShadow);
    this.setShadowOffset(new PVector(24, 86));

    this.setSpriteImage(crowSkeletonImage);
    this.setSpriteInterval(75);
    this.setSpriteWidth(121);
    this.setSpriteHeight(86);

    this.setDamage(3);
    this.setType(CROW_SKELETON);
    
    this.setIsDisabled(true);
  }

  void updateMovement() 
  {
    setMotionY(3);
    if (getX() != getTargetX() && isOnScreen()) 
    {
      setMotionX((getX() < getTargetX()) ? 3 : -3);
      
      return;
    }

    setMotionX(0);
  }

  void updateTarget()
  {
    if (isOnScreen()) 
    {
      if (!hasNewTarget) 
      {
        setTargetX(3 * (int)(playerX / 3));
        newTargetInterval = millis();
        hasNewTarget = true;
      }

      if (millis() > newTargetInterval + 1050) 
      {
        hasNewTarget = false;
      }
    }
  }

  boolean hasCollided() 
  {
    if (getX() + 95 > playerX && getX() + 25 < playerX + 63 && getY() + 86 > playerY && getY() < playerY + 126) 
    {
      return true;
    }

    return false;
  }

  void resetVariables(int x)
  {
    super.resetVariables(x);
    
    println(getX());
    
    hasNewTarget = false;
    setTarget(new PVector(0, 0));
  }
}

// -------------------------------------- RED SKELETON -----------------------------------------------

PImage redSkeleton;
PImage redSkeletonShadow;

final int RED_SKELETON = 6;

final int LEFT_SIDE_ON_GRID = 0;
final int RIGHT_SIDE_ON_GRID = 1;

private class EsqueletoRaiva extends Enemy {
  private int positionOnGrid;

  private boolean hasNewTarget;

  EsqueletoRaiva(int x, int y, int positionOnGrid) {
    this.setSelf(new PVector(x, y));
    this.setTarget((positionOnGrid == RIGHT_SIDE_ON_GRID) ? new PVector(100, 0) : new PVector(625, 0));

    this.setTypeOfObject(OBJECT_WITH_SHADOW);

    this.setShadowImage(redSkeletonShadow);
    this.setShadowOffset(new PVector(16, 114));

    this.setSpriteImage(redSkeleton);
    this.setSpriteInterval(75);
    this.setSpriteWidth(76);
    this.setSpriteHeight(126);

    this.setDamage(3);
    this.setType(RED_SKELETON);

    this.positionOnGrid = positionOnGrid;
  }

  void updateMovement() {
    if (isOnScreen()) {
      setMotionY(1);
      setMotionX((getX() < getTargetX()) ? 5 : -5);
    } else {
      setMotionY(4);
      setMotionX(0);
    }
  }

  void updateTarget() {
    if (isOnScreen()) {
      if (getX() == getTargetX()) {
        hasNewTarget = false;
      }

      if (!hasNewTarget) {
        switch(positionOnGrid) {
        case LEFT_SIDE_ON_GRID:
          setTargetX(625);
          positionOnGrid = RIGHT_SIDE_ON_GRID;
          break;
        case RIGHT_SIDE_ON_GRID:
          setTargetX(100);
          positionOnGrid = LEFT_SIDE_ON_GRID;
          break;
        }
        hasNewTarget = true;
      }
    }
  }
  
  void resetVariables(int x)
  {
  }
}

// ----------------------------------------- ENEMIES MANAGER ---------------------------------------------------

private class EnemiesManager
{
  private <T_Enemy extends Enemy> void computeEnemy(ArrayList<T_Enemy> enemies, ArrayList<HeadlessSkeletonHead> headlessSkeletonHeads, EnemiesSpawnManager spawnManager)
  {
    for (int i = 0; i < enemies.size(); ++i)
    {
      T_Enemy enemy = enemies.get(i);

      if (!enemy.getIsDisabled()) 
      {
        if (enemy.getType() == HEADLESS_SKELETON) triggerHeadlessSkeleton(enemy, headlessSkeletonHeads);

        enemy.updateTarget();
        enemy.updateMovement();
        enemy.update();
        enemy.display();

        if (enemy.hasExitScreen())
        {
          disableEnemy(enemy, spawnManager);
        }

        if (enemy.hasCollided())
        {
          damage(enemy.getDamage());
        }
      }
    }
  }

  private <T_Enemy extends Enemy> void deleteEnemy(ArrayList<T_Enemy> enemies, ArrayList<Weapon> weapons, EnemiesSpawnManager spawnManager)
  {
    for (int i = 0; i < enemies.size(); ++i)
    {
      T_Enemy enemy = enemies.get(i);
      for (int j = weapons.size() - 1; j >= 0; j--)
      {
        Weapon weapon = weapons.get(j);

        if (weapon.hasHit(enemy))
        {
          hitInimigos(enemy.getX() - 40, enemy.getY() - 20);
          disableEnemy(enemy, spawnManager);
        }
      }
    }
  }

  private void triggerHeadlessSkeleton(Enemy enemy, ArrayList<HeadlessSkeletonHead> headlessSkeletonHeads)
  {
    try
    {
      HeadlessSkeleton tmp = (HeadlessSkeleton)enemy;

      if (tmp.getHeadlessSkeletonHasKicked())
      {
        headlessSkeletonHeads.add(new HeadlessSkeletonHead(tmp.getX(), tmp.getY()));
        tmp.setHeadlessSkeletonHasKicked(false);
      }
    }
    catch(Exception e)
    {
      println(e.getMessage());
    }
  }

  private void handleSpawnManagerVariables(Enemy enemy, EnemiesSpawnManager spawnManager)
  {
    if (enemy.getType() != HEADLESS_SKELETON_HEAD)
    {
      switch(enemy.getType()) {
      case SKELETON:
        spawnManager.setSkeletonTotal(spawnManager.getSkeletonTotal() - 1);
        break;
      case HEADLESS_SKELETON:
        spawnManager.setHeadlessSkeletonTotal(spawnManager.getHeadlessSkeletonTotal() - 1);
        break;
      case DOG_SKELETON:
        spawnManager.setDogSkeletonTotal(spawnManager.getDogSkeletonTotal() - 1);
        break;
      case CROW_SKELETON:
        spawnManager.setCrowSkeletonTotal(spawnManager.getCrowSkeletonTotal() - 1);
        break;
      case RED_SKELETON:
        spawnManager.setRedSkeletonTotal(spawnManager.getRedSkeletonTotal() - 1);
        break;
      }

      spawnManager.setEnemiesTotal(spawnManager.getEnemiesTotal() - 1);
    }
  }

  private void disableEnemy(Enemy enemy, EnemiesSpawnManager spawnManager)
  {
    handleSpawnManagerVariables(enemy, spawnManager);

    int enemyPosition = -1;
    do {
      enemyPosition = (int)random(0, ENEMIES_SPAWN_X_POSITIONS.length);
    } while (enemyPosition == spawnManager.getEnemyLastPosition());

    spawnManager.setEnemyLastPosition(enemyPosition);
    enemy.resetVariables(ENEMIES_SPAWN_X_POSITIONS[enemyPosition]);
  }

  private void damage(int amount)
  {
    if (!isPlayerImmune)
    {
      playerCurrentHP -= amount;
      isPlayerImmune = true;
      timeImmune = millis();
    }
  }
}

// ----------------------------------------- ENEMIES SPAWN MANAGER ---------------------------------------------------

abstract private class EnemiesSpawnManager
{
  private int skeletonTotal;
  private int headlessSkeletonTotal;
  private int dogSkeletonTotal;
  private int crowSkeletonTotal;
  private int redSkeletonTotal;

  private int enemyLastPosition;
  private int enemiesTotal;

  private int spawnState;

  // SKELETON TOTAL
  public int getSkeletonTotal()
  {
    return this.skeletonTotal;
  }
  public void setSkeletonTotal(int skeletonTotal)
  {
    this.skeletonTotal = skeletonTotal;
  }

  // HEADLESS SKELETON TOTAL
  public int getHeadlessSkeletonTotal()
  {
    return this.headlessSkeletonTotal;
  }
  public void setHeadlessSkeletonTotal(int headlessSkeletonTotal)
  {
    this.headlessSkeletonTotal = headlessSkeletonTotal;
  }

  // DOG SKELETON TOTAL
  public int getDogSkeletonTotal()
  {
    return this.dogSkeletonTotal;
  }
  public void setDogSkeletonTotal(int dogSkeletonTotal)
  {
    this.dogSkeletonTotal = dogSkeletonTotal;
  }

  // CROW SKELETON TOTAL
  public int getCrowSkeletonTotal()
  {
    return this.crowSkeletonTotal;
  }
  public void setCrowSkeletonTotal(int crowSkeletonTotal)
  {
    this.crowSkeletonTotal = crowSkeletonTotal;
  }

  // RED SKELETON TOTAL
  public int getRedSkeletonTotal()
  {
    return this.redSkeletonTotal;
  }
  public void setRedSkeletonTotal(int redSkeletonTotal)
  {
    this.redSkeletonTotal = redSkeletonTotal;
  }

  // ENEMIES TOTAL
  public int getEnemyLastPosition()
  {
    return this.enemyLastPosition;
  }
  public void setEnemyLastPosition(int enemyLastPosition)
  {
    this.enemyLastPosition = enemyLastPosition;
  }

  // ENEMIES TOTAL
  public int getEnemiesTotal()
  {
    return this.enemiesTotal;
  }
  public void setEnemiesTotal(int enemiesTotal)
  {
    this.enemiesTotal = enemiesTotal;
  }

  EnemiesSpawnManager()
  {
    skeletonTotal         = 0;
    headlessSkeletonTotal = 0;
    dogSkeletonTotal      = 0;
    crowSkeletonTotal     = 0;
    redSkeletonTotal      = 0;

    enemyLastPosition     =-1;
    enemiesTotal          = 0;

    spawnState            = 1;
  }

  void updateSpawnState()
  {
    spawnState = (numberOfSceneries % 7 == 0 && numberOfSceneries != 0) ? (numberOfSceneries / 7) + 1 : spawnState;
  }

  void states()
  {
    if (!movementTutorialScreenActive)
    {
      switch (spawnState)
      {
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
  }

  void spawnEnemy(ArrayList<Enemy> enemies, PVector range, int enemyType)
  {
    enableEnemy(enemies, range);

    switch(enemyType)
    {
    case SKELETON:
      setSkeletonTotal(getSkeletonTotal() + 1);
      break;
    case HEADLESS_SKELETON:
      setHeadlessSkeletonTotal(getHeadlessSkeletonTotal() + 1);
      break;
    case DOG_SKELETON:
      setDogSkeletonTotal(getDogSkeletonTotal() + 1);
      break;
    case CROW_SKELETON:
      setCrowSkeletonTotal(getCrowSkeletonTotal() + 1);
      break;
    case RED_SKELETON:
      setRedSkeletonTotal(getRedSkeletonTotal() + 1);
    }
  }

  void enableEnemy(ArrayList<Enemy> enemies, PVector range)
  {
    int disabledEnemyIndex = getDisabledEnemyIndex(enemies, range);
    if (disabledEnemyIndex > -1) enemies.get(disabledEnemyIndex).setIsDisabled(false);
    this.setEnemiesTotal(getEnemiesTotal() + 1);
  }

  int getDisabledEnemyIndex(ArrayList<Enemy> enemies, PVector range)
  {
    for (int i = (int)range.x; i < (int)range.y; ++i)
    {
      Enemy enemy = enemies.get(i);
      if (enemy.getIsDisabled())
      {
        return i;
      }
    }

    return -1;
  }

  abstract void firstBatch();

  abstract void secondBatch();

  abstract void thirdBatch();

  abstract void fourthBatch();

  abstract void fifthBatch();

  abstract void sixthBatch();
}

// ----------------------------------------- FIRST MAP SPAWN MANAGER ---------------------------------------------------

final PVector SKELETONS_INDEX_RANGE          = new PVector(0, 2);
final PVector HEADLESS_SKELETONS_INDEX_RANGE = new PVector(2, 4);
final PVector DOG_SKELETONS_INDEX_RANGE      = new PVector(4, 6);
final PVector CROW_SKELETONS_INDEX_RANGE     = new PVector(6, 8);
final PVector RED_SKELETONS_INDEX_RANGE      = new PVector(8, 10);

private class FirstMapEnemiesSpawnManager extends EnemiesSpawnManager
{
  private ArrayList<Enemy> enemies                              = new ArrayList<Enemy>();
  private ArrayList<HeadlessSkeletonHead> headlessSkeletonHeads = new ArrayList<HeadlessSkeletonHead>();

  final int[] SKELETON_MAXIMUM          = { 1, 0, 1, 2, 2, 0 };
  final int[] HEADLESS_SKELETON_MAXIMUM = { 0, 1, 1, 1, 2, 0 };
  final int[] ENEMIES_MAXIMUM           = { 1, 1, 2, 3, 4, 0 };

  FirstMapEnemiesSpawnManager()
  {
    super();

    enemies.add(new Skeleton(300, -200));
    enemies.add(new Skeleton(500, -200));
    enemies.add(new HeadlessSkeleton(300, -200));
    enemies.add(new HeadlessSkeleton(600, -200));
  }

  void handleEnemySpawn(int maximum, int index)
  {
    while (getEnemiesTotal() < maximum)
    {
      if (getSkeletonTotal() < SKELETON_MAXIMUM[index])
      {
        spawnEnemy(enemies, SKELETONS_INDEX_RANGE, SKELETON);
      }       

      if (getHeadlessSkeletonTotal() < HEADLESS_SKELETON_MAXIMUM[index])
      {
        spawnEnemy(enemies, HEADLESS_SKELETONS_INDEX_RANGE, HEADLESS_SKELETON);
      }
    }
  }

  void firstBatch()
  {
    int max = ENEMIES_MAXIMUM[0];

    handleEnemySpawn(max, 0);
  }

  void secondBatch()
  {
    int max = ENEMIES_MAXIMUM[1];

    handleEnemySpawn(max, 1);
  }

  void thirdBatch()
  {
    int max = ENEMIES_MAXIMUM[2];

    handleEnemySpawn(max, 2);
  }

  void fourthBatch()
  {
    int max = ENEMIES_MAXIMUM[3];

    handleEnemySpawn(max, 3);
  }

  void fifthBatch()
  {
    int max = ENEMIES_MAXIMUM[4];

    handleEnemySpawn(max, 4);
  }

  void sixthBatch()
  {
  }
}

// ----------------------------------------- SECOND MAP SPAWN MANAGER ---------------------------------------------------

private class SecondMapEnemiesSpawnManager extends EnemiesSpawnManager
{
  private ArrayList<Enemy> enemies                              = new ArrayList<Enemy>();
  private ArrayList<HeadlessSkeletonHead> headlessSkeletonHeads = new ArrayList<HeadlessSkeletonHead>();

  final int[] SKELETON_MAXIMUM          = { 1, 1, 0, 1, 1, 0 };
  final int[] HEADLESS_SKELETON_MAXIMUM = { 1, 0, 1, 0, 1, 0 };
  final int[] DOG_SKELETON_MAXIMUM      = { 0, 1, 1, 1, 1, 0 };
  final int[] CROW_SKELETON_MAXIMUM     = { 0, 0, 0, 1, 1, 0 };
  final int[] ENEMIES_MAXIMUM           = { 2, 2, 2, 3, 4, 0 };

  SecondMapEnemiesSpawnManager()
  {
    super();

    enemies.add(new Skeleton(300, -200));
    enemies.add(new Skeleton(500, -200));
    enemies.add(new HeadlessSkeleton(300, -200));
    enemies.add(new HeadlessSkeleton(600, -200));
    enemies.add(new DogSkeleton(300, -200));
    enemies.add(new DogSkeleton(600, -200));
    enemies.add(new CrowSkeleton(300, -200));
    enemies.add(new CrowSkeleton(600, -200));
  }

  void handleEnemySpawn(int maximum, int index)
  {
    while (getEnemiesTotal() < maximum)
    {
      if (getSkeletonTotal() < SKELETON_MAXIMUM[index])
      {
        spawnEnemy(enemies, SKELETONS_INDEX_RANGE, SKELETON);
      }       

      if (getHeadlessSkeletonTotal() < HEADLESS_SKELETON_MAXIMUM[index])
      {
        spawnEnemy(enemies, HEADLESS_SKELETONS_INDEX_RANGE, HEADLESS_SKELETON);
      }

      if (getDogSkeletonTotal() < DOG_SKELETON_MAXIMUM[index])
      {
        spawnEnemy(enemies, DOG_SKELETONS_INDEX_RANGE, DOG_SKELETON);
      }

      if (getCrowSkeletonTotal() < CROW_SKELETON_MAXIMUM[index])
      {
        spawnEnemy(enemies, CROW_SKELETONS_INDEX_RANGE, CROW_SKELETON);
      }
    }
  }

  void firstBatch()
  {
    int max = ENEMIES_MAXIMUM[0];

    handleEnemySpawn(max, 0);
  }

  void secondBatch()
  {
    int max = ENEMIES_MAXIMUM[1];

    handleEnemySpawn(max, 1);
  }

  void thirdBatch()
  {
    int max = ENEMIES_MAXIMUM[2];

    handleEnemySpawn(max, 2);
  }

  void fourthBatch()
  {
    int max = ENEMIES_MAXIMUM[3];

    handleEnemySpawn(max, 3);
  }

  void fifthBatch()
  {
    int max = ENEMIES_MAXIMUM[4];

    handleEnemySpawn(max, 4);
  }

  void sixthBatch()
  {
  }
}

// ----------------------------------------- THIRD MAP SPAWN MANAGER ---------------------------------------------------

private class ThirdMapEnemiesSpawnManager extends EnemiesSpawnManager
{

  ThirdMapEnemiesSpawnManager()
  {
  }

  void firstBatch()
  {
  }

  void secondBatch()
  {
  }

  void thirdBatch()
  {
  }

  void fourthBatch()
  {
  }

  void fifthBatch()
  {
  }

  void sixthBatch()
  {
  }
}

// ----------------------------------------- FIRST BOSS SPAWN MANAGER ---------------------------------------------------




// ----------------------------------------- SECOND BOSS SPAWN MANAGER ---------------------------------------------------




// ----------------------------------------- THIRD BOSS SPAWN MANAGER ---------------------------------------------------




// ------------------------------------------------- EXTRA ----------------------------------------------------------
