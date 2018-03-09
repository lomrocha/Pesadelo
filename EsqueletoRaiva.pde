PImage redSkeleton;
PImage redSkeletonShadow;

final int REDSKELETON = 3;

public class EsqueletoRaiva extends Geral {
  private int movementX = 3;

  public EsqueletoRaiva(int x, int y) {
    this.setX(x);
    this.setY(y);

    setSpriteImage(redSkeleton);
    setSpriteInterval(75);
    setSpriteWidth(76);
    setSpriteHeight(126);
    setMovementY(3);
  }

  void display() {
    image(redSkeletonShadow, getX() + 16, getY() + 114);

    super.display();
  }

  void update() {
    setX(getX() + movementX);

    if (getX() < 100) {
      movementX = 3;
    }
    if (getX() + 30 > 700) {
      movementX = -3;
    } 

    super.update();
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


  for (int i = esqueletosRaiva.size() - 1; i >= 0; i = i - 1) {
    EsqueletoRaiva e = esqueletosRaiva.get(i);
    e.display();
    e.update();
    if (e.hasExitScreen()) {
      totalInimigos = totalInimigos - 1;
      esqueletosRaiva.remove(e);
    }
    if (e.hasCollided()) {
      damage(3);
    }
  }
  for (int i = esqueletosRaiva.size() - 1; i >= 0; i = i - 1) {
    EsqueletoRaiva e = esqueletosRaiva.get(i);
    for (int j = armas.size() - 1; j >= 0; j = j - 1) {
      Arma a = armas.get(j);
      if (a.hasHit(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.getX(), e.getY());
        esqueletosRaiva.remove(e);
        if (a.getIsStone()) {
          armas.remove(a);
        }
      }
    }
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