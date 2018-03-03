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

public class InimigoGeral{
  private PImage sprite;
  private PImage inimigo;

  private int x;
  private int y;
  private int movement;

  private int step;
  private int tempoSprite;
  private int tempoIntervaloSprite;

  private int spriteWidth;
  private int spriteHeight;

  void display(){
    if (millis() > tempoSprite + tempoIntervaloSprite) {
      sprite = inimigo.get(step, 0, spriteWidth, spriteHeight);
      step = step % inimigo.width + spriteWidth;
      image(sprite, x, y);
      tempoSprite = millis();
    } else {
      image(sprite, x, y);      
    }

    if (step == inimigo.width) {
      step = 0;
    }
  }

  void update(){
    y = y + movement;
  }

  boolean ataque(){
    if (x + spriteWidth > jLeiteX && x < jLeiteX + 63 && y + spriteHeight > jLeiteY && y < jLeiteY + 126) {
      return true;
    }

    return false;
  }

  boolean saiuDaTela(){
    if (Y > height) {
      return true;
    }

    return false;
  }
}

PImage esqueleto;
PImage sombraEsqueleto;

final int ESQUELETO = 0;

int[] valoresEsqueletoXMapaCoveiro = {200, 520};

public class Esqueleto {
  public Esqueleto(x, y) {
    this.x = x;
    this.y = y;
    
  }

  void display() {
    image (sombraEsqueleto, esqueletoX + 16, esqueletoY + 114);

    if (millis() > tempoSpriteEsqueleto + 155) { 
      spriteEsqueleto = esqueleto.get(stepEsqueleto, 0, 76, 126); 
      stepEsqueleto = stepEsqueleto % 228 + 76;
      image(spriteEsqueleto, esqueletoX, esqueletoY); 
      tempoSpriteEsqueleto = millis();
    } else {
      image(spriteEsqueleto, esqueletoX, esqueletoY);
    }

    if (stepEsqueleto == esqueleto.width) {
      stepEsqueleto = 0;
    }
  }

  void update() {
    esqueletoY = esqueletoY + 3;
  }

  boolean ataque() {
    if (esqueletoX + 76 > jLeiteX && esqueletoX < jLeiteX + 63 && esqueletoY + 126 > jLeiteY && esqueletoY < jLeiteY + 126) {
      return true;
    } else {
      return false;
    }
  }

  boolean saiuDaTela() {
    if (esqueletoY > height) {
      return true;
    } else {
      return false;
    }
  }
}

ArrayList<Esqueleto> esqueletos;

int esqueletoC, esqueletoL;

int indexRandomEsqueletoXMapaBoss;

