PImage skeletonHead;

public class CabecaEsqueleto extends InimigoGeral {
  private int movementX;

  private int skeletonHeadTarget;

  private boolean isHeadStraight;

  public CabecaEsqueleto(int x, int y, int skeletonHeadTarget) {
    this.x = x;
    this.y = y;
    this.skeletonHeadTarget = skeletonHeadTarget;
    
    movementY = 12;
  }

  void display() {
    image(skeletonHead, x, y);
  }

  void update() {
    x = x + movementX;
    if (!isHeadStraight) {
      if (x > skeletonHeadTarget) {
        movementX = -8;
      } else {
        movementX = 8;
      }
    } else {
      movementX = 0;
    }

    y = y + movementY;
  }

  void checaCabecaEsqueletoReta() {
    if (x < skeletonHeadTarget) {
      if (skeletonHeadTarget - x < 10) {  
        isHeadStraight = true;
      } else {
        isHeadStraight = false;
      }
    } else {
      if (x - skeletonHeadTarget < 10) {  
        isHeadStraight = true;
      } else {
        isHeadStraight = false;
      }
    }
  }
}

ArrayList<CabecaEsqueleto> cabecasEsqueleto;

void cabecaEsqueleto() {
  for (int i = cabecasEsqueleto.size() - 1; i >= 0; i = i - 1) {
    CabecaEsqueleto c = cabecasEsqueleto.get(i);
    c.display();
    c.update();
    c.checaCabecaEsqueletoReta();
    if (c.hasExitScreen()) {
      cabecasEsqueleto.remove(c);
    }

    if (c.hasAttacked() && !jLeiteImune) {
      vidaJLeiteAtual = vidaJLeiteAtual - 3;
      jLeiteImune = true;
      tempoImune = millis();
    }
  }
}