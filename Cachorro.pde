PImage skeletonDog;
PImage skeletonDogShadow;

final int SKELETON_DOG = 3;

final int[] skeletonDogSpawnPointsSecondBoss = {70, 382, 695};

public class Cachorro extends Inimigo {
  public Cachorro(int x, int y) {
    this.setX(x);
    this.setY(y);

    setSpriteImage(skeletonDog);
    setSpriteInterval(55);
    setSpriteWidth(45);
    setSpriteHeight(83);

    setDamage(2);
    setType(TypeOfEnemy.SKELETON_DOG.ordinal());
  }

  void display() {
    image (skeletonDogShadow, getX(), getY() + 45);

    super.display();
  }

  void updateMovement() {
    setMovementY(8);
  }
  
  void updateTarget(){}
}

ArrayList<Cachorro> cachorros = new ArrayList<Cachorro>();;

int cachorroC, cachorroL;

int indexRandomCachorroXMapaBoss;

void cachorro() {
  if (indexInimigos == 2) {
    if (gameState == GameState.SECONDBOSS.ordinal()) {
      if (cachorros.size() == 0 && !fazendeiroTomouDanoPneu && !fazendeiro.fazendeiroMorreu) {
        for (int i = 0; i < 2; i = i + 1) {
          indexRandomCachorroXMapaBoss = int(random(0, skeletonDogSpawnPointsSecondBoss.length));
          cachorros.add(new Cachorro(skeletonDogSpawnPointsSecondBoss[indexRandomCachorroXMapaBoss], 0));
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

    if (!movementTutorialScreenActive) {
      if (gameState == GameState.SECONDMAP.ordinal() && cachorros.size() < 2 && totalInimigos < 6) {
        cachorroC = int(random(0, 7));
        cachorroL = int(random(0, 4));

        if (ENEMY_POSITIONS_SECOND_MAP[cachorroC][cachorroL] == SKELETON_DOG) {
          cachorros.add(new Cachorro(100 + (cachorroC * (600 / 7)), -150 - (cachorroL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }

      if (gameState == GameState.THIRDMAP.ordinal() && cachorros.size() < 2 && totalInimigos < 6) {
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
    computeEnemy(cachorros);
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