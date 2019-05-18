private class Projectile extends Enemy {
  private PVector start = new PVector();
  private PVector velocity = new PVector();
  private PVector distance = new PVector();

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

  void updateMovement() {
    setMotionY(int(velocity.y));
    if (start.x != getTargetX()) {
      setMotionX((start.x < getTargetX()) ? int(velocity.x) : -int(velocity.x));

      return;
    }

    setMotionX(0);
  }

  void updateTarget() {
    // Calcula a distância entre o esqueleto e o jogador nos eixos 'x' e 'y'.
    distance.x = (getTargetX() > start.x) ? getTargetX() - (int)start.x : (int)start.x - getTargetX();
    distance.y = getTargetY() - (int)start.y;
    
    // Baseado na distância calculada acima, a velocidade do projétil é mapeada.
    velocity.x = (int)map(distance.x, 0, 500, 1, 12);
    velocity.y = (int)map(distance.y, 75, 474, 4, 12);
  }
}
