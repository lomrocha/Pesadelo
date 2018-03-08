PImage skeletonCrow;
PImage skeletonCrowShadow;

public class Corvo extends Geral {
  private int targetX = jLeiteX;

  private int newTargetInterval;

  private boolean hasNewTarget;

  public Corvo() {
    setX(int(random(100, width - 163)));
    setY(int(random(-300, -1000)));

    setSpriteImage(skeletonCrow);
    setSpriteInterval(75);
    setSpriteWidth(121);
    setSpriteHeight(86);
    setMovementY(4);
  }

  public Corvo(int x, int y) {
    this.setX(x);
    this.setY(y);

    setSpriteImage(skeletonCrow);
    setSpriteInterval(75);
    setSpriteWidth(121);
    setSpriteHeight(86);
    setMovementY(4);
  }

  void display() {
    super.display();

    image(skeletonCrowShadow, getX() + 24, getY() + 86);
  }  

  void updateTarget() {
    if (getY() > 0) {
      if (!hasNewTarget) {
        targetX = jLeiteX;
        newTargetInterval = millis();
        hasNewTarget = true;
      }

      if (millis() > newTargetInterval + 1000) {
        hasNewTarget = false;
      }
    }
  }

  void update() {
    if (getX() < targetX) {
      setX(getX() + 3);
    }
    if (getX() > targetX) {
      setX(getX() - 3);
    }

    super.update();
  }

  boolean hasCollided() {
    if (getX() + 95 > jLeiteX && getX() + 25 < jLeiteX + 63 && getY() + 86 > jLeiteY && getY() < jLeiteY + 126) {
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

    if (!telaTutorialAndandoAtiva) {
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
    c.updateTarget();
    c.update();
    c.display();
    if (c.hasExitScreen()) {
      corvos.remove(c);
    }
    if (c.hasCollided()) {
      damage(3);
    }
  }

  for (int i = corvos.size() - 1; i >= 0; i = i - 1) {
    Corvo c = corvos.get(i);
    for (int j = pasAtaque.size() - 1; j >= 0; j = j - 1) {
      PaAtaque p = pasAtaque.get(j);
      if (p.acertouCorvo(c)) {
        hitInimigos(c.getX(), c.getY());
        corvos.remove(c);
      }
    }
    for (int j = pedrasAtiradas.size() - 1; j >= 0; j = j - 1) {
      PedraAtirada p = pedrasAtiradas.get(j);
      if (p.acertouCorvo(c)) {
        hitInimigos(c.getX(), c.getY());
        pedrasAtiradas.remove(p);
        corvos.remove(c);
      }
    }
    for (int j = chicotes.size() - 1; j >= 0; j = j - 1) {
      ChicoteAtaque ch = chicotesAtaque.get(j);
      if (ch.acertouCorvo(c)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(c.getX(), c.getY());
        corvos.remove(c);
      }
    }
  }
}