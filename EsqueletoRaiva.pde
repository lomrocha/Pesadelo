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
    this.setBools(new boolean[] {hasNewTarget});

    this.positionOnGrid = positionOnGrid;
  }

  void updateBools() {
    this.setBools(new boolean[] {hasNewTarget});
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

  if (esqueletosRaiva.size() > 0) {
    computeEnemy(esqueletosRaiva, firstMapEnemiesSpawnManager);
    deleteEnemy(esqueletosRaiva);
  }
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
