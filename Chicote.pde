PImage whip;
PImage whipShadow;

public class Chicote extends Geral {
  public Chicote() {
    setX(int(random(100, 599)));
    setY(int(random(-300, -1000)));

    setSpriteImage(whip);
    setSpriteInterval(75);
    setSpriteWidth(101);
    setSpriteHeight(91);
    setMovementY(sceneryMovement);
  }

  public Chicote(int x, int y) {
    this.setX(x);
    this.setY(y);

    setSpriteImage(whip);
    setSpriteInterval(75);
    setSpriteWidth(101);
    setSpriteHeight(91);
    setMovementY(sceneryMovement);
  }

  void display() {
    image (whipShadow, getX() + 10, getY() + 76);

    super.display();
  }
}

ArrayList<Chicote> chicotes;

int indexRandomChicoteMapaBoss;

void chicote() {
  if (totalArmas == 0 && millis() > tempoGerarArma + 15000) {
    if (estadoJogo == "TerceiroMapa") {
      if (chicotes.size() == 0 && indexArma >= 5 && indexArma <= 9 && !telaTutorialAndandoAtiva) {
        chicotes.add(new Chicote());
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "MapaPadre") {
      if (chicotes.size() == 0 && indexArma >= 5 && indexArma <= 9) {
        indexRandomChicoteMapaBoss = int(random(0, valoresXMapaPadre.length));
        chicotes.add(new Chicote(valoresXMapaPadre[indexRandomChicoteMapaBoss], valoresYMapaPadre[indexRandomChicoteMapaBoss]));
        totalArmas = totalArmas + 1;
      }
    }
  }

  for (int i = chicotes.size() - 1; i >= 0; i = i - 1) {
    Chicote c = chicotes.get(i);
    if (estadoJogo == "TerceiroMapa") {
      c.update();
    }
    c.display();
    if (c.hasExitScreen() || c.hasCollided()) {
      chicotes.remove(c);
    }
    if (c.hasCollided()) {
      tempoGerarArma = millis();
      item = 3;
      totalItem = 10;
      armaGerada = false;
    }
  }
}