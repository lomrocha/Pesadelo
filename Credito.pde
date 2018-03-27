final int FIRSTCLOSINGCREDITY = 0;
final int SECONDCLOSINGCREDITY = 1000;
final int CLOSINGCREDITMOVEMENT = 1;

int timeToMoveClosingCredit;

public class ClosingCredit {
  private PVector closingCredit = new PVector();

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

    if (millis() > timeToMoveClosingCredit + 500) {
      closingCredit.y -= CLOSINGCREDITMOVEMENT;
    }
  }
}

ArrayList<ClosingCredit> closingCredits;

void closingCredit() {
  for (ClosingCredit cc : closingCredits) {
    cc.update();
    cc.display();
  }
}