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

    setAmountHeal(4);
    setAmountRecovered(0);
  }

  public Queijo() {
    this.setX(int(random(200, 500)));
    this.setY(int(random(-300, -1000)));

    setSpriteImage(queijo);
    setSpriteInterval(75);
    setSpriteWidth(31);
    setSpriteHeight(29);
    setMovementY(1);

    setAmountHeal(4);
    setAmountRecovered(0);
  }

  void display() {
    image (foodShadow, getX(), getY() + 19);

    super.display();
  }
}

int indexRandomQueijoMapaBoss;

void queijo() {
  if (totalFood < 1 && hasIndexChanged && millis() > timeToGenerateFood + intervalToGenerateFood) {
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      if (comidas.size() == 0 && foodIndex >= 5 && foodIndex <= 7 && !telaTutorialAndandoAtiva) {
        comidas.add(new Queijo());
        totalFood += 1;
      }
    }

    if (estadoJogo == "MapaCoveiro") {
      if (comidas.size() == 0 && foodIndex >= 5 && foodIndex <= 7) {
        indexRandomQueijoMapaBoss = int(random(0, valoresXMapaCoveiro.length));
        comidas.add(new Queijo(valoresXMapaCoveiro[indexRandomQueijoMapaBoss], valoresYMapaCoveiro[indexRandomQueijoMapaBoss]));
        totalFood += 1;
      }
    }

    if (estadoJogo == "MapaFazendeiro") {
      if (comidas.size() == 0 && foodIndex >= 5 && foodIndex <= 7) {
        indexRandomQueijoMapaBoss = int(random(0, valoresXMapaFazendeiro.length));
        comidas.add(new Queijo(valoresXMapaFazendeiro[indexRandomQueijoMapaBoss], valoresYMapaFazendeiro[indexRandomQueijoMapaBoss]));
        totalFood += 1;
      }
    }

    if (estadoJogo == "MapaPadre") {
      if (comidas.size() == 0 && foodIndex >= 5 && foodIndex <= 7) {
        indexRandomQueijoMapaBoss = int(random(0, valoresXMapaFazendeiro.length));
        comidas.add(new Queijo(valoresXMapaPadre[indexRandomQueijoMapaBoss], valoresYMapaPadre[indexRandomQueijoMapaBoss]));
        totalFood += 1;
      }
    }
  }
}