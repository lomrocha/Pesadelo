PImage vidaFazendeiroLayout;

int fazendeiroHitpointsCurrent;
int fazendeiroHitpointsMinimum;

int fazendeiroBonesIndex;

void vidaFazendeiro() {
  genericHitpointsLayout(bossHitpointsLayoutBackground, bossHitpointsLayoutBackgroundX, bossHitpointsLayoutBackgroundY, fazendeiroHitpointsMinimum, bossHitpointsBarX, bossHitpointsBarXStart, fazendeiroHitpointsCurrent, bossHitpointsBar, bossHitpointsBarY, bossHitpointsInterval, vidaFazendeiroLayout, bossHitpointsLayoutX, bossHitpointsLayoutY);
  image(bossBonesLayout[fazendeiroBonesIndex], 84, 54);
}

AudioPlayer[] sonsFazendeiroIdle = new AudioPlayer [3];
AudioPlayer[] sonsFazendeiroTomandoDano = new AudioPlayer [4];
AudioPlayer[] sonsFazendeiroSoltandoMimosa = new AudioPlayer [5];
AudioPlayer somSoltandoPneu;
AudioPlayer somFazendeiroMorreu;

PImage fazendeiroIdle;
PImage fazendeiroMovimento;
PImage fazendeiroFoice;
PImage fazendeiroMimosa;
PImage fazendeiroIdleMimosa;
PImage fazendeiroPneu;
PImage fazendeiroPneuEscudo;
PImage fazendeiroPneuDano;
PImage fazendeiroIdlePneu;
PImage fazendeiroMorte;

PImage sombraFazendeiro;

int[] valoresFazendeiroDestinoX = {25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100, 105, 110, 115, 120, 125, 130, 135, 140, 145, 150, 155, 160, 165, 170, 175, 180, 185, 190, 195, 200, 205, 210, 215, 220, 225, 230, 235, 240, 245, 250, 255, 260, 265, 270, 275, 280, 285, 290, 295, 300, 305, 310, 315, 320, 325, 330, 335, 340, 345, 350, 355, 360, 365, 370, 375, 380, 385, 390, 400, 405, 410, 415, 420, 425, 430, 435, 440, 445, 450, 455, 460, 465, 470, 475, 480, 485, 490, 500, 505, 510, 515, 520, 525, 530, 535, 540, 545, 550, 555, 560, 565, 570, 575, 580, 585}; 
int[] valoresFazendeiroDestinoY = {75, 80, 85, 90, 95, 100, 105, 110, 115, 120, 130, 135, 140, 145, 150, 155};

int fazendeiroX = valoresFazendeiroDestinoX[int(random(0, valoresFazendeiroDestinoX.length))];
int fazendeiroY = valoresFazendeiroDestinoY[int(random(0, valoresFazendeiroDestinoY.length))];

int indexRandomSomFazendeiroTomandoDano;

int tempoSpriteFazendeiroTomouDanoPneu;

int tempoBossMorreu;

boolean ataqueMimosaAcontecendo;
boolean soltouPneu, ataquePneuAcontecendo, fazendeiroTomouDanoPneu;

public class Fazendeiro {
  private PImage spriteFazendeiroIdle;
  private PImage spriteFazendeiroMovimento;
  private PImage spriteFazendeiroFoice;
  private PImage spriteFazendeiroMimosa;
  private PImage spriteFazendeiroIdleMimosa;
  private PImage spriteFazendeiroPneu;
  private PImage spriteFazendeiroPneuEscudo;
  private PImage spriteFazendeiroPneuDano;
  private PImage spriteFazendeiroIdlePneu;
  private PImage spriteFazendeiroMorte;

  private int destinoFazendeiroX = valoresFazendeiroDestinoX[int(random(0, valoresFazendeiroDestinoX.length))];
  private int destinoFazendeiroY = valoresFazendeiroDestinoY[int(random(0, valoresFazendeiroDestinoY.length))];

  private int stepFazendeiroIdle;
  private int tempoSpriteFazendeiroIdle;

  private int stepFazendeiroMovimento;
  private int tempoSpriteFazendeiroMovimento;

  private int stepFazendeiroFoice;
  private int tempoSpriteFazendeiroFoice;

  private int stepFazendeiroMimosa;
  private int tempoSpriteFazendeiroMimosa;

  private int stepFazendeiroIdleMimosa;
  private int tempoSpriteFazendeiroIdleMimosa;

