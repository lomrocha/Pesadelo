void jogando() {
  millisAvancadaMapa = millisAvancadaMapa + 1000 / 60;

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

  if (millisAvancada > tempoBossMorreu + 3000 && coveiro.coveiroMorreu) {
    estadoJogo = "SegundoMapa";
  }

  if (millisAvancada > tempoBossMorreu + 3000 && fazendeiro.fazendeiroMorreu) {
    estadoJogo = "TerceiroMapa";
  }

  if (millisAvancada > tempoBossMorreu + 7000 && padre.padreMorreu) {
    estadoJogo = "Vitoria";
  }


  cenario();
  inimigosTodos();
  armas(); 
  jLeite(); 
  comidaTodos();
  vida();
  caixaNumeroItem();
  if (telaTutorialAndandoAtiva) {
    telaTutorialAndando();
  }
  if (primeiraPedra == 1) {
    telaTutorialPedra();
  }
  telaGameOver();
  telaVitoria();
}