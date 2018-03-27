void jogando() {
  if (estadoJogo == "PrimeiroMapaNormal") {
    if (musicasAtivas) {
      temaIgreja.play();
    }
  }

  if (estadoJogo == "SegundoMapaNormal") {
    if (musicasAtivas) {
      temaFazenda.play();
    }
  }

  if (estadoJogo == "TerceiroMapaNormal") {
    if (musicasAtivas) {
      temaCidade.play();
    }
  }

  if (millis() > tempoBossMorreu + 3000 && coveiro.coveiroMorreu) {
    estadoJogo = "SegundoMapaNormal";
  }

  if (millis() > tempoBossMorreu + 3000 && fazendeiro.fazendeiroMorreu) {
    estadoJogo = "TerceiroMapaNormal";
  }

  if (millis() > tempoBossMorreu + 7000 && padre.padreMorreu) {
    estadoJogo = "Vitoria";
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