  private int stepFazendeiroPneu;
  private int tempoSpriteFazendeiroPneu;

  private int stepFazendeiroPneuEscudo;
  private int tempoSpriteFazendeiroPneuEscudo;

  private int stepFazendeiroPneuDano;
  private int tempoSpriteFazendeiroPneuDano;

  private int stepFazendeiroIdlePneu;
  private int tempoSpriteFazendeiroIdlePneu;

  private int stepFazendeiroMorte;
  private int tempoSpriteFazendeiroMorte;

  private int tempoNovoDestino = millis();

  private int indexRandomSomFazendeiroIdle;
  private int indexRandomSomFazendeiroMimosa;

  private int tempoNovoAtaqueFoice, tempoDanoFoice;

  private int tempoNovoAtaqueMimosa = millis();
  private int tempoNovoAtaquePneu = millis();

  private boolean somFazendeiroIdleTocando;

  private boolean andando;
  private boolean ataqueFoice, ataqueFoiceLigado, ataqueFoiceAcontecendo;
  private boolean novoAtaqueMimosa, gatilhoNovoAtaqueMimosaAtivo, gatilhoNovoAtaqueMimosa;                                               
  private boolean novoAtaquePneu, gatilhoNovoAtaquePneuAtivo, gatilhoNovoAtaquePneu; 
  private boolean fazendeiroMorreu, fazendeiroMorrendo;

