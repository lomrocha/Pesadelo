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

int playerCurrentHP;
int playerHPMaximum;
int playerHPMinimum;

int playerX, playerY; 

int stepJLeiteMovimento, stepJLeiteIdle, stepJLeiteItem, stepJLeiteDanoMovimento, stepJLeiteDanoIdle, stepJLeiteMorte;
int tempoSpriteJLeiteMovimento, tempoSpriteJLeiteIdle, tempoSpriteJLeiteItem, tempoSpriteJLeiteDanoMovimento, tempoSpriteJLeiteDanoIdle, tempoSpriteJLeiteMorte;

int timeImmune;

int tempoMorto;

boolean isPlayerImmune;
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
    playerCurrentHP = 15;
  }

  if (finalMapa) {
    if (playerY + 126 < - 50) {
      if (gameState == GameState.FIRST_MAP.getValue()) {
        gameState = GameState.FIRST_BOSS.getValue();
        if (temaIgreja.isPlaying()) {
          temaIgreja.pause();
        }
      }
      if (gameState == GameState.SECOND_MAP.getValue()) {
        gameState = GameState.SECOND_BOSS.getValue();
        if (temaFazenda.isPlaying()) {
          temaFazenda.pause();
        }
      }
      if (gameState == GameState.THIRD_MAP.getValue()) {
        gameState = GameState.THIRD_BOSS.getValue();
        if (temaCidade.isPlaying()) {
          temaCidade.pause();
        }
      }
    }
  }

  if (playerCurrentHP < 0 && !jLeiteMorreu) {
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
    if (gameState == GameState.FIRST_BOSS.getValue()) {
      if (isSoundActive) {
        sonsMorteJLeite[0].rewind();
        sonsMorteJLeite[0].play();
      }
    }
    if (gameState == GameState.SECOND_BOSS.getValue()) {
      if (isSoundActive) {
        sonsMorteJLeite[1].rewind();
        sonsMorteJLeite[1].play();
      }
    }
    if (gameState == GameState.THIRD_BOSS.getValue()) {
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
    if (gameState >= GameState.FIRST_MAP.getValue() && gameState <= GameState.THIRD_MAP.getValue()) {
      variablesPreLoad();
      gameState = GameState.MAIN_MENU.getValue();
    } else if (gameState >= GameState.FIRST_BOSS.getValue() && gameState <= GameState.THIRD_BOSS.getValue()) {
      lastState = gameState;
      gameState = GameState.GAMEOVER.getValue();
    }
  }

  if (millis() > timeImmune + 2000) {
    isPlayerImmune = false;
  }

  if (!jLeiteMorreu) {
    if (gameState >= GameState.FIRST_MAP.getValue() && gameState <= GameState.THIRD_MAP.getValue()) {
      if (jLeiteDireita && playerX < width - 163) { 
        playerX = playerX + 3;
      }
      if (jLeiteEsquerda && playerX > 100) {
        playerX = playerX - 3;
      }

      if (!finalMapa) {
        if (jLeiteCima && playerY > 0) {
          playerY = playerY - 3;
        }
      } else {
        if (jLeiteCima) {
          playerY = playerY - 3;
        }
      }

      if (jLeiteBaixo && playerY < height - 126) {
        playerY = playerY + 3;
      }
    }

    if (gameState >= GameState.FIRST_BOSS.getValue() && gameState <= GameState.THIRD_BOSS.getValue()) {
      if (!jLeiteLentidao) {
        if (jLeiteDireita && playerX < width - 88) { 
          playerX = playerX + 3;
        }

        if (jLeiteEsquerda && playerX > 25) {
          playerX = playerX - 3;
        }

        if (jLeiteCima && playerY > 75) {
          playerY = playerY - 3;
        }

        if (jLeiteBaixo && playerY < height - 126) {
          playerY = playerY + 3;
        }
      } else {
        if (jLeiteDireita && playerX < width - 88) { 
          playerX = playerX + 1;
        }

        if (jLeiteEsquerda && playerX > 25) {
          playerX = playerX - 1;
        }

        if (jLeiteCima && playerY > 75) {
          playerY = playerY - 1;
        }

        if (jLeiteBaixo && playerY < height - 126) {
          playerY = playerY + 1;
        }
      }
    }

    image(sombraJLeite, playerX + 7, playerY + 112);

    if (gameState >= GameState.FIRST_MAP.getValue() && gameState <= GameState.THIRD_MAP.getValue()) {
      if (!jLeiteUsoItem && !isPlayerImmune) {
        if (millis() > tempoSpriteJLeiteMovimento + 75) { 
          spriteJLeiteMovimento = jLeiteMovimento.get(stepJLeiteMovimento, 0, 63, 126); 
          stepJLeiteMovimento = stepJLeiteMovimento % 378 + 63;
          image(spriteJLeiteMovimento, playerX, playerY); 
          tempoSpriteJLeiteMovimento = millis();
        } else {
          image(spriteJLeiteMovimento, playerX, playerY);
        }
        if (stepJLeiteMovimento == jLeiteMovimento.width) {
          stepJLeiteMovimento = 0;
        }
      }

      if (isPlayerImmune && !jLeiteUsoItem) {
        if (millis() > tempoSpriteJLeiteDanoMovimento + 90) { 
          spriteJLeiteDanoMovimento = jLeiteDanoMovimento.get(stepJLeiteDanoMovimento, 0, 63, 126); 
          stepJLeiteDanoMovimento = stepJLeiteDanoMovimento % 378 + 63;
          image(spriteJLeiteDanoMovimento, playerX, playerY); 
          tempoSpriteJLeiteDanoMovimento = millis();
        } else {
          image(spriteJLeiteDanoMovimento, playerX, playerY);
        }

        if (stepJLeiteDanoMovimento == jLeiteDanoMovimento.width) {
          stepJLeiteDanoMovimento = 0;
        }
      }
    } else {
      if (jLeiteDireita || jLeiteEsquerda || jLeiteCima || jLeiteBaixo) {
        if (!jLeiteUsoItem && !isPlayerImmune) {
          if (millis() > tempoSpriteJLeiteMovimento + 75) { 
            spriteJLeiteMovimento = jLeiteMovimento.get(stepJLeiteMovimento, 0, 63, 126); 
            stepJLeiteMovimento = stepJLeiteMovimento % 378 + 63;
            image(spriteJLeiteMovimento, playerX, playerY); 
            tempoSpriteJLeiteMovimento = millis();
          } else {
            image(spriteJLeiteMovimento, playerX, playerY);
          }
          if (stepJLeiteMovimento == jLeiteMovimento.width) {
            stepJLeiteMovimento = 0;
          }
        }

        if (isPlayerImmune && !jLeiteUsoItem) {
          if (millis() > tempoSpriteJLeiteDanoMovimento + 90) { 
            spriteJLeiteDanoMovimento = jLeiteDanoMovimento.get(stepJLeiteDanoMovimento, 0, 63, 126); 
            stepJLeiteDanoMovimento = stepJLeiteDanoMovimento % 378 + 63;
            image(spriteJLeiteDanoMovimento, playerX, playerY); 
            tempoSpriteJLeiteDanoMovimento = millis();
          } else {
            image(spriteJLeiteDanoMovimento, playerX, playerY);
          }

          if (stepJLeiteDanoMovimento == jLeiteDanoMovimento.width) {
            stepJLeiteDanoMovimento = 0;
          }
        }
      } else {
        if (!jLeiteUsoItem && !isPlayerImmune) {
          if (millis() > tempoSpriteJLeiteIdle + 75) { 
            spriteJLeiteIdle = jLeiteIdle.get(stepJLeiteIdle, 0, 63, 126); 
            stepJLeiteIdle = stepJLeiteIdle % 378 + 63;
            image(spriteJLeiteIdle, playerX, playerY); 
            tempoSpriteJLeiteIdle = millis();
          } else {
            image(spriteJLeiteIdle, playerX, playerY);
          }
          if (stepJLeiteIdle == jLeiteIdle.width) {
            stepJLeiteIdle = 0;
          }
        }

        if (isPlayerImmune && !jLeiteUsoItem) {
          if (millis() > tempoSpriteJLeiteDanoIdle + 90) { 
            spriteJLeiteDanoIdle = jLeiteDanoIdle.get(stepJLeiteDanoIdle, 0, 63, 126); 
            stepJLeiteDanoIdle = stepJLeiteDanoIdle % 378 + 63;
            image(spriteJLeiteDanoIdle, playerX, playerY); 
            tempoSpriteJLeiteDanoIdle = millis();
          } else {
            image(spriteJLeiteDanoIdle, playerX, playerY);
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
          image(spriteJLeiteItem, playerX, playerY); 
          tempoSpriteJLeiteItem = millis();
        } else {
          image(spriteJLeiteItem, playerX, playerY);
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
        image(spriteJLeiteMorte, playerX - 31, playerY);
        tempoSpriteJLeiteMorte = millis();
      } else {
        image(spriteJLeiteMorte, playerX - 31, playerY);
      }

      if (stepJLeiteMorte == jLeiteMorte.width) {
        stepJLeiteMorte = 0;
        jLeiteMorrendo = false;
      }
    } else {
      spriteJLeiteMorte = jLeiteMorte.get(252, 0, 378, 125);
      image(spriteJLeiteMorte, playerX - 31, playerY);
    }
  }
}