void esqueleto() {
  if (indexInimigos == 0) {
    if (estadoJogo == "MapaCoveiro") {
      if (esqueletos.size() == 0 && !coveiro.coveiroMorreu && !coveiroTomouDanoAgua) {
        for (int i = 0; i < 2; i = i + 1) {
          indexRandomEsqueletoXMapaBoss = int(random(0, 2));
          esqueletos.add(new Esqueleto(valoresEsqueletoXMapaCoveiro[indexRandomEsqueletoXMapaBoss], 0));
        }
      }
    }

    if (estadoJogo == "MapaPadre") { 
      if (esqueletos.size() == 0 && totalInimigos < maximoInimigosPadre && !padre.padreMorreu) {
        indexRandomEsqueletoXMapaBoss = int(random(0, valoresInimigosXMapaPadre.length));
        esqueletos.add(new Esqueleto(valoresInimigosXMapaPadre[indexRandomEsqueletoXMapaBoss], 0));
        totalInimigos = totalInimigos + 1;
      }
    }

    if (!telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
      if (estadoJogo == "PrimeiroMapa" && esqueletos.size() < 2 && totalInimigos < 6) {
        esqueletoC = int(random(0, 7));
        esqueletoL = int(random(0, 4));

        if (posicoesInimigosNoPrimeiroMapa[esqueletoC][esqueletoL] == ESQUELETO) {
          esqueletos.add(new Esqueleto(100 + (esqueletoC * (600 / 7)), -150 - (esqueletoL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }

      if (estadoJogo == "SegundoMapa" && esqueletos.size() < 2 && totalInimigos < 6) {
        esqueletoC = int(random(0, 7));
        esqueletoL = int(random(0, 4));

        if (posicoesInimigosNoSegundoMapa[esqueletoC][esqueletoL] == ESQUELETO) {
          esqueletos.add(new Esqueleto(100 + (esqueletoC * (600 / 7)), -150 - (esqueletoL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }

      if (estadoJogo == "TerceiroMapa" && esqueletos.size() < 2 && totalInimigos < 6) {
        esqueletoC = int(random(0, 7));
        esqueletoL = int(random(0, 4));

        if (posicoesInimigosNoTerceiroMapa[esqueletoC][esqueletoL] == ESQUELETO) {
          esqueletos.add(new Esqueleto(100 + (esqueletoC * (600 / 7)), -150 - (esqueletoL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }
    }
  }

  for (int i = esqueletos.size() - 1; i >= 0; i = i - 1) {
    Esqueleto e = esqueletos.get(i);
    e.display();
    e.update();
    if (e.saiuDaTela()) {
      totalInimigos = totalInimigos - 1;
      esqueletos.remove(e);
    }
    if (e.ataque() && !jLeiteImune) {
      vidaJLeiteAtual = vidaJLeiteAtual - 2;
      jLeiteImune = true;
      tempoImune = millis();
    }
  }

  for (int i = esqueletos.size() - 1; i >= 0; i = i - 1) {
    Esqueleto e = esqueletos.get(i);
    for (int j = pasAtaque.size() - 1; j >= 0; j = j - 1) {
      PaAtaque p = pasAtaque.get(j);
      if (p.acertouEsqueleto(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.esqueletoX, e.esqueletoY);
        esqueletos.remove(e);
      }
    }
    for (int j = pedrasAtiradas.size() - 1; j >= 0; j = j - 1) {
      PedraAtirada p = pedrasAtiradas.get(j);
      if (p.acertouEsqueleto(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.esqueletoX, e.esqueletoY);
        pedrasAtiradas.remove(p);
        esqueletos.remove(e);
      }
    }
    for (int j = chicotes.size() - 1; j >= 0; j = j - 1) {
      ChicoteAtaque c = chicotesAtaque.get(j);
      if (c.acertouEsqueleto(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.esqueletoX, e.esqueletoY);
        esqueletos.remove(e);
      }
    }
  }
}

void posicoesEsqueleto() {
  posicoesInimigosNoPrimeiroMapa[0][0] = ESQUELETO;
  posicoesInimigosNoPrimeiroMapa[1][2] = ESQUELETO;
  posicoesInimigosNoPrimeiroMapa[2][0] = ESQUELETO;
  posicoesInimigosNoPrimeiroMapa[3][2] = ESQUELETO;
  posicoesInimigosNoPrimeiroMapa[4][0] = ESQUELETO;
  posicoesInimigosNoPrimeiroMapa[5][2] = ESQUELETO;
  posicoesInimigosNoPrimeiroMapa[6][0] = ESQUELETO;

  posicoesInimigosNoSegundoMapa [0][1] = ESQUELETO;
  posicoesInimigosNoSegundoMapa [1][3] = ESQUELETO;
  posicoesInimigosNoSegundoMapa [2][0] = ESQUELETO;
  posicoesInimigosNoSegundoMapa [3][2] = ESQUELETO;
  posicoesInimigosNoSegundoMapa [4][0] = ESQUELETO;
  posicoesInimigosNoSegundoMapa [5][0] = ESQUELETO;
  posicoesInimigosNoSegundoMapa [6][0] = ESQUELETO;

  posicoesInimigosNoTerceiroMapa[0][3] = ESQUELETO;
  posicoesInimigosNoTerceiroMapa[2][0] = ESQUELETO;
  posicoesInimigosNoTerceiroMapa[4][2] = ESQUELETO;
  posicoesInimigosNoTerceiroMapa[6][3] = ESQUELETO;
}

PImage esqueletoChuteAtaque;
PImage esqueletoChuteMovimento;
PImage sombraEsqueletoChute;

final int ESQUELETOCHUTE = 1;

public class EsqueletoChute {
  private PImage spriteEsqueletoChuteAtaque;
  private PImage spriteEsqueletoChuteMovimento;

  private int esqueletoChuteX;
  private int esqueletoChuteY;

  private int movimentoEsqueletoChuteX;
  private int movimentoEsqueletoChuteY;

  private int tempoTrocaDirecaoEsqueletoChuteX;

  private int stepEsqueletoChuteAtaque;
  private int tempoSpriteEsqueletoChuteAtaque;

  private int stepEsqueletoChuteMovimento;
  private int tempoSpriteEsqueletoChuteMovimento;

  private boolean perdeuCabeca;
  private boolean gatilhoEsqueletoCabeca, esqueletoCabecaSaiu;

  public EsqueletoChute(int esqueletoChuteX, int esqueletoChuteY) {
    this.esqueletoChuteX = esqueletoChuteX;
    this.esqueletoChuteY = esqueletoChuteY;
  }

  void display() {
    image (sombraEsqueletoChute, esqueletoChuteX + 1, esqueletoChuteY + 50);

    if (!perdeuCabeca) {
      if (millis() > tempoSpriteEsqueletoChuteAtaque + 200) { 
        if (esqueletoChuteY < 0) {
          spriteEsqueletoChuteAtaque = esqueletoChuteAtaque.get(0, 0, 49, 74);
        } else {
          spriteEsqueletoChuteAtaque = esqueletoChuteAtaque.get(stepEsqueletoChuteAtaque, 0, 49, 74); 
          stepEsqueletoChuteAtaque = stepEsqueletoChuteAtaque % 245 + 49;
        }
        image(spriteEsqueletoChuteAtaque, esqueletoChuteX, esqueletoChuteY); 
        tempoSpriteEsqueletoChuteAtaque = millis();
      } else {
        image(spriteEsqueletoChuteAtaque, esqueletoChuteX, esqueletoChuteY);
      }

      if (stepEsqueletoChuteAtaque == 196 && !gatilhoEsqueletoCabeca) {
        esqueletoCabecaSaiu = true;
        gatilhoEsqueletoCabeca = true;
      }

      if (stepEsqueletoChuteAtaque == esqueletoChuteAtaque.width) {
        perdeuCabeca = true;
        stepEsqueletoChuteAtaque = 0;
      }
    } else {
      if (millis() > tempoSpriteEsqueletoChuteMovimento + 200) { 
        spriteEsqueletoChuteMovimento = esqueletoChuteMovimento.get(stepEsqueletoChuteMovimento, 0, 48, 74); 
        stepEsqueletoChuteMovimento = stepEsqueletoChuteMovimento % 192 + 48;
        image(spriteEsqueletoChuteMovimento, esqueletoChuteX, esqueletoChuteY); 
        tempoSpriteEsqueletoChuteMovimento = millis();
      } else {
        image(spriteEsqueletoChuteMovimento, esqueletoChuteX, esqueletoChuteY);
      }

      if (stepEsqueletoChuteMovimento == esqueletoChuteMovimento.width) {
        stepEsqueletoChuteMovimento = 0;
      }
    }
  }

  void update() {
    esqueletoChuteX = esqueletoChuteX + movimentoEsqueletoChuteX;
    esqueletoChuteY = esqueletoChuteY + movimentoEsqueletoChuteY;

    if (!perdeuCabeca) {
      movimentoEsqueletoChuteY = int(movimentoCenario);
      movimentoEsqueletoChuteX = 0;
    } else {
      movimentoEsqueletoChuteY = int(movimentoCenario) + 1;
      if (millis() > tempoTrocaDirecaoEsqueletoChuteX + 350) {
        movimentoEsqueletoChuteX = int(random(-5, 5));
        tempoTrocaDirecaoEsqueletoChuteX = millis();
      }
    }
  }

  boolean ataque() {
    if (esqueletoChuteX + 48 > jLeiteX && esqueletoChuteX < jLeiteX + 63 && esqueletoChuteY + 74 > jLeiteY && esqueletoChuteY < jLeiteY + 126) {
      return true;
    } else {
      return false;
    }
  }

  boolean saiuDaTela() {
    if (esqueletoChuteY > height) {
      return true;
    } else {
      return false;
    }
  }
}

ArrayList<EsqueletoChute> esqueletosChute;

int esqueletoChuteC, esqueletoChuteL;

int indexRandomEsqueletoChuteXMapaBoss;

void esqueletoChute() {
  if (indexInimigos == 1) {
    if (estadoJogo == "MapaPadre") { 
      if (esqueletosChute.size() == 0 && totalInimigos < maximoInimigosPadre && !padre.padreMorreu) {
        indexRandomEsqueletoChuteXMapaBoss = int(random(0, valoresInimigosXMapaPadre.length));
        esqueletosChute.add(new EsqueletoChute(valoresInimigosXMapaPadre[indexRandomEsqueletoChuteXMapaBoss], 0));
        totalInimigos = totalInimigos + 1;
      }
    }

    if (!telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
      if (estadoJogo == "PrimeiroMapa" && esqueletosChute.size() < 2 && totalInimigos < 6) {
        esqueletoChuteC = int(random(0, 7));
        esqueletoChuteL = int(random(0, 4));

        if (posicoesInimigosNoPrimeiroMapa[esqueletoChuteC][esqueletoChuteL] == ESQUELETOCHUTE) {
          esqueletosChute.add(new EsqueletoChute(100 + (esqueletoChuteC * (600 / 7)), -150 - (esqueletoChuteL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }
      if (estadoJogo == "SegundoMapa" && esqueletosChute.size() < 2 && totalInimigos < 6) {
        esqueletoChuteC = int(random(0, 7));
        esqueletoChuteL = int(random(0, 4));

        if (posicoesInimigosNoSegundoMapa[esqueletoChuteC][esqueletoChuteL] == ESQUELETOCHUTE) {
          esqueletosChute.add(new EsqueletoChute(100 + (esqueletoChuteC * (600 / 7)), -150 - (esqueletoChuteL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }
      if (estadoJogo == "TerceiroMapa" && esqueletosChute.size() < 2 && totalInimigos < 6) {
        esqueletoChuteC = int(random(0, 7));
        esqueletoChuteL = int(random(0, 4));

        if (posicoesInimigosNoTerceiroMapa[esqueletoChuteC][esqueletoChuteL] == ESQUELETOCHUTE) {
          esqueletosChute.add(new EsqueletoChute(100 + (esqueletoChuteC * (600 / 7)), -150 - (esqueletoChuteL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }
    }
  }

  for (int i = esqueletosChute.size() - 1; i >= 0; i = i - 1) {
    EsqueletoChute e = esqueletosChute.get(i);
    e.display();
    if (e.esqueletoCabecaSaiu) {
      cabecasEsqueleto.add(new CabecaEsqueleto(e.esqueletoChuteX, e.esqueletoChuteY, jLeiteX));
      e.esqueletoCabecaSaiu = false;
    }
    e.update();
    if (e.saiuDaTela()) {
      totalInimigos = totalInimigos - 1;
      esqueletosChute.remove(e);
    }
    if (e.ataque() && !jLeiteImune) {
      vidaJLeiteAtual = vidaJLeiteAtual - 2;
      jLeiteImune = true;
      tempoImune = millis();
    }
  }

  for (int i = esqueletosChute.size() - 1; i >= 0; i = i - 1) {
    EsqueletoChute e = esqueletosChute.get(i);
    for (int j = pasAtaque.size() - 1; j >= 0; j = j - 1) {
      PaAtaque p = pasAtaque.get(j);
      if (p.acertouEsqueletoChute(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.esqueletoChuteX - 40, e.esqueletoChuteY - 20);
        esqueletosChute.remove(e);
      }
    }
    for (int j = pedrasAtiradas.size() - 1; j >= 0; j = j - 1) {
      PedraAtirada p = pedrasAtiradas.get(j);
      if (p.acertouEsqueletoChute(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.esqueletoChuteX - 40, e.esqueletoChuteY - 20);
        pedrasAtiradas.remove(p);
        esqueletosChute.remove(e);
      }
    }
    for (int j = chicotes.size() - 1; j >= 0; j = j - 1) {
      ChicoteAtaque c = chicotesAtaque.get(j);
      if (c.acertouEsqueletoChute(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.esqueletoChuteX - 40, e.esqueletoChuteY - 20);
        esqueletosChute.remove(e);
      }
    }
  }
}

void posicoesEsqueletoChute() {
  posicoesInimigosNoPrimeiroMapa[0][2] = ESQUELETOCHUTE;
  posicoesInimigosNoPrimeiroMapa[1][0] = ESQUELETOCHUTE;
  posicoesInimigosNoPrimeiroMapa[2][2] = ESQUELETOCHUTE;
  posicoesInimigosNoPrimeiroMapa[3][0] = ESQUELETOCHUTE;
  posicoesInimigosNoPrimeiroMapa[4][2] = ESQUELETOCHUTE;
  posicoesInimigosNoPrimeiroMapa[5][0] = ESQUELETOCHUTE;
  posicoesInimigosNoPrimeiroMapa[6][2] = ESQUELETOCHUTE;

  posicoesInimigosNoSegundoMapa [0][2] = ESQUELETOCHUTE;
  posicoesInimigosNoSegundoMapa [1][0] = ESQUELETOCHUTE;
  posicoesInimigosNoSegundoMapa [2][3] = ESQUELETOCHUTE;
  posicoesInimigosNoSegundoMapa [3][3] = ESQUELETOCHUTE;
  posicoesInimigosNoSegundoMapa [4][2] = ESQUELETOCHUTE;
  posicoesInimigosNoSegundoMapa [5][3] = ESQUELETOCHUTE;
  posicoesInimigosNoSegundoMapa [6][3] = ESQUELETOCHUTE;

  posicoesInimigosNoTerceiroMapa[0][2] = ESQUELETOCHUTE;
  posicoesInimigosNoTerceiroMapa[1][3] = ESQUELETOCHUTE;
  posicoesInimigosNoTerceiroMapa[2][1] = ESQUELETOCHUTE;
  posicoesInimigosNoTerceiroMapa[4][3] = ESQUELETOCHUTE;
  posicoesInimigosNoTerceiroMapa[5][1] = ESQUELETOCHUTE;
}

PImage cabecaEsqueletoChute;

public class CabecaEsqueleto {
  private float cabecaEsqueletoX;
  private float cabecaEsqueletoY;

  private float movimentoCabecaEsqueletoX;

  private float destinoCabecaEsqueletoX;

  private boolean cabecaEsqueletoReta;

  public CabecaEsqueleto(float cabecaEsqueletoX, float cabecaEsqueletoY, float destinoCabecaEsqueletoX) {
    this.cabecaEsqueletoX = cabecaEsqueletoX;
    this.cabecaEsqueletoY = cabecaEsqueletoY;
    this.destinoCabecaEsqueletoX = destinoCabecaEsqueletoX;
  }

  void display() {
    image(cabecaEsqueletoChute, cabecaEsqueletoX, cabecaEsqueletoY);
  }

  void update() {
    cabecaEsqueletoX = cabecaEsqueletoX + movimentoCabecaEsqueletoX;
    if (!cabecaEsqueletoReta) {
      if (cabecaEsqueletoX > destinoCabecaEsqueletoX) {
        movimentoCabecaEsqueletoX = -8;
      } else {
        movimentoCabecaEsqueletoX = 8;
      }
    } else {
      movimentoCabecaEsqueletoX = 0;
    }

    cabecaEsqueletoY = cabecaEsqueletoY + 12;
  }

  void checaCabecaEsqueletoReta() {
    if (cabecaEsqueletoX < destinoCabecaEsqueletoX) {
      if (destinoCabecaEsqueletoX - cabecaEsqueletoX < 10) {  
        cabecaEsqueletoReta = true;
      } else {
        cabecaEsqueletoReta = false;
      }
    } else {
      if (cabecaEsqueletoX - destinoCabecaEsqueletoX < 10) {  
        cabecaEsqueletoReta = true;
      } else {
        cabecaEsqueletoReta = false;
      }
    }
  }

  boolean acertouJLeite() {
    if (cabecaEsqueletoX + 36 > jLeiteX && cabecaEsqueletoX < jLeiteX + 63 && cabecaEsqueletoY + 89 > jLeiteY && cabecaEsqueletoY + 50 < jLeiteY + 126) {
      return true;
    } else {
      return false;
    }
  }

  boolean saiuDaTela() {
    if (cabecaEsqueletoY > height) {
      return true;
    } else {
      return false;
    }
  }
}

ArrayList<CabecaEsqueleto> cabecasEsqueleto;

void cabecaEsqueleto() {
  for (int i = cabecasEsqueleto.size() - 1; i >= 0; i = i - 1) {
    CabecaEsqueleto c = cabecasEsqueleto.get(i);
    c.display();
    c.update();
    c.checaCabecaEsqueletoReta();
    if (c.saiuDaTela()) {
      cabecasEsqueleto.remove(c);
    }

    if (c.acertouJLeite() && !jLeiteImune) {
      vidaJLeiteAtual = vidaJLeiteAtual - 3;
      jLeiteImune = true;
      tempoImune = millis();
    }
  }
}

PImage cachorro;
PImage sombraCachorro;

final int CACHORRO = 2;

int[] valoresCachorroXMapaFazendeiro = {70, 382, 695};

public class Cachorro {
  private PImage spriteCachorro;

  private int cachorroX;
  private int cachorroY;

  private int stepCachorro;
  private int tempoSpriteCachorro;

  public Cachorro(int cachorroX, int cachorroY) {
    this.cachorroX = cachorroX;
    this.cachorroY = cachorroY;
  }

  void display() {
    image (sombraCachorro, cachorroX, cachorroY + 45);

    if (millis() > tempoSpriteCachorro + 55) { 
      spriteCachorro = cachorro.get(stepCachorro, 0, 45, 83); 
      stepCachorro = stepCachorro % 270 + 45;
      image(spriteCachorro, cachorroX, cachorroY); 
      tempoSpriteCachorro = millis();
    } else {
      image(spriteCachorro, cachorroX, cachorroY);
    }

    if (stepCachorro == cachorro.width) {
      stepCachorro = 0;
    }
  }

  void update() {
    cachorroY = cachorroY + 8;
  }

  boolean ataque() {
    if (cachorroX + 45 > jLeiteX && cachorroX < jLeiteX + 63 && cachorroY + 83 > jLeiteY && cachorroY < jLeiteY) {
      return true;
    } else {
      return false;
    }
  }

  boolean saiuDaTela() {
    if (cachorroY > height) {
      return true;
    } else {
      return false;
    }
  }
}

ArrayList<Cachorro> cachorros;

int cachorroC, cachorroL;

int indexRandomCachorroXMapaBoss;

void cachorro() {
  if (indexInimigos == 2) {
    if (estadoJogo == "MapaFazendeiro") {
      if (cachorros.size() == 0 && !fazendeiroTomouDanoPneu && !fazendeiro.fazendeiroMorreu) {
        for (int i = 0; i < 2; i = i + 1) {
          indexRandomCachorroXMapaBoss = int(random(0, valoresCachorroXMapaFazendeiro.length));
          cachorros.add(new Cachorro(valoresCachorroXMapaFazendeiro[indexRandomCachorroXMapaBoss], 0));
        }
      }
    }

    if (estadoJogo == "MapaPadre") { 
      if (cachorros.size() == 0 && totalInimigos < maximoInimigosPadre && !padre.padreMorreu) {
        indexRandomCachorroXMapaBoss = int(random(0, valoresInimigosXMapaPadre.length));
        cachorros.add(new Cachorro(valoresInimigosXMapaPadre[indexRandomCachorroXMapaBoss], 0));
        totalInimigos = totalInimigos + 1;
      }
    }

    if (!telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
      if (estadoJogo == "SegundoMapa" && cachorros.size() < 2 && totalInimigos < 6) {
        cachorroC = int(random(0, 7));
        cachorroL = int(random(0, 4));

        if (posicoesInimigosNoSegundoMapa[cachorroC][cachorroL] == CACHORRO) {
          cachorros.add(new Cachorro(100 + (cachorroC * (600 / 7)), -150 - (cachorroL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }

      if (estadoJogo == "TerceiroMapa" && cachorros.size() < 2 && totalInimigos < 6) {
        cachorroC = int(random(0, 7));
        cachorroL = int(random(0, 4));

        if (posicoesInimigosNoTerceiroMapa[cachorroC][cachorroL] == CACHORRO) {
          cachorros.add(new Cachorro(100 + (cachorroC * (600 / 7)), -150 - (cachorroL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }
    }
  }

  for (int i = cachorros.size() - 1; i >= 0; i = i - 1) {
    Cachorro c = cachorros.get(i);
    c.display();
    c.update();
    if (c.saiuDaTela()) {
      totalInimigos = totalInimigos - 1;
      cachorros.remove(c);
    }
    if (c.ataque() && !jLeiteImune) {
      vidaJLeiteAtual = vidaJLeiteAtual - 2;
      jLeiteImune = true;
      tempoImune = millis();
    }
  }

  for (int i = cachorros.size() - 1; i >= 0; i = i - 1) {
    Cachorro c = cachorros.get(i);
    for (int j = pasAtaque.size() - 1; j >= 0; j = j - 1) {
      PaAtaque p = pasAtaque.get(j);
      if (p.acertouCachorro(c)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(c.cachorroX, c.cachorroY);
        cachorros.remove(c);
      }
    }
    for (int j = pedrasAtiradas.size() - 1; j >= 0; j = j - 1) {
      PedraAtirada p = pedrasAtiradas.get(j);
      if (p.acertouCachorro(c)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(c.cachorroX, c.cachorroY);
        pedrasAtiradas.remove(p);
        cachorros.remove(c);
      }
    }
    for (int j = chicotes.size() - 1; j >= 0; j = j - 1) {
      ChicoteAtaque ch = chicotesAtaque.get(j);
      if (ch.acertouCachorro(c)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(c.cachorroX, c.cachorroY);
        cachorros.remove(c);
      }
    }
  }
}

void posicoesCachorro() {
  posicoesInimigosNoSegundoMapa [0][0] = CACHORRO;
  posicoesInimigosNoSegundoMapa [1][1] = CACHORRO;
  posicoesInimigosNoSegundoMapa [2][2] = CACHORRO;
  posicoesInimigosNoSegundoMapa [3][0] = CACHORRO;
  posicoesInimigosNoSegundoMapa [4][3] = CACHORRO;
  posicoesInimigosNoSegundoMapa [5][2] = CACHORRO;
  posicoesInimigosNoSegundoMapa [6][2] = CACHORRO;

  posicoesInimigosNoTerceiroMapa[1][0] = CACHORRO;
  posicoesInimigosNoTerceiroMapa[3][0] = CACHORRO;
  posicoesInimigosNoTerceiroMapa[5][2] = CACHORRO;
  posicoesInimigosNoTerceiroMapa[6][1] = CACHORRO;
}

PImage corvo;
PImage sombraCorvo;

public class Corvo {
  private PImage spriteCorvo;

  private float corvoX = random(100, width - 163);
  private float corvoY = random(-300, -1000);

  private int destinoCorvoX = jLeiteX;

  private int tempoNovoDestino;
  private int tempoRandom = int(random(500, 1201));

  private int stepCorvo;
  private int tempoSpriteCorvo;

  private boolean novoDestino;

  public Corvo() {
  }

  public Corvo(float corvoX, float corvoY) {
    this.corvoX = corvoX;
    this.corvoY = corvoY;
  }

  void display() {
    if (millis() > tempoSpriteCorvo + 75) { 
      spriteCorvo = corvo.get(stepCorvo, 0, 121, 86); 
      stepCorvo = stepCorvo % 363 + 121;
      image(spriteCorvo, corvoX, corvoY); 
      tempoSpriteCorvo = millis();
    } else {
      image(spriteCorvo, corvoX, corvoY);
    }

    if (stepCorvo == corvo.width) {
      stepCorvo = 0;
    }

    image(sombraCorvo, corvoX + 24, corvoY + 86);
  }  

  void atualizaAlvo() {
    if (corvoY > 0) {
      if (destinoCorvoX != jLeiteX && !novoDestino) {
        tempoNovoDestino = millis();
        novoDestino = true;
      }
      if (millis() > tempoNovoDestino + tempoRandom) {
        destinoCorvoX = jLeiteX;
        tempoNovoDestino = millis();
        novoDestino = false;
      }
    }
  }

  void update() {
    if (corvoX < destinoCorvoX) {
      corvoX = corvoX + 2.5;
    }
    if (corvoX > destinoCorvoX) {
      corvoX = corvoX  - 2.5;
    }
    corvoY = corvoY + 3.5;
  }

  boolean ataque() {
    if (corvoX + 95 > jLeiteX && corvoX + 25 < jLeiteX + 63 && corvoY + 86 > jLeiteY && corvoY < jLeiteY + 126) {
      return true;
    } else {
      return false;
    }
  }

  boolean saiuDaTela() {
    if (corvoY > height) {
      return true;
    } else {
      return false;
    }
  }
}

ArrayList<Corvo> corvos;

int indexRandomCorvoXMapaBoss;

void corvo() {
  if (indexInimigos == 3) {
    if (estadoJogo == "MapaPadre") {
      if (corvos.size() == 0 && totalInimigos < maximoInimigosPadre && !padre.padreMorreu) {
        indexRandomCorvoXMapaBoss = int(random(0, valoresInimigosXMapaPadre.length));
        corvos.add(new Corvo(valoresInimigosXMapaPadre[indexRandomCorvoXMapaBoss], 0));
      }
    }

    if (!telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
      if (estadoJogo == "SegundoMapa" && corvos.size() < 2) {
        corvos.add(new Corvo());
      }

      if (estadoJogo == "TerceiroMapa" && corvos.size() < 2) {
        corvos.add(new Corvo());
      }
    }
  }

  for (int i = corvos.size() - 1; i >= 0; i = i - 1) {
    Corvo c = corvos.get(i);
    c.display();
    c.atualizaAlvo();
    c.update();
    if (c.saiuDaTela()) {
      corvos.remove(c);
    }
    if (c.ataque() && !jLeiteImune) {
      vidaJLeiteAtual = vidaJLeiteAtual - 3;
      jLeiteImune = true;
      tempoImune = millis();
    }
  }

  for (int i = corvos.size() - 1; i >= 0; i = i - 1) {
    Corvo c = corvos.get(i);
    for (int j = pasAtaque.size() - 1; j >= 0; j = j - 1) {
      PaAtaque p = pasAtaque.get(j);
      if (p.acertouCorvo(c)) {
        hitInimigos(c.corvoX, c.corvoY);
        corvos.remove(c);
      }
    }
    for (int j = pedrasAtiradas.size() - 1; j >= 0; j = j - 1) {
      PedraAtirada p = pedrasAtiradas.get(j);
      if (p.acertouCorvo(c)) {
        hitInimigos(c.corvoX, c.corvoY);
        pedrasAtiradas.remove(p);
        corvos.remove(c);
      }
    }
    for (int j = chicotes.size() - 1; j >= 0; j = j - 1) {
      ChicoteAtaque ch = chicotesAtaque.get(j);
      if (ch.acertouCorvo(c)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(c.corvoX, c.corvoY);
        corvos.remove(c);
      }
    }
  }
}

PImage esqueletoRaiva;
PImage sombraEsqueletoRaiva;

final int ESQUELETORAIVA = 3;

public class EsqueletoRaiva {
  private PImage spriteEsqueletoRaiva;

  private int esqueletoRaivaX;
  private int esqueletoRaivaY;

  private int movimentoEsqueletoRaivaX = 3;

  private int stepEsqueletoRaiva;
  private int tempoSpriteEsqueletoRaiva;

  public EsqueletoRaiva(int esqueletoRaivaX, int esqueletoRaivaY) {
    this.esqueletoRaivaX = esqueletoRaivaX;
    this.esqueletoRaivaY = esqueletoRaivaY;
  }

  void display() {
    image(sombraEsqueletoRaiva, esqueletoRaivaX + 16, esqueletoRaivaY + 114);

    if (millis() > tempoSpriteEsqueletoRaiva + 75) {
      spriteEsqueletoRaiva = esqueletoRaiva.get(stepEsqueletoRaiva, 0, 76, 126);
      stepEsqueletoRaiva = stepEsqueletoRaiva % 228 + 76;
      image(spriteEsqueletoRaiva, esqueletoRaivaX, esqueletoRaivaY);
      tempoSpriteEsqueletoRaiva = millis();
    } else {
      image(spriteEsqueletoRaiva, esqueletoRaivaX, esqueletoRaivaY);
    }

    if (stepEsqueletoRaiva == esqueletoRaiva.width) {
      stepEsqueletoRaiva = 0;
    }
  }

  void update() {
    esqueletoRaivaX = esqueletoRaivaX + movimentoEsqueletoRaivaX;

    if (esqueletoRaivaX < 100) {
      movimentoEsqueletoRaivaX = 3;
    }
    if (esqueletoRaivaX + 30 > 700) {
      movimentoEsqueletoRaivaX = -3;
    } 

    esqueletoRaivaY = esqueletoRaivaY + 3;
  }

  boolean ataque() {
    if (esqueletoRaivaX + 76 > jLeiteX && esqueletoRaivaX < jLeiteX + 63 && esqueletoRaivaY + 126 > jLeiteY && esqueletoRaivaY < jLeiteY + 126) {
      return true;
    } else {
      return false;
    }
  }

  boolean saiuDaTela() {
    if (esqueletoRaivaY > height) {
      return true;
    } else {
      return false;
    }
  }
}

ArrayList<EsqueletoRaiva> esqueletosRaiva;

int esqueletoRaivaC, esqueletoRaivaL;

int indexRandomEsqueletoRaivaXMapaBoss;

void esqueletoRaiva() {
  if (indexInimigos == 4) {
    if (estadoJogo == "MapaPadre") { 
      if (esqueletosRaiva.size() == 0 && totalInimigos < maximoInimigosPadre && !padre.padreMorreu) {
        indexRandomEsqueletoRaivaXMapaBoss = int(random(0, valoresInimigosXMapaPadre.length));
        esqueletosRaiva.add(new EsqueletoRaiva(valoresInimigosXMapaPadre[indexRandomEsqueletoRaivaXMapaBoss], 0));
        totalInimigos = totalInimigos + 1;
      }
    }

    if (!telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
      if (estadoJogo == "TerceiroMapa" && esqueletosRaiva.size() < 2 && totalInimigos < 6) {
        esqueletoRaivaC = int(random(0, 7));
        esqueletoRaivaL = int(random(0, 4));

        if (posicoesInimigosNoTerceiroMapa[esqueletoRaivaC][esqueletoRaivaL] == ESQUELETORAIVA) {
          esqueletosRaiva.add(new EsqueletoRaiva(100 + (esqueletoRaivaC * (600 / 7)), -150 - (esqueletoRaivaL * 150)));
          totalInimigos = totalInimigos + 1;
        }
      }
    }
  }


  for (int i = esqueletosRaiva.size() - 1; i >= 0; i = i - 1) {
    EsqueletoRaiva e = esqueletosRaiva.get(i);
    e.display();
    e.update();
    if (e.saiuDaTela()) {
      totalInimigos = totalInimigos - 1;
      esqueletosRaiva.remove(e);
    }
    if (e.ataque() && !jLeiteImune) {
      vidaJLeiteAtual = vidaJLeiteAtual - 3;
      jLeiteImune = true;
      tempoImune = millis();
    }
  }

  for (int i = esqueletosRaiva.size() - 1; i >= 0; i = i - 1) {
    EsqueletoRaiva e = esqueletosRaiva.get(i);
    for (int j = pasAtaque.size() - 1; j >= 0; j = j - 1) {
      PaAtaque p = pasAtaque.get(j);
      if (p.acertouEsqueletoRaiva(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.esqueletoRaivaX, e.esqueletoRaivaY);
        esqueletosRaiva.remove(e);
      }
    }
    for (int j = pedrasAtiradas.size() - 1; j >= 0; j = j - 1) {
      PedraAtirada p = pedrasAtiradas.get(j);
      if (p.acertouEsqueletoRaiva(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.esqueletoRaivaX, e.esqueletoRaivaY);
        pedrasAtiradas.remove(p);
        esqueletosRaiva.remove(e);
      }
    }
    for (int j = chicotes.size() - 1; j >= 0; j = j - 1) {
      ChicoteAtaque ch = chicotesAtaque.get(j);
      if (ch.acertouEsqueletoRaiva(e)) {
        totalInimigos = totalInimigos - 1;
        hitInimigos(e.esqueletoRaivaX, e.esqueletoRaivaY);
        esqueletosRaiva.remove(e);
      }
    }
  }
}

void posicoesEsqueletoRaiva() {
  posicoesInimigosNoTerceiroMapa[0][0] = ESQUELETORAIVA;
  posicoesInimigosNoTerceiroMapa[1][2] = ESQUELETORAIVA;
  posicoesInimigosNoTerceiroMapa[2][3] = ESQUELETORAIVA;
  posicoesInimigosNoTerceiroMapa[3][2] = ESQUELETORAIVA;
  posicoesInimigosNoTerceiroMapa[4][1] = ESQUELETORAIVA;
  posicoesInimigosNoTerceiroMapa[5][0] = ESQUELETORAIVA;
  posicoesInimigosNoTerceiroMapa[6][2] = ESQUELETORAIVA;
}