  void display() {
    image(sombraFazendeiro, fazendeiroX + 48, fazendeiroY + 113);
    if (!fazendeiroMorreu) {
      if (!andando && !ataqueFoice && !novoAtaqueMimosa && !ataqueMimosaAcontecendo && !novoAtaquePneu && !ataquePneuAcontecendo && !fazendeiroTomouDanoPneu) {
        if (!somFazendeiroIdleTocando) {
          if (sonsAtivos) {
            indexRandomSomFazendeiroIdle = int(random(0, sonsFazendeiroIdle.length));
            sonsFazendeiroIdle[indexRandomSomFazendeiroIdle].rewind();
            sonsFazendeiroIdle[indexRandomSomFazendeiroIdle].play();
            somFazendeiroIdleTocando = true;
          }
        }

        if (millis() > tempoSpriteFazendeiroIdle + 175) {
          spriteFazendeiroIdle = fazendeiroIdle.get(stepFazendeiroIdle, 0, 188, 125);
          stepFazendeiroIdle = stepFazendeiroIdle % 752 + 188;
          image(spriteFazendeiroIdle, fazendeiroX, fazendeiroY);
          tempoSpriteFazendeiroIdle = millis();
        } else {
          image(spriteFazendeiroIdle, fazendeiroX, fazendeiroY);
        }

        if (stepFazendeiroIdle == fazendeiroIdle.width) {
          stepFazendeiroIdle = 0;
        }
      }

      if (andando && !ataqueFoice && !novoAtaqueMimosa && !ataqueMimosaAcontecendo && !novoAtaquePneu && !ataquePneuAcontecendo && !fazendeiroTomouDanoPneu) {
        if (millis() > tempoSpriteFazendeiroMovimento + 75) {
          spriteFazendeiroMovimento = fazendeiroMovimento.get(stepFazendeiroMovimento, 0, 188, 125);
          stepFazendeiroMovimento = stepFazendeiroMovimento % 752 + 188;
          image(spriteFazendeiroMovimento, fazendeiroX, fazendeiroY);
          tempoSpriteFazendeiroMovimento = millis();
        } else {
          image(spriteFazendeiroMovimento, fazendeiroX, fazendeiroY);
        }

        if (stepFazendeiroMovimento == fazendeiroMovimento.width) {
          stepFazendeiroMovimento = 0;
        }
      } 

      if (ataqueFoice && !novoAtaqueMimosa && !ataqueMimosaAcontecendo && !novoAtaquePneu && !ataquePneuAcontecendo && !fazendeiroTomouDanoPneu) {
        if (millis() > tempoSpriteFazendeiroFoice + 155) {
          spriteFazendeiroFoice = fazendeiroFoice.get(stepFazendeiroFoice, 0, 248, 192);
          stepFazendeiroFoice = stepFazendeiroFoice % 1240 + 248;
          image (spriteFazendeiroFoice, fazendeiroX - 44, fazendeiroY - 35);
          tempoSpriteFazendeiroFoice = millis();
        } else {
          image(spriteFazendeiroFoice, fazendeiroX - 44, fazendeiroY - 35);
        }

        if (stepFazendeiroFoice == fazendeiroFoice.width) {
          ataqueFoice = false;
          ataqueFoiceAcontecendo = false;
          stepFazendeiroFoice = 0;
        }
      }

      if (novoAtaqueMimosa && !ataqueMimosaAcontecendo && !novoAtaquePneu && !ataquePneuAcontecendo && !fazendeiroTomouDanoPneu) {
        if (stepFazendeiroMimosa == 0) {
          if (sonsAtivos) {
            indexRandomSomFazendeiroMimosa = int(random(0, sonsFazendeiroSoltandoMimosa.length));
            sonsFazendeiroSoltandoMimosa[indexRandomSomFazendeiroMimosa].rewind();
            sonsFazendeiroSoltandoMimosa[indexRandomSomFazendeiroMimosa].play();
          }
        }

        if (millis() > tempoSpriteFazendeiroMimosa + 75) {
          spriteFazendeiroMimosa = fazendeiroMimosa.get(stepFazendeiroMimosa, 0, 191, 131);
          stepFazendeiroMimosa = stepFazendeiroMimosa % 1910 + 191;
          image(spriteFazendeiroMimosa, fazendeiroX + 10, fazendeiroY + 5);
          tempoSpriteFazendeiroMimosa = millis();
        } else {
          image(spriteFazendeiroMimosa, fazendeiroX + 10, fazendeiroY + 5);
        }

        if (stepFazendeiroMimosa == fazendeiroMimosa.width) {
          novoAtaqueMimosa = false;
          ataqueMimosaAcontecendo = true;
          stepFazendeiroMimosa = 0;
        }
      }

      if (ataqueMimosaAcontecendo && !novoAtaquePneu && !ataquePneuAcontecendo && !fazendeiroTomouDanoPneu) {
        if (millis() > tempoSpriteFazendeiroIdleMimosa + 175) {
          spriteFazendeiroIdleMimosa = fazendeiroIdleMimosa.get(stepFazendeiroIdleMimosa, 0, 188, 125);
          stepFazendeiroIdleMimosa = stepFazendeiroIdleMimosa % 752 + 188;
          image(spriteFazendeiroIdleMimosa, fazendeiroX, fazendeiroY);
          tempoSpriteFazendeiroIdleMimosa = millis();
        } else {
          image(spriteFazendeiroIdleMimosa, fazendeiroX, fazendeiroY);
        }

        if (stepFazendeiroIdleMimosa == fazendeiroIdleMimosa.width) {
          stepFazendeiroIdleMimosa = 0;
        }
      }

      if (novoAtaquePneu && !ataquePneuAcontecendo && !ataqueMimosaAcontecendo && !fazendeiroTomouDanoPneu) {
        if (stepFazendeiroPneu == 0) {
          if (sonsAtivos) {
            somSoltandoPneu.rewind();
            somSoltandoPneu.play();
          }
        }
        if (millis() > tempoSpriteFazendeiroPneu + 175) {
          spriteFazendeiroPneu = fazendeiroPneu.get(stepFazendeiroPneu, 0, 157, 132);
          stepFazendeiroPneu = stepFazendeiroPneu % 1413 + 157;
          image(spriteFazendeiroPneu, fazendeiroX + 40, fazendeiroY);
          tempoSpriteFazendeiroPneu = millis();
        } else {
          image(spriteFazendeiroPneu, fazendeiroX + 40, fazendeiroY);
        }

        if (stepFazendeiroPneu == 1099) {
          soltouPneu = true;
          pneuRolandoPrimeiraVez = true;
        }

        if (stepFazendeiroPneu == fazendeiroPneu.width) {
          novoAtaquePneu = false;
          ataquePneuAcontecendo = true;
          gatilhoNovoAtaquePneu = false;
          stepFazendeiroPneu = 0;
        }
      }

      if (pneuRolandoPrimeiraVez && ataquePneuAcontecendo && !ataqueMimosaAcontecendo && !fazendeiroTomouDanoPneu) {
        if (millis() > tempoSpriteFazendeiroPneuEscudo + 175) {
          spriteFazendeiroPneuEscudo = fazendeiroPneuEscudo.get(stepFazendeiroPneuEscudo, 0, 188, 125);
          stepFazendeiroPneuEscudo = stepFazendeiroPneuEscudo % 752 + 188;
          image(spriteFazendeiroPneuEscudo, fazendeiroX, fazendeiroY);
          tempoSpriteFazendeiroPneuEscudo = millis();
        } else {
          image(spriteFazendeiroPneuEscudo, fazendeiroX, fazendeiroY);
        }

        if (stepFazendeiroPneuEscudo == fazendeiroPneuEscudo.width) {
          stepFazendeiroPneuEscudo = 0;
        }
      }

      if (!pneuRolandoPrimeiraVez && ataquePneuAcontecendo && !ataqueMimosaAcontecendo && !fazendeiroTomouDanoPneu) {
        if (millis() > tempoSpriteFazendeiroIdlePneu + 175) {
          spriteFazendeiroIdlePneu = fazendeiroIdlePneu.get(stepFazendeiroIdlePneu, 0, 188, 125);
          stepFazendeiroIdlePneu = stepFazendeiroIdlePneu % 752 + 188;
          image(spriteFazendeiroIdlePneu, fazendeiroX, fazendeiroY);
          tempoSpriteFazendeiroIdlePneu = millis();
        } else {
          image(spriteFazendeiroIdlePneu, fazendeiroX, fazendeiroY);
        }

        if (stepFazendeiroIdlePneu == fazendeiroIdlePneu.width) {
          stepFazendeiroIdlePneu = 0;
        }
      }

      if (fazendeiroTomouDanoPneu && !ataqueMimosaAcontecendo) {
        if (millis() > tempoSpriteFazendeiroPneuDano + 175) {
          spriteFazendeiroPneuDano = fazendeiroPneuDano.get(stepFazendeiroPneuDano, 0, 188, 125);
          stepFazendeiroPneuDano = stepFazendeiroPneuDano % 752 + 188;
          image(spriteFazendeiroPneuDano, fazendeiroX, fazendeiroY);
          tempoSpriteFazendeiroPneuDano = millis();
        } else {
          image(spriteFazendeiroPneuDano, fazendeiroX, fazendeiroY);
        }

        if (stepFazendeiroPneuDano == fazendeiroPneuDano.width && millis() > tempoSpriteFazendeiroTomouDanoPneu + 1400) {
          fazendeiroTomouDanoPneu = false;
        }

        if (stepFazendeiroPneuDano == fazendeiroPneuDano.width) {
          stepFazendeiroPneuDano = 0;
        }
      }
    } else {
      if (fazendeiroMorrendo) {
        if (millis() > tempoSpriteFazendeiroMorte + 450) {
          spriteFazendeiroMorte = fazendeiroMorte.get(stepFazendeiroMorte, 0, 196, 155);
          stepFazendeiroMorte = stepFazendeiroMorte % 980 + 196;
          image(spriteFazendeiroMorte, fazendeiroX, fazendeiroY);
          tempoSpriteFazendeiroMorte = millis();
        } else {
          image(spriteFazendeiroMorte, fazendeiroX, fazendeiroY);
        }

        if (stepFazendeiroMorte == fazendeiroMorte.width) {
          stepFazendeiroMorte = 0;
          fazendeiroMorrendo = false;
        }
      } else {
        spriteFazendeiroMorte = fazendeiroMorte.get(784, 0, 980, 155);
        image(spriteFazendeiroMorte, fazendeiroX, fazendeiroY);
      }
    }
  }

