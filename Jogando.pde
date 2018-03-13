void jogando() {
  if (estadoJogo == "PrimeiroMapa") {
    if (musicasAtivas) {
      temaIgreja.play();
    }
  }

  if (estadoJogo == "SegundoMapa") {
    if (musicasAtivas) {
      temaFazenda.play();
    }
  }

  if (estadoJogo == "TerceiroMapa") {
    if (musicasAtivas) {
      temaCidade.play();
    }
  }

  if (millis() > tempoBossMorreu + 3000 && coveiro.coveiroMorreu) {
    estadoJogo = "SegundoMapa";
  }

  if (millis() > tempoBossMorreu + 3000 && fazendeiro.fazendeiroMorreu) {
    estadoJogo = "TerceiroMapa";
  }

  if (millis() > tempoBossMorreu + 7000 && padre.padreMorreu) {
    estadoJogo = "Vitoria";
  }


  cenario();
  inimigosTodos();
  armas(); 
  jLeite(); 
  foodAll();
  vida();
  caixaNumeroItem();
  if (telaTutorialAndandoAtiva) {
    telaTutorialAndando();
  }
  telaGameOver();
  telaVitoria();
}