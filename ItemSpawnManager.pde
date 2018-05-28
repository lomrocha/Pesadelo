private class RegularMapItemSpawnManager extends ItemSpawnManager {
  private ArrayList<Item> items = new ArrayList<Item>();

  protected void addItem() {
    if (getItemTotal() == 0 && getHasItemIndexChanged() && millis() > getTimeToGenerateItem() + getIntervalToGenerateItem() && items.size() == 0) {
      if (getItemIndex() >= 0 && getItemIndex() <= 4) {
        items.add(new Pa());
      } else if (getItemIndex() >=5 && getItemIndex() <= 9) {
        items.add(new Chicote());
      }

      setItemTotal(getItemTotal() + 1);
    }
  }
}

private class BossMapItemSpawnManager extends ItemSpawnManager {
  private ArrayList<Item> items = new ArrayList<Item>();

  protected void addItem() {
    switch(gameState) {
    case 3:
      setItem(X_VALUES_FIRST_BOSS, Y_VALUES_FIRST_BOSS);
      break;
    case 4:
      setItem(X_VALUES_SECOND_BOSS, Y_VALUES_SECOND_BOSS);
      break;
    case 5:
      setItem(X_VALUES_THIRD_BOSS, Y_VALUES_THIRD_BOSS);
      break;
    }
  }

  private void setItem(int[] xValues, int[] yValues) {
    int itemRandomMapPositionIndex = (int)random(0, xValues.length);
    if (getItemIndex() >= 0 && getItemIndex() <= 4) {
      items.add(new Pa(xValues[itemRandomMapPositionIndex], yValues[itemRandomMapPositionIndex]));
    } else if (getItemIndex() >= 5 && getItemIndex() <= 9) {
      items.add(new Chicote(xValues[itemRandomMapPositionIndex], yValues[itemRandomMapPositionIndex]));
    }

    setItemTotal(getItemTotal() + 1);
  }
}

abstract private class ItemSpawnManager {
  private int itemTotal;
  private int itemIndex = 10;

  private int timeToGenerateItem;
  private int intervalToGenerateItem = 10000;

  private boolean hasItemIndexChanged;

  // ITEM_TOTAL
  public int getItemTotal() {
    return this.itemTotal;
  }
  public void setItemTotal(int itemTotal) {
    this.itemTotal = itemTotal;
  }

  // ITEM_INDEX
  public int getItemIndex() {
    return this.itemIndex;
  }

  // TIME_TO_GENERATE_ITEM
  public int getTimeToGenerateItem() {
    return this.timeToGenerateItem;
  }

  // INTERVAL_TO_GENERATE_ITEM
  public int getIntervalToGenerateItem() {
    return this.intervalToGenerateItem;
  }

  // HAS_ITEM_INDEX_CHANGED
  public boolean getHasItemIndexChanged() {
    return this.hasItemIndexChanged;
  }

  abstract protected void addItem();

  void randomizeItemIndex() {
    if (!hasItemIndexChanged) {
      itemIndex = (int)random(0, 10);
      hasItemIndexChanged = true;
    }
  }

  void setSpawnVariables(int timeAmount) {
    itemTotal = (itemTotal == 1) ? itemTotal-- : itemTotal;

    hasItemIndexChanged = false;
    timeToGenerateItem = millis();
    intervalToGenerateItem = timeAmount;
  }
}