  void update() {
    if (!ataquePneuAcontecendo && !fazendeiroTomouDanoPneu && !fazendeiroMorreu) {
      if (millis() > tempoNovoDestino + 5000) {
        destinoFazendeiroX = valoresFazendeiroDestinoX[int(random(0, valoresFazendeiroDestinoX.length))];
        destinoFazendeiroY = valoresFazendeiroDestinoY[int(random(0, valoresFazendeiroDestinoY.length))];
        tempoNovoDestino = millis();
        gatilhoNovoAtaqueMimosa = false;
        gatilhoNovoAtaqueMimosaAtivo = false;
        gatilhoNovoAtaquePneuAtivo = false;
        somFazendeiroIdleTocando = false;
      }

      if (fazendeiroX == destinoFazendeiroX && fazendeiroY == destinoFazendeiroY) {
        andando = false;
      }

      if (fazendeiroX < destinoFazendeiroX) {
        andando = true;
        fazendeiroX = fazendeiroX + 5;
      }
      if (fazendeiroX > destinoFazendeiroX) {
        andando = true;
        fazendeiroX = fazendeiroX - 5;
      }

      if (fazendeiroY < destinoFazendeiroY) {
        andando = true;
        fazendeiroY = fazendeiroY + 5;
      }
      if (fazendeiroY > destinoFazendeiroY) {      
        andando = true;
        fazendeiroY = fazendeiroY - 5;
      }
    }
  }

