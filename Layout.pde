PImage itemBox;
PImage[] itemNumbers = new PImage [15];

PImage shovelBox;
PImage whipBox;

void caixaNumeroItem() {
  image(itemBox, 705, 510);
  if (weaponTotal - 1 >= 0) {
    if (item == SHOVEL) {
      image(shovelBox, 705, 510);
    } else if (item == WHIP) {
      image(whipBox, 705, 510);
    }
    image(itemNumbers[weaponTotal - 1], 725, 552);
  }
}

PImage playerHitpointsLayout;
PImage playerHitpointsLayoutBackground; 
PImage playerHitpointsBar;

final int playerHitpointsLayoutBackgroundX = 8;
final int playerHitpointsLayoutBackgroundY = 490;

final int playerHitpointsBarX = 115;
final int playerHitpointsBarY = 566;
final int playerHitpointsBarXStart = 115;

final int playerHitpointsInterval = 12;

final int playerHitpointsLayoutX = 8;
final int playerHitpointsLayoutY = 490;

void vida() {
  genericHitpointsLayout(playerHitpointsLayoutBackground, playerHitpointsLayoutBackgroundX, playerHitpointsLayoutBackgroundY, playerHitpointsMinimum, playerHitpointsBarX, playerHitpointsBarXStart, playerHitpointsCurrent, playerHitpointsBar, playerHitpointsBarY, playerHitpointsInterval, playerHitpointsLayout, playerHitpointsLayoutX, playerHitpointsLayoutY);
}

void genericHitpointsLayout(PImage layoutBackground, int layoutBackgroundX, int layoutBackgroundY, int hitpointsMinimum, int hitpointsBarX, int hitpointsBarXStart, int hitpointsCurrent, PImage hitpointsBar, int hitpointsBarY, int hitpointsBarInterval, PImage hitpointsLayout, int hitpointsLayoutX, int hitpointsLayoutY) {
  image(layoutBackground, layoutBackgroundX, layoutBackgroundY);

  hitpointsMinimum = 0;
  hitpointsBarX = hitpointsBarXStart;
  while (hitpointsMinimum < hitpointsCurrent) {
    image (hitpointsBar, hitpointsBarX, hitpointsBarY);
    hitpointsBarX += hitpointsBarInterval;
    hitpointsMinimum++;
  }

  image (hitpointsLayout, hitpointsLayoutX, hitpointsLayoutY);
}