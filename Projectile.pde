private class Projectile extends Enemy {
  private PVector start = new PVector();
  private PVector velocity = new PVector();

  private boolean hasNewTarget;

  // START
  public void setStart(PVector start) {
    this.start = start;
  }

  // VELOCITY
  public void setVelocity(PVector velocity) {
    this.velocity = velocity;
  }

  void display() {
    image(getSpriteImage(), getX(), getY());
  }

  void updateBools() {
    this.setBools(new boolean[] {hasNewTarget});
  }

  void updateMovement() {
    setMotionY(int(velocity.y));
    if (start.x != getTargetX()) {
      setMotionX((start.x < getTargetX()) ? int(velocity.x) : -int(velocity.x));

      return;
    }

    setMotionX(0);
  }

  void updateTarget() {
    int distanceX = (getTargetX() > start.x) ? getTargetX() - (int)start.x : (int)start.x - getTargetX();
    velocity.x = (int)map(distanceX, 0, 500, 1, 12);
    
    int distanceY = getTargetY() - (int)start.y;
    velocity.y = (int)map(distanceY, 75, 474, 4, 12);
  }
}
