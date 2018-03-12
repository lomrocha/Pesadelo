PImage stone;
PImage stoneShadow;

public class Pedra extends Item {
  public Pedra() {
    setX(int(random(100, 666)));
    setY(int(random(-300, -1000)));

    setValues();
  }

  public Pedra(int x, int y) {
    this.setX(x);
    this.setY(y);

    setValues();
  }

  void setValues() {
    setSpriteImage(stone);
    setSpriteInterval(75);
    setSpriteWidth(34);
    setSpriteHeight(27);
    setMovementY(1);

    setItemIndex(1);
    setItemTotal(15);
  }

  void display() {
    image (stoneShadow, getX(), getY() + 17);

    super.display();
  }
}

int indexRandomPedraMapaBoss;

void pedra() {
  if (totalArmas == 0 && millis() > tempoGerarArma + 15000) {
    if (estadoJogo == "SegundoMapa") {
      if (itens.size() == 0 && indexArma >= 5 && indexArma <= 9 && !telaTutorialAndandoAtiva) {
        itens.add(new Pedra());
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "TerceiroMapa") {
      if (itens.size() == 0 && indexArma >= 3 && indexArma <= 4 && !telaTutorialAndandoAtiva) {
        itens.add(new Pedra());
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "MapaFazendeiro") {
      if (itens.size() == 0 && indexArma >= 5 && indexArma <= 9) {
        indexRandomPedraMapaBoss = int(random(0, valoresXMapaFazendeiro.length));
        itens.add(new Pedra(valoresXMapaFazendeiro[indexRandomPedraMapaBoss], valoresYMapaFazendeiro[indexRandomPedraMapaBoss]));
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "MapaPadre") {
      if (itens.size() == 0 && indexArma >= 3 && indexArma <= 4) {
        indexRandomPedraMapaBoss = int(random(0, valoresXMapaPadre.length));
        itens.add(new Pedra(valoresXMapaPadre[indexRandomPedraMapaBoss], valoresYMapaPadre[indexRandomPedraMapaBoss]));
        totalArmas = totalArmas + 1;
      }
    }
  }
}