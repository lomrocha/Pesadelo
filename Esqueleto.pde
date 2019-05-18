PImage skeleton;
PImage skeletonShadow;

final int SKELETON = 1;

final int[] valoresEsqueletoXPrimeiroMapaBoss = {200, 520};

private class Esqueleto extends Enemy {
  Esqueleto(int x, int y) {
    this.setSelf(new PVector(x, y));
    
    this.setTypeOfObject(OBJECT_WITH_SHADOW);
    
    this.setShadowImage(skeletonShadow);
    this.setShadowOffset(new PVector(16, 114));

    this.setSpriteImage(skeleton);
    this.setSpriteInterval(155);
    this.setSpriteWidth(76);
    this.setSpriteHeight(126);

    this.setDamage(2);
    this.setType(SKELETON);
  }

  void updateMovement() {
    setMotionY(3);
  }

  void updateTarget() {
  }
}

int esqueletoC, esqueletoL;
int indexRandomEsqueletoXMapaBoss;

void esqueleto() {
  //if (indexInimigos == 0) {
  //  if (gameState == GameState.FIRSTBOSS.getValue()) {
  //    if (esqueletos.size() == 0 && !coveiro.coveiroMorreu && !coveiroTomouDanoAgua) {
  //      for (int i = 0; i < 2; i = i + 1) {
  //        indexRandomEsqueletoXMapaBoss = int(random(0, 2));
  //        esqueletos.add(new Esqueleto(valoresEsqueletoXPrimeiroMapaBoss[indexRandomEsqueletoXMapaBoss], 0));
  //      }
  //    }
  //  }

  //  if (gameState == GameState.THIRDBOSS.getValue()) { 
  //    if (esqueletos.size() == 0 && totalInimigos < maximoInimigosPadre && !padre.padreMorreu) {
  //      indexRandomEsqueletoXMapaBoss = int(random(0, valoresInimigosXTerceiroMapaBoss.length));
  //      esqueletos.add(new Esqueleto(valoresInimigosXTerceiroMapaBoss[indexRandomEsqueletoXMapaBoss], 0));
  //      totalInimigos = totalInimigos + 1;
  //    }
  //  }

  //if (!movementTutorialScreenActive) {
  //  /*if (gameState == GameState.FIRSTMAP.getValue() && esqueletos.size() < 2 && totalInimigos < 6) {
  //   esqueletoC = int(random(0, 7));
  //   esqueletoL = int(random(0, 4));

  //   if (ENEMY_POSITIONS_FIRST_MAP[esqueletoC][esqueletoL] == SKELETON) {
  //   esqueletos.add(new Esqueleto(100 + (esqueletoC * (600 / 7)), -150 - (esqueletoL * 150)));
  //   totalInimigos = totalInimigos + 1;
  //   }
  //   }*/

  //  if (gameState == GameState.SECONDMAP.getValue() && esqueletos.size() < 2 && totalInimigos < 6) {
  //    esqueletoC = int(random(0, 7));
  //    esqueletoL = int(random(0, 4));

  //    if (ENEMY_POSITIONS_SECOND_MAP[esqueletoC][esqueletoL] == SKELETON) {
  //      esqueletos.add(new Esqueleto(100 + (esqueletoC * (600 / 7)), -150 - (esqueletoL * 150)));
  //      totalInimigos = totalInimigos + 1;
  //    }
  //  }

  //  if (gameState == GameState.THIRDMAP.getValue() && esqueletos.size() < 2 && totalInimigos < 6) {
  //    esqueletoC = int(random(0, 7));
  //    esqueletoL = int(random(0, 4));

  //    if (ENEMY_POSITIONS_THIRD_MAP[esqueletoC][esqueletoL] == SKELETON) {
  //      esqueletos.add(new Esqueleto(100 + (esqueletoC * (600 / 7)), -150 - (esqueletoL * 150)));
  //      totalInimigos = totalInimigos + 1;
  //    }
  //  }
  //}

  if (firstMapEnemiesSpawnManager.skeletons.size() > 0) {
    computeEnemy(firstMapEnemiesSpawnManager.skeletons, firstMapEnemiesSpawnManager);
    deleteEnemy(firstMapEnemiesSpawnManager.skeletons);
  }
}

final int[][] SKELETON_POSITIONS = new int [5][8];

void skeletonPositions() {
  SKELETON_POSITIONS  [0][0] = SKELETON;
  SKELETON_POSITIONS  [0][2] = SKELETON;
  SKELETON_POSITIONS  [0][4] = SKELETON;
  SKELETON_POSITIONS  [0][6] = SKELETON;
  SKELETON_POSITIONS  [2][0] = SKELETON;
  SKELETON_POSITIONS  [2][2] = SKELETON;
  SKELETON_POSITIONS  [2][4] = SKELETON;
  SKELETON_POSITIONS  [2][6] = SKELETON;
  SKELETON_POSITIONS  [4][0] = SKELETON;
  SKELETON_POSITIONS  [4][2] = SKELETON;
  SKELETON_POSITIONS  [4][4] = SKELETON;
  SKELETON_POSITIONS  [4][6] = SKELETON;
}