  void ataqueFoice() {
    if (!ataqueMimosaAcontecendo && !ataquePneuAcontecendo && !fazendeiroTomouDanoPneu && !fazendeiroMorreu) {
      if (dist(fazendeiroX, fazendeiroY, jLeiteX, jLeiteY) < 100 && !ataqueFoiceLigado && millis() > tempoNovoAtaqueFoice + 1500) {
        tempoNovoAtaqueFoice = millis();
        tempoDanoFoice = millis();
        ataqueFoice = true;
        ataqueFoiceLigado = true;
        ataqueFoiceAcontecendo = true;
      } else {
        ataqueFoiceLigado = false;
      }
    }
  }

  void colisaoFoice() {
    if (ataqueFoiceAcontecendo && dist(fazendeiroX, fazendeiroY, jLeiteX, jLeiteY) < 100) {
      if (millis() > tempoDanoFoice + 310) {
        if (!jLeiteImune) {
          playerHitpointsCurrent = playerHitpointsCurrent - 3;
          jLeiteImune = true;
          tempoImune = millis();
        }
      }
    }
  }

  void ataqueMimosa() {
    if (!ataquePneuAcontecendo && !fazendeiroTomouDanoPneu && !fazendeiroMorreu) {
      if (fazendeiroX == destinoFazendeiroX && fazendeiroY == destinoFazendeiroY) {
        if (!gatilhoNovoAtaqueMimosa) {
          tempoNovoAtaqueMimosa = millis();
          gatilhoNovoAtaqueMimosa = true;
        }
        if (millis() > tempoNovoAtaqueMimosa + 1500 && !gatilhoNovoAtaqueMimosaAtivo) {
          novoAtaqueMimosa = true;
          gatilhoNovoAtaqueMimosaAtivo = true;
        }
      }
    }
  }

  void ataquePneu() {
    if (!ataquePneuAcontecendo && !ataqueMimosaAcontecendo && !fazendeiroMorreu) {
      if (!gatilhoNovoAtaquePneu) {
        tempoNovoAtaquePneu = millis();
        gatilhoNovoAtaquePneu = true;
      }
      if (millis() > tempoNovoAtaquePneu + 32000 && !gatilhoNovoAtaquePneuAtivo) {
        novoAtaquePneu = true;
        gatilhoNovoAtaquePneuAtivo = true;
      }
    }
  }

  void fazendeiroMorte() {
    if ((fazendeiroHitpointsCurrent <= 0 || fazendeiroBonesIndex == 0) && !fazendeiroMorreu) {
      fazendeiroMorreu = true;
      fazendeiroMorrendo = true;
      if (sonsAtivos) {
        somFazendeiroMorreu.rewind();
        somFazendeiroMorreu.play();
      }
      tempoBossMorreu = millis();
    }
  }
}

Fazendeiro fazendeiro;

void fazendeiro() {
  cachorro();
  vidaFazendeiro();
  pneu();
  mimosa();
  fazendeiro.display();
  fazendeiro.update();
  fazendeiro.ataqueFoice();
  fazendeiro.colisaoFoice();
  fazendeiro.ataqueMimosa();
  fazendeiro.ataquePneu();
  fazendeiro.fazendeiroMorte();
}

AudioPlayer[] sonsMimosaHit = new AudioPlayer [2];
AudioPlayer somMimosaErra;

PImage mimosa, mimosaDireita, mimosaEsquerda;

public class Mimosa {
  private PImage spriteMimosa;

  private int mimosaX = fazendeiroX + 66;
  private int mimosaY = fazendeiroY + 30;

  private int movimentoMimosaX;

  private int destinoX = jLeiteX;

  private int stepMimosa;
  private int tempoSpriteMimosa;

  private boolean mimosaReta;

  private boolean acertouJLeite;

