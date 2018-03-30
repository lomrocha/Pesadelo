AudioPlayer[] sonsMorteJLeite = new AudioPlayer [4];

PImage jLeiteMovimento, spriteJLeiteMovimento; 
PImage jLeiteIdle, spriteJLeiteIdle;
PImage jLeiteItem, spriteJLeiteItem;
PImage jLeiteDanoMovimento, spriteJLeiteDanoMovimento;
PImage jLeiteDanoIdle, spriteJLeiteDanoIdle;
PImage jLeiteMorte, spriteJLeiteMorte;

PImage sombraJLeite;

float tempoItem;
float tempoItemAtivo;

int playerHPCurrent;
int prayerHPMaximum;
int playerHPMinimum;

int jLeiteX, jLeiteY; 

int stepJLeiteMovimento, stepJLeiteIdle, stepJLeiteItem, stepJLeiteDanoMovimento, stepJLeiteDanoIdle, stepJLeiteMorte;
int tempoSpriteJLeiteMovimento, tempoSpriteJLeiteIdle, tempoSpriteJLeiteItem, tempoSpriteJLeiteDanoMovimento, tempoSpriteJLeiteDanoIdle, tempoSpriteJLeiteMorte;

int tempoImune;

int tempoMorto;

boolean jLeiteImune;
boolean jLeiteLentidao;

boolean jLeiteDireita, jLeiteEsquerda, jLeiteCima, jLeiteBaixo;

boolean jLeiteUsoItem;
boolean jLeiteUsoItemConfirma;
boolean jLeiteUsoItemContinua;

boolean jLeiteMorreu;
boolean jLeiteMorrendo;

boolean finalMapa;

boolean imortalidade;

