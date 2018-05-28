boolean isFirstMapSet;

void jogando() {
  if (gameState == GameState.FIRST_MAP.getValue()) {
    if (!isFirstMapSet) {
      if (firstMap == null) {
        firstMap = new FirstMap();
      } else {
        movementTutorialScreenActive = true;
        firstMap.regularMapItemSpawnManager.setSpawnVariables(7000);
        firstMap.regularMapFoodSpawnManager.setSpawnVariables(7000);
        isFirstMapSet = true;
      }
    } else {
      firstMap.scenery();
      firstMap.foodManager();
      firstMap.enemies();
      firstMap.hud();
    }
    if (isMusicActive) {
      temaIgreja.play();
    }
  }

  if (gameState == GameState.SECOND_MAP.getValue()) {
    if (isMusicActive) {
      temaFazenda.play();
    }
  }

  if (gameState == GameState.THIRD_MAP.getValue()) {
    if (isMusicActive) {
      temaCidade.play();
    }
  }

  if (millis() > tempoBossMorreu + 3000 && coveiro.coveiroMorreu) {
    gameState = GameState.SECOND_MAP.getValue();
  }

  if (millis() > tempoBossMorreu + 3000 && fazendeiro.fazendeiroMorreu) {
    gameState = GameState.THIRD_MAP.getValue();
  }

  if (millis() > tempoBossMorreu + 7000 && padre.padreMorreu) {
    gameState = GameState.WIN.getValue();
  }

  cenario();
  inimigosTodos();
  armas(); 
  jLeite(); 
  playerHitpoints();
  ib.updateItemImage();
  ib.display();
  if (movementTutorialScreenActive) {
    telaTutorialAndando();
  }
}
