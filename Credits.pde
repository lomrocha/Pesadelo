
// -------------------------------------- CREDITS ---------------------------------------------------

private class Credits {
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

// -------------------------------------- CLOSING CREDITS ---------------------------------------------------

final int FIRSTCLOSINGCREDITY = 0;
final int SECONDCLOSINGCREDITY = 1000;
final int CLOSINGCREDITMOVEMENT = 1;

int timeToMoveClosingCredit;

private class ClosingCredit {
  private PVector closingCredit = new PVector();
  private int movementY;

  ClosingCredit(int y) {
    this.closingCredit.x = 0;
    this.closingCredit.y = y;
  }

  void display() {
    image(creditos, closingCredit.x, closingCredit.y);
  }

  void update() {
    if (closingCredit.y + 1000 <= 0) {
      closingCredit.y = 1000;
    }

    closingCredit.y -= movementY;
  }

  void updateMovement() {
    movementY = (millis() > timeToMoveClosingCredit + 500) ? CLOSINGCREDITMOVEMENT : 0;
  }
}
