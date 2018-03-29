boolean isFirstMapSet;

void jogando() {
  if (gameState == GameState.FIRSTMAP.ordinal()) {
    if (!isFirstMapSet) {
      movementTutorialScreenActive = true;
      cenarios.add(new Cenario(0, 0));
      cenarios.add(new Cenario(-600, 0));
      generateItem(5000);
      generateFood(5000);
      isFirstMapSet = true;
    }
    if (isMusicActive) {
      temaIgreja.play();
    }
  }

  if (gameState == GameState.SECONDMAP.ordinal()) {
    if (isMusicActive) {
      temaFazenda.play();
    }
  }

  if (gameState == GameState.THIRDMAP.ordinal()) {
    if (isMusicActive) {
      temaCidade.play();
    }
  }

  if (millis() > tempoBossMorreu + 3000 && coveiro.coveiroMorreu) {
    gameState = GameState.SECONDMAP.ordinal();
  }

  if (millis() > tempoBossMorreu + 3000 && fazendeiro.fazendeiroMorreu) {
    gameState = GameState.THIRDMAP.ordinal();
  }

  if (millis() > tempoBossMorreu + 7000 && padre.padreMorreu) {
    gameState = GameState.WIN.ordinal();
  }

  cenario();
  inimigosTodos();
  armas(); 
  jLeite(); 
  foodAll();
  playerHitpoints();
  caixaNumeroItem();
  if (movementTutorialScreenActive) {
    telaTutorialAndando();
  }
}