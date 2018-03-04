int tempoGerarInimigo;
int indexInimigos;

int totalInimigos;
int maximoInimigosPadre = 2;

int[] valoresInimigosXMapaPadre = {25, 350, 679};

void inimigosTodos() {
  if (!jLeiteMorreu) {
    if (!telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
      if (int(millisAvancada) > tempoGerarInimigo + 250) {
        if (estadoJogo == "PrimeiroMapa") {
          indexInimigos = int(random(0, 2));
        } 
        if (estadoJogo == "SegundoMapa") {
          indexInimigos = int(random(0, 4));
        } 
        if (estadoJogo == "TerceiroMapa") {
          indexInimigos = int(random(1, 5));
        } 
        if (estadoJogo == "MapaPadre") {
          indexInimigos = int(random(0, 5));
          if (!ataqueLevantemAcontecendo) {
            maximoInimigosPadre = 2;
          } else {
            maximoInimigosPadre = 4;
          }
        }
        tempoGerarInimigo = int(millisAvancada);
      }
    }
  } else {
    indexInimigos = 6;
  }

  esqueleto();
  esqueletoChute();
  cabecaEsqueleto();
  cachorro();
  corvo();
  esqueletoRaiva();
}