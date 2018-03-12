PImage coxinha;

public class Coxinha extends Comida {
  public Coxinha(int x, int y) {
    this.setX(x);
    this.setY(y);

    setValues();
  }

  public Coxinha() {
    setX(int(random(200, 500)));
    setY(int(random(-300, -1000)));

    setValues();
  }

  void setValues() {
    setSpriteImage(coxinha);
    setSpriteInterval(75);
    setSpriteWidth(28);
    setSpriteHeight(30);
    setMovementY(1);

    setAmountHeal(5);
    setAmountRecovered(0);
  }

  void display() {
    image (foodShadow, getX(), getY() + 20);

    super.display();
  }
}

int indexRandomCoxinhaMapaBoss;

void coxinha() {
  if (totalFood < 1 && hasIndexChanged && millis() > timeToGenerateFood + intervalToGenerateFood) {
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      if (comidas.size() == 0 && foodIndex >= 8 && foodIndex <= 9 && !telaTutorialAndandoAtiva) {
        comidas.add(new Coxinha());
        totalFood += 1;
      }
    }

    if (estadoJogo == "MapaCoveiro") {
      if (comidas.size() == 0 && foodIndex >= 8 && foodIndex <= 9) {
        indexRandomCoxinhaMapaBoss = int(random(0, valoresXMapaCoveiro.length));
        comidas.add(new Coxinha(valoresXMapaCoveiro[indexRandomCoxinhaMapaBoss], valoresYMapaCoveiro[indexRandomCoxinhaMapaBoss]));
        totalFood += 1;
      }
    }

    if (estadoJogo == "MapaFazendeiro") {
      if (comidas.size() == 0 && foodIndex >= 8 && foodIndex <= 9) {
        indexRandomCoxinhaMapaBoss = int(random(0, valoresXMapaFazendeiro.length));
        comidas.add(new Coxinha(valoresXMapaFazendeiro[indexRandomCoxinhaMapaBoss], valoresYMapaFazendeiro[indexRandomCoxinhaMapaBoss]));
        totalFood += 1;
      }
    }

    if (estadoJogo == "MapaPadre") {
      if (comidas.size() == 0 && foodIndex >= 8 && foodIndex <= 9) {
        indexRandomCoxinhaMapaBoss = int(random(0, valoresXMapaPadre.length));
        comidas.add(new Coxinha(valoresXMapaPadre[indexRandomCoxinhaMapaBoss], valoresYMapaPadre[indexRandomCoxinhaMapaBoss]));
        totalFood += 1;
      }
    }
  }
}