  void display() {
    if (millis() > tempoSpriteMimosa + 70) { 
      if (!mimosaReta) {
        if (mimosaX > destinoX) {
          spriteMimosa = mimosaEsquerda.get(stepMimosa, 0, 94, 101);
        } else {
          spriteMimosa = mimosaDireita.get(stepMimosa, 0, 94, 101);
        }
      } else {
        spriteMimosa = mimosa.get(stepMimosa, 0, 94, 101);
      }
      stepMimosa = stepMimosa % 188 + 94;
      image(spriteMimosa, mimosaX, mimosaY);
      tempoSpriteMimosa = millis();
    } else {
      image(spriteMimosa, mimosaX, mimosaY);
    }

    if (stepMimosa == mimosa.width) {
      stepMimosa = 0;
    }
  }

  void update() {
    mimosaX = mimosaX + movimentoMimosaX;
    mimosaY = mimosaY + 8;
    if (!mimosaReta) {
      if (mimosaX > destinoX) {
        movimentoMimosaX = -8;
      } 
      if (mimosaX < destinoX) {
        movimentoMimosaX = 8;
      }
    } else {
      movimentoMimosaX = 0;
    }
  }

  void checaMimosaReta() {
    if (mimosaX < destinoX) {
      if (destinoX - mimosaX < 10) {  
        mimosaReta = true;
      } else {
        mimosaReta = false;
      }
    } else {
      if (mimosaX - destinoX < 8) {  
        mimosaReta = true;
      } else {
        mimosaReta = false;
      }
    }
  }

  boolean acertouJLeite() {
    if (mimosaX + 94 > jLeiteX && mimosaX < jLeiteX + 63 && mimosaY + 101 > jLeiteY && mimosaY < jLeiteY + 126) {
      acertouJLeite = true;
      return true;
    } else {
      return false;
    }
  }

  boolean saiuDaTela() {
    if (mimosaY > height) {
      ataqueMimosaAcontecendo = false;
      return true;
    } else {
      return false;
    }
  }
}

ArrayList<Mimosa> mimosas;

void mimosa() {
  if (ataqueMimosaAcontecendo && mimosas.size() == 0) {
    mimosas.add(new Mimosa());
  }

  for (int i = mimosas.size() - 1; i >= 0; i = i - 1) {
    Mimosa m = mimosas.get(i);
    m.display();
    m.update();
    m.checaMimosaReta();
    if (m.saiuDaTela()) {
      mimosas.remove(m);
      if (!m.acertouJLeite) {
        if (sonsAtivos) {
          somMimosaErra.rewind();
          somMimosaErra.play();
        }
      }
    }

    if (m.acertouJLeite() && !jLeiteImune) {
      playerHitpointsCurrent = playerHitpointsCurrent - 2;
      jLeiteImune = true;
      tempoImune = millis();
      if (sonsAtivos) {
        sonsMimosaHit[int(random(0, 2))].rewind();
        sonsMimosaHit[int(random(0, 2))].play();
      }
    }
  }
}

AudioPlayer somAcertouPneuJLeite, somAcertouPneuFazendeiro;

PImage pneuEsquerdaDesce, pneuEsquerdaSobe, pneuDireitaDesce, pneuDireitaSobe;

boolean pneuRolandoPrimeiraVez;

public class Pneu {
  private PImage spritePneu;

  private int pneuX = fazendeiroX - 30;
  private int pneuY = fazendeiroY + 70;

  private int destinoPneuX = 25;
  private int destinoPneuY = 300;

  private int movimentoPneuX = 1;
  private int movimentoPneuY = 1;

  private int totalRebatidasRestantes = 6;
  private int totalSprites = 7;

  private int stepPneu;
  private int tempoSpritePneu;

  private boolean novoDestinoPneu;

  private boolean acertarFazendeiro;

  void display() {
    if (millis() > tempoSpritePneu + 40) { 
      if (totalSprites == 7 || totalSprites == 3) {
        spritePneu = pneuEsquerdaDesce.get(stepPneu, 0, 116, 84);
      }
      if (totalSprites == 4 || totalSprites == 0) {
        spritePneu = pneuEsquerdaSobe.get(stepPneu, 0, 116, 84);
      }
      if (totalSprites == 6 || totalSprites == 2) {
        spritePneu = pneuDireitaDesce.get(stepPneu, 0, 116, 84);
      }
      if (totalSprites == 5 || totalSprites == 1) {
        spritePneu = pneuDireitaSobe.get(stepPneu, 0, 116, 84);
      }
      stepPneu = stepPneu % 232 + 116;
      image(spritePneu, pneuX, pneuY);
      tempoSpritePneu = millis();
    } else {
      image(spritePneu, pneuX, pneuY);
    }

    if (stepPneu == 232) {
      stepPneu = 0;
    }
  }

