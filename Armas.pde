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

  if (!telaTutorialAndandoAtiva) {
    if (!armaGerada) {
      indexArma = int(random(0, 10));
      tempoGerarArma = millis();
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
      caixaItemPedra = stone.get(0, 0, 34, 27);
      image(caixaItemPedra, 729, 516);
    } else if (item == 2) {
      image(caixaItemPa, 705, 510);
    } else if (item == 3) {
      image(caixaItemChicote, 705, 510);
    }
    image(imagensNumerosItem[totalItem - 1], 725, 552);
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
    if (jLeiteX + 160 > e.getX() && jLeiteX - 70 < e.getX() + 76 && jLeiteY + 56 > e.getY() && jLeiteY - 44 < e.getY() + 126) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  boolean acertouEsqueletoChute(EsqueletoChute e) {
    if (jLeiteX + 160 > e.getX() && jLeiteX - 70 < e.getX() + 49 && jLeiteY + 56 > e.getY() && jLeiteY - 44 < e.getY() + 74) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  boolean acertouCachorro(Cachorro c) {
    if (jLeiteX + 160 > c.getX() && jLeiteX - 70 < c.getX() + 45 && jLeiteY + 56 > c.getY() && jLeiteY - 44 < c.getY() + 83) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  boolean acertouCorvo(Corvo c) {
    if (jLeiteX + 160 > c.getX() + 45 && jLeiteX - 70 < c.getX() + 75 && jLeiteY + 56 > c.getY() && jLeiteY - 44 < c.getY() + 86) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  boolean acertouEsqueletoRaiva(EsqueletoRaiva e) {
    if (jLeiteX + 160 > e.getX() && jLeiteX - 70 < e.getX() + 76 && jLeiteY + 56 > e.getY() && jLeiteY - 44 < e.getY() + 126) {
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
    if (pedraFogoX + 16 > e.getX() && pedraFogoX < e.getX() + 76 && pedraFogoY + 26 > e.getY() && pedraFogoY < e.getY() + 126) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  boolean acertouEsqueletoChute(EsqueletoChute e) {
    if (pedraFogoX + 16 > e.getX() && pedraFogoX < e.getX() + 49 && pedraFogoY + 26 > e.getY() && pedraFogoY < e.getY() + 74) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  boolean acertouCachorro(Cachorro c) {
    if (pedraFogoX + 16 > c.getX() && pedraFogoX < c.getX() + 45 && pedraFogoY + 26 > c.getY() && pedraFogoY < c.getY() + 83) {
      return true;
    } else { 
      return false;
    }
  }

  boolean acertouCorvo(Corvo c) {
    if (pedraFogoX + 16 > c.getX() + 45 && pedraFogoX < c.getX() + 75 && pedraFogoY + 26 > c.getY() && pedraFogoY < c.getY() + 86) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  boolean acertouEsqueletoRaiva(EsqueletoRaiva e) {
    if (pedraFogoX + 16 > e.getX() && pedraFogoX < e.getX() + 76 && pedraFogoY + 26 > e.getY() && pedraFogoY < e.getY() + 126) {
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
    if (jLeiteX + 56 > e.getX() && jLeiteX + 50 < e.getX() + 76 && jLeiteY > e.getY() && jLeiteY - 140 < e.getY() + 126) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  boolean acertouEsqueletoChute(EsqueletoChute e) {
    if (jLeiteX + 56 > e.getX() && jLeiteX + 50 < e.getX() + 49 && jLeiteY > e.getY() && jLeiteY - 140 < e.getY() + 74) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  boolean acertouCachorro(Cachorro c) {
    if (jLeiteX + 56 > c.getX() && jLeiteX + 50 < c.getX() + 45 && jLeiteY > c.getY() && jLeiteY - 140 < c.getY() + 83) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  boolean acertouCorvo(Corvo c) {
    if (jLeiteX + 56 > c.getX() + 45 && jLeiteX + 50 < c.getX() + 75 && jLeiteY > c.getY() && jLeiteY - 140 < c.getY() + 86) {
      hitInimigosMostrando = true;
      return true;
    } else { 
      return false;
    }
  }

  boolean acertouEsqueletoRaiva(EsqueletoRaiva e) {
    if (jLeiteX + 56 > e.getX() && jLeiteX + 50 < e.getX() + 76 && jLeiteY > e.getY() && jLeiteY - 140 < e.getY() + 126) {
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