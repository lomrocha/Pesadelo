PImage whipAttack;

public class ChicoteAtaque extends Arma {
  public ChicoteAtaque() {
    setX(jLeiteX - 70);
    setY(jLeiteY - 140);

    setSpriteImage(whipAttack);
    setSpriteInterval(110);
    setSpriteWidth(234);
    setSpriteHeight(278);

    setDeleteWeapon(false);
    setDamageBoss(false);
    setIsStone(false);

    setFirstCollisionX(jLeiteX + 86);
    setSecondCollisionX(jLeiteX + 20);
    setFirstCollisionY(jLeiteY);
    setSecondCollisionY(jLeiteY - 140);
  }

  void update() {
    setX(jLeiteX - 70);
    setY(jLeiteY - 140);
  }
}

boolean umChicote;

void chicoteAtaque() {
  if (jLeiteUsoItem) {
    if (armas.size() == 0 && item == 3 && totalItem > 0 && !umChicote) {
      armas.add(new ChicoteAtaque());
      totalItem = totalItem - 1;
      umChicote = true;
    }
  }

  for (int i = armas.size() - 1; i >= 0; i = i - 1) {
    Arma a = armas.get(i);
    a.update();
    a.display();
    if (a.getDeleteWeapon()) {
      armas.remove(a);
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