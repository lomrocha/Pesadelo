void jogando() {
  if (gameState == GameState.FIRSTMAP.ordinal()) {
    if (musicasAtivas) {
      temaIgreja.play();
    }
  }

  if (gameState == GameState.SECONDMAP.ordinal()) {
    if (musicasAtivas) {
      temaFazenda.play();
    }
  }

  if (gameState == GameState.THIRDMAP.ordinal()) {
    if (musicasAtivas) {
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
  if (telaTutorialAndandoAtiva) {
    telaTutorialAndando();
  }
  telaGameOver();
  telaVitoria();
}