  void update() {
    pneuX = pneuX + movimentoPneuX;
    pneuY = pneuY + movimentoPneuY;

    if (dist(pneuX, pneuY, destinoPneuX, destinoPneuY) < 10) {
      novoDestinoPneu = true;
    }

    if (novoDestinoPneu) {
      if (totalRebatidasRestantes == 6) {
        if (jLeiteY > 300) {
          destinoPneuX = jLeiteX;
          destinoPneuY = jLeiteY;
        } else {
          destinoPneuX = 300;
          destinoPneuY = 515;
        }
        totalSprites = 6;
      }

      if (totalRebatidasRestantes == 5) {
        destinoPneuX = 659;
        destinoPneuY = 300;
        totalSprites = 5;
      }

      if (totalRebatidasRestantes == 4) {
        destinoPneuX = 300;
        destinoPneuY = 75;
        totalSprites = 4;
      }

      if (totalRebatidasRestantes == 3) {
        pneuRolandoPrimeiraVez = false;
        destinoPneuX = 25;
        destinoPneuY = 300;
        totalSprites = 3;
      }

      if (totalRebatidasRestantes == 2) {
        if (jLeiteY > 300) {
          destinoPneuX = jLeiteX;
          destinoPneuY = jLeiteY;
        } else {
          destinoPneuX = 300;
          destinoPneuY = 515;
        }
        totalSprites = 2;
      }

      if (totalRebatidasRestantes == 1) {
        destinoPneuX = 659;
        destinoPneuY = 300;
        totalSprites = 1;
      }

      if (totalRebatidasRestantes == 0) {
        destinoPneuX = fazendeiroX;
        destinoPneuY = fazendeiroY;
        acertarFazendeiro = true;
        totalSprites = 0;
      }

      totalRebatidasRestantes = totalRebatidasRestantes - 1;
      novoDestinoPneu = false;
    }

    if (pneuX > destinoPneuX) {
      movimentoPneuX = -5;
    }
    if (pneuX < destinoPneuX) {
      movimentoPneuX = 5;
    }

    if (pneuY > destinoPneuY) {
      movimentoPneuY = -5;
    } 
    if (pneuY < destinoPneuY) {      
      movimentoPneuY = 5;
    }
  }

  boolean acertouJoaoLeite() {
    if (pneuX + 66 > jLeiteX && pneuX < jLeiteX + 63 && pneuY + 69 > jLeiteY && pneuY < jLeiteY + 123) {
      return true;
    } else {
      return false;
    }
  }

  boolean acertouFazendeiro() {
    if (pneuX + 116 > fazendeiroX && pneuX < fazendeiroX + 188 && pneuY + 84 > fazendeiroY && pneuY < fazendeiroY + 125 && acertarFazendeiro) {
      if (fazendeiroBonesIndex >= 1) {
        fazendeiroBonesIndex = fazendeiroBonesIndex - 1;
      }
      tempoSpriteFazendeiroTomouDanoPneu = millis();
      fazendeiroTomouDanoPneu = true;
      return true;
    } else {
      return false;
    }
  }
}

ArrayList<Pneu> pneus;

void pneu() {
  if (pneus.size() == 0) {
    pneuRolandoPrimeiraVez = false;
    ataquePneuAcontecendo = false;
  }

  if (soltouPneu && pneus.size() == 0) {
    pneus.add(new Pneu());
  }

  for (int i = pneus.size() - 1; i >= 0; i = i - 1) {
    Pneu p = pneus.get(i);
    p.display();
    p.update();
    if (p.acertouJoaoLeite() || p.acertouFazendeiro()) {   
      soltouPneu = false;
      pneus.remove(p);
    }
    if (p.acertouJoaoLeite() && !jLeiteImune) {
      if (sonsAtivos) {
        somAcertouPneuJLeite.rewind();
        somAcertouPneuJLeite.play();
      }
      playerHitpointsCurrent = playerHitpointsCurrent - 5;
      jLeiteImune = true;
      tempoImune = millis();
    }
    if (p.acertouFazendeiro()) {
      if (sonsAtivos) {
        somAcertouPneuFazendeiro.rewind();
        somAcertouPneuFazendeiro.play();
      }
    }
  }
}