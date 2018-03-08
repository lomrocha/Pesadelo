PImage shovel;
PImage shovelShadow;

public class Pa extends Geral {
  public Pa() {
    setX(int(random(100, 616)));
    setY(int(random(-300, -1000)));

    setSpriteImage(shovel);
    setSpriteInterval(75);
    setSpriteWidth(84);
    setSpriteHeight(91);
    setMovementY(sceneryMovement);
  }

  public Pa(int x, int y) {
    this.setX(x);
    this.setY(y);

    setSpriteImage(shovel);
    setSpriteInterval(75);
    setSpriteWidth(84);
    setSpriteHeight(91);
    setMovementY(sceneryMovement);
  }

  void display() {
    image (shovelShadow, getX() + 1, getY() + 85);

    super.display();
  }
}

ArrayList<Pa> pas;

int indexRandomPaMapaBoss;

void pa() {
  if (totalArmas == 0 && millis() > tempoGerarArma + 15000) {
    if (estadoJogo == "PrimeiroMapa") {
      if (pas.size() == 0 && indexArma >= 0 && indexArma <= 9 && !telaTutorialAndandoAtiva) {
        pas.add(new Pa());
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "SegundoMapa") {
      if (pas.size() == 0 && indexArma >= 0 && indexArma <= 4 && !telaTutorialAndandoAtiva) {
        pas.add(new Pa());
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "TerceiroMapa") {
      if (pas.size() == 0 && indexArma >= 0 && indexArma <= 2 && !telaTutorialAndandoAtiva) {
        pas.add(new Pa());
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "MapaCoveiro") {
      if (pas.size() == 0 && indexArma >= 0 && indexArma <= 9) {
        indexRandomPaMapaBoss = int(random(0, valoresXMapaCoveiro.length));
        pas.add(new Pa(valoresXMapaCoveiro[indexRandomPaMapaBoss], valoresYMapaCoveiro[indexRandomPaMapaBoss]));
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "MapaFazendeiro") {
      if (pas.size() == 0 && indexArma >= 0 && indexArma <= 4) {
        indexRandomPaMapaBoss = int(random(0, valoresXMapaFazendeiro.length));
        pas.add(new Pa(valoresXMapaFazendeiro[indexRandomPaMapaBoss], valoresYMapaFazendeiro[indexRandomPaMapaBoss]));
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "MapaPadre") {
      if (pas.size() == 0 && indexArma >= 0 && indexArma <= 2) {
        indexRandomPaMapaBoss = int(random(0, valoresXMapaPadre.length));
        pas.add(new Pa(valoresXMapaPadre[indexRandomPaMapaBoss], valoresYMapaPadre[indexRandomPaMapaBoss]));
        totalArmas = totalArmas + 1;
      }
    }
  }

  for (int i = pas.size() - 1; i >= 0; i = i - 1) {
    Pa p = pas.get(i);
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      p.update();
    }
    p.display();
    if (p.hasExitScreen() || p.hasCollided()) {
      pas.remove(p);
    }
    if (p.hasCollided()) {
      tempoGerarArma = millis();
      item = 2;
      totalItem = 7;
      armaGerada = false;
    }
  }
}