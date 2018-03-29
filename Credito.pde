final int FIRSTCLOSINGCREDITY = 0;
final int SECONDCLOSINGCREDITY = 1000;
final int CLOSINGCREDITMOVEMENT = 1;

int timeToMoveClosingCredit;

public class ClosingCredit {
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

ArrayList<ClosingCredit> closingCredits = new ArrayList<ClosingCredit>();

void closingCredit() {
  for (ClosingCredit cc : closingCredits) {
    cc.updateMovement();
    cc.update();
    cc.display();
  }
}