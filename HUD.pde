private class HUD 
{
  private HitpointsLayout p;

  void display() {
    switch(gameState) 
    {
    case 3:
      coveiroHP.update();
      coveiroHP.display();
      break;
    case 4:
      fazendeiroHP.update();
      fazendeiroHP.display();
      break;
    case 5:
      p = (padre.padreMudouForma) ? madPadreHP : padreHP;
      p.update();
      p.display();
      break;
    }

    playerHP.update();
    playerHP.display();
    ib.updateItemImage();
    ib.display();
  }
}
