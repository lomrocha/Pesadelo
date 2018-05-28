private class RegularMapFoodSpawnManager extends FoodSpawnManager {
  private ArrayList<Comida> foods = new ArrayList<Comida>();

  void addFood() {
    if (getFoodTotal() == 0 && getHasFoodIndexChanged() && millis() > getTimeToGenerateFood() + getIntervalToGenerateFood() && foods.size() == 0) {
      if (getFoodIndex() >= 0 && getFoodIndex() <= 4) {
        foods.add(new Brigadeiro());
      } else if (getFoodIndex() >= 5 && getFoodIndex() <= 7) {
        foods.add(new Queijo());
      } else if (getFoodIndex() >= 8 && getFoodIndex() <= 9) { 
        foods.add(new Coxinha());
      }

      setFoodTotal(getFoodTotal() + 1);
    }
  }
}

private class BossMapFoodSpawnManager extends FoodSpawnManager {
  private ArrayList<Comida> foods = new ArrayList<Comida>();

  void addFood() {
    switch(gameState) {
    case 3:
      setFood(X_VALUES_FIRST_BOSS, Y_VALUES_FIRST_BOSS);
      break;
    case 4:
      setFood(X_VALUES_SECOND_BOSS, Y_VALUES_SECOND_BOSS);
      break;
    case 5:
      setFood(X_VALUES_THIRD_BOSS, Y_VALUES_THIRD_BOSS);
      break;
    }
  }

  void setFood(int[] xValues, int[] yValues) {
    int foodRandomMapPositionIndex = (int)random(0, xValues.length);
    if (getFoodIndex() >= 0 && getFoodIndex() <= 4) {
      foods.add(new Brigadeiro(xValues[foodRandomMapPositionIndex], yValues[foodRandomMapPositionIndex]));
    } else if (getFoodIndex() >= 5 && getFoodIndex() <= 7) {
      foods.add(new Queijo(xValues[foodRandomMapPositionIndex], yValues[foodRandomMapPositionIndex]));
    } else if (getFoodIndex() >= 8 && getFoodIndex() <= 9) { 
      foods.add(new Coxinha(xValues[foodRandomMapPositionIndex], yValues[foodRandomMapPositionIndex]));
    }

    setFoodTotal(getFoodTotal() + 1);
  }
}

abstract private class FoodSpawnManager {
  private int foodTotal;
  private int foodIndex = 10;

  private int timeToGenerateFood;
  private int intervalToGenerateFood = 10000;

  private boolean hasFoodIndexChanged;

  // FOOD_TOTAL
  public int getFoodTotal() {
    return this.foodTotal;
  }
  public void setFoodTotal(int foodTotal) {
    this.foodTotal = foodTotal;
  }

  // FOOD_INDEX
  public int getFoodIndex() {
    return this.foodIndex;
  }

  // TIME_TO_GENERATE_FOOD
  public int getTimeToGenerateFood() {
    return this.timeToGenerateFood;
  }

  // INTERVAL_TO_GENERATE_FOOD
  public int getIntervalToGenerateFood() {
    return this.intervalToGenerateFood;
  }

  // HAS_FOOD_INDEX_CHANGED
  public boolean getHasFoodIndexChanged() {
    return this.hasFoodIndexChanged;
  }

  abstract void addFood();

  void randomizeFoodIndex() {
    if (!hasFoodIndexChanged) {
      foodIndex = (int)random(0, 10);
      hasFoodIndexChanged = true;
    }
  }

  void setSpawnVariables(int timeAmount) {
    foodTotal = (foodTotal == 1) ? foodTotal-- : foodTotal;

    hasFoodIndexChanged = false;
    timeToGenerateFood = millis();
    intervalToGenerateFood = timeAmount;
  }
}
