PImage stoneAttack;

public class PedraAtirada extends Arma {
  public PedraAtirada() {
    setX(jLeiteX + 52);
    setY(jLeiteY + 26);

    setSpriteImage(stoneAttack);
    setSpriteInterval(90);
    setSpriteWidth(0);
    setSpriteHeight(0);

    setDeleteWeapon(false);
    setDamageBoss(false);
    setIsStone(true);

    setFirstCollisionX(getX() + 16);
    setSecondCollisionX(getX());
    setFirstCollisionY(getY() + 26);
    setSecondCollisionY(getY());
  }

  void display() {
    image(stoneAttack, getX(), getY());
  }

  void update() {
    setY(getY() - 10);
  }

  boolean hasHitFazendeiro() {
    if (getFirstCollisionX() > fazendeiroX + 60 && getSecondCollisionX() < fazendeiroX + 188 && getFirstCollisionY() > fazendeiroY && getSecondCollisionY() < fazendeiroY + 125) {
      if (!pneuRolandoPrimeiraVez) {
        hitBossesMostrando = true;
        hitBosses(fazendeiroX + 30, fazendeiroY + 20);
        return true;
      } else {
        hitEscudoMostrando = true;
        hitEscudo(fazendeiroX + 30, fazendeiroY + 20);
        setDeleteWeapon(true);
        return false;
      }
    } 

    return false;
  }

  boolean hasExitScreen() {
    if (getX() + stoneAttack.height < 0) {
      return true;
    } 

    return false;
  }
}

int tempoPedraAtirada;

boolean umaPedra;

void pedraAtirada() {
  if (jLeiteUsoItem) {
    if (armas.size() == 0 && item == 1 && totalItem > 0 && millis() > tempoPedraAtirada + 135 && !umaPedra) {
      armas.add(new PedraAtirada());
      totalItem = totalItem - 1;
      umaPedra = true;
    }
  }

  for (int i = armas.size() - 1; i >= 0; i = i - 1) {
    Arma a = armas.get(i);
    a.display();
    a.update();
    if (a.hasExitScreen() || a.getDeleteWeapon()) {
      armas.remove(a);
    }
    if (estadoJogo == "MapaFazendeiro") {
      if (a.hasHitFazendeiro()) {
        if (sonsAtivos) {
          indexRandomSomFazendeiroTomandoDano = int(random(0, 4));
          sonsFazendeiroTomandoDano[indexRandomSomFazendeiroTomandoDano].rewind();
          sonsFazendeiroTomandoDano[indexRandomSomFazendeiroTomandoDano].play();
        }
        vidaFazendeiroAtual = vidaFazendeiroAtual - 2;
        armas.remove(a);
      }
    }
    if (estadoJogo == "MapaPadre") {
      if (a.hasHitPadre()) {
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
        armas.remove(a);
      }
    }
  }
}