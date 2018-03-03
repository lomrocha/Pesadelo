PImage sombraComidas;

int tempoGerarComida;
int indexComida;

int totalRecuperado;

int totalComidas;

boolean comidaGerada;

void comidaTodos() {
  if (!jLeiteMorreu) {
    if (!telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
      if (millisAvancada > tempoGerarComida + 10000 && !comidaGerada) {
        indexComida = int(random(0, 10));
        tempoGerarComida = int(millisAvancada);
        comidaGerada = true;
      }
    }
  } else {
    indexComida = 10;
  }

  coxinha();
  brigadeiro();
  queijo();
}

PImage coxinha;

public class Coxinha {
  private PImage spriteCoxinha;

  private int coxinhaX = int(random(200, 500));
  private int coxinhaY = int(random(-300, -1000));

  private int stepCoxinha;
  private int tempoSpriteCoxinha;

  private int totalRecuperado = 0;

  public Coxinha(int coxinhaX, int coxinhaY) {
    this.coxinhaX = coxinhaX;
    this.coxinhaY = coxinhaY;
  }

  public Coxinha() {
  }

  void display() {
    image (sombraComidas, coxinhaX, coxinhaY + 20);

    if (millis() > tempoSpriteCoxinha + 75) {
      spriteCoxinha = coxinha.get(stepCoxinha, 0, 28, 30);
      stepCoxinha = stepCoxinha % 168 + 28;
      image(spriteCoxinha, coxinhaX, coxinhaY);
      tempoSpriteCoxinha = millis();
    } else {
      image(spriteCoxinha, coxinhaX, coxinhaY);
    }

    if (stepCoxinha == coxinha.width) {
      stepCoxinha = 0;
    }
  }

  void update() {
    coxinhaY = coxinhaY + 1;
  }

  boolean apanhado() {
    if (coxinhaX + 27 > jLeiteX && coxinhaX < jLeiteX + 63 && coxinhaY + 30 > jLeiteY && coxinhaY < jLeiteY + 126) {
      tempoGerarComida = int(millisAvancada);
      indexComida = 10;
      comidaGerada = false;
      return true;
    } else {
      return false;
    }
  }

  boolean saiuDaTela() {
    if (coxinhaY > height) {
      return true;
    } else {
      return false;
    }
  }
}

ArrayList<Coxinha> coxinhas;

int indexRandomCoxinhaMapaBoss;

int coxinhaRecuperacao = 5;

void coxinha() {
  if (totalComidas < 1) {
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      if (coxinhas.size() == 0 && indexComida >= 8 && indexComida <= 9 && !telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
        coxinhas.add(new Coxinha());
        totalComidas = totalComidas + 1;
      }
    }

    if (estadoJogo == "MapaCoveiro") {
      if (coxinhas.size() == 0 && indexComida >= 8 && indexComida <= 9) {
        indexRandomCoxinhaMapaBoss = int(random(0, valoresXMapaCoveiro.length));
        coxinhas.add(new Coxinha(valoresXMapaCoveiro[indexRandomCoxinhaMapaBoss], valoresYMapaCoveiro[indexRandomCoxinhaMapaBoss]));
        totalComidas = totalComidas + 1;
      }
    }

    if (estadoJogo == "MapaFazendeiro") {
      if (coxinhas.size() == 0 && indexComida >= 8 && indexComida <= 9) {
        indexRandomCoxinhaMapaBoss = int(random(0, valoresXMapaFazendeiro.length));
        coxinhas.add(new Coxinha(valoresXMapaFazendeiro[indexRandomCoxinhaMapaBoss], valoresYMapaFazendeiro[indexRandomCoxinhaMapaBoss]));
        totalComidas = totalComidas + 1;
      }
    }

    if (estadoJogo == "MapaPadre") {
      if (coxinhas.size() == 0 && indexComida >= 8 && indexComida <= 9) {
        indexRandomCoxinhaMapaBoss = int(random(0, valoresXMapaPadre.length));
        coxinhas.add(new Coxinha(valoresXMapaPadre[indexRandomCoxinhaMapaBoss], valoresYMapaPadre[indexRandomCoxinhaMapaBoss]));
        totalComidas = totalComidas + 1;
      }
    }
  }

  for (int i = coxinhas.size() - 1; i >= 0; i = i - 1) {
    Coxinha c = coxinhas.get(i);
    c.display();
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      c.update();
    }
    if (c.saiuDaTela()) {
      totalComidas = totalComidas - 1;
      coxinhas.remove(c);
    }
    if (c.apanhado()) {
      while (vidaJLeiteAtual < vidaJleiteMax && c.totalRecuperado < coxinhaRecuperacao) {
        c.totalRecuperado = c.totalRecuperado + 1;
        vidaJLeiteAtual = vidaJLeiteAtual + 1;
      }
      totalComidas = totalComidas - 1;
      coxinhas.remove(c);
    }
  }
}

