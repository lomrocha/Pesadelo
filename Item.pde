ArrayList<Item> itens;

public class Item extends Geral {
  private int itemIndex;
  private int itemTotal;

  public int getItemIndex() {
    return itemIndex;
  }
  protected void setItemIndex(int itemIndex) {
    this.itemIndex = itemIndex;
  }

  public int getItemTotal() {
    return itemTotal;
  }
  protected void setItemTotal(int itemTotal) {
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
      
      if (it.hasExitScreen()) {
        generateItem(2500);
      }
      if (it.hasCollided()) {
        item = it.getItemIndex();
        weaponTotal = it.getItemTotal();
      }
    }
  }
}

void generateItem(int timeAmount) {
  if (itemTotal == 1) {
    itemTotal--;
  }
  hasItemIndexChanged = false;
  timeToGenerateItem = millis();
  intervalToGenerateItem = timeAmount;
}

void addItem() {
  if (estadoJogo == "PrimeiroMapa" || (estadoJogo == "SegundoMapa") || estadoJogo == "TerceiroMapa") {
    if (!telaTutorialAndandoAtiva) {
      if (itemIndex >= 0 && itemIndex <= 4) {
        itens.add(new Pa());
      } else if (itemIndex >= 5 && itemIndex <= 9) {
        itens.add(new Chicote());
      }
      itemTotal++;
    }
  }
}

void addItemBoss() {
  if (estadoJogo == "MapaCoveiro") {
    itemRandomMapPositionIndex = int(random(0, valoresXMapaCoveiro.length));
    if (itemIndex >= 0 && itemIndex <= 4) {
      itens.add(new Pa(valoresXMapaCoveiro[itemRandomMapPositionIndex], valoresYMapaCoveiro[itemRandomMapPositionIndex]));
    } else if (itemIndex >= 5 && itemIndex <= 9) {
      itens.add(new Chicote(valoresXMapaCoveiro[itemRandomMapPositionIndex], valoresYMapaCoveiro[itemRandomMapPositionIndex]));
    }
    itemTotal++;
  }

  if (estadoJogo == "MapaFazendeiro") {
    itemRandomMapPositionIndex = int(random(0, valoresXMapaFazendeiro.length));
    if (itemIndex >= 0 && itemIndex <= 4) {
      itens.add(new Pa(valoresXMapaCoveiro[itemRandomMapPositionIndex], valoresYMapaCoveiro[itemRandomMapPositionIndex]));
    } else if (itemIndex >= 5 && itemIndex <= 9) {
      itens.add(new Chicote(valoresXMapaCoveiro[itemRandomMapPositionIndex], valoresYMapaCoveiro[itemRandomMapPositionIndex]));
    }
    itemTotal++;
  }

  if (estadoJogo == "MapaPadre") {
    itemRandomMapPositionIndex = int(random(0, valoresXMapaPadre.length));
    if (itemIndex >= 0 && itemIndex <= 4) {
      itens.add(new Pa(valoresXMapaCoveiro[itemRandomMapPositionIndex], valoresYMapaCoveiro[itemRandomMapPositionIndex]));
    } else if (itemIndex >= 5 && itemIndex <= 9) {
      itens.add(new Chicote(valoresXMapaCoveiro[itemRandomMapPositionIndex], valoresYMapaCoveiro[itemRandomMapPositionIndex]));
    }
    itemTotal++;
  }
}