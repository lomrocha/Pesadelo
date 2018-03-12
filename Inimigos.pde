int tempoGerarInimigo;
int indexInimigos;

int totalInimigos;
int maximoInimigosPadre = 2;

int[] valoresInimigosXMapaPadre = {25, 350, 679};

void inimigosTodos() {
  if (!jLeiteMorreu) {
    if (!telaTutorialAndandoAtiva) {
      if (millis() > tempoGerarInimigo + 250) {
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
        tempoGerarInimigo = millis();
      }
    }
  } else {
    indexInimigos = 6;
  }

  if (esqueletos.size() > 0) {
    deleteEnemy(esqueletos);
  }
  esqueleto();

  if (esqueletosChute.size() > 0) {
    deleteEnemy(esqueletosChute);
  }
  esqueletoChute();
  cabecaEsqueleto();

  if (cachorros.size() > 0) {
    deleteEnemy(cachorros);
  }
  cachorro();

  if (corvos.size() > 0) {
    deleteEnemy(corvos);
  }
  corvo();

  if (esqueletosRaiva.size() > 0) {
    deleteEnemy(esqueletosRaiva);
  }
  esqueletoRaiva();
}

void damage(int amount) {
  if (!jLeiteImune) {
    vidaJLeiteAtual -= amount;
    jLeiteImune = true;
    tempoImune = millis();
  }
}

<Inimigo extends Geral> void deleteEnemy(ArrayList<Inimigo> inimigos) {
  for (int i = inimigos.size() - 1; i >= 0; i--) {
    Inimigo inimigo = inimigos.get(i);
    for (int j = armas.size() - 1; j >= 0; j--) {
      Arma arma = armas.get(j);
      if (arma.hasHit(inimigo)) {
        totalInimigos--;
        hitInimigos(inimigo.getX() - 40, inimigo.getY() - 20);
        inimigos.remove(inimigo);
        if (arma.getIsStone()) {
          armas.remove(arma);
        }
      }
    }
  }
}