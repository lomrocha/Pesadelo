PImage coxinha;

public class Coxinha extends Comida {
  public Coxinha(int x, int y) {
    this.setX(x);
    this.setY(y);

    setSpriteImage(coxinha);
    setSpriteInterval(75);
    setSpriteWidth(28);
    setSpriteHeight(30);
    setMovementY(1);

    amountRecovered = 0;
  }

  public Coxinha() {
    this.setX(int(random(200, 500)));
    this.setY(int(random(-300, -1000)));

    setSpriteImage(coxinha);
    setSpriteInterval(75);
    setSpriteWidth(28);
    setSpriteHeight(30);
    setMovementY(1);

    amountRecovered = 0;
  }

  void display() {
    image (foodShadow, getX(), getY() + 20);

    super.display();
  }
}

ArrayList<Coxinha> coxinhas;

int indexRandomCoxinhaMapaBoss;

int amountHealCoxinha = 5;

void coxinha() {
  if (totalFood < 1 && hasIndexChanged && millis() > timeToGenerateFood + 10000) {
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      if (coxinhas.size() == 0 && foodIndex >= 8 && foodIndex <= 9 && !telaTutorialAndandoAtiva) {
        coxinhas.add(new Coxinha());
        totalFood += 1;
      }
    }

    if (estadoJogo == "MapaCoveiro") {
      if (coxinhas.size() == 0 && foodIndex >= 8 && foodIndex <= 9) {
        indexRandomCoxinhaMapaBoss = int(random(0, valoresXMapaCoveiro.length));
        coxinhas.add(new Coxinha(valoresXMapaCoveiro[indexRandomCoxinhaMapaBoss], valoresYMapaCoveiro[indexRandomCoxinhaMapaBoss]));
        totalFood += 1;
      }
    }

    if (estadoJogo == "MapaFazendeiro") {
      if (coxinhas.size() == 0 && foodIndex >= 8 && foodIndex <= 9) {
        indexRandomCoxinhaMapaBoss = int(random(0, valoresXMapaFazendeiro.length));
        coxinhas.add(new Coxinha(valoresXMapaFazendeiro[indexRandomCoxinhaMapaBoss], valoresYMapaFazendeiro[indexRandomCoxinhaMapaBoss]));
        totalFood += 1;
      }
    }

    if (estadoJogo == "MapaPadre") {
      if (coxinhas.size() == 0 && foodIndex >= 8 && foodIndex <= 9) {
        indexRandomCoxinhaMapaBoss = int(random(0, valoresXMapaPadre.length));
        coxinhas.add(new Coxinha(valoresXMapaPadre[indexRandomCoxinhaMapaBoss], valoresYMapaPadre[indexRandomCoxinhaMapaBoss]));
        totalFood += 1;
      }
    }
  }

  for (int i = coxinhas.size() - 1; i >= 0; i = i - 1) {
    Coxinha c = coxinhas.get(i);
    c.display();
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      c.update();
    }
    if (c.hasExitScreen() || c.hasCollided()) {
      coxinhas.remove(c);
      totalFood -= 1;
      hasIndexChanged = false;
      timeToGenerateFood = millis();
    }
    if (c.hasCollided()) {
      heal(amountHealCoxinha, c);
    }
  }
}