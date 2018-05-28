private class Item extends Geral {
  private int itemIndex;
  private int itemTotal;

  // ITEM_INDEX
  public int getItemIndex() {
    return this.itemIndex;
  }
  protected void setItemIndex(int itemIndex) {
    this.itemIndex = itemIndex;
  }

  // ITEM_TOTAL
  public int getItemTotal() {
    return this.itemTotal;
  }
  protected void setItemTotal(int itemTotal) {
    this.itemTotal = itemTotal;
  }
}
