int item;

int totalItem;
int primeiraPedra;

int tempoGerarArma;
int indexArma;

int totalArmas;

boolean armaGerada;

void armas() {
  if (totalItem == 0 && !jLeiteUsoItem && itens.size() == 0 && itens.size() == 0 && itens.size() == 0) {
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

  item();
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

ArrayList<Arma> armas;

public class Arma {
  private PImage sprite;
  private PImage spriteImage;

  private int x;
  private int y;

  private int step;
  private int spriteTime;
  private int spriteInterval;

  private int spriteWidth;
  private int spriteHeight;

  private boolean deleteWeapon;
  private boolean damageBoss;
  private boolean isStone;

  private int firstCollisionX;
  private int secondCollisionX;
  private int firstCollisionY;
  private int secondCollisionY;

  public PImage getSprite() {
    return sprite;
  }

  public void setSprite(PImage sprite) {
    this.sprite = sprite;
  }

  public PImage getSpriteImage() {
    return spriteImage;
  }

  public void setSpriteImage(PImage enemy) {
    this.spriteImage = enemy;
  }

  public int getX() {
    return x;
  }

  public void setX(int x) {
    this.x = x;
  }

  public int getY() {
    return y;
  }

  public void setY(int y) {
    this.y = y;
  }

  public int getStep() {
    return step;
  }

  public void setStep(int step) {
    this.step = step;
  }

  public int getSpriteTime() {
    return spriteTime;
  }

  public void setSpriteTime(int spriteTime) {
    this.spriteTime = spriteTime;
  }

  public int getSpriteInterval() {
    return spriteInterval;
  }

  public void setSpriteInterval(int spriteInterval) {
    this.spriteInterval = spriteInterval;
  }

  public int getSpriteWidth() {
    return spriteWidth;
  }

  public void setSpriteWidth(int spriteWidth) {
    this.spriteWidth = spriteWidth;
  }

  public int getSpriteHeight() {
    return spriteHeight;
  }

  public void setSpriteHeight(int spriteHeight) {
    this.spriteHeight = spriteHeight;
  }

  public boolean getDeleteWeapon() {
    return deleteWeapon;
  }

  public void setDeleteWeapon(boolean deleteWeapon) {
    this.deleteWeapon = deleteWeapon;
  }

  public boolean getDamageBoss() {
    return damageBoss;
  }

  public void setDamageBoss(boolean damageBoss) {
    this.damageBoss = damageBoss;
  }

  public boolean getIsStone() {
    return isStone;
  }

  public void setIsStone(boolean isStone) {
    this.isStone = isStone;
  }

  public int getFirstCollisionX() {
    return firstCollisionX;
  }

  public void setFirstCollisionX(int firstCollisionX) {
    this.firstCollisionX = firstCollisionX;
  }

  public int getSecondCollisionX() {
    return secondCollisionX;
  }

  public void setSecondCollisionX(int secondCollisionX) {
    this.secondCollisionX = secondCollisionX;
  }

  public int getFirstCollisionY() {
    return firstCollisionY;
  }

  public void setFirstCollisionY(int firstCollisionY) {
    this.firstCollisionY = firstCollisionY;
  }

  public int getSecondCollisionY() {
    return secondCollisionY;
  }

  public void setSecondCollisionY(int secondCollisionY) {
    this.secondCollisionY = secondCollisionY;
  }

  void display() {
    if (millis() > spriteTime + spriteInterval) {
      sprite = spriteImage.get(step, 0, spriteWidth, spriteHeight);
      step = step % spriteImage.width + spriteWidth;
      image(sprite, x, y);
      spriteTime = millis();
    } else {
      image(sprite, x, y);
    }

    if (step == spriteImage.width) {
      step = 0;
      deleteWeapon = true;
    }
  }

  void update() {
  }

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

  boolean hasExitScreen() {
    return false;
  }
}