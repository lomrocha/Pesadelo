PImage redSkeleton;
PImage redSkeletonShadow;

final int REDSKELETON = 4;

public class EsqueletoRaiva extends Inimigo {
  public EsqueletoRaiva(int x, int y) {
    this.setX(x);
    this.setY(y);

    this.setSpriteImage(redSkeleton);
    this.setSpriteInterval(75);
    this.setSpriteWidth(76);
    this.setSpriteHeight(126);

    this.setDamage(3);
    this.setType(TypeOfEnemy.RED_SKELETON.ordinal());
  }

  void display() {
    image(redSkeletonShadow, getX() + 16, getY() + 114);

    super.display();
  }

  void updateMovement() {
    if (getX() < 100) {
      setMotionX(2);
    }
    if (getX() + 30 > 700) {
      setMotionX(-2);
    }

    setMotionY(3);
  }
  
  void updateTarget(){}
}

ArrayList<EsqueletoRaiva> esqueletosRaiva = new ArrayList<EsqueletoRaiva>();

int esqueletoRaivaC, esqueletoRaivaL;

int indexRandomEsqueletoRaivaXMapaBoss;

void esqueletoRaiva() {
  if (indexInimigos == 4) {
    if (gameState == GameState.THIRDBOSS.ordinal()) { 
      if (esqueletosRaiva.size() == 0 && totalInimigos < maximoInimigosPadre && !padre.padreMorreu) {
        indexRandomEsqueletoRaivaXMapaBoss = int(random(0, valoresInimigosXTerceiroMapaBoss.length));
        esqueletosRaiva.add(new EsqueletoRaiva(valoresInimigosXTerceiroMapaBoss[indexRandomEsqueletoRaivaXMapaBoss], 0));
        totalInimigos = totalInimigos + 1;
      }
    }

    if (!movementTutorialScreenActive) {
      if (gameState == GameState.THIRDMAP.ordinal() && esqueletosRaiva.size() < 2 && totalInimigos < 6) {
        esqueletoRaivaC = int(random(0, 7));
        esqueletoRaivaL = int(random(0, 4));

        if (ENEMY_POSITIONS_THIRD_MAP[esqueletoRaivaC][esqueletoRaivaL] == REDSKELETON) {
          esqueletosRaiva.add(new EsqueletoRaiva(100 + (esqueletoRaivaC * (600 / 7)), -150 - (esqueletoRaivaL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }
    }
  }
  
  if (esqueletosRaiva.size() > 0) {
    computeEnemy(esqueletosRaiva);
    deleteEnemy(esqueletosRaiva);
  }
}

void redSkeletonPositions() {
  ENEMY_POSITIONS_THIRD_MAP[0][0] = REDSKELETON;
  ENEMY_POSITIONS_THIRD_MAP[1][2] = REDSKELETON;
  ENEMY_POSITIONS_THIRD_MAP[2][3] = REDSKELETON;
  ENEMY_POSITIONS_THIRD_MAP[3][2] = REDSKELETON;
  ENEMY_POSITIONS_THIRD_MAP[4][1] = REDSKELETON;
  ENEMY_POSITIONS_THIRD_MAP[5][0] = REDSKELETON;
  ENEMY_POSITIONS_THIRD_MAP[6][2] = REDSKELETON;
}