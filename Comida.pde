PImage foodShadow;

int timeToGenerateFood;
int intervalToGenerateFood = 10000;

int foodIndex;

int totalFood;

boolean hasIndexChanged;

void foodAll() {
  generateIndex();
  foods();

  coxinha();
  brigadeiro();
  queijo();
}

void generateIndex() {
  if (!telaTutorialAndandoAtiva) {
    if (!hasIndexChanged) {
      foodIndex = int(random(0, 10));
      hasIndexChanged = true;
    }
  }
}

ArrayList<Comida> comidas;

public class Comida extends Geral {
  private int amountHeal;
  private int amountRecovered = 0;

  public int getAmountHeal() {
    return amountHeal;
  }

  public void setAmountHeal(int amountHeal) {
    this.amountHeal = amountHeal;
  }

  public int getAmountRecovered() {
    return amountRecovered;
  }

  public void setAmountRecovered(int amountRecovered) {
    this.amountRecovered = amountRecovered;
  }
}

void foods() {
  for (int i = comidas.size() - 1; i >= 0; i = i - 1) {
    Comida c = comidas.get(i);
    c.display();
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      c.update();
    }
    if (c.hasExitScreen() || c.hasCollided()) {
      comidas.remove(c);
      generateFood();

      if (c.hasCollided()) {
        heal(c.getAmountHeal(), c);
      }
    }
  }
}

void generateFood() {
  totalFood -= 1;
  hasIndexChanged = false;
  timeToGenerateFood = millis();
  intervalToGenerateFood = 10000;
}

void heal(int amount, Comida c) {
  while (vidaJLeiteAtual < vidaJleiteMax && c.amountRecovered < amount) {
    c.amountRecovered += 1;
    vidaJLeiteAtual += 1;
  }
}