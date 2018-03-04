PImage kickingSkeleton;
PImage headlessKickingSkeleton;
PImage kickingSkeletonShadow;

final int KICKINGSKELETON = 1;

public class EsqueletoChute extends InimigoGeral {
  private PImage kickingSkeletonSprite;

  private int movementX;

  private int changeDirectionDelay;

  private int kickingSkeletonStep;
  private int kickingSkeletonSpriteTime;

  private boolean hasLostHead;
  private boolean gatilhoEsqueletoCabeca, esqueletoCabecaSaiu;

  public EsqueletoChute(int x, int y) {
    this.x = x;
    this.y = y;

    spriteInterval = 200;
    enemy = headlessKickingSkeleton;
    spriteWidth = 48;
    spriteHeight = 74;
    movementY = int(sceneryMovement);
  }

  void display() {
    image (kickingSkeletonShadow, x + 1, y + 50);

    if (!hasLostHead) {
      if (millis() > kickingSkeletonSpriteTime + 200) { 
        if (y < 0) {
          kickingSkeletonSprite = kickingSkeleton.get(0, 0, 49, 74);
        } else {
          kickingSkeletonSprite = kickingSkeleton.get(kickingSkeletonStep, 0, 49, 74); 
          kickingSkeletonStep = kickingSkeletonStep % 245 + 49;
        }
        image(kickingSkeletonSprite, x, y); 
        kickingSkeletonSpriteTime = millis();
      } else {
        image(kickingSkeletonSprite, x, y);
      }

      if (kickingSkeletonStep == 196 && !gatilhoEsqueletoCabeca) {
        esqueletoCabecaSaiu = true;
        gatilhoEsqueletoCabeca = true;
      }

      if (kickingSkeletonStep == kickingSkeletonSprite.width) {
        hasLostHead = true;
        kickingSkeletonStep = 0;
      }
    } else {
      super.display();
    }
  }

  void update() {
    x = x + movementX;
    y = y + movementY;

    if (!hasLostHead) {
      movementY = int(sceneryMovement);
      movementX = 0;
    } else {
      movementY = int(sceneryMovement) + 1;
      if (millis() > changeDirectionDelay + 350) {
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

    if (!telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
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

  for (int i = esqueletosChute.size() - 1; i >= 0; i = i - 1) {
    EsqueletoChute e = esqueletosChute.get(i);
    e.display();
    if (e.esqueletoCabecaSaiu) {
      cabecasEsqueleto.add(new CabecaEsqueleto(e.x, e.y, jLeiteX));
      e.esqueletoCabecaSaiu = false;
    }
    e.update();
    if (e.hasExitScreen()) {
      totalInimigos = totalInimigos - 1;
      esqueletosChute.remove(e);
    }
    if (e.hasAttacked() && !jLeiteImune) {
      vidaJLeiteAtual = vidaJLeiteAtual - 2;
      jLeiteImune = true;
      tempoImune = millis();
    }
  }

  for (int i = esqueletosChute.size() - 1; i >= 0; i = i - 1) {
    EsqueletoChute e = esqueletosChute.get(i);
    for (int j = pasAtaque.size() - 1; j >= 0; j = j - 1) {
      PaAtaque p = pasAtaque.get(j);
      if (p.acertouEsqueletoChute(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.x - 40, e.y - 20);
        esqueletosChute.remove(e);
      }
    }
    for (int j = pedrasAtiradas.size() - 1; j >= 0; j = j - 1) {
      PedraAtirada p = pedrasAtiradas.get(j);
      if (p.acertouEsqueletoChute(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.x - 40, e.y - 20);
        pedrasAtiradas.remove(p);
        esqueletosChute.remove(e);
      }
    }
    for (int j = chicotes.size() - 1; j >= 0; j = j - 1) {
      ChicoteAtaque c = chicotesAtaque.get(j);
      if (c.acertouEsqueletoChute(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.x - 40, e.y - 20);
        esqueletosChute.remove(e);
      }
    }
  }
}

void posicoesEsqueletoChute() {
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