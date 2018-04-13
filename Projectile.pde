class Projectile extends Inimigo {
  private PVector start = new PVector();
  private PVector velocity = new PVector();

  // START
  public PVector getStart() {
    return this.start;
  }
  public void setStart(PVector start) {
    this.start = start;
  }

  public int getStartX() {
    return int(this.start.x);
  }
  public void setStartX(int x) {
    this.start.x = x;
  }

  public int getStartY() {
    return int(this.start.y);
  }
  public void setStartY(int y) {
    this.start.y = y;
  }
  
  // VELOCITY
  public PVector getVelocity() {
    return this.velocity;
  }
  public void setVelocity(PVector velocity) {
    this.velocity = velocity;
  }

  public int getVelocityX() {
    return int(this.velocity.x);
  }
  public void setVelocityX(int x) {
    this.velocity.x = x;
  }

  public int getVelocityY() {
    return int(this.velocity.y);
  }
  public void setVelocityY(int y) {
    this.velocity.y = y;
  }

  void display() {
    image(getSpriteImage(), getX(), getY());
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
    int distance = (getTargetX() > start.x) ? getTargetX() - int(start.x) : int(start.x) - getTargetX();
    velocity.x = int(map(distance, 0, 579, 1, 9));
  }
}