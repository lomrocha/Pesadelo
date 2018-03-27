PImage skeletonDog;
PImage skeletonDogShadow;

final int SKELETONDOG = 2;

int[] valoresCachorroXSegundoMapaBoss = {70, 382, 695};

public class Cachorro extends Inimigo {
  public Cachorro(int x, int y) {
    this.setX(x);
    this.setY(y);

    setSpriteImage(skeletonDog);
    setSpriteInterval(55);
    setSpriteWidth(45);
    setSpriteHeight(83);

    setDamage(2);
    setIsHead(false);
  }

  void display() {
    image (skeletonDogShadow, getX(), getY() + 45);

    super.display();
  }

  void updateMovement() {
    setMovementY(8);
  }
}

ArrayList<Cachorro> cachorros;

int cachorroC, cachorroL;

int indexRandomCachorroXMapaBoss;

void cachorro() {
  if (indexInimigos == 2) {
    if (gameState == GameState.SECONDBOSS.ordinal()) {
      if (cachorros.size() == 0 && !fazendeiroTomouDanoPneu && !fazendeiro.fazendeiroMorreu) {
        for (int i = 0; i < 2; i = i + 1) {
          indexRandomCachorroXMapaBoss = int(random(0, valoresCachorroXSegundoMapaBoss.length));
          cachorros.add(new Cachorro(valoresCachorroXSegundoMapaBoss[indexRandomCachorroXMapaBoss], 0));
        }
      }
    }

    if (gameState == GameState.THIRDBOSS.ordinal()) { 
      if (cachorros.size() == 0 && totalInimigos < maximoInimigosPadre && !padre.padreMorreu) {
        indexRandomCachorroXMapaBoss = int(random(0, valoresInimigosXTerceiroMapaBoss.length));
        cachorros.add(new Cachorro(valoresInimigosXTerceiroMapaBoss[indexRandomCachorroXMapaBoss], 0));
        totalInimigos = totalInimigos + 1;
      }
    }

    if (!telaTutorialAndandoAtiva) {
      if (gameState == GameState.SECONDMAP.ordinal() && cachorros.size() < 2 && totalInimigos < 6) {
        cachorroC = int(random(0, 7));
        cachorroL = int(random(0, 4));

        if (enemyPositionsSecondMap[cachorroC][cachorroL] == SKELETONDOG) {
          cachorros.add(new Cachorro(100 + (cachorroC * (600 / 7)), -150 - (cachorroL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }

      if (gameState == GameState.THIRDMAP.ordinal() && cachorros.size() < 2 && totalInimigos < 6) {
        cachorroC = int(random(0, 7));
        cachorroL = int(random(0, 4));

        if (enemyPositionsThirdMap[cachorroC][cachorroL] == SKELETONDOG) {
          cachorros.add(new Cachorro(100 + (cachorroC * (600 / 7)), -150 - (cachorroL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }
    }
  }

  if (cachorros.size() > 0) {
    computeEnemy(cachorros);
    deleteEnemy(cachorros);
  }
}

void skeletonDogPositions() {
  enemyPositionsSecondMap [0][0] = SKELETONDOG;
  enemyPositionsSecondMap [1][1] = SKELETONDOG;
  enemyPositionsSecondMap [2][2] = SKELETONDOG;
  enemyPositionsSecondMap [3][0] = SKELETONDOG;
  enemyPositionsSecondMap [4][3] = SKELETONDOG;
  enemyPositionsSecondMap [5][2] = SKELETONDOG;
  enemyPositionsSecondMap [6][2] = SKELETONDOG;

  enemyPositionsThirdMap  [1][0] = SKELETONDOG;
  enemyPositionsThirdMap  [3][0] = SKELETONDOG;
  enemyPositionsThirdMap  [5][2] = SKELETONDOG;
  enemyPositionsThirdMap  [6][1] = SKELETONDOG;
}