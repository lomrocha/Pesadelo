PImage stone;
PImage stoneShadow;

public class Pedra extends Geral {
  public Pedra() {
    setX(int(random(100, 666)));
    setY(int(random(-300, -1000)));

    setSpriteImage(stone);
    setSpriteInterval(75);
    setSpriteWidth(34);
    setSpriteHeight(27);
    setMovementY(sceneryMovement);
  }

  public Pedra(int x, int y) {
    this.setX(x);
    this.setY(y);

    setSpriteImage(stone);
    setSpriteInterval(75);
    setSpriteWidth(34);
    setSpriteHeight(27);
    setMovementY(sceneryMovement);
  }

  void display() {
    image (stoneShadow, getX(), getY() + 17);

    super.display();
  }
}

ArrayList<Pedra> pedras;

int indexRandomPedraMapaBoss;

void pedra() {
  if (totalArmas == 0 && millis() > tempoGerarArma + 15000) {
    if (estadoJogo == "SegundoMapa") {
      if (pedras.size() == 0 && indexArma >= 5 && indexArma <= 9 && !telaTutorialAndandoAtiva) {
        pedras.add(new Pedra());
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "TerceiroMapa") {
      if (pedras.size() == 0 && indexArma >= 3 && indexArma <= 4 && !telaTutorialAndandoAtiva) {
        pedras.add(new Pedra());
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "MapaFazendeiro") {
      if (pas.size() == 0 && indexArma >= 5 && indexArma <= 9) {
        indexRandomPedraMapaBoss = int(random(0, valoresXMapaFazendeiro.length));
        pedras.add(new Pedra(valoresXMapaFazendeiro[indexRandomPedraMapaBoss], valoresYMapaFazendeiro[indexRandomPedraMapaBoss]));
        totalArmas = totalArmas + 1;
      }
    }

    if (estadoJogo == "MapaPadre") {
      if (pas.size() == 0 && indexArma >= 3 && indexArma <= 4) {
        indexRandomPedraMapaBoss = int(random(0, valoresXMapaPadre.length));
        pedras.add(new Pedra(valoresXMapaPadre[indexRandomPedraMapaBoss], valoresYMapaPadre[indexRandomPedraMapaBoss]));
        totalArmas = totalArmas + 1;
      }
    }
  }

  for (int i = pedras.size() - 1; i >= 0; i = i - 1) {
    Pedra p = pedras.get(i);
    if (estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      p.update();
    }
    p.display();
    if (p.hasExitScreen() || p.hasCollided()) {
      pedras.remove(p);
    }
    if (p.hasCollided()) {
      tempoGerarArma = millis();
      primeiraPedra = primeiraPedra + 1;
      item = 1;
      totalItem = 15;
      armaGerada = false;
    }
  }
}