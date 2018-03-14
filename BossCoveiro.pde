PImage vidaCoveiroLayout;

int coveiroHitpointsCurrent;
int coveiroHitpointsMinimum;

int coveiroBonesIndex;

void vidaCoveiro() {
  genericHitpointsLayout(bossHitpointsLayoutBackground, bossHitpointsLayoutBackgroundX, bossHitpointsLayoutBackgroundY, coveiroHitpointsMinimum, bossHitpointsBarX, bossHitpointsBarXStart, coveiroHitpointsCurrent, bossHitpointsBar, bossHitpointsBarY, bossHitpointsInterval, vidaCoveiroLayout, bossHitpointsLayoutX, bossHitpointsLayoutY);
  image(bossBonesLayout[coveiroBonesIndex], 84, 54);
}

AudioPlayer[] sonsCoveiroIdle = new AudioPlayer [3];
AudioPlayer[] sonsCoveiroTomandoDano = new AudioPlayer [8];
AudioPlayer somCoveiroFenda;
AudioPlayer[] sonsCoveiroEsmaga = new AudioPlayer [3];
AudioPlayer somCoveiroMorreu;

PImage coveiroIdle;
PImage coveiroMovimento;
PImage coveiroPa;
PImage coveiroPaFenda;
PImage coveiroCarregandoLapide;
PImage coveiroLapide;
PImage coveiroLapideDano;
PImage coveiroMorte;

PImage sombraCoveiro;

int[] valoresCoveiroDestinoX = {27, 42, 57, 72, 87, 102, 117, 132, 147, 162, 177, 192, 207, 222, 237, 252, 267, 282, 297, 312, 327, 342, 357, 372, 387, 402, 417, 432, 447, 462, 477, 492, 507, 522, 537, 552, 567, 582, 597, 612};
int[] valoresCoveiroDestinoY = {75, 78, 81, 84, 87, 90, 93, 96, 99, 102, 105, 108, 111, 114, 117, 120, 123, 126, 129, 132, 135, 138, 141, 144, 147, 150, 153, 156, 159, 162, 165, 168, 171, 174, 177, 180, 183};

int coveiroX = valoresCoveiroDestinoX[int(random(0, valoresCoveiroDestinoX.length))];
int coveiroY = valoresCoveiroDestinoY[int(random(0, valoresCoveiroDestinoY.length))];

int indexRandomSomCoveiroTomandoDano;

int tempoCoveiroTomouDanoAgua, tempoCoveiroDelayTomouDanoAgua;

boolean abriuFenda, ataqueFendaAcontecendo;
boolean ataqueLapideAcontecendo, coveiroTomouDanoAgua, coveiroDelayTomouDanoAgua;

public class Coveiro {
  private PImage spriteCoveiroIdle;
  private PImage spriteCoveiroMovimento;
  private PImage spriteCoveiroPa;
  private PImage spriteCoveiroCarregandoLapide;
  private PImage spriteCoveiroLapide;
  private PImage spriteCoveiroPaFenda;
  private PImage spriteCoveiroMorte;

  private int destinoCoveiroX = valoresCoveiroDestinoX[int(random(0, valoresCoveiroDestinoX.length))];
  private int destinoCoveiroY = valoresCoveiroDestinoY[int(random(0, valoresCoveiroDestinoY.length))];

  private int stepCoveiroIdle;
  private int tempoSpriteCoveiroIdle;

  private int stepCoveiroMovimento;
  private int tempoSpriteCoveiroMovimento;

  private int stepCoveiroPa;
  private int tempoSpriteCoveiroPa;

  private int stepCoveiroPaFenda;
  private int tempoSpriteCoveiroPaFenda;

  private int stepCoveiroCarregandoLapide;
  private int tempoSpriteCoveiroCarregandoLapide;

  private int stepCoveiroLapide;
  private int tempoSpriteCoveiroLapide;

  private int stepCoveiroMorte;
  private int tempoSpriteCoveiroMorte;

  private int indexRandomSomCoveiroIdle;
  private int indexRandomSomCoveiroEsmaga;

  private int tempoNovoDestino = millis();

  private int tempoNovoAtaquePa, tempoDanoPa;

  private int tempoNovoAtaqueFenda = millis();
  private int tempoGatilhoCarregarNovoAtaqueLapide = millis(), tempoGatilhoNovoAtaqueLapide;

