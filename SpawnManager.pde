private class FirstMapEnemiesSpawnManager extends EnemiesSpawnManager {
  private ArrayList<Esqueleto> skeletons = new ArrayList<Esqueleto>();
  private ArrayList<EsqueletoChute> kickingSkeletons = new ArrayList<EsqueletoChute>();

  final int[] SKELETON_MAXIMUM = {2, 1, 2, 2, 3};
  final int[] KICKING_SKELETON_MAXIMUM = {0, 1, 1, 2, 2};

  private int skeletonRow = 0;
  private int skeletonColumn = 0;
  private int kickingSkeletonRow = 0;
  private int kickingSkeletonColumn = 0;

  private PVector skeletonLastPosition = new PVector(1, 1);
  private PVector kickingSkeletonLastPosition = new PVector(1, 1);

  FirstMapEnemiesSpawnManager(int[] maximumModifier) {
    setMaximumModifier(maximumModifier);
  }

  void setSkeletonPosition() {    
    while (SKELETON_POSITIONS[skeletonRow][skeletonColumn] != SKELETON) {
      skeletonRow = int(random(0, 5));
      skeletonColumn = int(random(0, 8));

      PVector newPosition = new PVector(skeletonRow, skeletonColumn);
      if (newPosition == skeletonLastPosition) {
        skeletonRow = 1;
        skeletonColumn = 1;
      }
    }
  }

  void setKickingSkeletonPosition() {
    while (KICKING_SKELETON_POSITIONS[kickingSkeletonRow][kickingSkeletonColumn] != KICKING_SKELETON) {
      kickingSkeletonRow = int(random(0, 8));
      kickingSkeletonColumn = int(random(0, 12));

      PVector newPosition = new PVector(kickingSkeletonRow, kickingSkeletonColumn);
      if (newPosition == kickingSkeletonLastPosition) {
        kickingSkeletonRow = 1;
        kickingSkeletonColumn = 1;
      }
    }
  }

  void firstBatch() {
    int max = getMaximumModifier()[0];

    while (getEnemiesTotal() < max) {
      if (getSkeletonTotal() < SKELETON_MAXIMUM[0]) {
        setSkeletonPosition();

        skeletons.add(new Esqueleto(100 + (skeletonColumn * 75), -120 - (skeletonRow * 120)));
        
        skeletonLastPosition = new PVector(skeletonRow, skeletonColumn);

        skeletonRow = 4;
        skeletonColumn = 7;

        setSkeletonTotal(getSkeletonTotal() + 1);
        setEnemiesTotal(getEnemiesTotal() + 1);
      }
    }
  }

  void toBeNamed(int max, int index) {
    while (getEnemiesTotal() < max) {
      if (getSkeletonTotal() < SKELETON_MAXIMUM[index]) {
        setSkeletonPosition();

        skeletons.add(new Esqueleto(100 + (skeletonColumn * 75), -120 - (skeletonRow * 120)));
        
        skeletonLastPosition = new PVector(skeletonRow, skeletonColumn);

        skeletonRow = 4;
        skeletonColumn = 7;

        setSkeletonTotal(getSkeletonTotal() + 1);
        setEnemiesTotal(getEnemiesTotal() + 1);
      }        

      if (getKickingSkeletonTotal() < KICKING_SKELETON_MAXIMUM[index]) {
        setKickingSkeletonPosition();

        kickingSkeletons.add(new EsqueletoChute(120 + (kickingSkeletonColumn * 50), -75 - (kickingSkeletonRow * 75)));
        
        kickingSkeletonLastPosition = new PVector(kickingSkeletonRow, kickingSkeletonColumn);

        kickingSkeletonRow = 7;
        kickingSkeletonColumn = 11;

        setKickingSkeletonTotal(getKickingSkeletonTotal() + 1);
        setEnemiesTotal(getEnemiesTotal() + 1);
      }
    }
  }

  void secondBatch() {
    int max = getMaximumModifier()[1];

    toBeNamed(max, 1);
  }

  void thirdBatch() {
    int max = getMaximumModifier()[2];

    toBeNamed(max, 2);
  }

  void fourthBatch() {
    int max = getMaximumModifier()[3];

    toBeNamed(max, 3);
  }

  void fifthBatch() {
    int max = getMaximumModifier()[4];

    toBeNamed(max, 4);
  }

  void sixthBatch() {
  }
}

private class SecondMapEnemiesSpawnManager extends EnemiesSpawnManager {

  SecondMapEnemiesSpawnManager(int[] maximumModifier) {
    setMaximumModifier(maximumModifier);
  }

  void firstBatch() {
  }

  void secondBatch() {
  }

  void thirdBatch() {
  }

  void fourthBatch() {
  }

  void fifthBatch() {
  }

  void sixthBatch() {
  }
}

private class ThirdMapEnemiesSpawnManager extends EnemiesSpawnManager {

  ThirdMapEnemiesSpawnManager(int[] maximumModifier) {
    setMaximumModifier(maximumModifier);
  }

  void firstBatch() {
  }

  void secondBatch() {
  }

  void thirdBatch() {
  }

  void fourthBatch() {
  }

  void fifthBatch() {
  }

  void sixthBatch() {
  }
}
