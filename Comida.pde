PImage foodShadow;

int timeToGenerateFood;
int intervalToGenerateFood = 10000;

int foodIndex;

int foodTotal;

int foodRandomMapPositionIndex;

boolean hasFoodIndexChanged;

void foodAll() {
  generateFoodIndex();
  if (foodTotal == 0 && hasFoodIndexChanged && millis() > timeToGenerateFood + intervalToGenerateFood && comidas.size() == 0) {
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      addFood();
    } else if (estadoJogo == "MapaCoveiro" || estadoJogo == "MapaFazendeiro" || estadoJogo == "MapaPadre") {
      addFoodBoss();
    }
  }

  if (comidas.size() > 0) {
    foods();
  }
}

void generateFoodIndex() {
  if (!telaTutorialAndandoAtiva) {
    if (!hasFoodIndexChanged) {
      foodIndex = int(random(0, 10));
      hasFoodIndexChanged = true;
    }
  }
}

ArrayList<Comida> comidas;

public class Comida extends Geral {
  private int amountHeal;
  private int amountRecovered;

  public int getAmountHeal() {
    return amountHeal;
  }
  protected void setAmountHeal(int amountHeal) {
    this.amountHeal = amountHeal;
  }

  public int getAmountRecovered() {
    return amountRecovered;
  }
  protected void setAmountRecovered(int amountRecovered) {
    this.amountRecovered = amountRecovered;
  }
}

void generateFood(int timeAmount) {
  if (foodTotal == 1) {
    foodTotal--;
  }
  hasFoodIndexChanged = false;
  timeToGenerateFood = millis();
  intervalToGenerateFood = timeAmount;
}

void addFood() {
  if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
    if (!telaTutorialAndandoAtiva) {
      if (foodIndex >= 0 && foodIndex <= 4) {
        comidas.add(new Brigadeiro());
      } else if (foodIndex >= 5 && foodIndex <=7) {
        comidas.add(new Queijo());
      } else if (foodIndex >= 8 && foodIndex <= 9) { 
        comidas.add(new Coxinha());
      }
      foodTotal += 1;
    }
  }
}

void addFoodBoss() {
  if (estadoJogo == "MapaCoveiro") {
    foodRandomMapPositionIndex = int(random(0, valoresXMapaCoveiro.length));
    if (foodIndex >= 0 && foodIndex <= 4) {
      comidas.add(new Brigadeiro(valoresXMapaCoveiro[foodRandomMapPositionIndex], valoresYMapaCoveiro[foodRandomMapPositionIndex]));
    } else if (foodIndex >= 5 && foodIndex <=7) {
      comidas.add(new Queijo(valoresXMapaCoveiro[foodRandomMapPositionIndex], valoresYMapaCoveiro[foodRandomMapPositionIndex]));
    } else if (foodIndex >= 8 && foodIndex <= 9) { 
      comidas.add(new Coxinha(valoresXMapaCoveiro[foodRandomMapPositionIndex], valoresYMapaCoveiro[foodRandomMapPositionIndex]));
    }
    foodTotal += 1;
  }

  if (estadoJogo == "MapaFazendeiro") {
    foodRandomMapPositionIndex = int(random(0, valoresXMapaFazendeiro.length));
    if (foodIndex >= 0 && foodIndex <= 4) {
      comidas.add(new Brigadeiro(valoresXMapaCoveiro[foodRandomMapPositionIndex], valoresYMapaCoveiro[foodRandomMapPositionIndex]));
    } else if (foodIndex >= 5 && foodIndex <=7) {
      comidas.add(new Queijo(valoresXMapaCoveiro[foodRandomMapPositionIndex], valoresYMapaCoveiro[foodRandomMapPositionIndex]));
    } else if (foodIndex >= 8 && foodIndex <= 9) { 
      comidas.add(new Coxinha(valoresXMapaCoveiro[foodRandomMapPositionIndex], valoresYMapaCoveiro[foodRandomMapPositionIndex]));
    }
    foodTotal += 1;
  }

  if (estadoJogo == "MapaPadre") {
    foodRandomMapPositionIndex = int(random(0, valoresXMapaPadre.length));
    if (foodIndex >= 0 && foodIndex <= 4) {
      comidas.add(new Brigadeiro(valoresXMapaCoveiro[foodRandomMapPositionIndex], valoresYMapaCoveiro[foodRandomMapPositionIndex]));
    } else if (foodIndex >= 5 && foodIndex <=7) {
      comidas.add(new Queijo(valoresXMapaCoveiro[foodRandomMapPositionIndex], valoresYMapaCoveiro[foodRandomMapPositionIndex]));
    } else if (foodIndex >= 8 && foodIndex <= 9) { 
      comidas.add(new Coxinha(valoresXMapaCoveiro[foodRandomMapPositionIndex], valoresYMapaCoveiro[foodRandomMapPositionIndex]));
    }
    foodTotal += 1;
  }
}

void foods() {
  for (int i = comidas.size() - 1; i >= 0; --i) {
    Comida c = comidas.get(i);
    c.display();
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      c.update();
    }
    if (c.hasExitScreen() || c.hasCollided()) {
      comidas.remove(c);

      if (c.hasExitScreen()) {
        generateFood(2500);
      }
      if (c.hasCollided()) {
        heal(c.getAmountHeal(), c);
        generateFood(10000);
      }
    }
  }
}

void heal(int amount, Comida c) {
  while (playerHitpointsCurrent < prayerHitpointsMaximum && c.amountRecovered < amount) {
    c.amountRecovered++;
    playerHitpointsCurrent++;
  }
}