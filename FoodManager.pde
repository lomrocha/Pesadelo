private class FoodManager {
  private <Food extends Comida> void computeFood(ArrayList<Food> foods, FoodSpawnManager spawnManager) {
    for (int i = foods.size() - 1; i >= 0; --i) {
      Food food = foods.get(i);
      if (gameState >= GameState.FIRST_MAP.getValue() && gameState <= GameState.THIRD_MAP.getValue()) {
        food.update();
      }
      food.display();
      if (food.hasExitScreen() || food.hasCollided()) {
        foods.remove(food);
        spawnManager.setSpawnVariables(7000);

        if (food.hasCollided()) {
          heal(food.getAmountHeal(), food);
        }
      }
    }
  }

  private <Food extends Comida> void heal(int amount, Food food) {
    while (playerCurrentHP < playerHPMaximum && food.getAmountRecovered() < amount) {
      food.setAmountRecovered(food.getAmountRecovered() + 1);
      playerCurrentHP++;
    }
  }
}
