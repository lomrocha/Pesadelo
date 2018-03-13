PImage kickingSkeleton;
PImage headlessKickingSkeleton;
PImage kickingSkeletonShadow;

final int KICKINGSKELETON = 1;

public class EsqueletoChute extends Geral {
  private PImage kickingSkeletonSprite;

  private int movementX;

  private int changeDirectionDelay;

  private int kickingSkeletonStep;
  private int kickingSkeletonSpriteTime;

  private boolean hasLostHead;
  private boolean kickHeadTrigger, hasKickedHead;

  public EsqueletoChute(int x, int y) {
    this.setX(x);
    this.setY(y);

    setSpriteImage(headlessKickingSkeleton);
    setSpriteInterval(200);
    setSpriteWidth(48);
    setSpriteHeight(74);
  }

  void display() {
    image (kickingSkeletonShadow, getX() + 1, getY() + 50);

    if (!hasLostHead) {
      if (millis() > kickingSkeletonSpriteTime + 200) { 
        if (getY() < 0) {
          kickingSkeletonSprite = kickingSkeleton.get(0, 0, 49, 74);
        } else {
          kickingSkeletonSprite = kickingSkeleton.get(kickingSkeletonStep, 0, 49, 74); 
          kickingSkeletonStep = kickingSkeletonStep % 245 + 49;
        }
        image(kickingSkeletonSprite, getX(), getY()); 
        kickingSkeletonSpriteTime = millis();
      } else {
        image(kickingSkeletonSprite, getX(), getY());
      }

      if (kickingSkeletonStep == 196 && !kickHeadTrigger) {
        hasKickedHead = true;
        kickHeadTrigger = true;
      }

      if (kickingSkeletonStep == kickingSkeleton.width) {
        hasLostHead = true;
        kickingSkeletonStep = 0;
      }
    } else {
      super.display();
    }
  }

  void update() {
    super.update();

    setX(getX() + movementX);
  }

  void updateMovement() {
    if (!hasLostHead) {
      setMovementY(int(sceneryMovement));
      movementX = 0;
    } else {
      setMovementY(int(sceneryMovement) + 1);
      if (millis() > changeDirectionDelay + 250) {
        movementX = int(random(-5, 5));
        changeDirectionDelay = millis();
      }
    }
  }
}

ArrayList<EsqueletoChute> esqueletosChute;

int esqueletoChuteC, esqueletoChuteL;

int indexRandomEsqueletoChuteXMapaBoss;

void esqueletoChute() {
  if (indexInimigos == 1) {
    if (estadoJogo == "MapaPadre") { 
      if (esqueletosChute.size() == 0 && totalInimigos < maximoInimigosPadre && !padre.padreMorreu) {
        indexRandomEsqueletoChuteXMapaBoss = int(random(0, valoresInimigosXMapaPadre.length));
        esqueletosChute.add(new EsqueletoChute(valoresInimigosXMapaPadre[indexRandomEsqueletoChuteXMapaBoss], 0));
        totalInimigos = totalInimigos + 1;
      }
    }

    if (!telaTutorialAndandoAtiva) {
      if (estadoJogo == "PrimeiroMapa" && esqueletosChute.size() < 2 && totalInimigos < 6) {
        esqueletoChuteC = int(random(0, 7));
        esqueletoChuteL = int(random(0, 4));

        if (enemyPositionsFirstMap[esqueletoChuteC][esqueletoChuteL] == KICKINGSKELETON) {
          esqueletosChute.add(new EsqueletoChute(100 + (esqueletoChuteC * (600 / 7)), -150 - (esqueletoChuteL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }
      if (estadoJogo == "SegundoMapa" && esqueletosChute.size() < 2 && totalInimigos < 6) {
        esqueletoChuteC = int(random(0, 7));
        esqueletoChuteL = int(random(0, 4));

        if (enemyPositionsSecondMap[esqueletoChuteC][esqueletoChuteL] == KICKINGSKELETON) {
          esqueletosChute.add(new EsqueletoChute(100 + (esqueletoChuteC * (600 / 7)), -150 - (esqueletoChuteL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }
      if (estadoJogo == "TerceiroMapa" && esqueletosChute.size() < 2 && totalInimigos < 6) {
        esqueletoChuteC = int(random(0, 7));
        esqueletoChuteL = int(random(0, 4));

        if (enemyPositionsThirdMap[esqueletoChuteC][esqueletoChuteL] == KICKINGSKELETON) {
          esqueletosChute.add(new EsqueletoChute(100 + (esqueletoChuteC * (600 / 7)), -150 - (esqueletoChuteL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }
    }
  }
  
  if (esqueletosChute.size() > 0) {
    for (int i = esqueletosChute.size() - 1; i >= 0; i = i - 1) {
      EsqueletoChute e = esqueletosChute.get(i);
      e.updateMovement();
      e.update();
      e.display();
      if (e.hasKickedHead) {
        cabecasEsqueleto.add(new CabecaEsqueleto(e.getX(), e.getY()));
        e.hasKickedHead = false;
      }
      if (e.hasExitScreen()) {
        totalInimigos--;
        esqueletosChute.remove(e);
      }
      if (e.hasCollided()) {
        damage(2);
      }
    }
    
    deleteEnemy(esqueletosChute);
  }

  if (cabecasEsqueleto.size() > 0) {
    computeEnemy(cabecasEsqueleto);
  }
}

void kickingSkeletonPositions() {
  enemyPositionsFirstMap  [0][2] = KICKINGSKELETON;
  enemyPositionsFirstMap  [1][0] = KICKINGSKELETON;
  enemyPositionsFirstMap  [2][2] = KICKINGSKELETON;
  enemyPositionsFirstMap  [3][0] = KICKINGSKELETON;
  enemyPositionsFirstMap  [4][2] = KICKINGSKELETON;
  enemyPositionsFirstMap  [5][0] = KICKINGSKELETON;
  enemyPositionsFirstMap  [6][2] = KICKINGSKELETON;

  enemyPositionsSecondMap [0][2] = KICKINGSKELETON;
  enemyPositionsSecondMap [1][0] = KICKINGSKELETON;
  enemyPositionsSecondMap [2][3] = KICKINGSKELETON;
  enemyPositionsSecondMap [3][3] = KICKINGSKELETON;
  enemyPositionsSecondMap [4][2] = KICKINGSKELETON;
  enemyPositionsSecondMap [5][3] = KICKINGSKELETON;
  enemyPositionsSecondMap [6][3] = KICKINGSKELETON;

  enemyPositionsThirdMap  [0][2] = KICKINGSKELETON;
  enemyPositionsThirdMap  [1][3] = KICKINGSKELETON;
  enemyPositionsThirdMap  [2][1] = KICKINGSKELETON;
  enemyPositionsThirdMap  [4][3] = KICKINGSKELETON;
  enemyPositionsThirdMap  [5][1] = KICKINGSKELETON;
}