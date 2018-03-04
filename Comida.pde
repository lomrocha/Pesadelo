PImage foodShadow;

int tempoGerarComida;
int indexComida;

int amountRecovered;

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

public class Coxinha extends Geral {
  private int amountRecovered = 0;

  public Coxinha(int x, int y) {
    this.x = x;
    this.y = y;

    spriteImage = coxinha;
    spriteInterval = 75;
    spriteWidth = 28;
    spriteHeight = 30;
    movementY = 1;
  }

  public Coxinha() {
    this.x = int(random(200, 500));
    this.y = int(random(-300, -1000));

    spriteImage = coxinha;
    spriteInterval = 75;
    spriteWidth = 28;
    spriteHeight = 30;
    movementY = 1;
  }

  void display() {
    image (foodShadow, x, y + 20);

    super.display();
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
    if (c.hasExitScreen()) {
      totalComidas = totalComidas - 1;
      coxinhas.remove(c);
    }
    if (c.hasCollided()) {
      while (vidaJLeiteAtual < vidaJleiteMax && c.amountRecovered < coxinhaRecuperacao) {
        c.amountRecovered = c.amountRecovered + 1;
        vidaJLeiteAtual = vidaJLeiteAtual + 1;
      }
      totalComidas = totalComidas - 1;
      coxinhas.remove(c);
    }
  }
}

PImage brigadeiro;

public class Brigadeiro extends Geral {
  private int amountRecovered = 0;

  public Brigadeiro(int x, int y) {
    this.x = x;
    this.y = y;

    spriteImage = brigadeiro;
    spriteInterval = 75;
    spriteWidth = 32;
    spriteHeight = 31;
    movementY = 1;
  }

  public Brigadeiro() {
    this.x = int(random(200, 500));
    this.y = int(random(-300, -1000));

    spriteImage = brigadeiro;
    spriteInterval = 75;
    spriteWidth = 32;
    spriteHeight = 31;
    movementY = 1;
  }

  void display() {
    image (foodShadow, x, y + 20);

    super.display();
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
    if (b.hasExitScreen()) {
      totalComidas = totalComidas - 1;
      brigadeiros.remove(b);
    }
    if (b.hasCollided()) {
      while (vidaJLeiteAtual < vidaJleiteMax && b.amountRecovered < coxinhaRecuperacao) {
        b.amountRecovered = b.amountRecovered + 1;
        vidaJLeiteAtual = vidaJLeiteAtual + 1;
      }
      totalComidas = totalComidas - 1;
      brigadeiros.remove(b);
    }
  }
}

PImage queijo;

public class Queijo extends Geral {
  private int amountRecovered = 0;

  public Queijo(int x, int y) {
    this.x = x;
    this.y = y;

    spriteImage = coxinha;
    spriteInterval = 75;
    spriteWidth = 31;
    spriteHeight = 29;
    movementY = 1;
  }

  public Queijo() {
    this.x = int(random(200, 500));
    this.y = int(random(-300, -1000));

    spriteImage = coxinha;
    spriteInterval = 75;
    spriteWidth = 31;
    spriteHeight = 29;
    movementY = 1;
  }

  void display() {
    image (foodShadow, x, y + 19);

    super.display();
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
    if (q.hasExitScreen()) {
      totalComidas = totalComidas - 1;
      queijos.remove(q);
    }
    if (q.hasCollided()) {
      while (vidaJLeiteAtual < vidaJleiteMax && q.amountRecovered < coxinhaRecuperacao) {
        q.amountRecovered = q.amountRecovered + 1;
        vidaJLeiteAtual = vidaJLeiteAtual + 1;
      }
      totalComidas = totalComidas - 1;
      queijos.remove(q);
    }
  }
}