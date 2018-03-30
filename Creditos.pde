public class Credits {
  private ClosingCredit firstCredit = new ClosingCredit(FIRSTCLOSINGCREDITY);
  private ClosingCredit secondCredit = new ClosingCredit(SECONDCLOSINGCREDITY);

  private HandsButton handButton = new HandsButton(menuThumbsUp, menuPointingBack);

  void credits() {
    firstCredit.updateMovement();
    firstCredit.update();
    firstCredit.display();
    secondCredit.updateMovement();
    secondCredit.update();
    secondCredit.display();
  }

  void button() {
    handButton.display();

    if (handButton.hasClicked()) {
      firstCredit.closingCredit.y = FIRSTCLOSINGCREDITY;
      secondCredit.closingCredit.y = SECONDCLOSINGCREDITY;
    }

    handButton.setState();
  }
}