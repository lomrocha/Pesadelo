PImage skeletonDog;
PImage skeletonDogShadow;

final int SKELETONDOG = 2;

int[] valoresCachorroXMapaFazendeiro = {70, 382, 695};

public class Cachorro extends Geral {
  public Cachorro(int x, int y) {
    this.setX(x);
    this.setY(y);

    setSpriteImage(skeletonDog);
    setSpriteInterval(55);
    setSpriteWidth(45);
    setSpriteHeight(83);
    setMovementY(8);
  }

  void display() {
    image (skeletonDogShadow, getX(), getY() + 45);

    super.display();
  }
}

ArrayList<Cachorro> cachorros;

int cachorroC, cachorroL;

int indexRandomCachorroXMapaBoss;

void cachorro() {
  if (indexInimigos == 2) {
    if (estadoJogo == "MapaFazendeiro") {
      if (cachorros.size() == 0 && !fazendeiroTomouDanoPneu && !fazendeiro.fazendeiroMorreu) {
        for (int i = 0; i < 2; i = i + 1) {
          indexRandomCachorroXMapaBoss = int(random(0, valoresCachorroXMapaFazendeiro.length));
          cachorros.add(new Cachorro(valoresCachorroXMapaFazendeiro[indexRandomCachorroXMapaBoss], 0));
        }
      }
    }

    if (estadoJogo == "MapaPadre") { 
      if (cachorros.size() == 0 && totalInimigos < maximoInimigosPadre && !padre.padreMorreu) {
        indexRandomCachorroXMapaBoss = int(random(0, valoresInimigosXMapaPadre.length));
        cachorros.add(new Cachorro(valoresInimigosXMapaPadre[indexRandomCachorroXMapaBoss], 0));
        totalInimigos = totalInimigos + 1;
      }
    }

    if (!telaTutorialAndandoAtiva) {
      if (estadoJogo == "SegundoMapa" && cachorros.size() < 2 && totalInimigos < 6) {
        cachorroC = int(random(0, 7));
        cachorroL = int(random(0, 4));

        if (enemyPositionsSecondMap[cachorroC][cachorroL] == SKELETONDOG) {
          cachorros.add(new Cachorro(100 + (cachorroC * (600 / 7)), -150 - (cachorroL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }

      if (estadoJogo == "TerceiroMapa" && cachorros.size() < 2 && totalInimigos < 6) {
        cachorroC = int(random(0, 7));
        cachorroL = int(random(0, 4));

        if (enemyPositionsThirdMap[cachorroC][cachorroL] == SKELETONDOG) {
          cachorros.add(new Cachorro(100 + (cachorroC * (600 / 7)), -150 - (cachorroL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }
    }
  }

  for (int i = cachorros.size() - 1; i >= 0; i = i - 1) {
    Cachorro c = cachorros.get(i);
    c.display();
    c.update();
    if (c.hasExitScreen()) {
      totalInimigos = totalInimigos - 1;
      cachorros.remove(c);
    }
    if (c.hasCollided()) {
      damage(2);
    }
  }

  for (int i = cachorros.size() - 1; i >= 0; i = i - 1) {
    Cachorro c = cachorros.get(i);
    for (int j = pasAtaque.size() - 1; j >= 0; j = j - 1) {
      PaAtaque p = pasAtaque.get(j);
      if (p.acertouCachorro(c)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(c.getX(), c.getY());
        cachorros.remove(c);
      }
    }
    for (int j = pedrasAtiradas.size() - 1; j >= 0; j = j - 1) {
      PedraAtirada p = pedrasAtiradas.get(j);
      if (p.acertouCachorro(c)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(c.getX(), c.getY());
        pedrasAtiradas.remove(p);
        cachorros.remove(c);
      }
    }
    for (int j = chicotes.size() - 1; j >= 0; j = j - 1) {
      ChicoteAtaque ch = chicotesAtaque.get(j);
      if (ch.acertouCachorro(c)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(c.getX(), c.getY());
        cachorros.remove(c);
      }
    }
  }
}

void posicoesCachorro() {
  enemyPositionsSecondMap [0][0] = SKELETONDOG;
  enemyPositionsSecondMap [1][1] = SKELETONDOG;
  enemyPositionsSecondMap [2][2] = SKELETONDOG;
  enemyPositionsSecondMap [3][0] = SKELETONDOG;
  enemyPositionsSecondMap [4][3] = SKELETONDOG;
  enemyPositionsSecondMap [5][2] = SKELETONDOG;
  enemyPositionsSecondMap [6][2] = SKELETONDOG;

  enemyPositionsThirdMap  [1][0] = SKELETONDOG;
  enemyPositionsThirdMap  [3][0] = SKELETONDOG;
  enemyPositionsThirdMap  [5][2] = SKELETONDOG;
  enemyPositionsThirdMap  [6][1] = SKELETONDOG;
}