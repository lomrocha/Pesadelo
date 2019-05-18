PImage skeletonDog;
PImage skeletonDogShadow;

final PVector SKELETON_DOG_VELOCITY = new PVector(0, 4);

final int SKELETON_DOG = 4;

final int[] SKELETON_DOG_SPAWNPOINTS_BOSS = {70, 382, 695};

private class Cachorro extends Enemy {
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
    setMotionY((!hasNewTarget) ? int(velocity.y) + (int)(numberOfStops * 1.5) : 0);
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
        indexRandomCachorroXMapaBoss = int(random(0, SKELETON_DOG_SPAWNPOINTS_BOSS.length));
        cachorros.add(new Cachorro(SKELETON_DOG_SPAWNPOINTS_BOSS[indexRandomCachorroXMapaBoss], 0));
      }
    }
  }

  if (indexInimigos == 2) {
    if (gameState == GameState.SECOND_BOSS.getValue()) {
      if (cachorros.size() == 0 && !fazendeiroTomouDanoPneu && !fazendeiro.fazendeiroMorreu) {
        for (int i = 0; i < 2; i = i + 1) {
          indexRandomCachorroXMapaBoss = int(random(0, SKELETON_DOG_SPAWNPOINTS_BOSS.length));
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

  if (cachorros.size() > 0) {
    computeEnemy(cachorros, firstMapEnemiesSpawnManager);
    deleteEnemy(cachorros);
  }
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
