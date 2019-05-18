// -------------------------------------- ENEMY ---------------------------------------------------

final int[] ENEMIES_SPAWN_X_POSITIONS = {102, 201, 300, 402, 501, 600};

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

  abstract void resetVariables(int x);
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

  void resetVariables(int x)
  {
    setSelf(new PVector(x, -200));
    setIsDisabled(true);
  }
}

int esqueletoC, esqueletoL;
int indexRandomEsqueletoXMapaBoss;

void esqueleto() {
  //if (indexInimigos == 0) {
  //  if (gameState == GameState.FIRSTBOSS.getValue()) {
  //    if (esqueletos.size() == 0 && !coveiro.coveiroMorreu && !coveiroTomouDanoAgua) {
  //      for (int i = 0; i < 2; i = i + 1) {
  //        indexRandomEsqueletoXMapaBoss = int(random(0, 2));
  //        esqueletos.add(new Esqueleto(valoresEsqueletoXPrimeiroMapaBoss[indexRandomEsqueletoXMapaBoss], 0));
  //      }
  //    }
  //  }

  //  if (gameState == GameState.THIRDBOSS.getValue()) { 
  //    if (esqueletos.size() == 0 && totalInimigos < maximoInimigosPadre && !padre.padreMorreu) {
  //      indexRandomEsqueletoXMapaBoss = int(random(0, valoresInimigosXTerceiroMapaBoss.length));
  //      esqueletos.add(new Esqueleto(valoresInimigosXTerceiroMapaBoss[indexRandomEsqueletoXMapaBoss], 0));
  //      totalInimigos = totalInimigos + 1;
  //    }
  //  }

  //if (!movementTutorialScreenActive) {
  //  /*if (gameState == GameState.FIRSTMAP.getValue() && esqueletos.size() < 2 && totalInimigos < 6) {
  //   esqueletoC = int(random(0, 7));
  //   esqueletoL = int(random(0, 4));

  //   if (ENEMY_POSITIONS_FIRST_MAP[esqueletoC][esqueletoL] == SKELETON) {
  //   esqueletos.add(new Esqueleto(100 + (esqueletoC * (600 / 7)), -150 - (esqueletoL * 150)));
  //   totalInimigos = totalInimigos + 1;
  //   }
  //   }*/

  //  if (gameState == GameState.SECONDMAP.getValue() && esqueletos.size() < 2 && totalInimigos < 6) {
  //    esqueletoC = int(random(0, 7));
  //    esqueletoL = int(random(0, 4));

  //    if (ENEMY_POSITIONS_SECOND_MAP[esqueletoC][esqueletoL] == SKELETON) {
  //      esqueletos.add(new Esqueleto(100 + (esqueletoC * (600 / 7)), -150 - (esqueletoL * 150)));
  //      totalInimigos = totalInimigos + 1;
  //    }
  //  }

  //  if (gameState == GameState.THIRDMAP.getValue() && esqueletos.size() < 2 && totalInimigos < 6) {
  //    esqueletoC = int(random(0, 7));
  //    esqueletoL = int(random(0, 4));

  //    if (ENEMY_POSITIONS_THIRD_MAP[esqueletoC][esqueletoL] == SKELETON) {
  //      esqueletos.add(new Esqueleto(100 + (esqueletoC * (600 / 7)), -150 - (esqueletoL * 150)));
  //      totalInimigos = totalInimigos + 1;
  //    }
  //  }
  //}

  //if (firstMap.firstMapEnemiesSpawnManager.enemies.size() > 0) {
  //  computeEnemy(firstMapEnemiesSpawnManager.enemies, firstMapEnemiesSpawnManager);
  //  deleteEnemy(firstMapEnemiesSpawnManager.skeletons, firstMapEnemiesSpawnManager);
  //}
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
    //image (headlessSkeletonShadow, getX() + 1, getY() + 50);

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
      setMotionY((!isOnScreen()) ? 4 : SCENERY_VELOCITY / 2);
      setMotionX(0);
    } else
    {
      setMotionY(SCENERY_VELOCITY);
      setMotionX((getX() < getTargetX()) ? 3 : -3);
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
      int randomX = 1;
      while (randomX % 3 != 0)
      {
        randomX = (getX() < 386) ? (int)random(120, 386) : (int)random(386, 652);
        if (randomX % 3 == 0)
        {
          setTarget(new PVector(randomX, getTargetY() + 16));
          hasNewTarget = true;
        }
      }
    }
  }

  void resetVariables(int x)
  {
    setSelf(new PVector(x, -200));
    setIsDisabled(true);

    headlessSkeletonStep = 0;

    hasLostHead = false;
    kickHeadTrigger = false;

    hasNewTarget = false;
    setTarget(new PVector(0, 0));

    setHeadlessSkeletonHasKicked(false);
  }
}