  private boolean somCoveiroIdleTocando;

  private boolean andando;
  private boolean ataquePa, ataquePaLigado, ataquePaAcontecendo;
  private boolean novoAtaqueFenda, gatilhoNovoAtaqueFendaAtivo, gatilhoNovoAtaqueFenda;  
  private boolean carregandoNovoAtaqueLapide, novoAtaqueLapide, gatilhoNovoAtaqueLapideAtivo, gatilhoNovoAtaqueLapide, coveiroSocoChao;  
  private boolean coveiroMorreu, coveiroMorrendo;

  void display() {
    if (!coveiroMorreu) {
      image(sombraCoveiro, coveiroX + 2, coveiroY + 125);

      if (!andando && !ataquePa && !novoAtaqueFenda && !carregandoNovoAtaqueLapide && !novoAtaqueLapide && !coveiroTomouDanoAgua) {
        if (!somCoveiroIdleTocando) {
          if (sonsAtivos) {
            indexRandomSomCoveiroIdle = int(random(0, sonsCoveiroIdle.length));
            sonsCoveiroIdle[indexRandomSomCoveiroIdle].rewind();
            sonsCoveiroIdle[indexRandomSomCoveiroIdle].play();
            somCoveiroIdleTocando = true;
          }
        }

        if (millis() > tempoSpriteCoveiroIdle + 250) {
          spriteCoveiroIdle = coveiroIdle.get(stepCoveiroIdle, 0, 160, 188);
          stepCoveiroIdle = stepCoveiroIdle % 640 + 160;
          image(spriteCoveiroIdle, coveiroX, coveiroY);
          tempoSpriteCoveiroIdle = millis();
        } else {
          image(spriteCoveiroIdle, coveiroX, coveiroY);
        }

        if (stepCoveiroIdle == coveiroIdle.width) {
          stepCoveiroIdle = 0;
        }
      }

      if (andando && !ataquePa && !novoAtaqueFenda && !carregandoNovoAtaqueLapide && !novoAtaqueLapide && !coveiroTomouDanoAgua) {
        if (millis() > tempoSpriteCoveiroMovimento + 250) {
          spriteCoveiroMovimento = coveiroMovimento.get(stepCoveiroMovimento, 0, 160, 188);
          stepCoveiroMovimento = stepCoveiroMovimento % 640 + 160;
          image(spriteCoveiroMovimento, coveiroX, coveiroY);
          tempoSpriteCoveiroMovimento = millis();
        } else {
          image(spriteCoveiroMovimento, coveiroX, coveiroY);
        }

        if (stepCoveiroMovimento == coveiroMovimento.width) {
          stepCoveiroMovimento = 0;
        }
      }

      if (ataquePa && !novoAtaqueFenda && !carregandoNovoAtaqueLapide && !novoAtaqueLapide && !coveiroTomouDanoAgua) {
        if (millis() > tempoSpriteCoveiroPa + 155) {
          spriteCoveiroPa = coveiroPa.get(stepCoveiroPa, 0, 169, 272);
          stepCoveiroPa = stepCoveiroPa % 1014 + 169;
          image(spriteCoveiroPa, coveiroX - 5, coveiroY - 55);
          tempoSpriteCoveiroPa = millis();
        } else {
          image(spriteCoveiroPa, coveiroX - 5, coveiroY - 55);
        }

        if (stepCoveiroPa == coveiroPa.width) {
          ataquePa = false;
          ataquePaAcontecendo = false;
          stepCoveiroPa = 0;
        }
      }

      if (novoAtaqueFenda && !carregandoNovoAtaqueLapide && !novoAtaqueLapide && !coveiroTomouDanoAgua) {
        if (millis() > tempoSpriteCoveiroPaFenda + 275) {
          spriteCoveiroPaFenda = coveiroPaFenda.get(stepCoveiroPaFenda, 0, 242, 253);
          stepCoveiroPaFenda = stepCoveiroPaFenda % 1694 + 242;
          image(spriteCoveiroPaFenda, coveiroX - 59, coveiroY - 27);
          tempoSpriteCoveiroPaFenda = millis();
        } else {
          image(spriteCoveiroPaFenda, coveiroX - 59, coveiroY - 27);
        }

        if (stepCoveiroPaFenda == 1452) {
          if (sonsAtivos) {
            somCoveiroFenda.rewind();
            somCoveiroFenda.play();
          }
          abriuFenda = true;
          ataqueFendaAcontecendo = true;
        }

        if (stepCoveiroPaFenda == coveiroPaFenda.width) {
          novoAtaqueFenda = false;
          stepCoveiroPaFenda = 0;
        }
      }

      if (carregandoNovoAtaqueLapide && !novoAtaqueLapide && !coveiroTomouDanoAgua) {
        if (millis() > tempoSpriteCoveiroCarregandoLapide + 125) {
          spriteCoveiroCarregandoLapide = coveiroCarregandoLapide.get(stepCoveiroCarregandoLapide, 0, 190, 177);
          stepCoveiroCarregandoLapide = stepCoveiroCarregandoLapide % 3040 + 190;
          image(spriteCoveiroCarregandoLapide, coveiroX - 30, coveiroY);
          tempoSpriteCoveiroCarregandoLapide = millis();
        } else {
          image(spriteCoveiroCarregandoLapide, coveiroX - 30, coveiroY);
        }

        if (stepCoveiroCarregandoLapide == coveiroCarregandoLapide.width) {
          stepCoveiroCarregandoLapide = 0;
        }
      }

      if (novoAtaqueLapide && !coveiroTomouDanoAgua) {
        if (stepCoveiroLapide == 760) {
          if (sonsAtivos) {
            indexRandomSomCoveiroEsmaga = int(random(0, sonsCoveiroEsmaga.length));
            sonsCoveiroEsmaga[indexRandomSomCoveiroEsmaga].rewind();
            sonsCoveiroEsmaga[indexRandomSomCoveiroEsmaga].play();
          }
        }
        if (stepCoveiroLapide > 725) {
          coveiroSocoChao = true;
        }

        if (millis() > tempoSpriteCoveiroLapide + 125) {
          spriteCoveiroLapide = coveiroLapide.get(stepCoveiroLapide, 0, 190, 177);
          stepCoveiroLapide = stepCoveiroLapide % 1520 + 190;
          image(spriteCoveiroLapide, coveiroX - 30, coveiroY);
          tempoSpriteCoveiroLapide = millis();
        } else {
          image(spriteCoveiroLapide, coveiroX - 30, coveiroY);
        }

        if (stepCoveiroLapide == coveiroLapide.width) {
          novoAtaqueLapide = false;  
          gatilhoNovoAtaqueLapide = false;
          coveiroSocoChao = false;
          stepCoveiroLapide = 0;
        }
      }

      if (coveiroTomouDanoAgua) {
        image(coveiroLapideDano, coveiroX, coveiroY);

        if (millis() > tempoCoveiroTomouDanoAgua + 1000) {
          coveiroTomouDanoAgua = false;
        }
      }
    } else {
      if (coveiroMorrendo) {
        if (millis() > tempoSpriteCoveiroMorte + 105) {
          spriteCoveiroMorte = coveiroMorte.get(stepCoveiroMorte, 0, 180, 181);
          stepCoveiroMorte = stepCoveiroMorte % 1440 + 180;
          image(spriteCoveiroMorte, coveiroX, coveiroY);
          tempoSpriteCoveiroMorte = millis();
        } else {
          image(spriteCoveiroMorte, coveiroX, coveiroY);
        }

        if (stepCoveiroMorte == coveiroMorte.width) {
          stepCoveiroLapide = 0;
          coveiroMorrendo = false;
        }
      } else {
        spriteCoveiroMorte = coveiroMorte.get(1260, 0, 1440, 181);
        image(spriteCoveiroMorte, coveiroX, coveiroY);
      }
    }
  }