PImage brigadeiro;

public class Brigadeiro {
  private PImage spriteBrigadeiro;

  private int brigadeiroX = int(random(200, 500));
  private int brigadeiroY = int(random(-300, -1000));

  private int stepBrigadeiro;
  private int tempoSpriteBrigadeiro;

  private int totalRecuperado = 0;

  public Brigadeiro(int brigadeiroX, int brigadeiroY) {
    this.brigadeiroX = brigadeiroX;
    this.brigadeiroY = brigadeiroY;
  }

  public Brigadeiro() {
  }

  void display() {
    image (sombraComidas, brigadeiroX + 2, brigadeiroY + 21);

    if (millis() > tempoSpriteBrigadeiro + 75) {
      spriteBrigadeiro = brigadeiro.get(stepBrigadeiro, 0, 32, 31);
      stepBrigadeiro = stepBrigadeiro % 192 + 32;
      image(spriteBrigadeiro, brigadeiroX, brigadeiroY);
      tempoSpriteBrigadeiro = millis();
    } else {
      image(spriteBrigadeiro, brigadeiroX, brigadeiroY);
    }

    if (stepBrigadeiro == brigadeiro.width) {
      stepBrigadeiro = 0;
    }
  }

  void update() {
    brigadeiroY = brigadeiroY + 1;
  }

  boolean apanhado() {
    if (brigadeiroX + 32 > jLeiteX && brigadeiroX < jLeiteX + 63 && brigadeiroY + 31 > jLeiteY && brigadeiroY < jLeiteY + 126) {
      tempoGerarComida = int(millisAvancada);
      indexComida = 10;
      comidaGerada = false;
      return true;
    } else {
      return false;
    }
  }

  boolean saiuDaTela() {
    if (brigadeiroY > height) {
      return true;
    } else {
      return false;
    }
  }
}

ArrayList<Brigadeiro> brigadeiros;

int indexRandomBrigadeiroMapaBoss;

int brigadeiroRecuperacao = 4;

void brigadeiro() {
  if (totalComidas < 1) {
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      if (brigadeiros.size() == 0 && indexComida >= 0 && indexComida <= 4 && !telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
        brigadeiros.add(new Brigadeiro());
        totalComidas = totalComidas + 1;
      }
    }

    if (estadoJogo == "MapaCoveiro") {
      if (brigadeiros.size() == 0 && indexComida >= 0 && indexComida <= 4) {
        indexRandomBrigadeiroMapaBoss = int(random(0, valoresXMapaCoveiro.length));
        brigadeiros.add(new Brigadeiro(valoresXMapaCoveiro[indexRandomBrigadeiroMapaBoss], valoresYMapaCoveiro[indexRandomBrigadeiroMapaBoss]));
        totalComidas = totalComidas + 1;
      }
    }

    if (estadoJogo == "MapaFazendeiro") {
      if (brigadeiros.size() == 0 && indexComida >= 0 && indexComida <= 4) {
        indexRandomBrigadeiroMapaBoss = int(random(0, valoresXMapaFazendeiro.length));
        brigadeiros.add(new Brigadeiro(valoresXMapaFazendeiro[indexRandomBrigadeiroMapaBoss], valoresYMapaFazendeiro[indexRandomBrigadeiroMapaBoss]));
        totalComidas = totalComidas + 1;
      }
    }

    if (estadoJogo == "MapaPadre") {
      if (brigadeiros.size() == 0 && indexComida >= 0 && indexComida <= 4) {
        indexRandomBrigadeiroMapaBoss = int(random(0, valoresXMapaPadre.length));
        brigadeiros.add(new Brigadeiro(valoresXMapaPadre[indexRandomBrigadeiroMapaBoss], valoresYMapaPadre[indexRandomBrigadeiroMapaBoss]));
        totalComidas = totalComidas + 1;
      }
    }
  }

  for (int i = brigadeiros.size() - 1; i >= 0; i = i - 1) {
    Brigadeiro b = brigadeiros.get(i);
    b.display();
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      b.update();
    }
    if (b.saiuDaTela()) {
      totalComidas = totalComidas - 1;
      brigadeiros.remove(b);
    }
    if (b.apanhado()) {
      while (vidaJLeiteAtual < vidaJleiteMax && b.totalRecuperado < coxinhaRecuperacao) {
        b.totalRecuperado = b.totalRecuperado + 1;
        vidaJLeiteAtual = vidaJLeiteAtual + 1;
      }
      totalComidas = totalComidas - 1;
      brigadeiros.remove(b);
    }
  }
}