int esqueletoChuteC, esqueletoChuteL;

int indexRandomEsqueletoChuteXMapaBoss;

void esqueletoChute() {
  //if (indexInimigos == 1) {
  //  if (gameState == GameState.THIRDBOSS.getValue()) { 
  //    if (esqueletosChute.size() == 0 && totalInimigos < maximoInimigosPadre && !padre.padreMorreu) {
  //      indexRandomEsqueletoChuteXMapaBoss = int(random(0, valoresInimigosXTerceiroMapaBoss.length));
  //      esqueletosChute.add(new EsqueletoChute(valoresInimigosXTerceiroMapaBoss[indexRandomEsqueletoChuteXMapaBoss], 0));
  //      totalInimigos = totalInimigos + 1;
  //    }
  //  }

  //  if (!movementTutorialScreenActive) {
  //    /*
  //    if (gameState >= GameState.FIRSTMAP.getValue() && gameState <= GameState.THIRDMAP.getValue() && esqueletosChute.size() < 2 && totalInimigos < 6) {
  //     esqueletoChuteC = int(random(0, 8));
  //     esqueletoChuteL = int(random(0, 12));

  //     if (KICKING_SKELETON_POSITIONS[esqueletoChuteC][esqueletoChuteL] == KICKING_SKELETON) {
  //     esqueletosChute.add(new EsqueletoChute(120 + (esqueletoChuteC * 50), -150 - (esqueletoChuteL * 75)));
  //     totalInimigos = totalInimigos + 1;
  //     }
  //     }
  //     */
  //  }
  //}

  //if (firstMapEnemiesSpawnManager.kickingSkeletons.size() > 0) {
  //  computeEnemy(firstMapEnemiesSpawnManager.kickingSkeletons, firstMapEnemiesSpawnManager);
  //  deleteEnemy(firstMapEnemiesSpawnManager.kickingSkeletons, firstMapEnemiesSpawnManager);
  //}

  //if (cabecasEsqueleto.size() > 0) {
  //  computeEnemy(cabecasEsqueleto, firstMapEnemiesSpawnManager);
  //}
}

// -------------------------------------- SKELETON HEAD ----------------------------------------------

PImage skeletonHead;

final PVector SKELETON_HEAD_VELOCITY = new PVector(0, 12);

final int SKELETON_HEAD = 3;

