PImage foodShadow;

int timeToGenerateFood;
int foodIndex;

int amountRecovered;

int totalFood;

boolean hasIndexChanged;

void foodAll() {
  generateIndex();
  coxinha();
  brigadeiro();
  queijo();
}

void generateIndex() {
  if (!telaTutorialAndandoAtiva) {
    if (!hasIndexChanged) {
      foodIndex = int(random(0, 10));
      hasIndexChanged = true;
    }
  }
}

public class Comida extends Geral {
  private int amountRecovered = 0;
}

void heal(int amount, Comida c) {
  while (vidaJLeiteAtual < vidaJleiteMax && c.amountRecovered < amount) {
    c.amountRecovered += 1;
    vidaJLeiteAtual += 1;
  }
}