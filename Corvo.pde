PImage skeletonCrow;
PImage skeletonCrowShadow;

public class Corvo extends Geral {
  private PVector target = new PVector(jLeiteX, jLeiteY);
  private int movementX;

  private int newTargetInterval;

  private boolean hasNewTarget;

  public Corvo() {
    setX(360);
    setY(int(random(-300, -1000)));

    setValues();
  }

  public Corvo(int x, int y) {
    this.setX(x);
    this.setY(y);

    setValues();
  }

  private void setValues() {
    setSpriteImage(skeletonCrow);
    setSpriteInterval(75);
    setSpriteWidth(121);
    setSpriteHeight(86);
  }

  void display() {
    super.display();

    image(skeletonCrowShadow, getX() + 24, getY() + 86);
  } 

  void update() {
    super.update();

    setX(getX() + movementX);
  }

  void updateMovement() {
    if (getX() != target.x) {
      movementX = (getX() < target.x) ? 3 : -3;
    }
    else {
      movementX = 0;
    }
    
    setMovementY(3);
  }

  void updateTarget() {
    if (getY() > 0) {
      if (!hasNewTarget) {
        target.x = jLeiteX;
        newTargetInterval = millis();
        hasNewTarget = true;
      }

      if (millis() > newTargetInterval + 750) {
        hasNewTarget = false;
      }
    }
  }

  boolean hasCollided() {
    if (getX() + 95 > jLeiteX && getX() + 25 < jLeiteX + 63 && getY() + 86 > jLeiteY && getY() < jLeiteY + 126) {
      return true;
    } else {
      return false;
    }
  }
}

ArrayList<Corvo> corvos;

int indexRandomCorvoXMapaBoss;

void corvo() {
  if (indexInimigos == 3) {
    if (gameState == GameState.THIRDBOSS.ordinal()) {
      if (corvos.size() == 0 && totalInimigos < maximoInimigosPadre && !padre.padreMorreu) {
        indexRandomCorvoXMapaBoss = int(random(0, valoresInimigosXTerceiroMapaBoss.length));
        corvos.add(new Corvo(valoresInimigosXTerceiroMapaBoss[indexRandomCorvoXMapaBoss], 0));
      }
    }

    if (!telaTutorialAndandoAtiva) {
      if (gameState == GameState.SECONDMAP.ordinal() && corvos.size() < 1) {
        corvos.add(new Corvo());
      }

      if (gameState == GameState.THIRDMAP.ordinal() && corvos.size() < 1) {
        corvos.add(new Corvo());
      }
    }
  }

  if (corvos.size() > 0) {
    for (int i = corvos.size() - 1; i >= 0; i = i - 1) {
      Corvo c = corvos.get(i);
      c.updateTarget();
      c.updateMovement();
      c.update();
      c.display();
      if (c.hasExitScreen()) {
        corvos.remove(c);
      }
      if (c.hasCollided()) {
        damage(3);
      }
    }

    deleteEnemy(corvos);
  }
}