private class SkeletonHead extends Projectile 
{
  SkeletonHead(int x, int y) {
    this.setSelf(new PVector(x, y));
    this.setTarget(new PVector(playerX, playerY));

    this.setTypeOfObject(OBJECT_WITHOUT_SHADOW);

    this.setStart(new PVector(x, y));
    this.setVelocity(SKELETON_HEAD_VELOCITY);

    this.setSpriteImage(skeletonHead);
    this.setSpriteWidth(36);
    this.setSpriteHeight(89);

    this.setDamage(2);
    this.setType(SKELETON_HEAD);
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

PImage skeletonDog;
PImage skeletonDogShadow;

final PVector SKELETON_DOG_VELOCITY = new PVector(0, 4);

final int SKELETON_DOG = 4;

final int[] SKELETON_DOG_SPAWNPOINTS_BOSS = {70, 382, 695};

private class Cachorro extends Enemy 
{
  void resetVariables(int x)
  {
  }
  private PVector velocity = new PVector(SKELETON_DOG_VELOCITY.x, SKELETON_DOG_VELOCITY.y);

  private int timeToMove = 0;
  private int numberOfStops;

  private boolean hasNewTarget;

  Cachorro(int x, int y) {
    this.setSelf(new PVector(x, y));
    this.setTarget(new PVector(x, height));

    this.setTypeOfObject(OBJECT_WITH_SHADOW);

    this.setShadowImage(skeletonDogShadow);
    this.setShadowOffset(new PVector(0, 45));

    this.setSpriteImage(skeletonDog);
    this.setSpriteInterval(55);
    this.setSpriteWidth(45);
    this.setSpriteHeight(83);

    this.setDamage(2);
    this.setType(SKELETON_DOG);
  }

  void updateMovement() {
    setMotionY((!hasNewTarget) ? (int)velocity.y + (int)(numberOfStops * 1.5) : 0);
  }

  void updateTarget() {
    if (isOnScreen() && getY() > 125) {
      if (!hasNewTarget && millis() > timeToMove + 1250) {
        numberOfStops++;
        timeToMove = millis();
        hasNewTarget = true;
      }

      if (millis() > timeToMove + 750) {
        hasNewTarget = false;
      }
    }
  }
}

ArrayList<Cachorro> cachorros = new ArrayList<Cachorro>();

int cachorroC, cachorroL;

int indexRandomCachorroXMapaBoss;

void cachorro() {
  if (gameState == GameState.SECOND_BOSS.getValue()) {
    if (cachorros.size() == 0 && !fazendeiroTomouDanoPneu && !fazendeiro.fazendeiroMorreu) {
      for (int i = 0; i < 2; i = i + 1) {
        indexRandomCachorroXMapaBoss = (int)random(0, SKELETON_DOG_SPAWNPOINTS_BOSS.length);
        cachorros.add(new Cachorro(SKELETON_DOG_SPAWNPOINTS_BOSS[indexRandomCachorroXMapaBoss], 0));
      }
    }
  }

  if (indexInimigos == 2) {
    if (gameState == GameState.SECOND_BOSS.getValue()) {
      if (cachorros.size() == 0 && !fazendeiroTomouDanoPneu && !fazendeiro.fazendeiroMorreu) {
        for (int i = 0; i < 2; i = i + 1) {
          indexRandomCachorroXMapaBoss = (int)random(0, SKELETON_DOG_SPAWNPOINTS_BOSS.length);
          cachorros.add(new Cachorro(SKELETON_DOG_SPAWNPOINTS_BOSS[indexRandomCachorroXMapaBoss], 0));
        }
      }
    }

    if (gameState == GameState.THIRD_BOSS.getValue()) { 
      if (cachorros.size() == 0 && totalInimigos < maximoInimigosPadre && !padre.padreMorreu) {
        indexRandomCachorroXMapaBoss = int(random(0, valoresInimigosXTerceiroMapaBoss.length));
        cachorros.add(new Cachorro(valoresInimigosXTerceiroMapaBoss[indexRandomCachorroXMapaBoss], 0));
        totalInimigos = totalInimigos + 1;
      }
    }

    if (!movementTutorialScreenActive) {
      if (gameState == GameState.SECOND_MAP.getValue() && cachorros.size() < 2 && totalInimigos < 6) {
        cachorroC = int(random(0, 7));
        cachorroL = int(random(0, 4));

        if (ENEMY_POSITIONS_SECOND_MAP[cachorroC][cachorroL] == SKELETON_DOG) {
          cachorros.add(new Cachorro(100 + (cachorroC * (600 / 7)), -150 - (cachorroL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }

      if (gameState == GameState.THIRD_MAP.getValue() && cachorros.size() < 2 && totalInimigos < 6) {
        cachorroC = int(random(0, 7));
        cachorroL = int(random(0, 4));

        if (ENEMY_POSITIONS_THIRD_MAP[cachorroC][cachorroL] == SKELETON_DOG) {
          cachorros.add(new Cachorro(100 + (cachorroC * (600 / 7)), -150 - (cachorroL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }
    }
  }

  //if (cachorros.size() > 0) {
  //  computeEnemy(cachorros, firstMapEnemiesSpawnManager);
  //  deleteEnemy(cachorros, firstMapEnemiesSpawnManager);
  //}
}

void skeletonDogPositions() {
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

// -------------------------------------- RED SKELETON -----------------------------------------------

PImage redSkeleton;
PImage redSkeletonShadow;

final int RED_SKELETON = 6;

final int LEFT_SIDE_ON_GRID = 0;
final int RIGHT_SIDE_ON_GRID = 1;

private class EsqueletoRaiva extends Enemy {
  void resetVariables(int x)
  {
  }
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
}

ArrayList<EsqueletoRaiva> esqueletosRaiva = new ArrayList<EsqueletoRaiva>();

int esqueletoRaivaC = 1, esqueletoRaivaL = 1;

int indexRandomEsqueletoRaivaXMapaBoss;

void esqueletoRaiva() {
  if (gameState == GameState.THIRD_MAP.getValue() && esqueletosRaiva.size() < 2 && totalInimigos < 6) {
    while (RED_SKELETON_POSITIONS[esqueletoRaivaL][esqueletoRaivaC] != RED_SKELETON) {
      esqueletoRaivaL = (int)random(0, 5);
      esqueletoRaivaC = (int)random(0, 8);
    }
    int gridSide = 2;
    if (esqueletoRaivaC == 0) {
      gridSide = 0;
    } else if (esqueletoRaivaC == 7) {
      gridSide = 1;
    }

    esqueletosRaiva.add(new EsqueletoRaiva(100 + (esqueletoRaivaC * 75), -120 - (esqueletoRaivaL * 120), gridSide));
  }
  /*
  if (indexInimigos == 4) {
   if (gameState == GameState.THIRDBOSS.getValue()) { 
   if (esqueletosRaiva.size() == 0 && totalInimigos < maximoInimigosPadre && !padre.padreMorreu) {
   indexRandomEsqueletoRaivaXMapaBoss = int(random(0, valoresInimigosXTerceiroMapaBoss.length));
   esqueletosRaiva.add(new EsqueletoRaiva(valoresInimigosXTerceiroMapaBoss[indexRandomEsqueletoRaivaXMapaBoss], 0));
   totalInimigos = totalInimigos + 1;
   }
   }
   
   if (!movementTutorialScreenActive) {
   if (gameState == GameState.THIRDMAP.getValue() && esqueletosRaiva.size() < 2 && totalInimigos < 6) {
   esqueletoRaivaC = int(random(0, 7));
   esqueletoRaivaL = int(random(0, 4));
   
   if (ENEMY_POSITIONS_THIRD_MAP[esqueletoRaivaC][esqueletoRaivaL] == RED_SKELETON) {
   esqueletosRaiva.add(new EsqueletoRaiva(100 + (esqueletoRaivaC * (600 / 7)), -150 - (esqueletoRaivaL * 150)));
   totalInimigos = totalInimigos + 1;
   }
   }
   }
   }
   */

  //if (esqueletosRaiva.size() > 0) {
  //  computeEnemy(esqueletosRaiva, firstMapEnemiesSpawnManager);
  //  deleteEnemy(esqueletosRaiva, firstMapEnemiesSpawnManager);
  //}
}

final int[][] RED_SKELETON_POSITIONS = new int [5][8];

void redSkeletonPositions() {
  RED_SKELETON_POSITIONS[0][0] = RED_SKELETON;
  RED_SKELETON_POSITIONS[0][7] = RED_SKELETON;
  RED_SKELETON_POSITIONS[2][0] = RED_SKELETON;
  RED_SKELETON_POSITIONS[2][7] = RED_SKELETON;
  RED_SKELETON_POSITIONS[4][0] = RED_SKELETON;
  RED_SKELETON_POSITIONS[4][7] = RED_SKELETON;
}


// -------------------------------------- CROW SKELETON ----------------------------------------------

PImage skeletonCrow;
PImage skeletonCrowShadow;

final int SKELETON_CROW = 5;

private class Corvo extends Enemy {
  void resetVariables(int x)
  {
  }
  private int newTargetInterval;

  private boolean hasNewTarget;

  Corvo(int x, int y) {
    setValues(x, y);
  }

  Corvo() {
    setValues(360, (int)random(-300, -1000));
  }

  private void setValues(int x, int y) {
    this.setSelf(new PVector(x, y));
    this.setTarget(new PVector(playerX, playerY));

    this.setTypeOfObject(OBJECT_WITH_SHADOW);

    this.setShadowImage(skeletonCrowShadow);
    this.setShadowOffset(new PVector(24, 86));

    this.setSpriteImage(skeletonCrow);
    this.setSpriteInterval(75);
    this.setSpriteWidth(121);
    this.setSpriteHeight(86);

    this.setDamage(3);
    this.setType(SKELETON_CROW);
  }

  void updateMovement() {
    setMotionY(3);
    if (getX() != getTargetX()) {
      setMotionX((getX() < getTargetX()) ? 3 : -3);
      return;
    }

    setMotionX(0);
  }

  void updateTarget() {
    if (isOnScreen()) {
      if (!hasNewTarget) {
        setTargetX(playerX);
        newTargetInterval = millis();
        hasNewTarget = true;
      }

      if (millis() > newTargetInterval + 750) {
        hasNewTarget = false;
      }
    }
  }

  boolean hasCollided() {
    if (getX() + 95 > playerX && getX() + 25 < playerX + 63 && getY() + 86 > playerY && getY() < playerY + 126) {
      return true;
    }

    return false;
  }
}

ArrayList<Corvo> corvos = new ArrayList<Corvo>();

int indexRandomCorvoXMapaBoss;

void corvo() {
  if (indexInimigos == 3) {
    if (gameState == GameState.THIRD_BOSS.getValue()) {
      if (corvos.size() == 0 && totalInimigos < maximoInimigosPadre && !padre.padreMorreu) {
        indexRandomCorvoXMapaBoss = int(random(0, valoresInimigosXTerceiroMapaBoss.length));
        corvos.add(new Corvo(valoresInimigosXTerceiroMapaBoss[indexRandomCorvoXMapaBoss], 0));
      }
    }

    if (!movementTutorialScreenActive) {
      if (gameState == GameState.SECOND_MAP.getValue() && corvos.size() < 1) {
        corvos.add(new Corvo());
      }

      if (gameState == GameState.THIRD_MAP.getValue() && corvos.size() < 1) {
        corvos.add(new Corvo());
      }
    }
  }

  //if (corvos.size() > 0) {
  //  computeEnemy(corvos, firstMapEnemiesSpawnManager);
  //  deleteEnemy(corvos, firstMapEnemiesSpawnManager);
  //}
}

// ----------------------------------------- ENEMIES MANAGER ---------------------------------------------------

private class EnemiesManager
{
  private <T_Enemy extends Enemy> void computeEnemy(ArrayList<T_Enemy> enemies, ArrayList<SkeletonHead> skeletonHeads, EnemiesSpawnManager spawnManager)
  {
    for (int i = 0; i < enemies.size(); ++i)
    {
      T_Enemy enemy = enemies.get(i);

      if (!enemy.getIsDisabled()) 
      {
        if (enemy.getType() == HEADLESS_SKELETON) triggerHeadlessSkeleton(enemy, skeletonHeads);

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

  private void triggerHeadlessSkeleton(Enemy enemy, ArrayList<SkeletonHead> skeletonHeads)
  {
    try
    {
      HeadlessSkeleton tmp = (HeadlessSkeleton)enemy;

      if (tmp.getHeadlessSkeletonHasKicked())
      {
        skeletonHeads.add(new SkeletonHead(tmp.getX(), tmp.getY()));
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
    if (enemy.getType() != SKELETON_HEAD)
    {
      switch(enemy.getType()) {
      case SKELETON:
        spawnManager.setSkeletonTotal(spawnManager.getSkeletonTotal() - 1);
        break;
      case HEADLESS_SKELETON:
        spawnManager.setHeadlessSkeletonTotal(spawnManager.getHeadlessSkeletonTotal() - 1);
        break;
      case SKELETON_DOG:
        spawnManager.setDogSkeletonTotal(spawnManager.getDogSkeletonTotal() - 1);
        break;
      case SKELETON_CROW:
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

final PVector SKELETONS_INDEX_RANGE               = new PVector(0, 2);
final PVector HEADLESS_SKELETONS_INDEX_RANGE      = new PVector(2, 4);
final PVector HEADLESS_SKELETONS_HEAD_INDEX_RANGE = new PVector(4, 6);
final PVector DOG_SKELETONS_INDEX_RANGE           = new PVector(4, 6);
final PVector CROW_SKELETONS_INDEX_RANGE          = new PVector(6, 8);
final PVector RED_SKELETONS_INDEX_RANGE           = new PVector(8, 10);

private class FirstMapEnemiesSpawnManager extends EnemiesSpawnManager
{
  private ArrayList<Enemy> enemies              = new ArrayList<Enemy>();
  private ArrayList<SkeletonHead> skeletonHeads = new ArrayList<SkeletonHead>();

  final int[] ENEMIES_MAXIMUM          = { 1, 1, 2, 3, 4, 0 };
  final int[] SKELETON_MAXIMUM         = { 1, 0, 1, 2, 2, 0 };
  final int[] KICKING_SKELETON_MAXIMUM = { 0, 1, 1, 1, 2, 0 };

  FirstMapEnemiesSpawnManager()
  {
    super();

    enemies.add(new Skeleton(300, -200));
    enemies.add(new Skeleton(500, -200));
    enemies.add(new HeadlessSkeleton(300, -200));
    enemies.add(new HeadlessSkeleton(600, -200));
    enemies.add(new HeadlessSkeleton(600, -200));
    enemies.add(new HeadlessSkeleton(600, -200));
  }

  void handleEnemySpawn(int maximum, int index)
  {
    while (getEnemiesTotal() < maximum)
    {
      if (getSkeletonTotal() < SKELETON_MAXIMUM[index])
      {
        enableEnemy(enemies, SKELETONS_INDEX_RANGE);

        setSkeletonTotal(getSkeletonTotal() + 1);
      }       

      if (getHeadlessSkeletonTotal() < KICKING_SKELETON_MAXIMUM[index])
      {
        enableEnemy(enemies, HEADLESS_SKELETONS_INDEX_RANGE);

        setHeadlessSkeletonTotal(getHeadlessSkeletonTotal() + 1);
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

  SecondMapEnemiesSpawnManager()
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

// void damage(int amount)
// {
//   if (!isPlayerImmune)
//   {
//     playerCurrentHP -= amount;
//     isPlayerImmune = true;
//     timeImmune = millis();
//   }
// }

// <T_Enemy extends Enemy> void computeEnemy(ArrayList<T_Enemy> inimigos, EnemiesSpawnManager spawnManager) {
//   for (int i = inimigos.size() - 1; i >= 0; i = i - 1) {
//     T_Enemy enemy = inimigos.get(i);

//     if (!enemy.getIsDisabled())
//     {

//       if (enemy.getType() == HEADLESS_SKELETON) 
//       {

//         HeadlessSkeleton tmp = (HeadlessSkeleton)enemy;
//         if (tmp.getHeadlessSkeletonHasKicked()) 
//         {
//           cabecasEsqueleto.add(new CabecaEsqueleto(tmp.getX(), tmp.getY()));
//           tmp.setHeadlessSkeletonHasKicked(false);
//         }
//       }

//       enemy.updateTarget();
//       enemy.updateMovement();
//       enemy.update();
//       enemy.display();

//       if (enemy.hasExitScreen()) 
//       {
//         if (enemy.getType() != SKELETON_HEAD) 
//         {
//           switch(enemy.getType()) {
//           case SKELETON:
//             spawnManager.setSkeletonTotal(spawnManager.getSkeletonTotal() - 1);
//             break;
//           case HEADLESS_SKELETON:
//             spawnManager.setHeadlessSkeletonTotal(spawnManager.getHeadlessSkeletonTotal() - 1);
//             break;
//           case SKELETON_DOG:
//             spawnManager.setDogSkeletonTotal(spawnManager.getDogSkeletonTotal() - 1);
//             break;
//           case SKELETON_CROW:
//             spawnManager.setCrowSkeletonTotal(spawnManager.getCrowSkeletonTotal() - 1);
//             break;
//           case RED_SKELETON:
//             spawnManager.setRedSkeletonTotal(spawnManager.getRedSkeletonTotal() - 1);
//             break;
//           }

//           firstMapEnemiesSpawnManager.setEnemiesTotal(firstMapEnemiesSpawnManager.getEnemiesTotal() - 1);
//         }

//         int enemyPosition = -1;
//         do {
//           enemyPosition = (int)random(0, ENEMIES_SPAWN_X_POSITIONS.length);
//         } while (enemyPosition == enemyLastPosition);

//         enemyLastPosition = enemyPosition;
//         enemy.resetVariables(ENEMIES_SPAWN_X_POSITIONS[enemyPosition]);
//       }

//       if (enemy.hasCollided()) 
//       {
//         damage(enemy.getDamage());
//       }
//     }
//   }
// }

// int enemyLastPosition = -1;

// <E extends Enemy> void deleteEnemy(ArrayList<E> inimigos, EnemiesSpawnManager spawnManager) {
//   for (int i = inimigos.size() - 1; i >= 0; i--) {
//     E enemy = inimigos.get(i);
//     for (int j = firstMap.weaponSpawnManager.weapons.size() - 1; j >= 0; j--) {
//       Weapon arma = firstMap.weaponSpawnManager.weapons.get(j);
//       if (arma.hasHit(enemy)) {
//         totalInimigos--;
//         hitInimigos(enemy.getX() - 40, enemy.getY() - 20);
//         if (enemy.getType() != SKELETON_HEAD) {
//           //switch(enemy.getType()) {
//           //case SKELETON:
//           //  spawnManager.setSkeletonTotal(spawnManager.getSkeletonTotal() - 1);
//           //  break;
//           //case HEADLESS_SKELETON:
//           //  spawnManager.setKickingSkeletonTotal(spawnManager.getKickingSkeletonTotal() - 1);
//           //  break;
//           //case SKELETON_DOG:
//           //  spawnManager.setSkeletonDogTotal(spawnManager.getSkeletonDogTotal() - 1);
//           //  break;
//           //case SKELETON_CROW:
//           //  spawnManager.setSkeletonCrowTotal(spawnManager.getSkeletonCrowTotal() - 1);
//           //  break;
//           //case RED_SKELETON:
//           //  spawnManager.setRedSkeletonTotal(spawnManager.getRedSkeletonTotal() - 1);
//           //  break;
//           //}
//           firstMapEnemiesSpawnManager.setEnemiesTotal(firstMapEnemiesSpawnManager.getEnemiesTotal() - 1);
//         }
//         inimigos.remove(enemy);
//       }
//     }
//   }
// }

int tempoGerarInimigo;
int indexInimigos;

int totalInimigos;
int maximoInimigosPadre = 2;

int[] valoresInimigosXTerceiroMapaBoss =
  {25, 350, 679};

void inimigosTodos()
{
  if (!jLeiteMorreu)
  {
    if (!movementTutorialScreenActive)
    {
      if (millis() > tempoGerarInimigo + 250)
      {
        if (gameState == GameState.FIRST_MAP.getValue())
        {
          indexInimigos = int(random(0, 2));
        } 
        if (gameState == GameState.SECOND_MAP.getValue())
        {
          indexInimigos = int(random(0, 4));
        } 
        if (gameState == GameState.THIRD_MAP.getValue())
        {
          indexInimigos = int(random(1, 5));
        } 
        if (gameState == GameState.THIRD_BOSS.getValue())
        {
          indexInimigos = int(random(0, 5));
          if (!ataqueLevantemAcontecendo)
          {
            maximoInimigosPadre = 2;
          } else
          {
            maximoInimigosPadre = 4;
          }
        }
        tempoGerarInimigo = millis();
      }
    }
  } else
  {
    indexInimigos = 6;
  }

  esqueleto();
  esqueletoChute();
  cachorro();
  corvo();
  esqueletoRaiva();
}
