class FirstMapEnemiesSpawnManager extends EnemiesSpawnManager {
  private ArrayList<Esqueleto> skeletons = new ArrayList<Esqueleto>();
  private ArrayList<EsqueletoChute> kickingSkeletons = new ArrayList<EsqueletoChute>();
  
  final int[] SKELETON_MAXIMUM = {2, 1, 2, 2, 3};
  final int[] KICKING_SKELETON_MAXIMUM = {0, 1, 1, 2, 2};

  private int skeletonRow = 0;
  private int skeletonColumn = 0;
  private int kickingSkeletonRow = 0;
  private int kickingSkeletonColumn = 0;

  private int skeletonTotal;
  private int kickingSkeletonTotal;

  FirstMapEnemiesSpawnManager(int[] maximumModifier) {
    setMaximumModifier(maximumModifier);
  }

  void setSkeletonPosition() {    
    while (SKELETON_POSITIONS[skeletonRow][skeletonColumn] != SKELETON) {
      skeletonRow = int(random(0, 5));
      skeletonColumn = int(random(0, 8));
    }
  }

  void setKickingSkeletonPosition() {
    while (KICKING_SKELETON_POSITIONS[kickingSkeletonRow][kickingSkeletonColumn] != KICKING_SKELETON) {
      kickingSkeletonRow = int(random(0, 8));
      kickingSkeletonColumn = int(random(0, 12));
    }
  }

  void firstBatch() {
    //println("first batch: \n" + "Skeletons - "  + getEnemiesTotal());
    int max = getMaximumModifier()[0];

    while (getEnemiesTotal() < max) {
      if (skeletonTotal < SKELETON_MAXIMUM[0]) {
        setSkeletonPosition();

        skeletons.add(new Esqueleto(100 + (skeletonColumn * 85), -150 - (skeletonRow * 150)));

        skeletonRow = 4;
        skeletonColumn = 7;
        
        skeletonTotal++;
        setEnemiesTotal(getEnemiesTotal() + 1);
      }
    }
  }

  void toBeNamed(int max, int index) {
    while (getEnemiesTotal() < max) {
      if (skeletonTotal < SKELETON_MAXIMUM[index]) {
        setSkeletonPosition();

        skeletons.add(new Esqueleto(100 + (skeletonColumn * 85), -150 - (skeletonRow * 150)));

        skeletonRow = 4;
        skeletonColumn = 7;

        skeletonTotal++;
        setEnemiesTotal(getEnemiesTotal() + 1);
      }        

      if (kickingSkeletonTotal < KICKING_SKELETON_MAXIMUM[index]) {
        setKickingSkeletonPosition();

        kickingSkeletons.add(new EsqueletoChute(120 + (kickingSkeletonColumn * 50), -150 - (kickingSkeletonRow * 75)));

        kickingSkeletonRow = 7;
        kickingSkeletonColumn = 11;

        kickingSkeletonTotal++;
        setEnemiesTotal(getEnemiesTotal() + 1);
      }
    }
  }

  void secondBatch() {
    //println("second batch: \n" + "Skeletons - " + skeletonTotal + "\nKickingSkeleton - " + kickingSkeletonTotal);
    int max = getMaximumModifier()[1];

    toBeNamed(max, 1);
  }

  void thirdBatch() {
    //println("third batch: \n" + "Skeletons - " + skeletonTotal + "\nKickingSkeleton - " + kickingSkeletonTotal);
    int max = getMaximumModifier()[2];

    toBeNamed(max, 2);
  }

  void fourthBatch() {
    //println("fourth batch: \n" + "Skeletons - " + skeletonTotal + "\nKickingSkeleton - " + kickingSkeletonTotal);
    int max = getMaximumModifier()[3];

    toBeNamed(max, 3);
  }

  void fifthBatch() {
    //println("fifth batch: \n" + "Skeletons - " + skeletonTotal + "\nKickingSkeleton - " + kickingSkeletonTotal);
    int max = getMaximumModifier()[4];

    toBeNamed(max, 4);
  }

  void sixthBatch() {
  }
}

class SecondMapEnemiesSpawnManager extends EnemiesSpawnManager {

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

class ThirdMapEnemiesSpawnManager extends EnemiesSpawnManager {

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