PImage queijo;

public class Queijo {
  private PImage spriteQueijo;

  private int queijoX = int(random(200, 500));
  private int queijoY = int(random(-300, -1000));

  private int stepQueijo;
  private int tempoSpriteQueijo;

  private int totalRecuperado = 0;

  public Queijo(int queijoX, int queijoY) {
    this.queijoX = queijoX;
    this.queijoY = queijoY;
  }

  public Queijo() {
  }

  void display() {
    image (sombraComidas, queijoX, queijoY + 19);

    if (millis() > tempoSpriteQueijo + 75) { 
      spriteQueijo = queijo.get(stepQueijo, 0, 31, 29); 
      stepQueijo = stepQueijo % 186 + 31;
      image(spriteQueijo, queijoX, queijoY); 
      tempoSpriteQueijo = millis();
    } else {
      image(spriteQueijo, queijoX, queijoY);
    }

    if (stepQueijo == queijo.width) {
      stepQueijo = 0;
    }
  }

  void update() {
    queijoY = queijoY + 1;
  }

  boolean apanhado() {
    if (queijoX + 31 > jLeiteX && queijoX < jLeiteX + 63 && queijoY + 29 > jLeiteY && queijoY < jLeiteY + 126) {
      tempoGerarComida = int(millisAvancada);
      indexComida = 10;
      comidaGerada = false;
      return true;
    } else {
      return false;
    }
  }

  boolean saiuDaTela() {
    if (queijoY > height) {
      return true;
    } else {
      return false;
    }
  }
}

ArrayList<Queijo> queijos;

int indexRandomQueijoMapaBoss;

int queijoRecuperacao = 3;

void queijo() {
  if (totalComidas < 1) {
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      if (queijos.size() == 0 && indexComida >= 5 && indexComida <= 7 && !telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
        queijos.add(new Queijo());
        totalComidas = totalComidas + 1;
      }
    }

    if (estadoJogo == "MapaCoveiro") {
      if (queijos.size() == 0 && indexComida >= 5 && indexComida <= 7) {
        indexRandomQueijoMapaBoss = int(random(0, valoresXMapaCoveiro.length));
        queijos.add(new Queijo(valoresXMapaCoveiro[indexRandomQueijoMapaBoss], valoresYMapaCoveiro[indexRandomQueijoMapaBoss]));
        totalComidas = totalComidas + 1;
      }
    }

    if (estadoJogo == "MapaFazendeiro") {
      if (queijos.size() == 0 && indexComida >= 5 && indexComida <= 7) {
        indexRandomQueijoMapaBoss = int(random(0, valoresXMapaFazendeiro.length));
        queijos.add(new Queijo(valoresXMapaFazendeiro[indexRandomQueijoMapaBoss], valoresYMapaFazendeiro[indexRandomQueijoMapaBoss]));
        totalComidas = totalComidas + 1;
      }
    }

    if (estadoJogo == "MapaPadre") {
      if (queijos.size() == 0 && indexComida >= 5 && indexComida <= 7) {
        indexRandomQueijoMapaBoss = int(random(0, valoresXMapaFazendeiro.length));
        queijos.add(new Queijo(valoresXMapaPadre[indexRandomQueijoMapaBoss], valoresYMapaPadre[indexRandomQueijoMapaBoss]));
        totalComidas = totalComidas + 1;
      }
    }
  }

  for (int i = queijos.size() - 1; i >= 0; i = i - 1) {
    Queijo q = queijos.get(i);
    q.display();
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      q.update();
    }
    if (q.saiuDaTela()) {
      totalComidas = totalComidas - 1;
      queijos.remove(q);
    }
    if (q.apanhado()) {
      while (vidaJLeiteAtual < vidaJleiteMax && q.totalRecuperado < coxinhaRecuperacao) {
        q.totalRecuperado = q.totalRecuperado + 1;
        vidaJLeiteAtual = vidaJLeiteAtual + 1;
      }
      totalComidas = totalComidas - 1;
      queijos.remove(q);
    }
  }
}