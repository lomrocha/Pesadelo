// ------------------------------------ FOOD -------------------------------------------------

final int BRIGADEIRO = 0;
final int QUEIJO     = 1;
final int COXINHA    = 2;

PImage foodShadow;

private class Food extends BaseMovement 
{
  private int amountHeal;
  private int amountRecovered;

  private boolean isDisabled;

  // AMOUNT HEAL
  public int getAmountHeal() 
  {
    return amountHeal;
  }
  protected void setAmountHeal(int amountHeal) 
  {
    this.amountHeal = amountHeal;
  }

  // AMOUNT RECOVERED
  public int getAmountRecovered() 
  {
    return amountRecovered;
  }
  protected void setAmountRecovered(int amountRecovered) 
  {
    this.amountRecovered = amountRecovered;
  }

  // IS DISABLED
  public boolean getIsDisabled()
  {
    return isDisabled;
  }
  protected void setIsDisabled(boolean isDisabled)
  {
    this.isDisabled = isDisabled;
  }

  // Reset the position of the food object to the top of the screen.
  // Make it disabled so it won't move.
  // Reset the amount of health it has recovered.
  void resetVariables()
  {
    setSelf(new PVector((int)random(100, 670), -200));
    setIsDisabled(true);
    setAmountRecovered(0);
  }
}

// -------------------------------------- COXINHA ---------------------------------------------------

PImage coxinhaImage;

final int COXINHA_HEAL = 5;

private class Coxinha extends Food 
{
  Coxinha(int x, int y) 
  {
    setValues(x, y, OBJECT_WITHOUT_SHADOW);
  }

  Coxinha() 
  {
    setValues((int)random(100, 670), -50, OBJECT_WITH_SHADOW);
  }

  private void setValues(int x, int y, int index) 
  {
    this.setSelf(new PVector(x, y));

    this.setTypeOfObject(index);

    this.setShadowImage(foodShadow);
    this.setShadowOffset(new PVector(0, 20));

    this.setSpriteImage(coxinhaImage);
    this.setSpriteInterval(75);
    this.setSpriteWidth(28);
    this.setSpriteHeight(30);
    this.setMotionY(SCENERY_VELOCITY / 2);

    this.setAmountHeal(COXINHA_HEAL);
    this.setAmountRecovered(0);

    this.setIsDisabled(true);
  }
}

// -------------------------------------- BRIGADEIRO ---------------------------------------------------

PImage brigadeiroImage;

final int BRIGADEIRO_HEAL = 3;

private class Brigadeiro extends Food 
{
  Brigadeiro(int x, int y) 
  {
    setValues(x, y, OBJECT_WITHOUT_SHADOW);
  }

  Brigadeiro() 
  {
    setValues((int)random(100, 670), -50, OBJECT_WITH_SHADOW);
  }

  private void setValues(int x, int y, int index) 
  {
    this.setSelf(new PVector(x, y));

    this.setTypeOfObject(index);

    this.setShadowImage(foodShadow);
    this.setShadowOffset(new PVector(0, 20));

    this.setSpriteImage(brigadeiroImage);
    this.setSpriteInterval(75);
    this.setSpriteWidth(32);
    this.setSpriteHeight(31);
    this.setMotionY(SCENERY_VELOCITY / 2);

    this.setAmountHeal(BRIGADEIRO_HEAL);
    this.setAmountRecovered(0);

    this.setIsDisabled(true);
  }
}

// ------------------------------------ PÃO DE QUEIJO -------------------------------------------------

PImage queijoImage;

final int QUEIJO_HEAL = 4;

private class Queijo extends Food 
{
  Queijo(int x, int y) 
  {
    setValues(x, y, OBJECT_WITHOUT_SHADOW);
  }

  public Queijo() 
  {
    setValues((int)random(100, 670), -50, OBJECT_WITH_SHADOW);
  }

  private void setValues(int x, int y, int index) 
  {
    this.setSelf(new PVector(x, y));

    this.setShadowImage(foodShadow);
    this.setShadowOffset(new PVector(0, 19));

    this.setTypeOfObject(index);

    this.setSpriteImage(queijoImage);
    this.setSpriteInterval(75);
    this.setSpriteWidth(31);
    this.setSpriteHeight(29);
    this.setMotionY(SCENERY_VELOCITY / 2);

    this.setAmountHeal(QUEIJO_HEAL);
    this.setAmountRecovered(0);

    this.setIsDisabled(true);
  }
}

// ------------------------------------ FOOD MANAGER -------------------------------------------------

