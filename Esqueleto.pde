PImage skeleton;
PImage skeletonShadow;

final int SKELETON = 0;

int[] valoresEsqueletoXMapaCoveiro = {200, 520};

public class Esqueleto extends InimigoGeral {
  public Esqueleto(int x, int y) {
    this.x = x;
    this.y = y;

    spriteInterval = 155;
    enemy = skeleton;
    spriteWidth = 76;
    spriteHeight = 126;
    movementY = 3;
  }

  void display() {
    image (skeletonShadow, x + 16, y + 114);

    super.display();
  }
}

ArrayList<Esqueleto> esqueletos;

int esqueletoC, esqueletoL;

int indexRandomEsqueletoXMapaBoss;

void esqueleto() {
  if (indexInimigos == 0) {
    if (estadoJogo == "MapaCoveiro") {
      if (esqueletos.size() == 0 && !coveiro.coveiroMorreu && !coveiroTomouDanoAgua) {
        for (int i = 0; i < 2; i = i + 1) {
          indexRandomEsqueletoXMapaBoss = int(random(0, 2));
          esqueletos.add(new Esqueleto(valoresEsqueletoXMapaCoveiro[indexRandomEsqueletoXMapaBoss], 0));
        }
      }
    }

    if (estadoJogo == "MapaPadre") { 
      if (esqueletos.size() == 0 && totalInimigos < maximoInimigosPadre && !padre.padreMorreu) {
        indexRandomEsqueletoXMapaBoss = int(random(0, valoresInimigosXMapaPadre.length));
        esqueletos.add(new Esqueleto(valoresInimigosXMapaPadre[indexRandomEsqueletoXMapaBoss], 0));
        totalInimigos = totalInimigos + 1;
      }
    }

    if (!telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
      if (estadoJogo == "PrimeiroMapa" && esqueletos.size() < 2 && totalInimigos < 6) {
        esqueletoC = int(random(0, 7));
        esqueletoL = int(random(0, 4));

        if (enemyPositionsFirstMap[esqueletoC][esqueletoL] == SKELETON) {
          esqueletos.add(new Esqueleto(100 + (esqueletoC * (600 / 7)), -150 - (esqueletoL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }

      if (estadoJogo == "SegundoMapa" && esqueletos.size() < 2 && totalInimigos < 6) {
        esqueletoC = int(random(0, 7));
        esqueletoL = int(random(0, 4));

        if (enemyPositionsSecondMap[esqueletoC][esqueletoL] == SKELETON) {
          esqueletos.add(new Esqueleto(100 + (esqueletoC * (600 / 7)), -150 - (esqueletoL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }

      if (estadoJogo == "TerceiroMapa" && esqueletos.size() < 2 && totalInimigos < 6) {
        esqueletoC = int(random(0, 7));
        esqueletoL = int(random(0, 4));

        if (enemyPositionsThirdMap[esqueletoC][esqueletoL] == SKELETON) {
          esqueletos.add(new Esqueleto(100 + (esqueletoC * (600 / 7)), -150 - (esqueletoL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }
    }
  }

  for (int i = esqueletos.size() - 1; i >= 0; i = i - 1) {
    Esqueleto e = esqueletos.get(i);
    e.display();
    e.update();
    if (e.hasExitScreen()) {
      totalInimigos = totalInimigos - 1;
      esqueletos.remove(e);
    }
    if (e.hasAttacked() && !jLeiteImune) {
      vidaJLeiteAtual = vidaJLeiteAtual - 2;
      jLeiteImune = true;
      tempoImune = millis();
    }
  }

  for (int i = esqueletos.size() - 1; i >= 0; i = i - 1) {
    Esqueleto e = esqueletos.get(i);
    for (int j = pasAtaque.size() - 1; j >= 0; j = j - 1) {
      PaAtaque p = pasAtaque.get(j);
      if (p.acertouEsqueleto(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.x, e.y);
        esqueletos.remove(e);
      }
    }
    for (int j = pedrasAtiradas.size() - 1; j >= 0; j = j - 1) {
      PedraAtirada p = pedrasAtiradas.get(j);
      if (p.acertouEsqueleto(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.x, e.y);
        pedrasAtiradas.remove(p);
        esqueletos.remove(e);
      }
    }
    for (int j = chicotes.size() - 1; j >= 0; j = j - 1) {
      ChicoteAtaque c = chicotesAtaque.get(j);
      if (c.acertouEsqueleto(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.x, e.y);
        esqueletos.remove(e);
      }
    }
  }
}

void posicoesEsqueleto() {
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