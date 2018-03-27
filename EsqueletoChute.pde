PImage kickingSkeleton;
PImage headlessKickingSkeleton;
PImage kickingSkeletonShadow;

final int KICKINGSKELETON = 1;

public class EsqueletoChute extends Geral {
  private PImage kickingSkeletonSprite;

  private int movementX;

  private PVector target = new PVector(jLeiteX, jLeiteY);

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
      setMovementY(1);
      if (getX() != target.x) { 
        movementX = (getX() < target.x) ? 3 : -3;
      } else {
        movementX = 0;
      }
    } else {
      setMovementY(sceneryMovement + 1);
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
    if (estadoJogo == "TerceiroMapaBoss") { 
      if (esqueletosChute.size() == 0 && totalInimigos < maximoInimigosPadre && !padre.padreMorreu) {
        indexRandomEsqueletoChuteXMapaBoss = int(random(0, valoresInimigosXTerceiroMapaBoss.length));
        esqueletosChute.add(new EsqueletoChute(valoresInimigosXTerceiroMapaBoss[indexRandomEsqueletoChuteXMapaBoss], 0));
        totalInimigos = totalInimigos + 1;
      }
    }

    if (!telaTutorialAndandoAtiva) {
      if ((estadoJogo == "PrimeiroMapaNormal" || estadoJogo == "SegundoMapaNormal" || estadoJogo == "TerceiroMapaNormal") && esqueletosChute.size() < 2 && totalInimigos < 6) {
        esqueletoChuteC = int(random(0, 8));
        esqueletoChuteL = int(random(0, 12));

        if (kickingSkeletonPositions[esqueletoChuteC][esqueletoChuteL] == KICKINGSKELETON) {
          esqueletosChute.add(new EsqueletoChute(120 + (esqueletoChuteC * 50), -150 - (esqueletoChuteL * 75)));
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

int kickingSkeletonPositions[][];

void kickingSkeletonPositions() {
  kickingSkeletonPositions [0][0] = KICKINGSKELETON;
  kickingSkeletonPositions [0][3] = KICKINGSKELETON;
  kickingSkeletonPositions [0][6] = KICKINGSKELETON;
  kickingSkeletonPositions [0][9] = KICKINGSKELETON;
  kickingSkeletonPositions [3][0] = KICKINGSKELETON;
  kickingSkeletonPositions [3][3] = KICKINGSKELETON;
  kickingSkeletonPositions [3][6] = KICKINGSKELETON;
  kickingSkeletonPositions [3][9] = KICKINGSKELETON;
  kickingSkeletonPositions [6][0] = KICKINGSKELETON;
  kickingSkeletonPositions [6][3] = KICKINGSKELETON;
  kickingSkeletonPositions [6][6] = KICKINGSKELETON;
  kickingSkeletonPositions [6][9] = KICKINGSKELETON;
}