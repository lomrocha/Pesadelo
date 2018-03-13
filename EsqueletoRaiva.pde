PImage redSkeleton;
PImage redSkeletonShadow;

final int REDSKELETON = 3;

public class EsqueletoRaiva extends Inimigo {
  private int movementX = 3;

  public EsqueletoRaiva(int x, int y) {
    this.setX(x);
    this.setY(y);

    setSpriteImage(redSkeleton);
    setSpriteInterval(75);
    setSpriteWidth(76);
    setSpriteHeight(126);

    setDamage(3);
    setIsHead(false);
  }

  void display() {
    image(redSkeletonShadow, getX() + 16, getY() + 114);

    super.display();
  }

  void update() {
    super.update();

    setX(getX() + movementX);
  }

  void updateMovement() {
    if (getX() < 100) {
      movementX = 4;
    }
    if (getX() + 30 > 700) {
      movementX = -4;
    }

    setMovementY(4);
  }
}

ArrayList<EsqueletoRaiva> esqueletosRaiva;

int esqueletoRaivaC, esqueletoRaivaL;

int indexRandomEsqueletoRaivaXMapaBoss;

void esqueletoRaiva() {
  if (indexInimigos == 4) {
    if (estadoJogo == "MapaPadre") { 
      if (esqueletosRaiva.size() == 0 && totalInimigos < maximoInimigosPadre && !padre.padreMorreu) {
        indexRandomEsqueletoRaivaXMapaBoss = int(random(0, valoresInimigosXMapaPadre.length));
        esqueletosRaiva.add(new EsqueletoRaiva(valoresInimigosXMapaPadre[indexRandomEsqueletoRaivaXMapaBoss], 0));
        totalInimigos = totalInimigos + 1;
      }
    }

    if (!telaTutorialAndandoAtiva) {
      if (estadoJogo == "TerceiroMapa" && esqueletosRaiva.size() < 2 && totalInimigos < 6) {
        esqueletoRaivaC = int(random(0, 7));
        esqueletoRaivaL = int(random(0, 4));

        if (enemyPositionsThirdMap[esqueletoRaivaC][esqueletoRaivaL] == REDSKELETON) {
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
  enemyPositionsThirdMap[0][0] = REDSKELETON;
  enemyPositionsThirdMap[1][2] = REDSKELETON;
  enemyPositionsThirdMap[2][3] = REDSKELETON;
  enemyPositionsThirdMap[3][2] = REDSKELETON;
  enemyPositionsThirdMap[4][1] = REDSKELETON;
  enemyPositionsThirdMap[5][0] = REDSKELETON;
  enemyPositionsThirdMap[6][2] = REDSKELETON;
}