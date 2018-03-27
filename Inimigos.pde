int tempoGerarInimigo;
int indexInimigos;

int totalInimigos;
int maximoInimigosPadre = 2;

int[] valoresInimigosXTerceiroMapaBoss = {25, 350, 679};

void inimigosTodos() {
  if (!jLeiteMorreu) {
    if (!telaTutorialAndandoAtiva) {
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


  esqueleto();
  esqueletoChute();
  cachorro();
  corvo();
  esqueletoRaiva();
}

public abstract class Inimigo extends Geral {
  private int damage;

  private boolean isHead;

  public int getDamage() {
    return damage;
  }
  protected void setDamage(int damage) {
    this.damage = damage;
  }

  public boolean getIsHead() {
    return isHead;
  } 
  protected void setIsHead(boolean isHead) {
    this.isHead = isHead;
  }

  abstract void updateMovement();
}

void damage(int amount) {
  if (!jLeiteImune) {
    playerHitpointsCurrent -= amount;
    jLeiteImune = true;
    tempoImune = millis();
  }
}

<Enemy extends Inimigo> void computeEnemy(ArrayList<Enemy> inimigos) {
  for (int i = inimigos.size() - 1; i >= 0; i = i - 1) {
    Enemy enemy = inimigos.get(i);
    enemy.updateMovement();
    enemy.update();
    enemy.display();
    if (enemy.hasExitScreen()) {
      inimigos.remove(enemy);
      if (!enemy.getIsHead()) {
        totalInimigos--;
      }
    }
    if (enemy.hasCollided()) {
      damage(enemy.getDamage());
    }
  }
}

<Enemy extends Geral> void deleteEnemy(ArrayList<Enemy> inimigos) {
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