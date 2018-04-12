int tempoGerarInimigo;
int indexInimigos;

int totalInimigos;
int maximoInimigosPadre = 2;

int[] valoresInimigosXTerceiroMapaBoss = {25, 350, 679};

void inimigosTodos() {
  if (!jLeiteMorreu) {
    if (!movementTutorialScreenActive) {
      if (millis() > tempoGerarInimigo + 250) {
        if (gameState == GameState.FIRSTMAP.ordinal()) {
          indexInimigos = int(random(0, 2));
        } 
        if (gameState == GameState.SECONDMAP.ordinal()) {
          indexInimigos = int(random(0, 4));
        } 
        if (gameState == GameState.THIRDMAP.ordinal()) {
          indexInimigos = int(random(1, 5));
        } 
        if (gameState == GameState.THIRDBOSS.ordinal()) {
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

enum TypeOfEnemy {
  SKELETON, KICKING_SKELETON, SKELETON_HEAD, SKELETON_DOG, SKELETON_CROW, RED_SKELETON
}

public abstract class Inimigo extends Geral {
  private int damage;
  private int type;

  public int getDamage() {
    return damage;
  }
  protected void setDamage(int damage) {
    this.damage = damage;
  }

  public int getType() {
    return type;
  }
  protected void setType(int type) {
    this.type = type;
  }

  abstract void updateMovement();

  abstract void updateTarget();
}

void damage(int amount) {
  if (!isPlayerImmune) {
    playerCurrentHP -= amount;
    isPlayerImmune = true;
    timeImmune = millis();
  }
}

<Enemy extends Inimigo, KickingSkeleton extends EsqueletoChute> void computeEnemy(ArrayList<Enemy> inimigos) {
  for (int i = inimigos.size() - 1; i >= 0; i = i - 1) {
    Enemy enemy = inimigos.get(i);
    enemy.updateTarget();
    enemy.updateMovement();
    enemy.update();
    enemy.display();
    if (enemy.hasExitScreen()) {
      inimigos.remove(enemy);
      if (enemy.getType() != TypeOfEnemy.SKELETON_HEAD.ordinal()) {
        if (enemy.getType() == TypeOfEnemy.SKELETON.ordinal()) {
          firstMapEnemiesSpawnManager.skeletonTotal--;
        }
        if (enemy.getType() == TypeOfEnemy.KICKING_SKELETON.ordinal()) {
          firstMapEnemiesSpawnManager.kickingSkeletonTotal--;
        }
        firstMapEnemiesSpawnManager.setEnemiesTotal(firstMapEnemiesSpawnManager.getEnemiesTotal() - 1);
      }
    }
    if (enemy.hasCollided()) {
      damage(enemy.getDamage());
    }
  }
}

<Enemy extends Inimigo> void deleteEnemy(ArrayList<Enemy> inimigos) {
  for (int i = inimigos.size() - 1; i >= 0; i--) {
    Enemy enemy = inimigos.get(i);
    for (int j = armas.size() - 1; j >= 0; j--) {
      Arma arma = armas.get(j);
      if (arma.hasHit(enemy)) {
        totalInimigos--;
        hitInimigos(enemy.getX() - 40, enemy.getY() - 20);
        inimigos.remove(enemy);
      }
    }
  }
}