  void update() {
    if (!novoAtaqueFenda && !coveiroDelayTomouDanoAgua && !coveiroTomouDanoAgua && !coveiroMorreu) {
      if (!carregandoNovoAtaqueLapide && !novoAtaqueLapide) {
        if (millis() > tempoNovoDestino + 5000) {
          destinoCoveiroX = valoresCoveiroDestinoX[int(random(0, valoresCoveiroDestinoX.length))];
          destinoCoveiroY = valoresCoveiroDestinoY[int(random(0, valoresCoveiroDestinoY.length))];
          tempoNovoDestino = millis();
          gatilhoNovoAtaqueFenda = false;
          gatilhoNovoAtaqueFendaAtivo = false;
          gatilhoNovoAtaqueLapideAtivo = false;
          somCoveiroIdleTocando = false;
        }

        if (coveiroX == destinoCoveiroX && coveiroY == destinoCoveiroY) {
          andando = false;
        }

        if (coveiroX < destinoCoveiroX) {
          andando = true;
          coveiroX = coveiroX + 3;
        }
        if (coveiroX > destinoCoveiroX) {
          andando = true;
          coveiroX = coveiroX - 3;
        }

        if (coveiroY < destinoCoveiroY) {
          andando = true;
          coveiroY = coveiroY + 3;
        }
        if (coveiroY > destinoCoveiroY) {      
          andando = true;
          coveiroY = coveiroY - 3;
        }
      } else {
        if (carregandoNovoAtaqueLapide) {
          if (coveiroX < jLeiteX - 38) {
            coveiroX = coveiroX + 3;
          }
          if (coveiroX > jLeiteX - 38) {
            coveiroX = coveiroX - 3;
          }
          if (coveiroY < 184) {
            coveiroY = coveiroY + 3;
          }
        }
      }
    }
  }