private class FoodManager 
{
  private <T_Food extends Food> void computeFood(ArrayList<T_Food> foods, FoodSpawnManager spawnManager) 
  {
    for (int i = 0; i < foods.size(); ++i) 
    {
      Food food = foods.get(i);

      // Only the food that is not disabled can be updated and displayed.
      if (!food.getIsDisabled()) 
      { 

        if (gameState >= GameState.FIRST_MAP.getValue() && gameState <= GameState.THIRD_MAP.getValue()) 
        {
          food.update();
        }

        food.display();
        if (food.hasExitScreen() || food.hasCollided()) 
        { 

          if (food.hasCollided()) 
          {
            heal(food.getAmountHeal(), food);
          }

          food.resetVariables();
          spawnManager.setSpawnVariables(7000);
        }
      }
    }
  }

  private <T_Food extends Food> void heal(int amount, T_Food food) 
  {
    while (playerCurrentHP < playerHPMaximum && food.getAmountRecovered() < amount) 
    {
      food.setAmountRecovered(food.getAmountRecovered() + 1);
      playerCurrentHP++;
    }
  }
}

// ------------------------------------ FOOD SPAWN MANAGER -------------------------------------------------

abstract private class FoodSpawnManager 
{
  private int foodTotal;
  private int foodIndex = 10;

  private int timeToGenerateFood;
  private int intervalToGenerateFood = 10000;

  private boolean hasFoodIndexChanged;

  // FOOD_TOTAL
  public int getFoodTotal() 
  {
    return this.foodTotal;
  }
  public void setFoodTotal(int foodTotal) 
  {
    this.foodTotal = foodTotal;
  }

  // FOOD_INDEX
  public int getFoodIndex() 
  {
    return this.foodIndex;
  }

  // TIME_TO_GENERATE_FOOD
  public int getTimeToGenerateFood() 
  {
    return this.timeToGenerateFood;
  }

  // INTERVAL_TO_GENERATE_FOOD
  public int getIntervalToGenerateFood() 
  {
    return this.intervalToGenerateFood;
  }

  // HAS_FOOD_INDEX_CHANGED
  public boolean getHasFoodIndexChanged() 
  {
    return this.hasFoodIndexChanged;
  }

  abstract void addFood();

  void randomizeFoodIndex() 
  {
    while (!hasFoodIndexChanged) 
    {
      int newFoodIndex = (int)random(0, 10);

      if (newFoodIndex != foodIndex) 
      {
        foodIndex = newFoodIndex;
        hasFoodIndexChanged = true;
      }
    }
  }

  void setSpawnVariables(int timeAmount) 
  {
    foodTotal = 0;

    hasFoodIndexChanged    = false;
    timeToGenerateFood     = millis();
    intervalToGenerateFood = timeAmount;
  }
}

// ------------------------------- REGULAR MAP FOOD SPAWN MANAGER -------------------------------------

private class RegularMapFoodSpawnManager extends FoodSpawnManager 
{
  private ArrayList<Food> foods = new ArrayList<Food>();

  RegularMapFoodSpawnManager()
  {
    foods.add(new Brigadeiro());
    foods.add(new Queijo());
    foods.add(new Coxinha());
  }

  void addFood() 
  {
    if (getFoodTotal() == 0 && getHasFoodIndexChanged()) 
    {
      if (getFoodIndex() >= 0 && getFoodIndex() <= 4) 
      {
        foods.get(BRIGADEIRO).setIsDisabled(false);
      } 
      else if (getFoodIndex() >= 5 && getFoodIndex() <= 7) 
      {
        foods.get(QUEIJO).setIsDisabled(false);
      } 
      else if (getFoodIndex() >= 8 && getFoodIndex() <= 9) 
      { 
        foods.get(COXINHA).setIsDisabled(false);
      }

      setFoodTotal(getFoodTotal() + 1);
    }
  }
}

// ------------------------------- BOSS MAP FOOD SPAWN MANAGER -------------------------------------

private class BossMapFoodSpawnManager extends FoodSpawnManager 
{
  private ArrayList<Food> foods = new ArrayList<Food>();

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

  void setFood(int[] xValues, int[] yValues) 
  {
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

// ------------------------------------ EXTRA -------------------------------------------------

//void foodAll() {
//  generateFoodIndex();

//  if (foodTotal == 0 && hasFoodIndexChanged && millis() > timeToGenerateFood + intervalToGenerateFood && Foods.size() == 0) {
//    if (gameState >= GameState.FIRSTMAP.getValue() && gameState <= GameState.THIRDMAP.getValue()) {
//      addFood();
//    } else if (gameState >= GameState.FIRSTBOSS.getValue() && gameState <= GameState.THIRDBOSS.getValue()) {
//      addFoodBoss();
//    }
//  }

//  if (Foods.size() > 0) {
//    foods();
//  }
//}
