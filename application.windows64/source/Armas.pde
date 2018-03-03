int item;

int totalItem;
int primeiraPedra;

int tempoGerarArma;
int indexArma;

int totalArmas;

boolean armaGerada;

void armas() {
  if (totalItem == 0 && !jLeiteUsoItem && pedras.size() == 0 && pas.size() == 0 && chicotes.size() == 0) {
    item = 0;
    totalArmas = 0;
  }

  if (!telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
    if (!armaGerada) {
      indexArma = int(random(0, 10));
      tempoGerarArma = int(millisAvancada);
      armaGerada = true;
    }
  }

  pa();
  paAtaque();
  pedra();
  pedraAtirada();
  chicote();
  chicoteAtaque();
}

PImage caixaNumeroItem;
PImage[] imagensNumerosItem = new PImage [15];
PImage imagemNumeroItemInfinito;

PImage caixaItemPa;
PImage caixaItemPedra;
PImage caixaItemChicote;

void caixaNumeroItem() {
  image(caixaNumeroItem, 705, 510);
  if (totalItem - 1 >= 0) {
    if (item == 1) {
      caixaItemPedra = pedra.get(0, 0, 34, 27);
      image(caixaItemPedra, 729, 516);
    } else if (item == 2) {
      image(caixaItemPa, 705, 510);
    } else if (item == 3) {
      image(caixaItemChicote, 705, 510);
    }
    image(imagensNumerosItem[totalItem - 1], 725, 552);
  }
}

PImage pa;
PImage sombraPa;

public class Pa {
  private PImage spritePa;

  private int paX = int(random(100, 616));
  private int paY = int(random(-300, -1000));

  private int stepPa;
  private int tempoSpritePa;

  public Pa() {
  }

  public Pa(int paX, int paY) {
    this.paX = paX;
    this.paY = paY;
  }

  void display() {
    image (sombraPa, paX + 1, paY + 85);

    if (millis() > tempoSpritePa + 75) {
      spritePa = pa.get(stepPa, 0, 84, 91); 
      stepPa = stepPa % 504 + 84;
      image(spritePa, paX, paY); 
      tempoSpritePa = millis();
    } else {
      image(spritePa, paX, paY);
    }

    if (stepPa == pa.width) {
      stepPa = 0;
    }
  }

  void update() {
    paY = paY + 1;
  }

  boolean apanhado() {
    if (paX + 84 > jLeiteX && paX < jLeiteX + 63 && paY + 91 > jLeiteY && paY < jLeiteY + 126) {
      tempoGerarArma = int(millisAvancada);
      item = 2;
      totalItem = 7;
      armaGerada = false;
      return true;
    } else {
      return false;
    }
  }

  boolean saiuDaTela() {
    if (paY > height) {
      return true;
    } else {
      return false;
    }
  }
}

ArrayList<Pa> pas;

int indexRandomPaMapaBoss;