  void ataquePa() {
    if (!novoAtaqueFenda && !carregandoNovoAtaqueLapide && !novoAtaqueLapide && !coveiroDelayTomouDanoAgua && !coveiroTomouDanoAgua && !coveiroMorreu) {
      if (dist(coveiroX, coveiroY, jLeiteX, jLeiteY) < 200 && !ataquePaLigado && millis() > tempoNovoAtaquePa + 1500) {
        tempoNovoAtaquePa = millis();
        tempoDanoPa = millis();
        ataquePa = true;
        ataquePaLigado = true;
        ataquePaAcontecendo = true;
      } else {
        ataquePaLigado = false;
      }
    }
  }

  void colisaoPa() {
    if (!novoAtaqueFenda && !carregandoNovoAtaqueLapide && !novoAtaqueLapide && !coveiroDelayTomouDanoAgua && !coveiroTomouDanoAgua && !coveiroMorreu) {
      if (ataquePaAcontecendo && dist(coveiroX, coveiroY, jLeiteX, jLeiteY) < 200) {
        if (millis() > tempoDanoPa + 775) {
          if (!jLeiteImune) {
            playerHitpointsCurrent = playerHitpointsCurrent - 5;
            jLeiteImune = true;
            tempoImune = millis();
          }
        }
      }
    }
  }

  void ataqueFenda() {
    if (!novoAtaqueFenda && !ataqueFendaAcontecendo && !novoAtaqueLapide && !coveiroDelayTomouDanoAgua && !coveiroTomouDanoAgua && !coveiroMorreu) {
      if (coveiroX == destinoCoveiroX && coveiroY == destinoCoveiroY) {
        if (!gatilhoNovoAtaqueFenda) {
          tempoNovoAtaqueFenda = millis();
          gatilhoNovoAtaqueFenda = true;
        }
        if (millis() > tempoNovoAtaqueFenda + 1500 && !gatilhoNovoAtaqueFendaAtivo) {
          novoAtaqueFenda = true;
          gatilhoNovoAtaqueFendaAtivo = true;
        }
      }
    }
  }

  void ataqueCarregandoLapide() {
    if (!novoAtaqueFenda && !coveiroTomouDanoAgua && !coveiroMorreu) {
      if (!gatilhoNovoAtaqueLapide) {
        tempoGatilhoCarregarNovoAtaqueLapide = millis();
        gatilhoNovoAtaqueLapide = true;
      }
      if (millis() > tempoGatilhoCarregarNovoAtaqueLapide + 32000 && !gatilhoNovoAtaqueLapideAtivo) {
        carregandoNovoAtaqueLapide = true;
        ataqueLapideAcontecendo = true;
        tempoGatilhoNovoAtaqueLapide = millis();
        gatilhoNovoAtaqueLapideAtivo = true;
      }
    }
  }

  void ataqueLapide() {
    if (millis() > tempoGatilhoNovoAtaqueLapide + 4000 && carregandoNovoAtaqueLapide) {
      carregandoNovoAtaqueLapide = false;
      novoAtaqueLapide = true;
      lapideAtaqueSumiu = false;
      ataquePaAcontecendo = false;
    }
  }

