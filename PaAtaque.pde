PImage shovelAttack;

public class PaAtaque extends Arma {
  public PaAtaque() {
    setX(jLeiteX - 70);
    setY(jLeiteY - 44);

    setSpriteImage(shovelAttack);
    setSpriteInterval(90);
    setSpriteWidth(234);
    setSpriteHeight(173);

    setDeleteObject(false);
    setDamageBoss(false);
    setIsStone(false);

    setFirstCollisionX(jLeiteX + 160);
    setSecondCollisionX(jLeiteX - 70);
    setFirstCollisionY(jLeiteY + 56);
    setSecondCollisionY(jLeiteY - 44);
  }

  void update() {
    setX(jLeiteX - 70);
    setY(jLeiteY - 44);
  }
}

boolean umaPa;

void paAtaque() {
  if (jLeiteUsoItem) {
    if (armas.size() == 0 && item == 2 && totalItem > 0 && !umaPa) {
      armas.add(new PaAtaque());
      totalItem = totalItem - 1;
      umaPa = true;
    }
  }

  for (int i = armas.size() - 1; i >= 0; i = i - 1) {
    Arma a = armas.get(i);
    a.update();
    a.display();
    if (a.getDeleteObject()) {
      armas.remove(a);
    }
    if (estadoJogo == "MapaCoveiro") {
      if (a.hasHitCoveiro() && !a.getDamageBoss()) {
        if (sonsAtivos) {
          indexRandomSomCoveiroTomandoDano = int(random(0, sonsCoveiroTomandoDano.length));
          sonsCoveiroTomandoDano[indexRandomSomCoveiroTomandoDano].rewind();
          sonsCoveiroTomandoDano[indexRandomSomCoveiroTomandoDano].play();
        }
        vidaCoveiroAtual = vidaCoveiroAtual - 1;
        a.setDamageBoss(true);
      }
    }
    if (estadoJogo == "MapaFazendeiro") {
      if (a.hasHitFazendeiro() && !a.getDamageBoss()) {
        if (sonsAtivos) {
          indexRandomSomFazendeiroTomandoDano = int(random(0, sonsFazendeiroTomandoDano.length));
          sonsFazendeiroTomandoDano[indexRandomSomFazendeiroTomandoDano].rewind();
          sonsFazendeiroTomandoDano[indexRandomSomFazendeiroTomandoDano].play();
        }
        vidaFazendeiroAtual = vidaFazendeiroAtual - 2;
        a.setDamageBoss(true);
      }
    }
    if (estadoJogo == "MapaPadre") {
      if (a.hasHitPadre() && !a.getDamageBoss()) {
        if (vidaPadreAtual > 0) {
          if (sonsAtivos) {
            indexRandomSomPadreTomandoDano = int(random(0, sonsPadreTomandoDano.length));
            sonsPadreTomandoDano[indexRandomSomPadreTomandoDano].rewind();
            sonsPadreTomandoDano[indexRandomSomPadreTomandoDano].play();
          }
          vidaPadreAtual = vidaPadreAtual - 2;
          a.setDamageBoss(true);
        } else {
          if (sonsAtivos) {
            indexRandomSomPadreTomandoDano = int(random(0, sonsPadreRaivaTomandoDano.length));
            sonsPadreRaivaTomandoDano[indexRandomSomPadreTomandoDano].rewind();
            sonsPadreRaivaTomandoDano[indexRandomSomPadreTomandoDano].play();
          }
          vidaPadreRaivaAtual = vidaPadreRaivaAtual - 2;
          a.setDamageBoss(true);
        }
      }
    }
  }
}