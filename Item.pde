ArrayList<Item> itens;

public class Item extends Geral {
  private int itemIndex;
  private int itemTotal;

  public int getItemIndex() {
    return itemIndex;
  }

  public void setItemIndex(int itemIndex) {
    this.itemIndex = itemIndex;
  }

  public int getItemTotal() {
    return itemTotal;
  }

  public void setItemTotal(int itemTotal) {
    this.itemTotal = itemTotal;
  }
}

void item() {  
  for (int i = itens.size() - 1; i >= 0; i = i - 1) {
    Item it = itens.get(i);
    if (estadoJogo == "PrimeiroMapa" || estadoJogo == "SegundoMapa" || estadoJogo == "TerceiroMapa") {
      it.update();
    }
    it.display();
    if (it.hasExitScreen() || it.hasCollided()) {
      itens.remove(it);
    }
    if (it.hasCollided()) {
      tempoGerarArma = millis();
      item = it.getItemIndex();
      totalItem = it.getItemTotal();
      armaGerada = false;
    }
  }
}