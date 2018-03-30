public class Handler {
  void spriteHandler(MaisGeral object) {
    if (millis() > object.getSpriteTime() + object.getSpriteInterval()) {
      object.setSprite(object.getSpriteImage().get(object.getStep(), 0, object.getSpriteWidth(), object.getSpriteHeight()));
      object.setStep(object.getStep() % object.getSpriteImage().width + object.getSpriteWidth());
      object.setSpriteTime(millis());
    }

    image(object.getSprite(), object.getX(), object.getY());
  }

  void stepHandler(MaisGeral object) {
    if (object.getStep() == object.getSpriteImage().width) {
      object.setStep(0);
    }
  }

  void hitpointsLayoutHandler(PImage layoutBackground, int layoutBackgroundX, int layoutBackgroundY, int hitpointsMinimum, int hitpointsBarX, int hitpointsBarXStart, int hitpointsCurrent, PImage hitpointsBar, int hitpointsBarY, int hitpointsBarInterval, PImage hitpointsLayout, int hitpointsLayoutX, int hitpointsLayoutY) {
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
}