PImage skeleton;
PImage skeletonShadow;

final int SKELETON = 0;

int[] valoresEsqueletoXMapaCoveiro = {200, 520};

public class Esqueleto extends InimigoGeral {
  public Esqueleto(int x, int y) {
    x = x;
    y = y;

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

        if (posicoesInimigosNoPrimeiroMapa[esqueletoC][esqueletoL] == SKELETON) {
          esqueletos.add(new Esqueleto(100 + (esqueletoC * (600 / 7)), -150 - (esqueletoL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }

      if (estadoJogo == "SegundoMapa" && esqueletos.size() < 2 && totalInimigos < 6) {
        esqueletoC = int(random(0, 7));
        esqueletoL = int(random(0, 4));

        if (posicoesInimigosNoSegundoMapa[esqueletoC][esqueletoL] == SKELETON) {
          esqueletos.add(new Esqueleto(100 + (esqueletoC * (600 / 7)), -150 - (esqueletoL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }

      if (estadoJogo == "TerceiroMapa" && esqueletos.size() < 2 && totalInimigos < 6) {
        esqueletoC = int(random(0, 7));
        esqueletoL = int(random(0, 4));

        if (posicoesInimigosNoTerceiroMapa[esqueletoC][esqueletoL] == SKELETON) {
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
    if (e.saiuDaTela()) {
      totalInimigos = totalInimigos - 1;
      esqueletos.remove(e);
    }
    if (e.ataque() && !jLeiteImune) {
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
        hitInimigos(e.esqueletoX, e.esqueletoY);
        esqueletos.remove(e);
      }
    }
    for (int j = pedrasAtiradas.size() - 1; j >= 0; j = j - 1) {
      PedraAtirada p = pedrasAtiradas.get(j);
      if (p.acertouEsqueleto(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.esqueletoX, e.esqueletoY);
        pedrasAtiradas.remove(p);
        esqueletos.remove(e);
      }
    }
    for (int j = chicotes.size() - 1; j >= 0; j = j - 1) {
      ChicoteAtaque c = chicotesAtaque.get(j);
      if (c.acertouEsqueleto(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.esqueletoX, e.esqueletoY);
        esqueletos.remove(e);
      }
    }
  }
}

void posicoesEsqueleto() {
  posicoesInimigosNoPrimeiroMapa[0][0] = SKELETON;
  posicoesInimigosNoPrimeiroMapa[1][2] = SKELETON;
  posicoesInimigosNoPrimeiroMapa[2][0] = SKELETON;
  posicoesInimigosNoPrimeiroMapa[3][2] = SKELETON;
  posicoesInimigosNoPrimeiroMapa[4][0] = SKELETON;
  posicoesInimigosNoPrimeiroMapa[5][2] = SKELETON;
  posicoesInimigosNoPrimeiroMapa[6][0] = SKELETON;

  posicoesInimigosNoSegundoMapa [0][1] = SKELETON;
  posicoesInimigosNoSegundoMapa [1][3] = SKELETON;
  posicoesInimigosNoSegundoMapa [2][0] = SKELETON;
  posicoesInimigosNoSegundoMapa [3][2] = SKELETON;
  posicoesInimigosNoSegundoMapa [4][0] = SKELETON;
  posicoesInimigosNoSegundoMapa [5][0] = SKELETON;
  posicoesInimigosNoSegundoMapa [6][0] = SKELETON;

  posicoesInimigosNoTerceiroMapa[0][3] = SKELETON;
  posicoesInimigosNoTerceiroMapa[2][0] = SKELETON;
  posicoesInimigosNoTerceiroMapa[4][2] = SKELETON;
  posicoesInimigosNoTerceiroMapa[6][3] = SKELETON;
}