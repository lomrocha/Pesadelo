PImage skeleton;
PImage skeletonShadow;

final int SKELETON = 0;

int[] valoresEsqueletoXPrimeiroMapaBoss = {200, 520};

public class Esqueleto extends Inimigo {
  public Esqueleto(int x, int y) {
    this.setX(x);
    this.setY(y);

    setSpriteImage(skeleton);
    setSpriteInterval(155);
    setSpriteWidth(76);
    setSpriteHeight(126);

    setDamage(2);
    setIsHead(false);
  }

  void display() {
    image (skeletonShadow, getX() + 16, getY() + 114);

    super.display();
  }

  void updateMovement() {
    setMovementY(3);
  }
}

ArrayList<Esqueleto> esqueletos;

int esqueletoC, esqueletoL;

int indexRandomEsqueletoXMapaBoss;

void esqueleto() {
  if (indexInimigos == 0) {
    if (gameState == GameState.FIRSTBOSS.ordinal()) {
      if (esqueletos.size() == 0 && !coveiro.coveiroMorreu && !coveiroTomouDanoAgua) {
        for (int i = 0; i < 2; i = i + 1) {
          indexRandomEsqueletoXMapaBoss = int(random(0, 2));
          esqueletos.add(new Esqueleto(valoresEsqueletoXPrimeiroMapaBoss[indexRandomEsqueletoXMapaBoss], 0));
        }
      }
    }

    if (gameState == GameState.THIRDBOSS.ordinal()) { 
      if (esqueletos.size() == 0 && totalInimigos < maximoInimigosPadre && !padre.padreMorreu) {
        indexRandomEsqueletoXMapaBoss = int(random(0, valoresInimigosXTerceiroMapaBoss.length));
        esqueletos.add(new Esqueleto(valoresInimigosXTerceiroMapaBoss[indexRandomEsqueletoXMapaBoss], 0));
        totalInimigos = totalInimigos + 1;
      }
    }

    if (!telaTutorialAndandoAtiva) {
      if (gameState == GameState.FIRSTMAP.ordinal() && esqueletos.size() < 2 && totalInimigos < 6) {
        esqueletoC = int(random(0, 7));
        esqueletoL = int(random(0, 4));

        if (enemyPositionsFirstMap[esqueletoC][esqueletoL] == SKELETON) {
          esqueletos.add(new Esqueleto(100 + (esqueletoC * (600 / 7)), -150 - (esqueletoL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }

      if (gameState == GameState.SECONDMAP.ordinal() && esqueletos.size() < 2 && totalInimigos < 6) {
        esqueletoC = int(random(0, 7));
        esqueletoL = int(random(0, 4));

        if (enemyPositionsSecondMap[esqueletoC][esqueletoL] == SKELETON) {
          esqueletos.add(new Esqueleto(100 + (esqueletoC * (600 / 7)), -150 - (esqueletoL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }

      if (gameState == GameState.THIRDMAP.ordinal() && esqueletos.size() < 2 && totalInimigos < 6) {
        esqueletoC = int(random(0, 7));
        esqueletoL = int(random(0, 4));

        if (enemyPositionsThirdMap[esqueletoC][esqueletoL] == SKELETON) {
          esqueletos.add(new Esqueleto(100 + (esqueletoC * (600 / 7)), -150 - (esqueletoL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }
    }
  }
  
  if (esqueletos.size() > 0) {
    computeEnemy(esqueletos);
    deleteEnemy(esqueletos);
  }
}

void skeletonPositions() {
  enemyPositionsFirstMap  [0][0] = SKELETON;
  enemyPositionsFirstMap  [1][2] = SKELETON;
  enemyPositionsFirstMap  [2][0] = SKELETON;
  enemyPositionsFirstMap  [3][2] = SKELETON;
  enemyPositionsFirstMap  [4][0] = SKELETON;
  enemyPositionsFirstMap  [5][2] = SKELETON;
  enemyPositionsFirstMap  [6][0] = SKELETON;

  enemyPositionsSecondMap [0][1] = SKELETON;
  enemyPositionsSecondMap [1][3] = SKELETON;
  enemyPositionsSecondMap [2][0] = SKELETON;
  enemyPositionsSecondMap [3][2] = SKELETON;
  enemyPositionsSecondMap [4][0] = SKELETON;
  enemyPositionsSecondMap [5][0] = SKELETON;
  enemyPositionsSecondMap [6][0] = SKELETON;

  enemyPositionsThirdMap  [0][3] = SKELETON;
  enemyPositionsThirdMap  [2][0] = SKELETON;
  enemyPositionsThirdMap  [4][2] = SKELETON;
  enemyPositionsThirdMap  [6][3] = SKELETON;
}