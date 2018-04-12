public abstract class EnemiesSpawnManager {
  private int spawnState = 1;

  private int enemiesTotal;
  private int enemiesMaximum;

  private int[] maximumModifier;

  public int getSpawnState()  {
    return this.spawnState;
  }
  public void setSpawnState(int spawnState)
  {
    this.spawnState = spawnState;
  }

  public int getEnemiesTotal() {
    return this.enemiesTotal;
  }
  public void setEnemiesTotal(int enemiesTotal) {
    this.enemiesTotal = enemiesTotal;
  }

  public int getEnemiesMaximum() {
    return this.enemiesMaximum;
  }
  public void setEnemiesMaximum(int enemiesMaximum) {
    this.enemiesMaximum = enemiesMaximum;
  }

  public int[] getMaximumModifier() {
    return this.maximumModifier;
  }
  public void setMaximumModifier(int[] maximumModifier) {
    this.maximumModifier = maximumModifier;
  }

  EnemiesSpawnManager(int[] maximumModifier) {
    this.maximumModifier = maximumModifier;
  }

  void setVariables() {
    spawnState = (numberOfSceneries % 7 == 0 && numberOfSceneries != 0) ? (numberOfSceneries / 7) + 1 : spawnState;

    enemiesMaximum = maximumModifier[spawnState - 1];
  }

  void states() {
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

  abstract void firstBatch();

  abstract void secondBatch();

  abstract void thirdBatch();

  abstract void fourthBatch();

  abstract void fifthBatch();

  abstract void sixthBatch();
}