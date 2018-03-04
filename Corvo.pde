PImage skeletonCrow;
PImage skeletonCrowShadow;

public class Corvo extends InimigoGeral {
  private int targetX = jLeiteX;

  private int newTargetInterval;
  private int randomTime = int(random(500, 1201));

  private boolean hasNewTarget;

  public Corvo() {
    x = int(random(100, width - 163));
    y = int(random(-300, -1000));
    
    spriteInterval = 75;
    enemy = skeletonCrow;
    spriteWidth = 121;
    spriteHeight = 86;
    movementY = 4;
  }

  public Corvo(int x, int y) {
    this.x = x;
    this.y = y;

    spriteInterval = 75;
    enemy = skeletonCrow;
    spriteWidth = 121;
    spriteHeight = 86;
    movementY = 4;
  }

  void display() {
    super.display();

    image(skeletonCrowShadow, x + 24, y + 86);
  }  

  void atualizaAlvo() {
    if (y > 0) {
      if (targetX != jLeiteX && !hasNewTarget) {
        newTargetInterval = millis();
        hasNewTarget = true;
      }
      if (millis() > newTargetInterval + randomTime) {
        targetX = jLeiteX;
        newTargetInterval = millis();
        hasNewTarget = false;
      }
    }
  }

  void update() {
    if (x < targetX) {
      x = x + 3;
    }
    if (x > targetX) {
      x = x - 3;
    }

    super.update();
  }

  boolean hasAttacked() {
    if (x + 95 > jLeiteX && x + 25 < jLeiteX + 63 && y + 86 > jLeiteY && y < jLeiteY + 126) {
      return true;
    } else {
      return false;
    }
  }
}

ArrayList<Corvo> corvos;

int indexRandomCorvoXMapaBoss;

void corvo() {
  if (indexInimigos == 3) {
    if (estadoJogo == "MapaPadre") {
      if (corvos.size() == 0 && totalInimigos < maximoInimigosPadre && !padre.padreMorreu) {
        indexRandomCorvoXMapaBoss = int(random(0, valoresInimigosXMapaPadre.length));
        corvos.add(new Corvo(valoresInimigosXMapaPadre[indexRandomCorvoXMapaBoss], 0));
      }
    }

    if (!telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
      if (estadoJogo == "SegundoMapa" && corvos.size() < 2) {
        corvos.add(new Corvo());
      }

      if (estadoJogo == "TerceiroMapa" && corvos.size() < 2) {
        corvos.add(new Corvo());
      }
    }
  }

  for (int i = corvos.size() - 1; i >= 0; i = i - 1) {
    Corvo c = corvos.get(i);
    c.display();
    c.atualizaAlvo();
    c.update();
    if (c.hasExitScreen()) {
      corvos.remove(c);
    }
    if (c.hasAttacked() && !jLeiteImune) {
      vidaJLeiteAtual = vidaJLeiteAtual - 3;
      jLeiteImune = true;
      tempoImune = millis();
    }
  }

  for (int i = corvos.size() - 1; i >= 0; i = i - 1) {
    Corvo c = corvos.get(i);
    for (int j = pasAtaque.size() - 1; j >= 0; j = j - 1) {
      PaAtaque p = pasAtaque.get(j);
      if (p.acertouCorvo(c)) {
        hitInimigos(c.x, c.y);
        corvos.remove(c);
      }
    }
    for (int j = pedrasAtiradas.size() - 1; j >= 0; j = j - 1) {
      PedraAtirada p = pedrasAtiradas.get(j);
      if (p.acertouCorvo(c)) {
        hitInimigos(c.x, c.y);
        pedrasAtiradas.remove(p);
        corvos.remove(c);
      }
    }
    for (int j = chicotes.size() - 1; j >= 0; j = j - 1) {
      ChicoteAtaque ch = chicotesAtaque.get(j);
      if (ch.acertouCorvo(c)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(c.x, c.y);
        corvos.remove(c);
      }
    }
  }
}