  void coveiroMorte() {
    if ((coveiroHitpointsCurrent <= 0 || coveiroBonesIndex == 0) && !coveiroMorreu) {
      coveiroMorreu = true;
      coveiroMorrendo = true;
      if (sonsAtivos) {
        somCoveiroMorreu.rewind();
        somCoveiroMorreu.play();
      }
      tempoBossMorreu = millis();
    }
  }
}

Coveiro coveiro;

void coveiro() {
  lapideAtaque();
  lapideCenario();
  vidaCoveiro();
  pocaCenario();
  esqueleto();
  fenda();
  coveiro.display();
  coveiro.update();
  coveiro.ataquePa();
  coveiro.colisaoPa();
  coveiro.ataqueFenda();
  coveiro.ataqueCarregandoLapide();
  coveiro.ataqueLapide();
  coveiro.coveiroMorte();
  aguaPocaCenario();
}

PImage fendaAbrindo;
PImage fendaAberta;
PImage fendaFechando;

public class Fenda {
  private PImage spriteFendaAbrindo;
  private PImage spriteFendaFechando;

  private int fendaX = coveiroX - 50;
  private int fendaY = coveiroY + 130;

  private int stepFendaAbrindo;
  private int tempoSpriteFendaAbrindo;

  private int stepFendaFechando;
  private int tempoSpriteFendaFechando;

  private int tempoFendaAberta = millis();

  private boolean fendaAbriu;
  private boolean fendaFechou;

  private boolean causouDanoJLeite;

  void display() {
    if (abriuFenda) {
      if (millis() > tempoSpriteFendaAbrindo + 85) {
        spriteFendaAbrindo = fendaAbrindo.get(stepFendaAbrindo, 0, 251, 612);
        stepFendaAbrindo = stepFendaAbrindo % 1715 + 251;
        image(spriteFendaAbrindo, fendaX, fendaY);
        tempoSpriteFendaAbrindo = millis();
      } else {
        image(spriteFendaAbrindo, fendaX, fendaY);
      }

      if (stepFendaAbrindo == fendaAbrindo.width) {
        abriuFenda = false;
        causouDanoJLeite = false;
        fendaAbriu = true;
        tempoFendaAberta = millis();
        stepFendaAbrindo = 0;
      } else {
        causouDanoJLeite = true;
      }
    }

    if (fendaAbriu) {
      if (millis() > tempoFendaAberta + 5000) {
        if (millis() > tempoSpriteFendaFechando + 250) {
          spriteFendaFechando = fendaFechando.get(stepFendaFechando, 0, 251, 612);
          stepFendaFechando = stepFendaFechando % 1715 + 251;
          image(spriteFendaFechando, fendaX, fendaY);
          tempoSpriteFendaFechando = millis();
        } else {
          image(spriteFendaFechando, fendaX, fendaY);
        }

        if (stepFendaFechando == fendaFechando.width) {
          fendaFechou = true;
          ataqueFendaAcontecendo = false;
          stepFendaFechando = 0;
        }
      } else {
        image(fendaAberta, fendaX, fendaY);
      }
    }
  }

  void colisao() {
    if (jLeiteX + 63 > fendaX + 40 && jLeiteX < fendaX + 220 && jLeiteY > fendaY - 50) {
      if (causouDanoJLeite && !jLeiteImune) {
        playerHitpointsCurrent = playerHitpointsCurrent - 4;
        jLeiteImune = true;
        tempoImune = millis();
      }
      jLeiteLentidao = true;
    } else {
      jLeiteLentidao = false;
    }
  }
}

ArrayList<Fenda> fendas;

void fenda() {
  if (fendas.size() == 0 && abriuFenda) {
    fendas.add(new Fenda());
  }

  for (int i = fendas.size() - 1; i >= 0; i = i - 1) {
    Fenda f = fendas.get(i);
    f.display();
    f.colisao();
    if (f.fendaFechou) {
      jLeiteLentidao = false;
      fendas.remove(f);
    }
  }
}

PImage[] imagensLapidesAtaque = new PImage [3];

int indexLapideAtaque;

boolean lapideAtaqueSumiu = true;

public class LapideAtaque {
  private PImage spriteLapideAtaque;

  private int lapideX = coveiroX;
  private int lapideY = jLeiteY;

