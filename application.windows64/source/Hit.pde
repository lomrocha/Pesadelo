PImage hitInimigos, spriteHitInimigos;

int stepHitInimigos;
int tempoSpriteHitInimigos;

boolean hitInimigosMostrando;

void hitInimigos(float X, float Y) {
  if (hitInimigosMostrando) {
    if (millis() > tempoSpriteHitInimigos + 45) {
      spriteHitInimigos = hitInimigos.get(stepHitInimigos, 0, 126, 126); 
      stepHitInimigos = stepHitInimigos % 378 + 126;
      image(spriteHitInimigos, X, Y); 
      tempoSpriteHitInimigos = millis();
    } else {
      image(spriteHitInimigos, X, Y);
    }

    if (stepHitInimigos == hitInimigos.width) {
      stepHitInimigos = 0;
      hitInimigosMostrando = false;
    }
  }
}

PImage hitBosses, spriteHitBosses;

int stepHitBosses;
int tempoSpriteHitBosses;

boolean hitBossesMostrando;

void hitBosses(float X, float Y) {
  if (hitBossesMostrando) {
    if (millis() > tempoSpriteHitBosses + 45) {
      spriteHitBosses = hitBosses.get(stepHitBosses, 0, 144, 126); 
      stepHitBosses = stepHitBosses % 432 + 144;
      image(spriteHitBosses, X, Y); 
      tempoSpriteHitBosses = millis();
    } else {
      image(spriteHitBosses, X, Y);
    }

    if (stepHitBosses == hitBosses.width) {
      stepHitBosses = 0;
      hitBossesMostrando = false;
    }
  }
}

PImage hitEscudo, spriteHitEscudo;

int stepHitEscudo;
int tempoSpriteHitEscudo;

boolean hitEscudoMostrando;

void hitEscudo(float X, float Y) {
  if (hitEscudoMostrando) {
    if (millis() > tempoSpriteHitEscudo + 45) {
      spriteHitEscudo = hitEscudo.get(stepHitEscudo, 0, 144, 126); 
      stepHitEscudo = stepHitEscudo % 432 + 144;
      image(spriteHitEscudo, X, Y); 
      tempoSpriteHitEscudo = millis();
    } else {
      image(spriteHitEscudo, X, Y);
    }

    if (stepHitEscudo == hitEscudo.width) {
      stepHitEscudo = 0;
      hitEscudoMostrando = false;
    }
  }
}

PImage hitCruz;
PImage hitRaivaCruz;

PImage spriteHitCruz;

int stepHitCruz;
int tempoSpriteHitCruz;

boolean hitHitCruzMostrando;

void hitCruz(float X, float Y) {
  if (hitHitCruzMostrando) {
    if (millis() > tempoSpriteHitCruz + 145) {
      if (!padre.padreMudouForma) {
        spriteHitEscudo = hitCruz.get(stepHitCruz, 0, 126, 126);
      } else {
        spriteHitEscudo = hitRaivaCruz.get(stepHitCruz, 0, 126, 126);
      }
      stepHitCruz = stepHitCruz % 378 + 126;
      image(spriteHitEscudo, X, Y); 
      tempoSpriteHitCruz = millis();
    } else {
      image(spriteHitEscudo, X, Y);
    }

    if (stepHitCruz == hitCruz.width) {
      stepHitCruz = 0;
      hitHitCruzMostrando = false;
    }
  }
}