PImage kickingSkeleton;
PImage headlessKickingSkeleton;
PImage kickingSkeletonShadow;

final int KICKING_SKELETON = 2;

private class EsqueletoChute extends Enemy {
  private PImage kickingSkeletonSprite;

  private int kickingSkeletonStep;
  private int kickingSkeletonSpriteTime;

  private boolean hasLostHead;
  private boolean kickHeadTrigger;

  private boolean hasNewTarget;

  public EsqueletoChute(int x, int y) {
    this.setSelf(new PVector(x, y));
    
    this.setTypeOfObject(OBJECT_WITHOUT_SHADOW);

    this.setTarget(new PVector(0, 0));

    this.setSpriteImage(headlessKickingSkeleton);
    this.setSpriteInterval(200);
    this.setSpriteWidth(48);
    this.setSpriteHeight(74);

    this.setDamage(2);
    this.setType(KICKING_SKELETON);
    this.setBools(new boolean[] {false});
  }

  void display() {
    image (kickingSkeletonShadow, getX() + 1, getY() + 50);

    if (!hasLostHead) {
      if (millis() > kickingSkeletonSpriteTime + 200) { 
        if (!isOnScreen()) {
          kickingSkeletonSprite = kickingSkeleton.get(0, 0, 49, 74);
        } else {
          kickingSkeletonSprite = kickingSkeleton.get(kickingSkeletonStep, 0, 49, 74); 
          kickingSkeletonStep = kickingSkeletonStep % 245 + 49;
        }
        kickingSkeletonSpriteTime = millis();
      }

      image(kickingSkeletonSprite, getX(), getY());

      if (kickingSkeletonStep == 196 && !kickHeadTrigger) {
        setBools(new boolean[] {true});
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

  void updateBools() {
    this.setBools(new boolean[] {false});
  }

  void updateMovement() {
    if (!hasLostHead) {
      setMotionY((!isOnScreen()) ? 4 : SCENERY_VELOCITY / 2);
      setMotionX(0);
    } else {
      setMotionY(SCENERY_VELOCITY);
      setMotionX((getX() < getTargetX()) ? 3 : -3);
    }
  }

  void updateTarget() {
    if (getX() == getTargetX()) {
      hasNewTarget = false;
    }

    if (!hasNewTarget) {
      int randomX = 1;
      while (randomX % 3 != 0) {
        randomX = (getX() < 386) ? int(random(120, 386)) : int(random(386, 652));
        if (randomX % 3 == 0) {
          setTarget(new PVector(randomX, getTargetY() + 16));
          hasNewTarget = true;
        }
      }
    }
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

  if (firstMapEnemiesSpawnManager.kickingSkeletons.size() > 0) {
    computeEnemy(firstMapEnemiesSpawnManager.kickingSkeletons, firstMapEnemiesSpawnManager);
    deleteEnemy(firstMapEnemiesSpawnManager.kickingSkeletons);
  }

  if (cabecasEsqueleto.size() > 0) {
    computeEnemy(cabecasEsqueleto, firstMapEnemiesSpawnManager);
  }
}

final int[][] KICKING_SKELETON_POSITIONS = new int [8][12];

void kickingSkeletonPositions() {
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
