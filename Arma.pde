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

  if (itemTotal == 0 && hasItemIndexChanged && millis() > timeToGenerateItem + intervalToGenerateItem && itens.size() == 0) {
    if (gameState >= GameState.FIRSTMAP.ordinal() && gameState <= GameState.THIRDMAP.ordinal()) {
      addItem();
    } else if (gameState >= GameState.FIRSTBOSS.ordinal() && gameState <= GameState.THIRDBOSS.ordinal()) {
      addItemBoss();
    }
  }

  generateItemIndex();
  item();
  if (armas.size() > 0) {
    arma();
  }

  if (jLeiteUsoItem && armas.size() == 0 && weaponTotal > 0) {
    weapon();
  }
}

void generateItemIndex() {
  if (!telaTutorialAndandoAtiva) {
    if (!hasItemIndexChanged) {
      itemIndex = int(random(0, 10));
      hasItemIndexChanged = true;
    }
  }
}

ArrayList<Arma> armas = new ArrayList<Arma>();

public abstract class Arma extends MaisGeral {
  private boolean damageBoss;

  private int firstCollisionX;
  private int secondCollisionX;
  private int firstCollisionY;
  private int secondCollisionY;

  public boolean getDamageBoss() {
    return damageBoss;
  }
  protected void setDamageBoss(boolean damageBoss) {
    this.damageBoss = damageBoss;
  }

  public int getFirstCollisionX() {
    return firstCollisionX;
  }
  protected void setFirstCollisionX(int firstCollisionX) {
    this.firstCollisionX = firstCollisionX;
  }

  public int getSecondCollisionX() {
    return secondCollisionX;
  }
  protected void setSecondCollisionX(int secondCollisionX) {
    this.secondCollisionX = secondCollisionX;
  }

  public int getFirstCollisionY() {
    return firstCollisionY;
  }
  protected void setFirstCollisionY(int firstCollisionY) {
    this.firstCollisionY = firstCollisionY;
  }

  public int getSecondCollisionY() {
    return secondCollisionY;
  }
  protected void setSecondCollisionY(int secondCollisionY) {
    this.secondCollisionY = secondCollisionY;
  }

  abstract void update();

  boolean hasHit(Geral g) {
    if (firstCollisionX > g.getX() && secondCollisionX < g.getX() + g.getSpriteWidth() && firstCollisionY > g.getY() && secondCollisionY < g.getY() + g.getSpriteHeight()) {
      hitInimigosMostrando = true;
      return true;
    }

    return false;
  }

  boolean hasHitCrow(Corvo c) {
    if (firstCollisionX > c.getX() + 45 && secondCollisionX < c.getX() + 75 && firstCollisionY > c.getY() && secondCollisionY < c.getY() + 86) {
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
    if (item == WHIP) {
      armas.add(new ChicoteAtaque());
    }
    if (item == SHOVEL) {
      armas.add(new PaAtaque());
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
    if (a.getDeleteObject()) {
      armas.remove(a);
    }
    if (gameState == GameState.FIRSTBOSS.ordinal()) {
      if (a.hasHitCoveiro() && !a.getDamageBoss()) {
        if (sonsAtivos) {
          indexRandomSomCoveiroTomandoDano = int(random(0, sonsCoveiroTomandoDano.length));
          sonsCoveiroTomandoDano[indexRandomSomCoveiroTomandoDano].rewind();
          sonsCoveiroTomandoDano[indexRandomSomCoveiroTomandoDano].play();
        }
        coveiroHitpointsCurrent -= 2;
        a.setDamageBoss(true);
      }
    }
    if (gameState == GameState.SECONDBOSS.ordinal()) {
      if (a.hasHitFazendeiro() && !a.getDamageBoss()) {
        if (sonsAtivos) {
          indexRandomSomFazendeiroTomandoDano = int(random(0, sonsFazendeiroTomandoDano.length));
          sonsFazendeiroTomandoDano[indexRandomSomFazendeiroTomandoDano].rewind();
          sonsFazendeiroTomandoDano[indexRandomSomFazendeiroTomandoDano].play();
        }
        fazendeiroHitpointsCurrent -= 2;
        a.setDamageBoss(true);
      }
    }
    if (gameState == GameState.THIRDBOSS.ordinal()) {
      if (a.hasHitPadre() && !a.getDamageBoss()) {
        if (vidaPadreAtual > 0) {
          if (sonsAtivos) {
            indexRandomSomPadreTomandoDano = int(random(0, sonsPadreTomandoDano.length));
            sonsPadreTomandoDano[indexRandomSomPadreTomandoDano].rewind();
            sonsPadreTomandoDano[indexRandomSomPadreTomandoDano].play();
          }
          vidaPadreAtual -= 2;
          a.setDamageBoss(true);
        } else {
          if (sonsAtivos) {
            indexRandomSomPadreTomandoDano = int(random(0, sonsPadreRaivaTomandoDano.length));
            sonsPadreRaivaTomandoDano[indexRandomSomPadreTomandoDano].rewind();
            sonsPadreRaivaTomandoDano[indexRandomSomPadreTomandoDano].play();
          }
          vidaPadreRaivaAtual -= 2;
          a.setDamageBoss(true);
        }
      }
    }
  }
}