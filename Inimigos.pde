int tempoGerarInimigo;
int indexInimigos;

int totalInimigos;
int maximoInimigosPadre = 2;

int[] valoresInimigosXMapaPadre = {25, 350, 679};

void inimigosTodos() {
  if (!jLeiteMorreu) {
    if (!telaTutorialAndandoAtiva && totalCenariosCriados < totalCenariosPossiveis) {
      if (int(millisAvancada) > tempoGerarInimigo + 250) {
        if (estadoJogo == "PrimeiroMapa") {
          indexInimigos = int(random(0, 2));
        } 
        if (estadoJogo == "SegundoMapa") {
          indexInimigos = int(random(0, 4));
        } 
        if (estadoJogo == "TerceiroMapa") {
          indexInimigos = int(random(1, 5));
        } 
        if (estadoJogo == "MapaPadre") {
          indexInimigos = int(random(0, 5));
          if (!ataqueLevantemAcontecendo) {
            maximoInimigosPadre = 2;
          } else {
            maximoInimigosPadre = 4;
          }
        }
        tempoGerarInimigo = int(millisAvancada);
      }
    }
  } else {
    indexInimigos = 6;
  }

  esqueleto();
  esqueletoChute();
  cabecaEsqueleto();
  cachorro();
  corvo();
  esqueletoRaiva();
}

public class InimigoGeral {
  protected PImage sprite;
  protected PImage enemy;

  protected int x;
  protected int y;
  protected int movementY;

  protected int step;
  protected int spriteTime;
  protected int spriteInterval;

  protected int spriteWidth;
  protected int spriteHeight;

  public PImage getSprite() {
    return sprite;
  }

  public void setSprite(PImage sprite) {
    this.sprite = sprite;
  }

  public PImage getEnemy() {
    return enemy;
  }

  public void setEnemy(PImage enemy) {
    this.enemy = enemy;
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

  public int getmovementY() {
    return movementY;
  }

  public void setmovementY(int movementY) {
    this.movementY = movementY;
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

  void display() {
    if (millis() > spriteTime + spriteInterval) {
      sprite = enemy.get(step, 0, spriteWidth, spriteHeight);
      step = step % enemy.width + spriteWidth;
      image(sprite, x, y);
      spriteTime = millis();
    } else {
      image(sprite, x, y);
    }

    if (step == enemy.width) {
      step = 0;
    }
  }

  void update() {
    y = y + movementY;
  }

  boolean hasAttacked() {
    if (x + spriteWidth > jLeiteX && x < jLeiteX + 63 && y + spriteHeight > jLeiteY && y < jLeiteY + 126) {
      return true;
    }

    return false;
  }

  boolean hasExitScreen() {
    if (Y > height) {
      return true;
    }

    return false;
  }
}