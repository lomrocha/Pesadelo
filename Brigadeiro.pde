PImage brigadeiro;

public class Brigadeiro extends Comida {
  public Brigadeiro(int x, int y) {
    this.setX(x);
    this.setY(y);

    setValues();
  }

  public Brigadeiro() {
    this.setX(int(random(200, 500)));
    this.setY(int(random(-300, -1000)));

    setValues();
  }

  void setValues() {
    setSpriteImage(brigadeiro);
    setSpriteInterval(75);
    setSpriteWidth(32);
    setSpriteHeight(31);
    setMovementY(1);

    setAmountHeal(3);
    setAmountRecovered(0);
  }

  void display() {
    image (foodShadow, getX(), getY() + 20);

    super.display();
  }
}

int indexRandomBrigadeiroMapaBoss;

void brigadeiro() {
  if (totalFood < 1 && hasIndexChanged && millis() > timeToGenerateFood + intervalToGenerateFood) {
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      if (comidas.size() == 0 && foodIndex >= 0 && foodIndex <= 4 && !telaTutorialAndandoAtiva) {
        comidas.add(new Brigadeiro());
        totalFood += 1;
      }
    }

    if (estadoJogo == "MapaCoveiro") {
      if (comidas.size() == 0 && foodIndex >= 0 && foodIndex <= 4) {
        indexRandomBrigadeiroMapaBoss = int(random(0, valoresXMapaCoveiro.length));
        comidas.add(new Brigadeiro(valoresXMapaCoveiro[indexRandomBrigadeiroMapaBoss], valoresYMapaCoveiro[indexRandomBrigadeiroMapaBoss]));
        totalFood += 1;
      }
    }

    if (estadoJogo == "MapaFazendeiro") {
      if (comidas.size() == 0 && foodIndex >= 0 && foodIndex <= 4) {
        indexRandomBrigadeiroMapaBoss = int(random(0, valoresXMapaFazendeiro.length));
        comidas.add(new Brigadeiro(valoresXMapaFazendeiro[indexRandomBrigadeiroMapaBoss], valoresYMapaFazendeiro[indexRandomBrigadeiroMapaBoss]));
        totalFood += 1;
      }
    }

    if (estadoJogo == "MapaPadre") {
      if (comidas.size() == 0 && foodIndex >= 0 && foodIndex <= 4) {
        indexRandomBrigadeiroMapaBoss = int(random(0, valoresXMapaPadre.length));
        comidas.add(new Brigadeiro(valoresXMapaPadre[indexRandomBrigadeiroMapaBoss], valoresYMapaPadre[indexRandomBrigadeiroMapaBoss]));
        totalFood += 1;
      }
    }
  }
}