class EnemiesManager {

  <Enemy extends Inimigo, KickingSkeleton extends EsqueletoChute> void computeEnemy(ArrayList<Enemy> inimigos, ArrayList<KickingSkeleton> kicks) {
    for (int i = inimigos.size() - 1; i >= 0; i = i - 1) {
      Enemy enemy = inimigos.get(i);
      KickingSkeleton kick = kicks.get(i);
      enemy.updateMovement();
      enemy.update();
      enemy.display();
      if(enemy == kick){
        println("igual");
      }
      if (enemy.hasExitScreen()) {
        inimigos.remove(enemy);
        if (enemy.getType() != TypeOfEnemy.SKELETON_HEAD.ordinal()) {
          if (enemy.getType() == TypeOfEnemy.SKELETON.ordinal()) {
            firstMapEnemiesSpawnManager.skeletonTotal--;
          }
          if (enemy.getType() == TypeOfEnemy.KICKING_SKELETON.ordinal()) {
            firstMapEnemiesSpawnManager.kickingSkeletonTotal--;
          }
          firstMapEnemiesSpawnManager.setEnemiesTotal(firstMapEnemiesSpawnManager.getEnemiesTotal() - 1);
        }
      }
      if (enemy.hasCollided()) {
        damage(enemy.getDamage());
      }
    }
  }

  void damage(int amount) {
    if (!isPlayerImmune) {
      playerCurrentHP -= amount;
      isPlayerImmune = true;
      timeImmune = millis();
    }
  }
}