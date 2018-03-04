PImage redSkeleton;
PImage redSkeletonShadow;

final int REDSKELETON = 3;

public class EsqueletoRaiva extends InimigoGeral {
  private int movementX = 3;

  public EsqueletoRaiva(int x, int y) {
    this.x = x;
    this.y = y;
    
    spriteInterval = 75;
    enemy = redSkeleton;
    spriteWidth = 76;
    spriteHeight = 126;
    movementY = 3;
  }

  void display() {
    image(redSkeletonShadow, x + 16, y + 114);
    
    super.display();
  }

  void update() {
    x = x + movementX;

    if (x < 100) {
      movementX = 3;
    }
    if (x + 30 > 700) {
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

    if (!telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
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
    if (e.hasAttacked() && !jLeiteImune) {
      vidaJLeiteAtual = vidaJLeiteAtual - 3;
      jLeiteImune = true;
      tempoImune = millis();
    }
  }

  for (int i = esqueletosRaiva.size() - 1; i >= 0; i = i - 1) {
    EsqueletoRaiva e = esqueletosRaiva.get(i);
    for (int j = pasAtaque.size() - 1; j >= 0; j = j - 1) {
      PaAtaque p = pasAtaque.get(j);
      if (p.acertouEsqueletoRaiva(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.x, e.y);
        esqueletosRaiva.remove(e);
      }
    }
    for (int j = pedrasAtiradas.size() - 1; j >= 0; j = j - 1) {
      PedraAtirada p = pedrasAtiradas.get(j);
      if (p.acertouEsqueletoRaiva(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.x, e.y);
        pedrasAtiradas.remove(p);
        esqueletosRaiva.remove(e);
      }
    }
    for (int j = chicotes.size() - 1; j >= 0; j = j - 1) {
      ChicoteAtaque ch = chicotesAtaque.get(j);
      if (ch.acertouEsqueletoRaiva(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.x, e.y);
        esqueletosRaiva.remove(e);
      }
    }
  }
}

void posicoesEsqueletoRaiva() {
  enemyPositionsThirdMap[0][0] = REDSKELETON;
  enemyPositionsThirdMap[1][2] = REDSKELETON;
  enemyPositionsThirdMap[2][3] = REDSKELETON;
  enemyPositionsThirdMap[3][2] = REDSKELETON;
  enemyPositionsThirdMap[4][1] = REDSKELETON;
  enemyPositionsThirdMap[5][0] = REDSKELETON;
  enemyPositionsThirdMap[6][2] = REDSKELETON;
}