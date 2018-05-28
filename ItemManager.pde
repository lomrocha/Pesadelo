private class ItemManager {
  private void computeItem(ArrayList<Item> items, ItemSpawnManager itemSpawnManager, WeaponSpawnManager weaponSpawnManager) {  
    for (int i = items.size() - 1; i >= 0; i = i - 1) {
      Item it = items.get(i);
      if (gameState >= GameState.FIRST_MAP.getValue() && gameState <= GameState.THIRD_MAP.getValue()) {
        it.update();
      }
      it.display();
      if (it.hasExitScreen() || it.hasCollided()) {
        items.remove(it);
        itemSpawnManager.setSpawnVariables(7000);

        if (it.hasCollided()) {
          weaponSpawnManager.setItemIndex(it.getItemIndex());
          weaponSpawnManager.setWeaponTotal(it.getItemTotal());
        }
      }
    }
  }
}

private class WeaponSpawnManager{
  private int itemIndex;
  private int weaponTotal;
  
  // ITEM_INDEX
  public void setItemIndex(int itemIndex){
    this.itemIndex = itemIndex;
  }
  
  // WEAPON_TOTAL
  public int getWeaponTotal(){
    return this.weaponTotal;
  }
  public void setWeaponTotal(int weaponTotal){
    this.weaponTotal = weaponTotal;
  }
}
