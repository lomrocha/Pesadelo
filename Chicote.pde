PImage whip;
PImage whipShadow;

public class Chicote extends Item {
  public Chicote() {
    setX(int(random(100, 599)));
    setY(int(random(-300, -1000)));

    setValues();
  }

  public Chicote(int x, int y) {
    this.setX(x);
    this.setY(y);

    setValues();
  }

  void setValues() {
    setSpriteImage(whip);
    setSpriteInterval(75);
    setSpriteWidth(101);
    setSpriteHeight(91);
    setMovementY(1);

    setItemIndex(3);
    setItemTotal(10);
  }

  void display() {
    image (whipShadow, getX() + 10, getY() + 76);

    super.display();
  }
}

int indexRandomChicoteMapaBoss;

void chicote() {
  if (totalArmas == 0 && millis() > tempoGerarArma + 15000) {
    if (estadoJogo == "TerceiroMapa") {
      if (itens.size() == 0 && indexArma >= 5 && indexArma <= 9 && !telaTutorialAndandoAtiva) {
        itens.add(new Chicote());
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "MapaPadre") {
      if (itens.size() == 0 && indexArma >= 5 && indexArma <= 9) {
        indexRandomChicoteMapaBoss = int(random(0, valoresXMapaPadre.length));
        itens.add(new Chicote(valoresXMapaPadre[indexRandomChicoteMapaBoss], valoresYMapaPadre[indexRandomChicoteMapaBoss]));
        totalArmas = totalArmas + 1;
      }
    }
  }
}