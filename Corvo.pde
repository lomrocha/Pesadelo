PImage skeletonCrow;
PImage skeletonCrowShadow;

final int SKELETON_CROW = 5;

private class Corvo extends Enemy {
  private int newTargetInterval;

  private boolean hasNewTarget;

  Corvo(int x, int y) {
    setValues(x, y);
  }

  Corvo() {
    setValues(360, int(random(-300, -1000)));
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

  if (corvos.size() > 0) {
    computeEnemy(corvos, firstMapEnemiesSpawnManager);
    deleteEnemy(corvos);
  }
}
