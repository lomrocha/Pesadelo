// ------------------------------------ FIRST MAP -------------------------------------------------

private class FirstMap
{
  private Scenery firstScenery  = new Scenery( 000, 0);
  private Scenery secondScenery = new Scenery(-600, 0);
  private Scenery[] sceneries   = { firstScenery, secondScenery };

  //private TransitionGate door =  new TransitionGate(230, 0, DOOR);

  private HUD hud =  new HUD();

  //private Player player =  new Player();

  private EnemiesManager enemiesManager                           = new EnemiesManager();
  private SecondMapEnemiesSpawnManager firstMapEnemiesSpawnManager = new SecondMapEnemiesSpawnManager();

  private FoodManager foodManager                               = new FoodManager();
  private RegularMapFoodSpawnManager regularMapFoodSpawnManager = new RegularMapFoodSpawnManager();

  private ItemManager itemManager                               = new ItemManager();
  private RegularMapItemSpawnManager regularMapItemSpawnManager = new RegularMapItemSpawnManager();

  private WeaponManager weaponManager           = new WeaponManager();
  private WeaponSpawnManager weaponSpawnManager = new WeaponSpawnManager();

  //private TutorialSprite walking = new TutorialSprite(250, 90, WALKING_SPRITE);
  //private TutorialSprite attacking = new TutorialSprite(540, 60, ATTACKING_SPRITE);

  private void hud()
  {
    hud.display(weaponSpawnManager);
  }

  private void enemies()
  {
    firstMapEnemiesSpawnManager.updateSpawnState();
    firstMapEnemiesSpawnManager.states();

    enemiesManager.computeEnemy(firstMapEnemiesSpawnManager.enemies, firstMapEnemiesSpawnManager.headlessSkeletonHeads, firstMapEnemiesSpawnManager);
    enemiesManager.deleteEnemy(firstMapEnemiesSpawnManager.enemies, weaponSpawnManager.weapons, firstMapEnemiesSpawnManager);

    enemiesManager.computeEnemy(firstMapEnemiesSpawnManager.headlessSkeletonHeads, firstMapEnemiesSpawnManager.headlessSkeletonHeads, firstMapEnemiesSpawnManager);
    //enemiesManager.deleteEnemy(firstMapEnemiesSpawnManager.skeletonHeads, firstMapEnemiesSpawnManager, weaponSpawnManager.weapons);
  }

  private void scenery()
  {
    for (Scenery s : sceneries)
    {
      s.updateMovement();
      s.update();
      s.display();
    }
  }

  private void foodManager()
  {
    if (!movementTutorialScreenActive)
    {
      if (regularMapFoodSpawnManager.getFoodTotal() > 0) foodManager.computeFood(regularMapFoodSpawnManager.foods, regularMapFoodSpawnManager);

      if (!regularMapFoodSpawnManager.getHasFoodIndexChanged() && millis() > regularMapFoodSpawnManager.getTimeToGenerateFood() + regularMapFoodSpawnManager.getIntervalToGenerateFood())
      {
        regularMapFoodSpawnManager.randomizeFoodIndex();
        regularMapFoodSpawnManager.addFood();
      }
    }
  }

  private void itemManager()
  {
    if (!movementTutorialScreenActive)
    {
      if (regularMapItemSpawnManager.getItemTotal() > 0) itemManager.computeItem(regularMapItemSpawnManager.items, weaponSpawnManager, regularMapItemSpawnManager);

      if (!regularMapItemSpawnManager.getHasItemIndexChanged() &&  millis() > regularMapItemSpawnManager.getTimeToGenerateItem() + regularMapItemSpawnManager.getIntervalToGenerateItem())
      {
        regularMapItemSpawnManager.randomizeItemIndex();
        regularMapItemSpawnManager.addItem();
      }
    }
  }

  private void weaponManager()
  {
    if (regularMapItemSpawnManager.getItemTotal() == 1) 
    {
      weaponManager.computeWeapon(weaponSpawnManager.weapons);
    }
  }
}

// --------------------------------------- SECOND MAP -------------------------------------------------



// --------------------------------------- THIRD MAP -------------------------------------------------