void pa() {
  if (totalArmas == 0 && millisAvancada > tempoGerarArma + 15000) {
    if (estadoJogo == "PrimeiroMapa") {
      if (pas.size() == 0 && indexArma >= 0 && indexArma <= 9 && !telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
        pas.add(new Pa());
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "SegundoMapa") {
      if (pas.size() == 0 && indexArma >= 0 && indexArma <= 4 && !telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
        pas.add(new Pa());
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "TerceiroMapa") {
      if (pas.size() == 0 && indexArma >= 0 && indexArma <= 2 && !telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
        pas.add(new Pa());
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "MapaCoveiro") {
      if (pas.size() == 0 && indexArma >= 0 && indexArma <= 9) {
        indexRandomPaMapaBoss = int(random(0, valoresXMapaCoveiro.length));
        pas.add(new Pa(valoresXMapaCoveiro[indexRandomPaMapaBoss], valoresYMapaCoveiro[indexRandomPaMapaBoss]));
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "MapaFazendeiro") {
      if (pas.size() == 0 && indexArma >= 0 && indexArma <= 4) {
        indexRandomPaMapaBoss = int(random(0, valoresXMapaFazendeiro.length));
        pas.add(new Pa(valoresXMapaFazendeiro[indexRandomPaMapaBoss], valoresYMapaFazendeiro[indexRandomPaMapaBoss]));
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "MapaPadre") {
      if (pas.size() == 0 && indexArma >= 0 && indexArma <= 2) {
        indexRandomPaMapaBoss = int(random(0, valoresXMapaPadre.length));
        pas.add(new Pa(valoresXMapaPadre[indexRandomPaMapaBoss], valoresYMapaPadre[indexRandomPaMapaBoss]));
        totalArmas = totalArmas + 1;
      }
    }
  }

  for (int i = pas.size() - 1; i >= 0; i = i - 1) {
    Pa p = pas.get(i);
    p.display();
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      p.update();
    }
    if (p.apanhado() || p.saiuDaTela()) {
      pas.remove(p);
    }
  }
}

PImage paAtaque;

public class PaAtaque {
  private PImage spritePaAtaque;

  private int paAtaqueX = jLeiteX - 70;
  private int paAtaqueY = jLeiteY - 44;

  private int stepPaAtaque;
  private int tempoSpritePaAtaque;

  private boolean umDanoBoss;
  private boolean deletarPa;

  void display() {
    if (millis() > tempoSpritePaAtaque + 90) {
      spritePaAtaque = paAtaque.get(stepPaAtaque, 0, 234, 173);
      stepPaAtaque = stepPaAtaque % 702 + 234;
      image(spritePaAtaque, paAtaqueX, paAtaqueY);
      tempoSpritePaAtaque = millis();
    } else {
      image(spritePaAtaque, paAtaqueX, paAtaqueY);
    }

    if (stepPaAtaque == paAtaque.width) {
      deletarPa = true;
      stepPaAtaque = 0;
    }
  }

  void update() {
    paAtaqueX = jLeiteX - 70;
    paAtaqueY = jLeiteY - 44;
  }

  boolean acertouEsqueleto(Esqueleto e) {
    if (jLeiteX + 160 > e.esqueletoX && jLeiteX - 70 < e.esqueletoX + 76 && jLeiteY + 56 > e.esqueletoY && jLeiteY - 44 < e.esqueletoY + 126) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  boolean acertouEsqueletoChute(EsqueletoChute e) {
    if (jLeiteX + 160 > e.esqueletoChuteX && jLeiteX - 70 < e.esqueletoChuteX + 49 && jLeiteY + 56 > e.esqueletoChuteY && jLeiteY - 44 < e.esqueletoChuteY + 74) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  boolean acertouCachorro(Cachorro c) {
    if (jLeiteX + 160 > c.cachorroX && jLeiteX - 70 < c.cachorroX + 45 && jLeiteY + 56 > c.cachorroY && jLeiteY - 44 < c.cachorroY + 83) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  boolean acertouCorvo(Corvo c) {
    if (jLeiteX + 160 > c.corvoX + 45 && jLeiteX - 70 < c.corvoX + 75 && jLeiteY + 56 > c.corvoY && jLeiteY - 44 < c.corvoY + 86) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  boolean acertouEsqueletoRaiva(EsqueletoRaiva e) {
    if (jLeiteX + 160 > e.esqueletoRaivaX && jLeiteX - 70 < e.esqueletoRaivaX + 76 && jLeiteY + 56 > e.esqueletoRaivaY && jLeiteY - 44 < e.esqueletoRaivaY + 126) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  boolean acertouCoveiro() {
    if (jLeiteX + 160 > coveiroX && jLeiteX - 70 < coveiroX + 169 && jLeiteY + 56 > coveiroY && jLeiteY - 44 < coveiroY + 188) {
      hitBossesMostrando = true;
      hitBosses(coveiroX, coveiroY + 20);
      return true;
    } else { 
      return false;
    }
  }

  boolean acertouFazendeiro() {
    if (jLeiteX + 160 > fazendeiroX + 60 && jLeiteX - 70 < fazendeiroX + 188 && jLeiteY + 56 > fazendeiroY && jLeiteY - 44 < fazendeiroY + 125) {
      if (!pneuRolandoPrimeiraVez) {
        hitBossesMostrando = true;
        hitBosses(fazendeiroX + 30, fazendeiroY + 20);
        return true;
      } else {
        hitEscudoMostrando = true;
        hitEscudo(fazendeiroX + 30, fazendeiroY + 20);
        return false;
      }
    } else { 
      return false;
    }
  }

  boolean acertouPadre() {
    if (jLeiteX + 160 > padreX + 20 && jLeiteX - 70 < padreX + 110 && jLeiteY + 56 > padreY && jLeiteY - 44 < padreY + 152) {
      hitBossesMostrando = true;
      hitBosses(padreX, padreY);
      return true;
    } else { 
      return false;
    }
  }
}

ArrayList<PaAtaque> pasAtaque;

boolean umaPa;

void paAtaque() {
  if (jLeiteUsoItem) {
    if (pasAtaque.size() == 0 && item == 2 && totalItem > 0 && !umaPa) {
      pasAtaque.add(new PaAtaque());
      totalItem = totalItem - 1;
      umaPa = true;
    }
  }

  for (int i = pasAtaque.size() - 1; i >= 0; i = i - 1) {
    PaAtaque p = pasAtaque.get(i);
    p.display();
    p.update();
    if (p.deletarPa) {
      pasAtaque.remove(p);
    }
    if (estadoJogo == "MapaCoveiro") {
      if (p.acertouCoveiro() && !p.umDanoBoss) {
        if (sonsAtivos) {
          indexRandomSomCoveiroTomandoDano = int(random(0, sonsCoveiroTomandoDano.length));
          sonsCoveiroTomandoDano[indexRandomSomCoveiroTomandoDano].rewind();
          sonsCoveiroTomandoDano[indexRandomSomCoveiroTomandoDano].play();
        }
        vidaCoveiroAtual = vidaCoveiroAtual - 1;
        p.umDanoBoss = true;
      }
    }
    if (estadoJogo == "MapaFazendeiro") {
      if (p.acertouFazendeiro() && !p.umDanoBoss) {
        if (sonsAtivos) {
          indexRandomSomFazendeiroTomandoDano = int(random(0, sonsFazendeiroTomandoDano.length));
          sonsFazendeiroTomandoDano[indexRandomSomFazendeiroTomandoDano].rewind();
          sonsFazendeiroTomandoDano[indexRandomSomFazendeiroTomandoDano].play();
        }
        vidaFazendeiroAtual = vidaFazendeiroAtual - 2;
        p.umDanoBoss = true;
      }
    }
    if (estadoJogo == "MapaPadre") {
      if (p.acertouPadre() && !p.umDanoBoss) {
        if (vidaPadreAtual > 0) {
          if (sonsAtivos) {
            indexRandomSomPadreTomandoDano = int(random(0, sonsPadreTomandoDano.length));
            sonsPadreTomandoDano[indexRandomSomPadreTomandoDano].rewind();
            sonsPadreTomandoDano[indexRandomSomPadreTomandoDano].play();
          }
          vidaPadreAtual = vidaPadreAtual - 2;
          p.umDanoBoss = true;
        } else {
          if (sonsAtivos) {
            indexRandomSomPadreTomandoDano = int(random(0, sonsPadreRaivaTomandoDano.length));
            sonsPadreRaivaTomandoDano[indexRandomSomPadreTomandoDano].rewind();
            sonsPadreRaivaTomandoDano[indexRandomSomPadreTomandoDano].play();
          }
          vidaPadreRaivaAtual = vidaPadreRaivaAtual - 2;
          p.umDanoBoss = true;
        }
      }
    }
  }
}

PImage pedra;
PImage sombraPedra;

public class Pedra {
  private PImage spritePedra;

  private int pedraX = int(random(100, 666));
  private int pedraY = int(random(-300, -1000));

  private int stepPedra;
  private int tempoSpritePedra;

  public Pedra() {
  }

  public Pedra(int pedraX, int pedraY) {
    this.pedraX = pedraX;
    this.pedraY = pedraY;
  }

  void display() {
    image (sombraPedra, pedraX, pedraY + 17);

    if (millis() > tempoSpritePedra + 75) {
      spritePedra = pedra.get(stepPedra, 0, 34, 27); 
      stepPedra = stepPedra % 204 + 34;
      image(spritePedra, pedraX, pedraY); 
      tempoSpritePedra = millis();
    } else {
      image(spritePedra, pedraX, pedraY);
    }

    if (stepPedra == pedra.width) {
      stepPedra = 0;
    }
  }

  void update() {
    pedraY = pedraY + 1;
  }

  boolean apanhado() {
    if (pedraX + 34 > jLeiteX && pedraX < jLeiteX + 63 && pedraY + 27 > jLeiteY && pedraY < jLeiteY + 126) {
      tempoGerarArma = int(millisAvancada);
      primeiraPedra = primeiraPedra + 1;
      item = 1;
      totalItem = 15;
      armaGerada = false;
      return true;
    } else {
      return false;
    }
  }

  boolean saiuDaTela() {
    if (pedraY > height) {
      return true;
    } else {
      return false;
    }
  }
}

ArrayList<Pedra> pedras;

int indexRandomPedraMapaBoss;

void pedra() {
  if (totalArmas == 0 && millisAvancada > tempoGerarArma + 15000) {
    if (estadoJogo == "SegundoMapa") {
      if (pedras.size() == 0 && indexArma >= 5 && indexArma <= 9 && !telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
        pedras.add(new Pedra());
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "TerceiroMapa") {
      if (pedras.size() == 0 && indexArma >= 3 && indexArma <= 4 && !telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
        pedras.add(new Pedra());
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "MapaFazendeiro") {
      if (pas.size() == 0 && indexArma >= 5 && indexArma <= 9) {
        indexRandomPedraMapaBoss = int(random(0, valoresXMapaFazendeiro.length));
        pedras.add(new Pedra(valoresXMapaFazendeiro[indexRandomPedraMapaBoss], valoresYMapaFazendeiro[indexRandomPedraMapaBoss]));
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "MapaPadre") {
      if (pas.size() == 0 && indexArma >= 3 && indexArma <= 4) {
        indexRandomPedraMapaBoss = int(random(0, valoresXMapaPadre.length));
        pedras.add(new Pedra(valoresXMapaPadre[indexRandomPedraMapaBoss], valoresYMapaPadre[indexRandomPedraMapaBoss]));
        totalArmas = totalArmas + 1;
      }
    }
  }

  for (int i = pedras.size() - 1; i >= 0; i = i - 1) {
    Pedra p = pedras.get(i);
    p.display();
    if (estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      p.update();
    }
    if (p.apanhado() || p.saiuDaTela()) {
      pedras.remove(p);
    }
  }
}

PImage pedraFogo;

public class PedraAtirada {
  private int pedraFogoX = jLeiteX + 52;
  private int pedraFogoY = jLeiteY + 26;

  private boolean bateuNoEscudo;

  void display() {
    image(pedraFogo, pedraFogoX, pedraFogoY);
  }

  void update() {
    pedraFogoY = pedraFogoY - 10;
  }

  boolean acertouEsqueleto(Esqueleto e) {
    if (pedraFogoX + 16 > e.esqueletoX && pedraFogoX < e.esqueletoX + 76 && pedraFogoY + 26 > e.esqueletoY && pedraFogoY < e.esqueletoY + 126) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  boolean acertouEsqueletoChute(EsqueletoChute e) {
    if (pedraFogoX + 16 > e.esqueletoChuteX && pedraFogoX < e.esqueletoChuteX + 49 && pedraFogoY + 26 > e.esqueletoChuteY && pedraFogoY < e.esqueletoChuteY + 74) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  boolean acertouCachorro(Cachorro c) {
    if (pedraFogoX + 16 > c.cachorroX && pedraFogoX < c.cachorroX + 45 && pedraFogoY + 26 > c.cachorroY && pedraFogoY < c.cachorroY + 83) {
      return true;
    } else { 
      return false;
    }
  }

  boolean acertouCorvo(Corvo c) {
    if (pedraFogoX + 16 > c.corvoX + 45 && pedraFogoX < c.corvoX + 75 && pedraFogoY + 26 > c.corvoY && pedraFogoY < c.corvoY + 86) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  boolean acertouEsqueletoRaiva(EsqueletoRaiva e) {
    if (pedraFogoX + 16 > e.esqueletoRaivaX && pedraFogoX < e.esqueletoRaivaX + 76 && pedraFogoY + 26 > e.esqueletoRaivaY && pedraFogoY < e.esqueletoRaivaY + 126) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  boolean acertouFazendeiro() {
    if (pedraFogoX + 16 > fazendeiroX + 60 && pedraFogoX < fazendeiroX + 188 && pedraFogoY + 26 > fazendeiroY && pedraFogoY < fazendeiroY + 125) {
      if (!pneuRolandoPrimeiraVez) {
        hitBossesMostrando = true;
        hitBosses(fazendeiroX + 30, fazendeiroY + 20);
        return true;
      } else {
        hitEscudoMostrando = true;
        hitEscudo(fazendeiroX + 30, fazendeiroY + 20);
        bateuNoEscudo = true;
        return false;
      }
    } else { 
      return false;
    }
  }

  boolean acertouPadre() {
    if (pedraFogoX + 16 > padreX + 20 && pedraFogoX < padreX + 110 && pedraFogoY + 26 > padreY && pedraFogoY < padreY + 152) {
      hitBossesMostrando = true;
      hitBosses(padreX, padreY);
      return true;
    } else { 
      return false;
    }
  }

  boolean saiuDaTela() {
    if (pedraFogoY + pedraFogo.height < 0) {
      return true;
    } else {
      return false;
    }
  }
}

ArrayList<PedraAtirada> pedrasAtiradas;

int tempoPedraAtirada;

boolean umaPedra;

void pedraAtirada() {
  if (jLeiteUsoItem) {
    if (pedrasAtiradas.size() == 0 && item == 1 && totalItem > 0 && millis() > tempoPedraAtirada + 135 && !umaPedra) {
      pedrasAtiradas.add(new PedraAtirada());
      totalItem = totalItem - 1;
      umaPedra = true;
    }
  }

  for (int i = pedrasAtiradas.size() - 1; i >= 0; i = i - 1) {
    PedraAtirada p = pedrasAtiradas.get(i);
    p.display();
    p.update();
    if (p.saiuDaTela() || p.bateuNoEscudo) {
      pedrasAtiradas.remove(p);
    }
    if (estadoJogo == "MapaFazendeiro") {
      if (p.acertouFazendeiro()) {
        if (sonsAtivos) {
          indexRandomSomFazendeiroTomandoDano = int(random(0, 4));
          sonsFazendeiroTomandoDano[indexRandomSomFazendeiroTomandoDano].rewind();
          sonsFazendeiroTomandoDano[indexRandomSomFazendeiroTomandoDano].play();
        }
        vidaFazendeiroAtual = vidaFazendeiroAtual - 2;
        pedrasAtiradas.remove(p);
      }
    }
    if (estadoJogo == "MapaPadre") {
      if (p.acertouPadre()) {
        if (vidaPadreAtual > 0) {
          if (sonsAtivos) {
            indexRandomSomPadreTomandoDano = int(random(0, sonsPadreTomandoDano.length));
            sonsPadreTomandoDano[indexRandomSomPadreTomandoDano].rewind();
            sonsPadreTomandoDano[indexRandomSomPadreTomandoDano].play();
          }
          vidaPadreAtual = vidaPadreAtual - 2;
        } else {
          if (sonsAtivos) {
            indexRandomSomPadreTomandoDano = int(random(0, sonsPadreRaivaTomandoDano.length));
            sonsPadreRaivaTomandoDano[indexRandomSomPadreTomandoDano].rewind();
            sonsPadreRaivaTomandoDano[indexRandomSomPadreTomandoDano].play();
          }
          vidaPadreRaivaAtual = vidaPadreRaivaAtual - 2;
        }
        pedrasAtiradas.remove(p);
      }
    }
  }
}

PImage chicote;
PImage sombraChicote;

public class Chicote {
  private PImage spriteChicote;

  private int chicoteX = int(random(200, 500));
  private int chicoteY = int(random(-300, -1000));

  private int stepChicote;
  private int tempoSpriteChicote;

  public Chicote() {
  }

  public Chicote(int chicoteX, int chicoteY) {
    this.chicoteX = chicoteX;
    this.chicoteY = chicoteY;
  }

  void display() {
    image (sombraChicote, chicoteX + 10, chicoteY + 76);

    if (millis() > tempoSpriteChicote + 75) {
      spriteChicote = chicote.get(stepChicote, 0, 101, 91); 
      stepChicote = stepChicote % 606 + 101;
      image(spriteChicote, chicoteX, chicoteY); 
      tempoSpriteChicote = millis();
    } else {
      image(spriteChicote, chicoteX, chicoteY);
    }

    if (stepChicote == chicote.width) {
      stepChicote = 0;
    }
  }

  void update() {
    chicoteY = chicoteY + 1;
  }

  boolean apanhado() {
    if (chicoteX + 101 > jLeiteX && chicoteX < jLeiteX + 63 && chicoteY + 91 > jLeiteY && chicoteY < jLeiteY + 126) {
      tempoGerarArma = int(millisAvancada);
      item = 3;
      totalItem = 10;
      armaGerada = false;
      return true;
    } else {
      return false;
    }
  }

  boolean saiuDaTela() {
    if (chicoteY > height) {
      return true;
    } else {
      return false;
    }
  }
}

ArrayList<Chicote> chicotes;

int indexRandomChicoteMapaBoss;

void chicote() {
  if (totalArmas == 0 && millisAvancada > tempoGerarArma + 15000) {
    if (estadoJogo == "TerceiroMapa") {
      if (chicotes.size() == 0 && indexArma >= 5 && indexArma <= 9 && !telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
        chicotes.add(new Chicote());
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "MapaPadre") {
      if (chicotes.size() == 0 && indexArma >= 5 && indexArma <= 9) {
        indexRandomChicoteMapaBoss = int(random(0, valoresXMapaPadre.length));
        chicotes.add(new Chicote(valoresXMapaPadre[indexRandomChicoteMapaBoss], valoresYMapaPadre[indexRandomChicoteMapaBoss]));
        totalArmas = totalArmas + 1;
      }
    }
  }

  for (int i = chicotes.size() - 1; i >= 0; i = i - 1) {
    Chicote c = chicotes.get(i);
    c.display();
    if (estadoJogo == "TerceiroMapa") {
      c.update();
    }
    if (c.apanhado() || c.saiuDaTela()) {
      chicotes.remove(c);
    }
  }
}

PImage chicoteAtaque;

public class ChicoteAtaque {
  private PImage spriteChicoteArma;

  private int chicoteArmaX = jLeiteX - 70;
  private int chicoteArmaY = jLeiteY - 140;

  private int stepChicoteAtaque;
  private int tempoSpriteChiteAtaque;

  private boolean umDanoBoss;
  private boolean deletarChicote;

  void display() {
    if (millis() > tempoSpriteChiteAtaque + 110) {
      spriteChicoteArma = chicoteAtaque.get(stepChicoteAtaque, 0, 234, 278); 
      stepChicoteAtaque = stepChicoteAtaque % 702 + 234;
      image(spriteChicoteArma, chicoteArmaX, chicoteArmaY); 
      tempoSpriteChiteAtaque = millis();
    } else {
      image(spriteChicoteArma, chicoteArmaX, chicoteArmaY);
    }

    if (stepChicoteAtaque == chicoteAtaque.width) {
      stepChicoteAtaque = 0;
      deletarChicote = true;
    }
  }

  void update() {
    chicoteArmaX = jLeiteX - 70;
    chicoteArmaY = jLeiteY - 140;
  }

  boolean acertouEsqueleto(Esqueleto e) {
    if (jLeiteX + 56 > e.esqueletoX && jLeiteX + 50 < e.esqueletoX + 76 && jLeiteY > e.esqueletoY && jLeiteY - 140 < e.esqueletoY + 126) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  boolean acertouEsqueletoChute(EsqueletoChute e) {
    if (jLeiteX + 56 > e.esqueletoChuteX && jLeiteX + 50 < e.esqueletoChuteX + 49 && jLeiteY > e.esqueletoChuteY && jLeiteY - 140 < e.esqueletoChuteY + 74) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  boolean acertouCachorro(Cachorro c) {
    if (jLeiteX + 56 > c.cachorroX && jLeiteX + 50 < c.cachorroX + 45 && jLeiteY > c.cachorroY && jLeiteY - 140 < c.cachorroY + 83) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  boolean acertouCorvo(Corvo c) {
    if (jLeiteX + 56 > c.corvoX + 45 && jLeiteX + 50 < c.corvoX + 75 && jLeiteY > c.corvoY && jLeiteY - 140 < c.corvoY + 86) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  boolean acertouEsqueletoRaiva(EsqueletoRaiva e) {
    if (jLeiteX + 56 > e.esqueletoRaivaX && jLeiteX + 50 < e.esqueletoRaivaX + 76 && jLeiteY > e.esqueletoRaivaY && jLeiteY - 140 < e.esqueletoRaivaY + 126) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  boolean acertouPadre() {
    if (jLeiteX + 56 > padreX + 20 && jLeiteX + 50 < padreX + 110 && jLeiteY > padreY && jLeiteY - 140 < padreY + 152) {
      hitBossesMostrando = true;
      hitBosses(padreX, padreY);
      return true;
    } else { 
      return false;
    }
  }
}

ArrayList<ChicoteAtaque> chicotesAtaque;

boolean umChicote;

void chicoteAtaque() {
  if (jLeiteUsoItem) {
    if (chicotesAtaque.size() == 0 && item == 3 && totalItem > 0 && !umChicote) {
      chicotesAtaque.add(new ChicoteAtaque());
      totalItem = totalItem - 1;
      umChicote = true;
    }
  }

  for (int i = chicotesAtaque.size() - 1; i >= 0; i = i - 1) {
    ChicoteAtaque c = chicotesAtaque.get(i);
    c.display();
    c.update();
    if (c.deletarChicote) {
      chicotesAtaque.remove(c);
    }

    if (estadoJogo == "MapaPadre") {
      if (c.acertouPadre() && !c.umDanoBoss) {
        if (vidaPadreAtual > 0) {
          if (sonsAtivos) {
            indexRandomSomPadreTomandoDano = int(random(0, sonsPadreTomandoDano.length));
            sonsPadreTomandoDano[indexRandomSomPadreTomandoDano].rewind();
            sonsPadreTomandoDano[indexRandomSomPadreTomandoDano].play();
          }
          vidaPadreAtual = vidaPadreAtual - 2;
          c.umDanoBoss = true;
        } else {
          if (sonsAtivos) {
            indexRandomSomPadreTomandoDano = int(random(0, sonsPadreRaivaTomandoDano.length));
            sonsPadreRaivaTomandoDano[indexRandomSomPadreTomandoDano].rewind();
            sonsPadreRaivaTomandoDano[indexRandomSomPadreTomandoDano].play();
          }
          vidaPadreRaivaAtual = vidaPadreRaivaAtual - 2;
          c.umDanoBoss = true;
        }
      }
    }
  }
}