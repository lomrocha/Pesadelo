PImage brigadeiro;

public class Brigadeiro extends Comida {
  public Brigadeiro(int x, int y) {
    this.setX(x);
    this.setY(y);

    setSpriteImage(brigadeiro);
    setSpriteInterval(75);
    setSpriteWidth(32);
    setSpriteHeight(31);
    setMovementY(1);

    amountRecovered = 0;
  }

  public Brigadeiro() {
    this.setX(int(random(200, 500)));
    this.setY(int(random(-300, -1000)));

    setSpriteImage(brigadeiro);
    setSpriteInterval(75);
    setSpriteWidth(32);
    setSpriteHeight(31);
    setMovementY(1);

    amountRecovered = 0;
  }

  void display() {
    image (foodShadow, getX(), getY() + 20);

    super.display();
  }
}

ArrayList<Brigadeiro> brigadeiros;

int indexRandomBrigadeiroMapaBoss;

int amountHealBrigadeiro = 3;

void brigadeiro() {
  if (totalFood < 1 && hasIndexChanged && millis() > timeToGenerateFood + 10000) {
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      if (brigadeiros.size() == 0 && foodIndex >= 0 && foodIndex <= 4 && !telaTutorialAndandoAtiva) {
        brigadeiros.add(new Brigadeiro());
        totalFood += 1;
      }
    }

    if (estadoJogo == "MapaCoveiro") {
      if (brigadeiros.size() == 0 && foodIndex >= 0 && foodIndex <= 4) {
        indexRandomBrigadeiroMapaBoss = int(random(0, valoresXMapaCoveiro.length));
        brigadeiros.add(new Brigadeiro(valoresXMapaCoveiro[indexRandomBrigadeiroMapaBoss], valoresYMapaCoveiro[indexRandomBrigadeiroMapaBoss]));
        totalFood += 1;
      }
    }

    if (estadoJogo == "MapaFazendeiro") {
      if (brigadeiros.size() == 0 && foodIndex >= 0 && foodIndex <= 4) {
        indexRandomBrigadeiroMapaBoss = int(random(0, valoresXMapaFazendeiro.length));
        brigadeiros.add(new Brigadeiro(valoresXMapaFazendeiro[indexRandomBrigadeiroMapaBoss], valoresYMapaFazendeiro[indexRandomBrigadeiroMapaBoss]));
        totalFood += 1;
      }
    }

    if (estadoJogo == "MapaPadre") {
      if (brigadeiros.size() == 0 && foodIndex >= 0 && foodIndex <= 4) {
        indexRandomBrigadeiroMapaBoss = int(random(0, valoresXMapaPadre.length));
        brigadeiros.add(new Brigadeiro(valoresXMapaPadre[indexRandomBrigadeiroMapaBoss], valoresYMapaPadre[indexRandomBrigadeiroMapaBoss]));
        totalFood += 1;
      }
    }
  }

  for (int i = brigadeiros.size() - 1; i >= 0; i = i - 1) {
    Brigadeiro b = brigadeiros.get(i);
    b.display();
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      b.update();
    }
    if (b.hasExitScreen() || b.hasCollided()) {
      brigadeiros.remove(b);
      totalFood -= 1;
      hasIndexChanged = false;
      timeToGenerateFood = millis();
    }
    if (b.hasCollided()) {
      heal(amountHealBrigadeiro, b);
    }
  }
}