void jLeite() {
  if (imortalidade) {
    playerHPCurrent = 15;
  }

  if (finalMapa) {
    if (jLeiteY + 126 < - 50) {
      if (gameState == GameState.FIRSTMAP.ordinal()) {
        gameState = GameState.FIRSTBOSS.ordinal();
        if (temaIgreja.isPlaying()) {
          temaIgreja.pause();
        }
      }
      if (gameState == GameState.SECONDMAP.ordinal()) {
        gameState = GameState.SECONDBOSS.ordinal();
        if (temaFazenda.isPlaying()) {
          temaFazenda.pause();
        }
      }
      if (gameState == GameState.THIRDMAP.ordinal()) {
        gameState = GameState.THIRDBOSS.ordinal();
        if (temaCidade.isPlaying()) {
          temaCidade.pause();
        }
      }
    }
  }

  if (playerHitpointsCurrent < 0 && !jLeiteMorreu) {
    jLeiteMorreu = true;
    jLeiteMorrendo = true;
    tempoMorto = millis();
    if (temaBoss.isPlaying()) {
      temaCidade.pause();
    }
    if (temaIgreja.isPlaying()) {
      temaCidade.pause();
    }
    if (temaFazenda.isPlaying()) {
      temaCidade.pause();
    }
    if (temaCidade.isPlaying()) {
      temaCidade.pause();
    }
    if (gameState == GameState.FIRSTBOSS.ordinal()) {
      if (isSoundActive) {
        sonsMorteJLeite[0].rewind();
        sonsMorteJLeite[0].play();
      }
    }
    if (gameState == GameState.SECONDBOSS.ordinal()) {
      if (isSoundActive) {
        sonsMorteJLeite[1].rewind();
        sonsMorteJLeite[1].play();
      }
    }
    if (gameState == GameState.THIRDBOSS.ordinal()) {
      if (!padre.padreMudouForma) {
        if (isSoundActive) {
          sonsMorteJLeite[2].rewind();
          sonsMorteJLeite[2].play();
        }
      } else {
        if (isSoundActive) {
          sonsMorteJLeite[3].rewind();
          sonsMorteJLeite[3].play();
        }
      }
    }
  }

  if (jLeiteMorreu && millis() > tempoMorto + 2500) {
    if (gameState >= GameState.FIRSTMAP.ordinal() && gameState <= GameState.THIRDMAP.ordinal()) {
      setup();
      gameState = GameState.MAINMENU.ordinal();
    } else if (gameState >= GameState.FIRSTBOSS.ordinal() && gameState <= GameState.THIRDBOSS.ordinal()) {
      lastState = gameState;
      gameState = GameState.GAMEOVER.ordinal();
    }
  }

  if (millis() > tempoImune + 2000) {
    jLeiteImune = false;
  }

  if (!jLeiteMorreu) {
    if (gameState >= GameState.FIRSTMAP.ordinal() && gameState <= GameState.THIRDMAP.ordinal()) {
      if (jLeiteDireita && jLeiteX < width - 163) { 
        jLeiteX = jLeiteX + 3;
      }
      if (jLeiteEsquerda && jLeiteX > 100) {
        jLeiteX = jLeiteX - 3;
      }

      if (!finalMapa) {
        if (jLeiteCima && jLeiteY > 0) {
          jLeiteY = jLeiteY - 3;
        }
      } else {
        if (jLeiteCima) {
          jLeiteY = jLeiteY - 3;
        }
      }

      if (jLeiteBaixo && jLeiteY < height - 126) {
        jLeiteY = jLeiteY + 3;
      }
    }

    if (gameState >= GameState.FIRSTBOSS.ordinal() && gameState <= GameState.THIRDBOSS.ordinal()) {
      if (!jLeiteLentidao) {
        if (jLeiteDireita && jLeiteX < width - 88) { 
          jLeiteX = jLeiteX + 3;
        }

        if (jLeiteEsquerda && jLeiteX > 25) {
          jLeiteX = jLeiteX - 3;
        }

        if (jLeiteCima && jLeiteY > 75) {
          jLeiteY = jLeiteY - 3;
        }

        if (jLeiteBaixo && jLeiteY < height - 126) {
          jLeiteY = jLeiteY + 3;
        }
      } else {
        if (jLeiteDireita && jLeiteX < width - 88) { 
          jLeiteX = jLeiteX + 1;
        }

        if (jLeiteEsquerda && jLeiteX > 25) {
          jLeiteX = jLeiteX - 1;
        }

        if (jLeiteCima && jLeiteY > 75) {
          jLeiteY = jLeiteY - 1;
        }

        if (jLeiteBaixo && jLeiteY < height - 126) {
          jLeiteY = jLeiteY + 1;
        }
      }
    }

    image(sombraJLeite, jLeiteX + 7, jLeiteY + 112);

    if (gameState >= GameState.FIRSTMAP.ordinal() && gameState <= GameState.THIRDMAP.ordinal()) {
      if (!jLeiteUsoItem && !jLeiteImune) {
        if (millis() > tempoSpriteJLeiteMovimento + 75) { 
          spriteJLeiteMovimento = jLeiteMovimento.get(stepJLeiteMovimento, 0, 63, 126); 
          stepJLeiteMovimento = stepJLeiteMovimento % 378 + 63;
          image(spriteJLeiteMovimento, jLeiteX, jLeiteY); 
          tempoSpriteJLeiteMovimento = millis();
        } else {
          image(spriteJLeiteMovimento, jLeiteX, jLeiteY);
        }
        if (stepJLeiteMovimento == jLeiteMovimento.width) {
          stepJLeiteMovimento = 0;
        }
      }

      if (jLeiteImune && !jLeiteUsoItem) {
        if (millis() > tempoSpriteJLeiteDanoMovimento + 90) { 
          spriteJLeiteDanoMovimento = jLeiteDanoMovimento.get(stepJLeiteDanoMovimento, 0, 63, 126); 
          stepJLeiteDanoMovimento = stepJLeiteDanoMovimento % 378 + 63;
          image(spriteJLeiteDanoMovimento, jLeiteX, jLeiteY); 
          tempoSpriteJLeiteDanoMovimento = millis();
        } else {
          image(spriteJLeiteDanoMovimento, jLeiteX, jLeiteY);
        }

        if (stepJLeiteDanoMovimento == jLeiteDanoMovimento.width) {
          stepJLeiteDanoMovimento = 0;
        }
      }
    } else {
      if (jLeiteDireita || jLeiteEsquerda || jLeiteCima || jLeiteBaixo) {
        if (!jLeiteUsoItem && !jLeiteImune) {
          if (millis() > tempoSpriteJLeiteMovimento + 75) { 
            spriteJLeiteMovimento = jLeiteMovimento.get(stepJLeiteMovimento, 0, 63, 126); 
            stepJLeiteMovimento = stepJLeiteMovimento % 378 + 63;
            image(spriteJLeiteMovimento, jLeiteX, jLeiteY); 
            tempoSpriteJLeiteMovimento = millis();
          } else {
            image(spriteJLeiteMovimento, jLeiteX, jLeiteY);
          }
          if (stepJLeiteMovimento == jLeiteMovimento.width) {
            stepJLeiteMovimento = 0;
          }
        }

        if (jLeiteImune && !jLeiteUsoItem) {
          if (millis() > tempoSpriteJLeiteDanoMovimento + 90) { 
            spriteJLeiteDanoMovimento = jLeiteDanoMovimento.get(stepJLeiteDanoMovimento, 0, 63, 126); 
            stepJLeiteDanoMovimento = stepJLeiteDanoMovimento % 378 + 63;
            image(spriteJLeiteDanoMovimento, jLeiteX, jLeiteY); 
            tempoSpriteJLeiteDanoMovimento = millis();
          } else {
            image(spriteJLeiteDanoMovimento, jLeiteX, jLeiteY);
          }

          if (stepJLeiteDanoMovimento == jLeiteDanoMovimento.width) {
            stepJLeiteDanoMovimento = 0;
          }
        }
      } else {
        if (!jLeiteUsoItem && !jLeiteImune) {
          if (millis() > tempoSpriteJLeiteIdle + 75) { 
            spriteJLeiteIdle = jLeiteIdle.get(stepJLeiteIdle, 0, 63, 126); 
            stepJLeiteIdle = stepJLeiteIdle % 378 + 63;
            image(spriteJLeiteIdle, jLeiteX, jLeiteY); 
            tempoSpriteJLeiteIdle = millis();
          } else {
            image(spriteJLeiteIdle, jLeiteX, jLeiteY);
          }
          if (stepJLeiteIdle == jLeiteIdle.width) {
            stepJLeiteIdle = 0;
          }
        }

        if (jLeiteImune && !jLeiteUsoItem) {
          if (millis() > tempoSpriteJLeiteDanoIdle + 90) { 
            spriteJLeiteDanoIdle = jLeiteDanoIdle.get(stepJLeiteDanoIdle, 0, 63, 126); 
            stepJLeiteDanoIdle = stepJLeiteDanoIdle % 378 + 63;
            image(spriteJLeiteDanoIdle, jLeiteX, jLeiteY); 
            tempoSpriteJLeiteDanoIdle = millis();
          } else {
            image(spriteJLeiteDanoIdle, jLeiteX, jLeiteY);
          }

          if (stepJLeiteDanoIdle == jLeiteDanoIdle.width) {
            stepJLeiteDanoIdle = 0;
          }
        }
      }
    }

    if (jLeiteUsoItem) {
      if (item != 0) {
        if (millis() > tempoSpriteJLeiteItem + 90) { 
          spriteJLeiteItem = jLeiteItem.get(stepJLeiteItem, 0, 94, 126); 
          stepJLeiteItem = stepJLeiteItem % 282 + 94;
          image(spriteJLeiteItem, jLeiteX, jLeiteY); 
          tempoSpriteJLeiteItem = millis();
        } else {
          image(spriteJLeiteItem, jLeiteX, jLeiteY);
        }

        if (stepJLeiteItem == jLeiteItem.width) {
          stepJLeiteItem = 0;
        }

        jLeiteUsoItemContinua = true;
      }
    }

    if (jLeiteUsoItemContinua && millis() > tempoItem + 270) {
      jLeiteUsoItem = false;
      if (millis() > tempoItemAtivo + 870) {
        jLeiteUsoItemConfirma = false;
        jLeiteUsoItemContinua = false;
      }
    }
  } else {
    if (jLeiteMorrendo) {
      if (millis() > tempoSpriteJLeiteMorte + 450) {
        spriteJLeiteMorte = jLeiteMorte.get(stepJLeiteMorte, 0, 126, 126);
        stepJLeiteMorte = stepJLeiteMorte % 378 + 126;
        image(spriteJLeiteMorte, jLeiteX - 31, jLeiteY);
        tempoSpriteJLeiteMorte = millis();
      } else {
        image(spriteJLeiteMorte, jLeiteX - 31, jLeiteY);
      }

      if (stepJLeiteMorte == jLeiteMorte.width) {
        stepJLeiteMorte = 0;
        jLeiteMorrendo = false;
      }
    } else {
      spriteJLeiteMorte = jLeiteMorte.get(252, 0, 378, 125);
      image(spriteJLeiteMorte, jLeiteX - 31, jLeiteY);
    }
  }
}