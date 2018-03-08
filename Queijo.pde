PImage queijo;

public class Queijo extends Comida {
  public Queijo(int x, int y) {
    this.setX(x);
    this.setY(y);

    setSpriteImage(queijo);
    setSpriteInterval(75);
    setSpriteWidth(31);
    setSpriteHeight(29);
    setMovementY(1);

    amountRecovered = 0;
  }

  public Queijo() {
    this.setX(int(random(200, 500)));
    this.setY(int(random(-300, -1000)));

    setSpriteImage(queijo);
    setSpriteInterval(75);
    setSpriteWidth(31);
    setSpriteHeight(29);
    setMovementY(1);

    amountRecovered = 0;
  }

  void display() {
    image (foodShadow, getX(), getY() + 19);

    super.display();
  }
}

ArrayList<Queijo> queijos;

int indexRandomQueijoMapaBoss;

int amountHealQueijo = 4;

void queijo() {
  if (totalFood < 1 && hasIndexChanged && millis() > timeToGenerateFood + 10000) {
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      if (queijos.size() == 0 && foodIndex >= 5 && foodIndex <= 7 && !telaTutorialAndandoAtiva) {
        queijos.add(new Queijo());
        totalFood += 1;
      }
    }

    if (estadoJogo == "MapaCoveiro") {
      if (queijos.size() == 0 && foodIndex >= 5 && foodIndex <= 7) {
        indexRandomQueijoMapaBoss = int(random(0, valoresXMapaCoveiro.length));
        queijos.add(new Queijo(valoresXMapaCoveiro[indexRandomQueijoMapaBoss], valoresYMapaCoveiro[indexRandomQueijoMapaBoss]));
        totalFood += 1;
      }
    }

    if (estadoJogo == "MapaFazendeiro") {
      if (queijos.size() == 0 && foodIndex >= 5 && foodIndex <= 7) {
        indexRandomQueijoMapaBoss = int(random(0, valoresXMapaFazendeiro.length));
        queijos.add(new Queijo(valoresXMapaFazendeiro[indexRandomQueijoMapaBoss], valoresYMapaFazendeiro[indexRandomQueijoMapaBoss]));
        totalFood += 1;
      }
    }

    if (estadoJogo == "MapaPadre") {
      if (queijos.size() == 0 && foodIndex >= 5 && foodIndex <= 7) {
        indexRandomQueijoMapaBoss = int(random(0, valoresXMapaFazendeiro.length));
        queijos.add(new Queijo(valoresXMapaPadre[indexRandomQueijoMapaBoss], valoresYMapaPadre[indexRandomQueijoMapaBoss]));
        totalFood += 1;
      }
    }
  }

  for (int i = queijos.size() - 1; i >= 0; i = i - 1) {
    Queijo q = queijos.get(i);
    q.display();
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      q.update();
    }
    if (q.hasExitScreen() || q.hasCollided()) {
      queijos.remove(q);
      totalFood -= 1;
      hasIndexChanged = false;
      timeToGenerateFood = millis();
    }
    if (q.hasCollided()) {
      heal(amountHealQueijo, q);
    }
  }
}