private class EnemiesManager {
  private <E extends Enemy> void computeEnemy(ArrayList<E> inimigos, EnemiesSpawnManager spawnManager) {
    for (int i = inimigos.size() - 1; i >= 0; i = i - 1) {
      E enemy = inimigos.get(i);
      if (enemy.getType() == KICKING_SKELETON) {
        if (enemy.getKickingSkeletonHasKicked()) {
          cabecasEsqueleto.add(new CabecaEsqueleto(enemy.getX(), enemy.getY()));
          enemy.setKickingSkeletonHasKicked(false);
        }
      }
      enemy.updateTarget();
      enemy.updateMovement();
      enemy.update();
      enemy.display();
      if (enemy.hasExitScreen()) {
        handleSpawnManagerVariables(enemy, spawnManager);
        inimigos.remove(enemy);
      }
      if (enemy.hasCollided()) {
        damage(enemy.getDamage());
      }
    }
  }

  private <E extends Enemy> void deleteEnemy(ArrayList<E> inimigos, EnemiesSpawnManager spawnManager) {
    for (int i = inimigos.size() - 1; i >= 0; i--) {
      E enemy = inimigos.get(i);
      for (int j = weapons.size() - 1; j >= 0; j--) {
        Weapon arma = weapons.get(j);
        if (arma.hasHit(enemy)) {
          handleSpawnManagerVariables(enemy, spawnManager);
          hitInimigos(enemy.getX() - 40, enemy.getY() - 20);
          inimigos.remove(enemy);
        }
      }
    }
  }

  private void handleSpawnManagerVariables(Enemy enemy, EnemiesSpawnManager spawnManager) {
    if (enemy.getType() != SKELETON_HEAD) {
      switch(enemy.getType()) {
      case SKELETON:
        spawnManager.setSkeletonTotal(spawnManager.getSkeletonTotal() - 1);
        break;
      case KICKING_SKELETON:
        spawnManager.setKickingSkeletonTotal(spawnManager.getKickingSkeletonTotal() - 1);
        break;
      case SKELETON_DOG:
        spawnManager.setSkeletonDogTotal(spawnManager.getSkeletonDogTotal() - 1);
        break;
      case SKELETON_CROW:
        spawnManager.setSkeletonCrowTotal(spawnManager.getSkeletonCrowTotal() - 1);
        break;
      case RED_SKELETON:
        spawnManager.setRedSkeletonTotal(spawnManager.getRedSkeletonTotal() - 1);
        break;
      }
      spawnManager.setEnemiesTotal(spawnManager.getEnemiesTotal() - 1);
    }
  }

  private void damage(int amount) {
    if (!isPlayerImmune) {
      playerCurrentHP -= amount;
      isPlayerImmune = true;
      timeImmune = millis();
    }
  }
}
