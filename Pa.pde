PImage shovel;
PImage shovelShadow;

public class Pa extends Item {
  public Pa() {
    setX(int(random(100, 616)));
    setY(int(random(-300, -1000)));

    setValues();
  }

  public Pa(int x, int y) {
    this.setX(x);
    this.setY(y);

    setValues();
  }

  void setValues() {
    setSpriteImage(shovel);
    setSpriteInterval(75);
    setSpriteWidth(84);
    setSpriteHeight(91);
    setMovementY(1);

    setItemIndex(2);
    setItemTotal(7);
  }

  void display() {
    image (shovelShadow, getX() + 1, getY() + 85);

    super.display();
  }
}

int indexRandomPaMapaBoss;

void pa() {
  if (totalArmas == 0 && millis() > tempoGerarArma + 15000) {
    if (estadoJogo == "PrimeiroMapa") {
      if (itens.size() == 0 && indexArma >= 0 && indexArma <= 9 && !telaTutorialAndandoAtiva) {
        itens.add(new Pa());
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "SegundoMapa") {
      if (itens.size() == 0 && indexArma >= 0 && indexArma <= 4 && !telaTutorialAndandoAtiva) {
        itens.add(new Pa());
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "TerceiroMapa") {
      if (itens.size() == 0 && indexArma >= 0 && indexArma <= 2 && !telaTutorialAndandoAtiva) {
        itens.add(new Pa());
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "MapaCoveiro") {
      if (itens.size() == 0 && indexArma >= 0 && indexArma <= 9) {
        indexRandomPaMapaBoss = int(random(0, valoresXMapaCoveiro.length));
        itens.add(new Pa(valoresXMapaCoveiro[indexRandomPaMapaBoss], valoresYMapaCoveiro[indexRandomPaMapaBoss]));
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "MapaFazendeiro") {
      if (itens.size() == 0 && indexArma >= 0 && indexArma <= 4) {
        indexRandomPaMapaBoss = int(random(0, valoresXMapaFazendeiro.length));
        itens.add(new Pa(valoresXMapaFazendeiro[indexRandomPaMapaBoss], valoresYMapaFazendeiro[indexRandomPaMapaBoss]));
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "MapaPadre") {
      if (itens.size() == 0 && indexArma >= 0 && indexArma <= 2) {
        indexRandomPaMapaBoss = int(random(0, valoresXMapaPadre.length));
        itens.add(new Pa(valoresXMapaPadre[indexRandomPaMapaBoss], valoresYMapaPadre[indexRandomPaMapaBoss]));
        totalArmas = totalArmas + 1;
      }
    }
  }
}