abstract private class EnemiesSpawnManager {
  private int spawnState = 1;

  private int skeletonTotal;
  private int kickingSkeletonTotal;
  private int skeletonDogTotal;
  private int skeletonCrowTotal;
  private int redSkeletonTotal;

  private int enemiesTotal;

  private int[] maximumModifier;
  
  // SKELETON_TOTAL
  public int getSkeletonTotal() {
    return this.skeletonTotal;
  }
  public void setSkeletonTotal(int skeletonTotal) {
    this.skeletonTotal = skeletonTotal;
  }
  
  // KICKING_SKELETON_TOTAL
  public int getKickingSkeletonTotal() {
    return this.kickingSkeletonTotal;
  }
  public void setKickingSkeletonTotal(int kickingSkeletonTotal) {
    this.kickingSkeletonTotal = kickingSkeletonTotal;
  }
  
  // SKELETON_DOG_TOTAL
  public int getSkeletonDogTotal() {
    return this.skeletonDogTotal;
  }
  public void setSkeletonDogTotal(int skeletonDogTotal) {
    this.skeletonDogTotal = skeletonDogTotal;
  }
  
  // SKELETON_CROW_TOTAL
  public int getSkeletonCrowTotal() {
    return this.skeletonCrowTotal;
  }
  public void setSkeletonCrowTotal(int skeletonCrowTotal) {
    this.skeletonCrowTotal = skeletonCrowTotal;
  }
  
  // RED_SKELETON_TOTAL
  public int getRedSkeletonTotal() {
    return this.redSkeletonTotal;
  }
  public void setRedSkeletonTotal(int redSkeletonTotal) {
    this.redSkeletonTotal = redSkeletonTotal;
  }

  // ENEMIES_TOTAL
  public int getEnemiesTotal() {
    return this.enemiesTotal;
  }
  public void setEnemiesTotal(int enemiesTotal) {
    this.enemiesTotal = enemiesTotal;
  }

  // MAXIMUM_MODIFIER
  public int[] getMaximumModifier() {
    return this.maximumModifier;
  }
  public void setMaximumModifier(int[] maximumModifier) {
    this.maximumModifier = maximumModifier;
  }

  void setVariables() {
    spawnState = (numberOfSceneries % 7 == 0 && numberOfSceneries != 0) ? (numberOfSceneries / 7) + 1 : spawnState;
  }

  void states() {
    if (!movementTutorialScreenActive) {
      switch (spawnState) {
      case 1:
        firstBatch();
        break;
      case 2:
        secondBatch();
        break;
      case 3:
        thirdBatch();
        break;
      case 4:
        fourthBatch();
        break;
      case 5:
        fifthBatch();
        break;
      case 6:
        sixthBatch();
        break;
      }
    }
  }

  abstract void firstBatch();

  abstract void secondBatch();

  abstract void thirdBatch();

  abstract void fourthBatch();

  abstract void fifthBatch();

  abstract void sixthBatch();
}
