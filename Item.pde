ArrayList<Item> itens = new ArrayList<Item>();

public class Item extends Geral {
  private int itemIndex;
  private int itemTotal;

  public int getItemIndex() {
    return itemIndex;
  }
  protected void setItemIndex(int itemIndex) {
    this.itemIndex = itemIndex;
  }

  public int getItemTotal() {
    return itemTotal;
  }
  protected void setItemTotal(int itemTotal) {
    this.itemTotal = itemTotal;
  }
}

void item() {  
  for (int i = itens.size() - 1; i >= 0; i = i - 1) {
    Item it = itens.get(i);
    if (gameState >= GameState.FIRSTMAP.ordinal() && gameState <= GameState.THIRDMAP.ordinal()) {
      it.update();
    }
    it.display();
    if (it.hasExitScreen() || it.hasCollided()) {
      itens.remove(it);

      if (it.hasExitScreen()) {
        generateItem(2500);
      }
      if (it.hasCollided()) {
        item = it.getItemIndex();
        weaponTotal = it.getItemTotal();
      }
    }
  }
}

void generateItem(int timeAmount) {
  if (itemTotal == 1) {
    itemTotal--;
  }
  
  hasItemIndexChanged = false;
  timeToGenerateItem = millis();
  intervalToGenerateItem = timeAmount;
}

void addItem() {
  if (!movementTutorialScreenActive) {
    if (itemIndex >= 0 && itemIndex <= 4) {
      itens.add(new Pa());
    } else if (itemIndex >= 5 && itemIndex <= 9) {
      itens.add(new Chicote());
    }

    itemTotal++;
  }
}

void addItemBoss() {
  if (gameState == GameState.FIRSTBOSS.ordinal()) {
    itemRandomMapPositionIndex = int(random(0, valoresXPrimeiroMapaBoss.length));
    if (itemIndex >= 0 && itemIndex <= 4) {
      itens.add(new Pa(valoresXPrimeiroMapaBoss[itemRandomMapPositionIndex], valoresYPrimeiroMapaBoss[itemRandomMapPositionIndex]));
    } else if (itemIndex >= 5 && itemIndex <= 9) {
      itens.add(new Chicote(valoresXPrimeiroMapaBoss[itemRandomMapPositionIndex], valoresYPrimeiroMapaBoss[itemRandomMapPositionIndex]));
    }

    itemTotal++;
  }

  if (gameState == GameState.SECONDBOSS.ordinal()) {
    itemRandomMapPositionIndex = int(random(0, valoresXSegundoMapaBoss.length));
    if (itemIndex >= 0 && itemIndex <= 4) {
      itens.add(new Pa(valoresXSegundoMapaBoss[itemRandomMapPositionIndex], valoresYSegundoMapaBoss[itemRandomMapPositionIndex]));
    } else if (itemIndex >= 5 && itemIndex <= 9) {
      itens.add(new Chicote(valoresXSegundoMapaBoss[itemRandomMapPositionIndex], valoresYSegundoMapaBoss[itemRandomMapPositionIndex]));
    }

    itemTotal++;
  }

  if (gameState == GameState.THIRDBOSS.ordinal()) {
    itemRandomMapPositionIndex = int(random(0, valoresXTerceiroMapaBoss.length));
    if (itemIndex >= 0 && itemIndex <= 4) {
      itens.add(new Pa(valoresXTerceiroMapaBoss[itemRandomMapPositionIndex], valoresYTerceiroMapaBoss[itemRandomMapPositionIndex]));
    } else if (itemIndex >= 5 && itemIndex <= 9) {
      itens.add(new Chicote(valoresXTerceiroMapaBoss[itemRandomMapPositionIndex], valoresYTerceiroMapaBoss[itemRandomMapPositionIndex]));
    }

    itemTotal++;
  }
}