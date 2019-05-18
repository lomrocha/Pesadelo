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
  private FirstMapEnemiesSpawnManager firstMapEnemiesSpawnManager = new FirstMapEnemiesSpawnManager(ENEMIES_MAXIMUM_FIRST_MAP);

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
    enemiesManager.computeEnemy(firstMapEnemiesSpawnManager.skeletons, firstMapEnemiesSpawnManager);
    enemiesManager.deleteEnemy(firstMapEnemiesSpawnManager.skeletons, firstMapEnemiesSpawnManager, weaponSpawnManager.weapons);
    
    //enemiesManager.computeEnemy(firstMapEnemiesSpawnManager.kickingSkeletons, firstMapEnemiesSpawnManager);
    //enemiesManager.deleteEnemy(firstMapEnemiesSpawnManager.kickingSkeletons, firstMapEnemiesSpawnManager, weaponSpawnManager.weapons);
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
      foodManager.computeFood(regularMapFoodSpawnManager.foods, regularMapFoodSpawnManager);
      regularMapFoodSpawnManager.randomizeFoodIndex();
      regularMapFoodSpawnManager.addFood();
    }
  }

  private void itemManager()
  {
    if (!movementTutorialScreenActive)
    {
      itemManager.computeItem(regularMapItemSpawnManager.items, weaponSpawnManager);
      regularMapItemSpawnManager.randomizeItemIndex();
      regularMapItemSpawnManager.addItem();
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