  private int destinoX = coveiroX;
  private int destinoY = jLeiteY - 40;

  private int stepLapideAtaque;
  private int tempoSpriteLapideAtaque;

  private boolean lapideDeletar;

  void display() {
    if (millis() > tempoSpriteLapideAtaque + 125) { 
      spriteLapideAtaque = imagensLapidesAtaque[indexLapideAtaque].get(stepLapideAtaque, 0, 144, 188); 
      stepLapideAtaque = stepLapideAtaque % 5760 + 144;
      image(spriteLapideAtaque, lapideX, lapideY); 
      tempoSpriteLapideAtaque = millis();
    } else {
      image(spriteLapideAtaque, lapideX, lapideY);
    }

    if (stepLapideAtaque == imagensLapidesAtaque[0].width) {
      lapideDeletar = true;
      stepLapideAtaque = 0;
    }
  }

  void update() {
    destinoX = coveiroX;
    destinoY = jLeiteY - 40;

    lapideX = destinoX;
    lapideY = destinoY;
  }

  boolean acertouJLeite() {
    if (millis() > coveiro.tempoGatilhoNovoAtaqueLapide + 4375) {
      if (lapideX + 94 > jLeiteX && lapideX + 50 < jLeiteX + 63 && lapideY < jLeiteY + 126 && lapideY + 188 > jLeiteY) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}

ArrayList<LapideAtaque> lapidesAtaque;

void lapideAtaque() {
  if (ataqueLapideAcontecendo && lapidesAtaque.size() == 0) {
    indexLapideAtaque = int(random(0, 3));
    lapidesAtaque.add(new LapideAtaque());
  }

  for (int i = lapidesAtaque.size() - 1; i >= 0; i = i - 1) {
    LapideAtaque l = lapidesAtaque.get(i);
    l.display();
    l.update();
    if (l.lapideDeletar || coveiro.coveiroMorreu) {
      ataqueLapideAcontecendo = false;
      lapideAtaqueSumiu = true;
      lapidesAtaque.remove(l);
    }

    if (l.acertouJLeite() && !jLeiteImune) {
      playerHitpointsCurrent = playerHitpointsCurrent - 5;
      jLeiteImune = true;
      tempoImune = millis();
    }
  }
}

PImage[] imagensLapidesCenario = new PImage [3];

public class LapideCenario {
  private PImage spriteLapideCenario;

  private int lapideX;
  private int lapideY;

  private int stepLapideCenario;
  private int tempoSpriteLapideCenario;

  private int indexLapideCenario;

  private int tempoLapideAtiva = - 6000;

  private boolean lapideAcionada;

  public LapideCenario(int lapideX, int lapideY, int indexLapideCenario) {
    this.lapideX = lapideX;
    this.lapideY = lapideY;
    this.indexLapideCenario = indexLapideCenario;
  }

  void display() {
    if (millis() > tempoLapideAtiva + 2500) {
      if (millis() > tempoSpriteLapideCenario + 125) { 
        if (!lapideAcionada) {
          spriteLapideCenario = imagensLapidesCenario[indexLapideCenario].get(0, 0, 145, 183);
        } else {
          spriteLapideCenario = imagensLapidesCenario[indexLapideCenario].get(stepLapideCenario, 0, 145, 183);
          stepLapideCenario = stepLapideCenario % 725 + 145;
        }
        image(spriteLapideCenario, lapideX, lapideY); 
        tempoSpriteLapideCenario = millis();
      } else {
        image(spriteLapideCenario, lapideX, lapideY);
      }

      if (stepLapideCenario == imagensLapidesCenario[0].width) {
        tempoLapideAtiva = millis();
        lapideAcionada = false;
        stepLapideCenario = 0;
      }
    }
  }

  void acionarLapide() {
    if (indexLapideAtaque == indexLapideCenario && millis() > coveiro.tempoGatilhoNovoAtaqueLapide + 4000 && !lapideAtaqueSumiu) {
      lapideAcionada = true;
    }
  }
}

ArrayList<LapideCenario> lapidesCenario;

void lapideCenario() {
  if (lapidesCenario.size() == 0) {
    lapidesCenario.add(new LapideCenario(24, 8, 0));
    lapidesCenario.add(new LapideCenario(324, 8, 1));
    lapidesCenario.add(new LapideCenario(624, 8, 2));
  }

  for (int i = lapidesCenario.size() - 1; i >= 0; i = i - 1) {
    LapideCenario l = lapidesCenario.get(i);
    l.display();
    if (!coveiro.coveiroMorreu) {
      l.acionarLapide();
      if (l.lapideAcionada && millis() > l.tempoLapideAtiva + 2000 && lapideAtaqueSumiu) {
        l.lapideAcionada = false;
      }
    }
  }
}

PImage aguaPoca;

public class AguaPocaCenario {
  private PImage spriteAguaPoca;

  private float aguaPocaX;
  private float aguaPocaY = coveiroY;

  private int stepAguaPoca;
  private int tempoSpriteAguaPoca;

  private boolean aguaEvaporou;

  public AguaPocaCenario(float aguaPocaX) {
    this.aguaPocaX = aguaPocaX;
  }

  void display() {
    if (millis() > tempoSpriteAguaPoca + 75) { 
      spriteAguaPoca = aguaPoca.get(stepAguaPoca, 0, 168, 187); 
      stepAguaPoca = stepAguaPoca % 504 + 168;
      image(spriteAguaPoca, aguaPocaX, aguaPocaY); 
      tempoSpriteAguaPoca = millis();
    } else {
      image(spriteAguaPoca, aguaPocaX, aguaPocaY);
    }

    if (stepAguaPoca == aguaPoca.width) {
      aguaEvaporou = true;
      stepAguaPoca = 0;
    }
  }
}

ArrayList<AguaPocaCenario> aguasPocaCenario;

void aguaPocaCenario() {
  for (int i = aguasPocaCenario.size() - 1; i >= 0; i = i - 1) {
    AguaPocaCenario a = aguasPocaCenario.get(i);
    a.display();
    if (a.aguaEvaporou) {
      aguasPocaCenario.remove(a);
    }
  }
}

PImage[] imagensPocaCenarioCheia = new PImage [3];
PImage[] imagensPocaCenarioVazia = new PImage [3];

public class PocaCenario {
  private float pocaCenarioX;
  private float pocaCenarioY;

  private int indexImagem;

  private int ximira;

  private boolean pocaEsvaziou;

  public PocaCenario(float pocaCenarioX, float pocaCenarioY, int indexImagem) {
    this.pocaCenarioX = pocaCenarioX;
    this.pocaCenarioY = pocaCenarioY;
    this.indexImagem = indexImagem;
  }

  void display() {
    if (!pocaEsvaziou) {
      image(imagensPocaCenarioCheia[indexImagem], pocaCenarioX, pocaCenarioY);
      ximira = 1;
    } else {
      image(imagensPocaCenarioVazia[indexImagem], pocaCenarioX, pocaCenarioY);
      ximira = 2;
    }
  }

  boolean coveiroAcertou() {
    if (coveiro.coveiroSocoChao) {
      if (coveiroX > pocaCenarioX && coveiroX < pocaCenarioX + 160 && coveiroY + 200 > pocaCenarioY) {
        if (!pocaEsvaziou) {
          if (coveiroBonesIndex >= 1) {
            coveiroBonesIndex = coveiroBonesIndex - 1;
          }
        }
        coveiro.coveiroSocoChao = false;
        pocaEsvaziou = true;
        tempoCoveiroDelayTomouDanoAgua = millis();
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}

ArrayList<PocaCenario> pocasCenario;

void pocaCenario() {
  if (pocasCenario.size() == 0) {
    pocasCenario.add(new PocaCenario(124.5, 338, 0));
    pocasCenario.add(new PocaCenario(320.0, 338, 1));
    pocasCenario.add(new PocaCenario(515.5, 338, 2));
  }

  for (int i = pocasCenario.size() - 1; i >= 0; i = i - 1) {
    PocaCenario p = pocasCenario.get(i);
    p.display();
    if (p.coveiroAcertou() && p.ximira == 1) {
      aguasPocaCenario.add(new AguaPocaCenario(p.pocaCenarioX - 8));
      coveiroDelayTomouDanoAgua = true;
    }
  }

  if (coveiroDelayTomouDanoAgua && millis() > tempoCoveiroDelayTomouDanoAgua + 100) {
    coveiroTomouDanoAgua = true;
    tempoCoveiroTomouDanoAgua = millis();
    coveiroDelayTomouDanoAgua = false;
  }
}