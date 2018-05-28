int item;

int weaponTotal;

int itemTotal;
int timeToGenerateItem;
int itemIndex;

int itemRandomMapPositionIndex;

int intervalToGenerateItem;

boolean hasItemIndexChanged;

void armas() {
  if (weaponTotal == 0 && !jLeiteUsoItem && itens.size() == 0) {
    item = 0;
    itemTotal = 0;
  }

  if (armas.size() > 0) {
    arma();
  }

  if (jLeiteUsoItem && armas.size() == 0 && weaponTotal > 0) {
    weapon();
  }
}

ArrayList<Arma> armas = new ArrayList<Arma>();

abstract private class Arma extends MaisGeral {
  private int firstCollisionX;
  private int secondCollisionX;
  private int firstCollisionY;
  private int secondCollisionY;

  private boolean deleteWeapon;
  private boolean damageBoss;

  // FIRST_COLLISION_X
  protected void setFirstCollisionX(int firstCollisionX) {
    this.firstCollisionX = firstCollisionX;
  }

  // SECOND_COLLISION_X
  protected void setSecondCollisionX(int secondCollisionX) {
    this.secondCollisionX = secondCollisionX;
  }

  // FIRST_COLLISION_Y
  protected void setFirstCollisionY(int firstCollisionY) {
    this.firstCollisionY = firstCollisionY;
  }

  // SECOND_COLLISION_Y
  protected void setSecondCollisionY(int secondCollisionY) {
    this.secondCollisionY = secondCollisionY;
  }
  
  // DELETE_WEAPON
  public boolean getDeleteWeapon() {
    return deleteWeapon;
  } 
  protected void setDeleteWeapon(boolean deleteWeapon) {
    this.deleteWeapon = deleteWeapon;
  }
  
  // DAMAGE_BOSS
  public boolean getDamageBoss() {
    return damageBoss;
  }
  protected void setDamageBoss(boolean damageBoss) {
    this.damageBoss = damageBoss;
  }

  void stepHandler() {
    if (getStep() == getSpriteImage().width) {
      this.deleteWeapon = true;
    }
  }

  abstract void update();

  boolean hasHit(Geral g) {
    if (firstCollisionX > g.getX() && secondCollisionX < g.getX() + g.getSpriteWidth() && firstCollisionY > g.getY() && secondCollisionY < g.getY() + g.getSpriteHeight()) {
      hitInimigosMostrando = true;
      return true;
    }

    return false;
  }

  boolean hasHitCoveiro() {
    if (firstCollisionX > coveiroX && secondCollisionX < coveiroX + 169 && firstCollisionY > coveiroY && secondCollisionY < coveiroY + 188) {
      hitBossesMostrando = true;
      hitBosses(coveiroX, coveiroY + 20);
      return true;
    } 

    return false;
  }

  boolean hasHitFazendeiro() {
    if (firstCollisionX > fazendeiroX + 60 && secondCollisionX < fazendeiroX + 188 && firstCollisionY > fazendeiroY && secondCollisionY < fazendeiroY + 125) {
      if (!pneuRolandoPrimeiraVez) {
        hitBossesMostrando = true;
        hitBosses(fazendeiroX + 30, fazendeiroY + 20);
        return true;
      } else {
        hitEscudoMostrando = true;
        hitEscudo(fazendeiroX + 30, fazendeiroY + 20);
        return false;
      }
    } 

    return false;
  }

  boolean hasHitPadre() {
    if (firstCollisionX > padreX + 20 && secondCollisionX < padreX + 110 && firstCollisionY > padreY && secondCollisionY < padreY + 152) {
      hitBossesMostrando = true;
      hitBosses(padreX, padreY);
      return true;
    } 

    return false;
  }
}

boolean oneWeapon;

void weapon() {
  if (!oneWeapon) {
    switch(item) {
    case WHIP: 
      armas.add(new ChicoteAtaque());
      break;
    case SHOVEL:
      armas.add(new PaAtaque());
      break;
    }

    weaponTotal--;
    oneWeapon = true;
  }
}

void arma() {
  for (int i = armas.size() - 1; i >= 0; i = i - 1) {
    Arma a = armas.get(i);
    a.update();
    a.display();
    if (a.getDeleteWeapon()) {
      armas.remove(a);
    }
    if (gameState == GameState.FIRST_BOSS.getValue()) {
      if (a.hasHitCoveiro() && !a.getDamageBoss()) {
        if (isSoundActive) {
          indexRandomSomCoveiroTomandoDano = int(random(0, sonsCoveiroTomandoDano.length));
          sonsCoveiroTomandoDano[indexRandomSomCoveiroTomandoDano].rewind();
          sonsCoveiroTomandoDano[indexRandomSomCoveiroTomandoDano].play();
        }
        coveiroCurrentHP -= 2;
        a.setDamageBoss(true);
      }
    }
    if (gameState == GameState.SECOND_BOSS.getValue()) {
      if (a.hasHitFazendeiro() && !a.getDamageBoss()) {
        if (isSoundActive) {
          indexRandomSomFazendeiroTomandoDano = int(random(0, sonsFazendeiroTomandoDano.length));
          sonsFazendeiroTomandoDano[indexRandomSomFazendeiroTomandoDano].rewind();
          sonsFazendeiroTomandoDano[indexRandomSomFazendeiroTomandoDano].play();
        }
        fazendeiroCurrentHP -= 2;
        a.setDamageBoss(true);
      }
    }
    if (gameState == GameState.THIRD_BOSS.getValue()) {
      if (a.hasHitPadre() && !a.getDamageBoss()) {
        if (padreCurrentHP > 0) {
          if (isSoundActive) {
            indexRandomSomPadreTomandoDano = int(random(0, sonsPadreTomandoDano.length));
            sonsPadreTomandoDano[indexRandomSomPadreTomandoDano].rewind();
            sonsPadreTomandoDano[indexRandomSomPadreTomandoDano].play();
          }
          padreCurrentHP -= 2;
          a.setDamageBoss(true);
        } else {
          if (isSoundActive) {
            indexRandomSomPadreTomandoDano = int(random(0, sonsPadreRaivaTomandoDano.length));
            sonsPadreRaivaTomandoDano[indexRandomSomPadreTomandoDano].rewind();
            sonsPadreRaivaTomandoDano[indexRandomSomPadreTomandoDano].play();
          }
          madPadreCurrentHP -= 2;
          a.setDamageBoss(true);
        }
      }
    }
  }
}
