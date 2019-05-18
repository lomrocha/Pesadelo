// ------------------------------------ FIRST MAP -------------------------------------------------

private class FirstMap {
  private Scenery firstScenery  = new Scenery( 000, 0);
  private Scenery secondScenery = new Scenery(-600, 0);
  private Scenery[] sceneries = new Scenery[2];

  //private TransitionGate door =  new TransitionGate(230, 0, DOOR);

  private HUD hud =  new HUD();

  //private Player player =  new Player();

  private EnemiesManager enemiesManager = new EnemiesManager();
  private FirstMapEnemiesSpawnManager firstMapEnemiesSpawnManager = new FirstMapEnemiesSpawnManager(ENEMIES_MAXIMUM_FIRST_MAP);

  private FoodManager foodManager = new FoodManager();
  private RegularMapFoodSpawnManager regularMapFoodSpawnManager = new RegularMapFoodSpawnManager();
  
  private ItemManager itemManager = new ItemManager();
  private RegularMapItemSpawnManager regularMapItemSpawnManager = new RegularMapItemSpawnManager();
  
  private WeaponSpawnManager weaponSpawnManager = new WeaponSpawnManager();

  //private TutorialSprite walking = new TutorialSprite(250, 90, WALKING_SPRITE);
  //private TutorialSprite attacking = new TutorialSprite(540, 60, ATTACKING_SPRITE);

  FirstMap() {
    addScenery();
  }
  
  private void hud(){
    hud.display();
  }

  private void enemies() {
    enemiesManager.computeEnemy(firstMapEnemiesSpawnManager.skeletons, firstMapEnemiesSpawnManager);
    enemiesManager.deleteEnemy(firstMapEnemiesSpawnManager.skeletons, firstMapEnemiesSpawnManager);
    enemiesManager.computeEnemy(firstMapEnemiesSpawnManager.kickingSkeletons, firstMapEnemiesSpawnManager);
    enemiesManager.deleteEnemy(firstMapEnemiesSpawnManager.kickingSkeletons, firstMapEnemiesSpawnManager);
  }

  private void addScenery() {
    sceneries[0] = firstScenery;
    sceneries[1] = secondScenery;
  }

  private void scenery() {
    for (Scenery s : sceneries) {
      s.updateMovement();
      s.update();
      s.display();
    }
  }
  
  private void itemManager() {
    if (!movementTutorialScreenActive) {
      itemManager.computeItem(regularMapItemSpawnManager.items, regularMapItemSpawnManager, weaponSpawnManager);
      regularMapItemSpawnManager.randomizeItemIndex();
      regularMapItemSpawnManager.addItem();
    }
  }

  private void foodManager() {
    if (!movementTutorialScreenActive) {
      foodManager.computeFood(regularMapFoodSpawnManager.foods, regularMapFoodSpawnManager);
      regularMapFoodSpawnManager.randomizeFoodIndex();
      regularMapFoodSpawnManager.addFood();
    }
  }
}

// ------------------------------------ SECOND MAP -------------------------------------------------

// ------------------------------------ THIRD MAP -------------------------------------------------
