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
    if (gameState >= GameState.FIRSTMAP.ordinal() && gameState <= GameState.THIRDMAP.ordinal()) {
      addFood();
    } else if (gameState >= GameState.FIRSTBOSS.ordinal() && gameState <= GameState.THIRDBOSS.ordinal()) {
      addFoodBoss();
    }
  }

  if (comidas.size() > 0) {
    foods();
  }
}

void generateFoodIndex() {
  if (!movementTutorialScreenActive) {
    if (!hasFoodIndexChanged) {
      foodIndex = int(random(0, 10));
      hasFoodIndexChanged = true;
    }
  }
}

ArrayList<Comida> comidas = new ArrayList<Comida>();

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
  if (!movementTutorialScreenActive) {
    if (foodIndex >= 0 && foodIndex <= 4) {
      comidas.add(new Brigadeiro());
    } else if (foodIndex >= 5 && foodIndex <=7) {
      comidas.add(new Queijo());
    } else if (foodIndex >= 8 && foodIndex <= 9) { 
      comidas.add(new Coxinha());
    }

    foodTotal++;
  }
}

<Food extends Comida> void x(Food food, ArrayList<Food> foods){
  foods.add(food);
}

void addFoodBoss() {
  if (gameState == GameState.FIRSTBOSS.ordinal()) {
    foodRandomMapPositionIndex = int(random(0, X_VALUES_FIRST_BOSS.length));
    if (foodIndex >= 0 && foodIndex <= 4) {
      comidas.add(new Brigadeiro(X_VALUES_FIRST_BOSS[foodRandomMapPositionIndex], Y_VALUES_FIRST_BOSS[foodRandomMapPositionIndex]));
    } else if (foodIndex >= 5 && foodIndex <=7) {
      comidas.add(new Queijo(X_VALUES_FIRST_BOSS[foodRandomMapPositionIndex], Y_VALUES_FIRST_BOSS[foodRandomMapPositionIndex]));
    } else if (foodIndex >= 8 && foodIndex <= 9) { 
      comidas.add(new Coxinha(X_VALUES_FIRST_BOSS[foodRandomMapPositionIndex], Y_VALUES_FIRST_BOSS[foodRandomMapPositionIndex]));
    }

    foodTotal++;
  }

  if (gameState == GameState.SECONDBOSS.ordinal()) {
    foodRandomMapPositionIndex = int(random(0, X_VALUES_SECOND_BOSS.length));
    if (foodIndex >= 0 && foodIndex <= 4) {
      comidas.add(new Brigadeiro(X_VALUES_SECOND_BOSS[foodRandomMapPositionIndex], Y_VALUES_SECOND_BOSS[foodRandomMapPositionIndex]));
    } else if (foodIndex >= 5 && foodIndex <=7) {
      comidas.add(new Queijo(X_VALUES_SECOND_BOSS[foodRandomMapPositionIndex], Y_VALUES_SECOND_BOSS[foodRandomMapPositionIndex]));
    } else if (foodIndex >= 8 && foodIndex <= 9) { 
      comidas.add(new Coxinha(X_VALUES_SECOND_BOSS[foodRandomMapPositionIndex], Y_VALUES_SECOND_BOSS[foodRandomMapPositionIndex]));
    }
    
    foodTotal++;
  }

  if (gameState == GameState.THIRDBOSS.ordinal()) {
    foodRandomMapPositionIndex = int(random(0, X_VALUES_THIRD_BOSS.length));
    if (foodIndex >= 0 && foodIndex <= 4) {
      comidas.add(new Brigadeiro(X_VALUES_THIRD_BOSS[foodRandomMapPositionIndex], Y_VALUES_THIRD_BOSS[foodRandomMapPositionIndex]));
    } else if (foodIndex >= 5 && foodIndex <=7) {
      comidas.add(new Queijo(X_VALUES_THIRD_BOSS[foodRandomMapPositionIndex], Y_VALUES_THIRD_BOSS[foodRandomMapPositionIndex]));
    } else if (foodIndex >= 8 && foodIndex <= 9) { 
      comidas.add(new Coxinha(X_VALUES_THIRD_BOSS[foodRandomMapPositionIndex], Y_VALUES_THIRD_BOSS[foodRandomMapPositionIndex]));
    }
    foodTotal++;
  }
}

void foods() {
  for (int i = comidas.size() - 1; i >= 0; --i) {
    Comida c = comidas.get(i);
    c.display();
    if (gameState >= GameState.FIRSTMAP.ordinal() && gameState <= GameState.THIRDMAP.ordinal()) {
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
  while (playerCurrentHP < prayerHPMaximum && c.amountRecovered < amount) {
    c.amountRecovered++;
    playerCurrentHP++;
  }
}