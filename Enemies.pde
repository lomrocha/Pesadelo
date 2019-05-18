int tempoGerarInimigo;
int indexInimigos;

int totalInimigos;
int maximoInimigosPadre = 2;

int[] valoresInimigosXTerceiroMapaBoss = {25, 350, 679};

void inimigosTodos() {
  if (!jLeiteMorreu) {
    if (!movementTutorialScreenActive) {
      if (millis() > tempoGerarInimigo + 250) {
        if (gameState == GameState.FIRST_MAP.getValue()) {
          indexInimigos = int(random(0, 2));
        } 
        if (gameState == GameState.SECOND_MAP.getValue()) {
          indexInimigos = int(random(0, 4));
        } 
        if (gameState == GameState.THIRD_MAP.getValue()) {
          indexInimigos = int(random(1, 5));
        } 
        if (gameState == GameState.THIRD_BOSS.getValue()) {
          indexInimigos = int(random(0, 5));
          if (!ataqueLevantemAcontecendo) {
            maximoInimigosPadre = 2;
          } else {
            maximoInimigosPadre = 4;
          }
        }
        tempoGerarInimigo = millis();
      }
    }
  } else {
    indexInimigos = 6;
  }

  firstMapEnemiesSpawnManager.setVariables();
  firstMapEnemiesSpawnManager.states();
  esqueleto();
  esqueletoChute();
  cachorro();
  corvo();
  esqueletoRaiva();
}

abstract private class Enemy extends Geral {
  private PVector target = new PVector();

  private int damage;
  private int type;

  private boolean kickingSkeletonHasKicked;

  // TARGET
  protected void setTarget(PVector target) {
    this.target = target;
  }

  public int getTargetX() {
    return int(this.target.x);
  }
  protected void setTargetX(int x) {
    this.target.x = x;
  }

  public int getTargetY() {
    return int(this.target.y);
  }

  // DAMAGE
  public int getDamage() {
    return this.damage;
  }
  protected void setDamage(int damage) {
    this.damage = damage;
  }

  // TYPE
  public int getType() {
    return this.type;
  }
  protected void setType(int type) {
    this.type = type;
  }

  // KICKING_SKELETON_HAS_KICKED
  public boolean getKickingSkeletonHasKicked() {
    return this.kickingSkeletonHasKicked;
  }
  public void setKickingSkeletonHasKicked(boolean kickingSkeletonHasKicked) {
    this.kickingSkeletonHasKicked = kickingSkeletonHasKicked;
  }

  abstract void updateMovement();

  abstract void updateTarget();

  boolean isOnScreen() {
    if (getY() > 0) {
      return true;
    }

    return false;
  }
}

void damage(int amount) {
  if (!isPlayerImmune) {
    playerCurrentHP -= amount;
    isPlayerImmune = true;
    timeImmune = millis();
  }
}

<E extends Enemy> void computeEnemy(ArrayList<E> inimigos, EnemiesSpawnManager spawnManager) {
  for (int i = inimigos.size() - 1; i >= 0; i = i - 1) {
    E enemy = inimigos.get(i);
    if (enemy.getType() == KICKING_SKELETON) {
      if (enemy.getKickingSkeletonHasKicked()) {
        cabecasEsqueleto.add(new CabecaEsqueleto(enemy.getX(), enemy.getY()));
        enemy.setKickingSkeletonHasKicked(false);
      }
    }
    enemy.updateTarget();
    enemy.updateMovement();
    enemy.update();
    enemy.display();
    if (enemy.hasExitScreen()) {
      if (enemy.getType() != SKELETON_HEAD) {
        switch(enemy.getType()) {
        case SKELETON:
          spawnManager.setSkeletonTotal(spawnManager.getSkeletonTotal() - 1);
          break;
        case KICKING_SKELETON:
          spawnManager.setKickingSkeletonTotal(spawnManager.getKickingSkeletonTotal() - 1);
          break;
        case SKELETON_DOG:
          spawnManager.setSkeletonDogTotal(spawnManager.getSkeletonDogTotal() - 1);
          break;
        case SKELETON_CROW:
          spawnManager.setSkeletonCrowTotal(spawnManager.getSkeletonCrowTotal() - 1);
          break;
        case RED_SKELETON:
          spawnManager.setRedSkeletonTotal(spawnManager.getRedSkeletonTotal() - 1);
          break;
        }
        firstMapEnemiesSpawnManager.setEnemiesTotal(firstMapEnemiesSpawnManager.getEnemiesTotal() - 1);
      }
      inimigos.remove(enemy);
    }
    if (enemy.hasCollided()) {
      damage(enemy.getDamage());
    }
  }
}

<E extends Enemy> void deleteEnemy(ArrayList<E> inimigos) {
  for (int i = inimigos.size() - 1; i >= 0; i--) {
    E enemy = inimigos.get(i);
    for (int j = weapons.size() - 1; j >= 0; j--) {
      Weapon arma = weapons.get(j);
      if (arma.hasHit(enemy)) {
        totalInimigos--;
        hitInimigos(enemy.getX() - 40, enemy.getY() - 20);
        inimigos.remove(enemy);
      }
    }
  }
}
