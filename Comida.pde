//void foodAll() {
//  generateFoodIndex();

//  if (foodTotal == 0 && hasFoodIndexChanged && millis() > timeToGenerateFood + intervalToGenerateFood && comidas.size() == 0) {
//    if (gameState >= GameState.FIRSTMAP.getValue() && gameState <= GameState.THIRDMAP.getValue()) {
//      addFood();
//    } else if (gameState >= GameState.FIRSTBOSS.getValue() && gameState <= GameState.THIRDBOSS.getValue()) {
//      addFoodBoss();
//    }
//  }

//  if (comidas.size() > 0) {
//    foods();
//  }
//}

PImage foodShadow;

private class Comida extends Geral {
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
