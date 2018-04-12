PImage padreHPLayout;
PImage madPadreHPLayout;

PImage[] vidaPadreLayoutOsso = new PImage [5];

PImage madPadreHPBar;

int padreCurrentHP, madPadreCurrentHP;
int vidaPadreMin, vidaPadreRaivaMin;

int vidaPadreBarraX;
int vidaPadreRaivaBarraX;

int indexVidaPadreOsso;

void vidaPadre() {
  image(bossHPBackground, 0, 0);

  HitpointsLayout p;
  p = (padre.padreMudouForma) ? madPadreHP : padreHP;
  p.update();
  p.display();
  image(vidaPadreLayoutOsso[indexVidaPadreOsso], 84, 54);
}

AudioPlayer[] sonsPadreIdle = new AudioPlayer [2];
AudioPlayer[] sonsPadreRaivaIdle = new AudioPlayer [4];
AudioPlayer[] sonsPadreCaveira = new AudioPlayer [2];
AudioPlayer[] sonsPadreTomandoDano = new AudioPlayer [3];
AudioPlayer[] sonsPadreRaivaTomandoDano = new AudioPlayer [3];
AudioPlayer[] sonsPadreLevantem = new AudioPlayer [2];
AudioPlayer[] sonsPadreImpossivel = new AudioPlayer [2];
AudioPlayer somPadreRaio;
AudioPlayer somPadreMorreu;

PImage padreMovimentoIdle;
PImage padreCruz;
PImage padreLevantem;
PImage padreCaveiraAparecendo;
PImage padreCaveira;
PImage[] padreCaveiraDano = new PImage [2];
PImage padreRaivaMovimentoIdle;
PImage padreRaivaCruz;
PImage padreRaivaLevantem;
PImage padreRaivaCaveiraAparecendo;
PImage padreRaivaCaveira;
PImage[] padreRaivaCaveiraDano = new PImage [2];
PImage padreRaivaRaio;
PImage padreMorte;

PImage sombraPadre;

int[] valoresPadreDestinoX = {27, 30, 33, 36, 39, 42, 45, 48, 51, 54, 57, 60, 63, 66, 69, 72, 75, 78, 81, 84, 87, 90, 93, 96, 99, 102, 105, 108, 111, 114, 117, 120, 123, 126, 129, 132, 135, 138, 141, 144, 147, 150, 153, 156, 159, 162, 165, 168, 171, 174, 177, 180, 183, 186, 189, 192, 207, 222, 237, 252, 267, 282, 297, 312, 327, 342, 357, 372, 387, 402, 417, 432, 447, 462, 477, 492, 507, 522, 537, 552, 567, 582, 597, 612};
int[] valoresPadreDestinoY = {75, 78, 81, 84, 87, 90, 93, 96, 99, 102, 105, 108, 111, 114, 117, 120, 123, 126, 129, 132, 135, 138, 141};

int padreX = valoresPadreDestinoX[int(random(0, valoresPadreDestinoX.length))];
int padreY = valoresPadreDestinoY[int(random(0, valoresPadreDestinoY.length))];

int indexRandomSomPadreTomandoDano;

boolean ataqueLevantemAcontecendo;
boolean ataqueCaveiraAcontecendo, padreCaveiraCaiuCabeca, umOsso = true;

public class Padre {
  private PImage spritePadreMovimentoIdle;
  private PImage spritePadreCruz;
  private PImage spritePadreLevantem;
  private PImage spritePadreCaveiraAparecendo;
  private PImage spritePadreCaveira;
  private PImage spritePadreCaveiraDano;
  private PImage spritePadreRaivaMovimentoIdle;
  private PImage spritePadreRaivaCruz;
  private PImage spritePadreRaivaLevantem;
  private PImage spritePadreRaivaCaveiraAparecendo;
  private PImage spritePadreRaivaCaveira;
  private PImage spritePadreRaivaCaveiraDano;
  private PImage spritePadreRaivaCaveiraDano2; 
  private PImage spritePadreRaivaRaio;
  private PImage spritePadreMorte;

  private int destinoPadreX = valoresPadreDestinoX[int(random(0, valoresPadreDestinoX.length))];
  private int destinoPadreY = valoresPadreDestinoY[int(random(0, valoresPadreDestinoY.length))];

  private int stepPadreMovimentoIdle;
  private int tempoSpritePadreMovimentoIdle;

  private int stepPadreCruz;
  private int tempoSpritePadreCruz;

  private int stepPadreLevantem;
  private int tempoSpritePadreLevantem;

  private int stepPadreCaveiraAparecendo;
  private int tempoSpritePadreCaveiraAparecendo;

  private int stepPadreCaveira;
  private int tempoSpritePadreCaveira;

  private int stepPadreCaveiraDano;
  private int tempoSpritePadreCaveiraDano;

  private int stepPadreRaivaMovimentoIdle;
  private int tempoSpritePadreRaivaMovimentoIdle;

  private int stepPadreRaivaCruz;
  private int tempoSpritePadreRaivaCruz;

  private int stepPadreRaivaLevantem;
  private int tempoSpritePadreRaivaLevantem;

  private int stepPadreRaivaCaveiraAparecendo;
  private int tempoSpritePadreRaivaCaveiraAparecendo;

  private int stepPadreRaivaCaveira;
  private int tempoSpritePadreRaivaCaveira;

  private int stepPadreRaivaCaveiraDano;
  private int tempoSpritePadreRaivaCaveiraDano;

  private int stepPadreRaivaCaveiraDano2;
  private int tempoSpritePadreRaivaCaveiraDano2;

  private int stepPadreRaivaRaio;
  private int tempoSpritePadreRaivaRaio;

  private int stepPadreMorte;
  private int tempoSpritePadreMorte;

  private int indexRandomSomPadreIdle;

  private int tempoNovoDestino = millis();

  private int tempoNovoAtaqueCruz, tempoDanoCruz;

  private int tempoNovoAtaqueLevantem = millis(), tempoDuracaoAtaqueLevantem, amountRecoveredLevantem;

  private int tempoNovoAtaqueCaveira = millis();

  private int tempoSpritePadreTomouDanoCaveira;

  private int tempoSpritePadreCarregandoAtaqueRaio, tempoGatilhoCarregarNovoAtaqueRaio = millis();

  private boolean somPadreIdleTocando;

  private boolean ataqueCruz, ataqueCruzLigado, ataqueCruzAcontecendo;
  private boolean novoAtaqueLevantem, gatilhoNovoAtaqueLevantemAtivo, gatilhoNovoAtaqueLevantem, padreRaivaCurou;  
  private boolean novoAtaqueCaveira, caveiraApareceu, gatilhoNovoAtaqueCaveiraAtivo, gatilhoNovoAtaqueCaveira, padreTomouDanoCaveira;
  private boolean padreMudouForma, padreFormaMudada;
  private boolean padreCarregandoNovoAtaqueRaio, gatilhoNovoAtaqueRaioAtivo, gatilhoNovoAtaqueRaio, padreParouCarregarRaio;  
  private boolean padreMorreu, padreMorrendo;

  void display() {
    if (!padreMudouForma && !novoAtaqueLevantem) {
      image(sombraPadre, padreX + 30, padreY + 145);
    }

    if (!padreMudouForma) {
      if (!ataqueCruz && !novoAtaqueLevantem && !novoAtaqueCaveira && !caveiraApareceu && !padreCaveiraCaiuCabeca && !padreTomouDanoCaveira) {
        if (!somPadreIdleTocando) {
          if (isSoundActive) {
            indexRandomSomPadreIdle = int(random(0, sonsPadreIdle.length));
            sonsPadreIdle[indexRandomSomPadreIdle].rewind();
            sonsPadreIdle[indexRandomSomPadreIdle].play();
            somPadreIdleTocando = true;
          }
        }

        if (millis() > tempoSpritePadreMovimentoIdle + 150) { 
          spritePadreMovimentoIdle = padreMovimentoIdle.get(stepPadreMovimentoIdle, 0, 110, 152); 
          stepPadreMovimentoIdle = stepPadreMovimentoIdle % 220 + 110;
          image(spritePadreMovimentoIdle, padreX, padreY); 
          tempoSpritePadreMovimentoIdle = millis();
        } else {
          image(spritePadreMovimentoIdle, padreX, padreY);
        }

        if (stepPadreMovimentoIdle == padreMovimentoIdle.width) {
          stepPadreMovimentoIdle = 0;
        }
      }

      if (ataqueCruz && !novoAtaqueLevantem && !novoAtaqueCaveira && !caveiraApareceu && !padreCaveiraCaiuCabeca && !padreTomouDanoCaveira) {
        if (millis() > tempoSpritePadreCruz + 150) { 
          spritePadreCruz = padreCruz.get(stepPadreCruz, 0, 113, 201); 
          stepPadreCruz = stepPadreCruz % 678 + 113;
          image(spritePadreCruz, padreX + 3, padreY - 47); 
          tempoSpritePadreCruz = millis();
        } else {
          image(spritePadreCruz, padreX + 3, padreY - 47);
        }

        if (stepPadreCruz == padreCruz.width) {
          ataqueCruz = false;
          ataqueCruzAcontecendo = false;
          ataqueCruzLigado = false;
          stepPadreCruz = 0;
        }
      }

      if (novoAtaqueLevantem && !novoAtaqueCaveira && !caveiraApareceu && !padreCaveiraCaiuCabeca && !padreTomouDanoCaveira) {
        if (stepPadreLevantem == 0) {
          if (isSoundActive) {
            sonsPadreLevantem[0].rewind();
            sonsPadreLevantem[0].play();
          }
        }

        if (millis() > tempoSpritePadreLevantem + 150) { 
          spritePadreLevantem = padreLevantem.get(stepPadreLevantem, 0, 110, 153); 
          stepPadreLevantem = stepPadreLevantem % 220 + 110;
          image(spritePadreLevantem, padreX, padreY); 
          tempoSpritePadreLevantem = millis();
        } else {
          image(spritePadreLevantem, padreX, padreY);
        }

        if (stepPadreLevantem == padreLevantem.width) {
          stepPadreLevantem = 0;
        }

        if (millis() > tempoDuracaoAtaqueLevantem + 5000) {
          novoAtaqueLevantem = false;
          ataqueLevantemAcontecendo = false;
        }
      }

      if (novoAtaqueCaveira && !caveiraApareceu && !padreCaveiraCaiuCabeca && !padreTomouDanoCaveira) {
        if (millis() > tempoSpritePadreCaveiraAparecendo + 150) { 
          spritePadreCaveiraAparecendo = padreCaveiraAparecendo.get(stepPadreCaveiraAparecendo, 0, 113, 199); 
          stepPadreCaveiraAparecendo = stepPadreCaveiraAparecendo % 678 + 113;
          image(spritePadreCaveiraAparecendo, padreX + 3, padreY - 47); 
          tempoSpritePadreCaveiraAparecendo = millis();
        } else {
          image(spritePadreCaveiraAparecendo, padreX + 3, padreY - 47);
        }

        if (stepPadreCaveiraAparecendo == padreCaveiraAparecendo.width) {
          stepPadreCaveiraAparecendo = 0;
          caveiraApareceu = true;
          novoAtaqueCaveira = false;
          gatilhoNovoAtaqueCaveira = false;
        }
      }

      if (caveiraApareceu && !padreCaveiraCaiuCabeca && !padreTomouDanoCaveira) {
        if (stepPadreCaveira == 0) {
          if (isSoundActive) {
            sonsPadreCaveira[0].rewind();
            sonsPadreCaveira[0].play();
          }
        }

        if (millis() > tempoSpritePadreCaveira + 150) { 
          spritePadreCaveira = padreCaveira.get(stepPadreCaveira, 0, 113, 199); 
          stepPadreCaveira = stepPadreCaveira % 678 + 113;
          image(spritePadreCaveira, padreX + 3, padreY - 47); 
          tempoSpritePadreCaveira = millis();
        } else {
          image(spritePadreCaveira, padreX + 3, padreY - 47);
        }

        if (stepPadreCaveira == padreCaveira.width) {
          stepPadreCaveira = 0;
        }
      }

      if (padreCaveiraCaiuCabeca && !padreTomouDanoCaveira) {
        if (millis() > tempoSpritePadreCaveiraDano + 150) { 
          spritePadreCaveiraDano = padreCaveiraDano[0].get(stepPadreCaveiraDano, 0, 113, 199); 
          stepPadreCaveiraDano = stepPadreCaveiraDano % 678 + 113;
          image(spritePadreCaveiraDano, padreX + 3, padreY - 47); 
          tempoSpritePadreCaveiraDano = millis();
        } else {
          image(spritePadreCaveiraDano, padreX + 3, padreY - 47);
        }

        if (stepPadreCaveiraDano == padreCaveiraDano[0].width) {
          stepPadreCaveiraDano = 0;
          padreCaveiraCaiuCabeca = false;
          tempoSpritePadreTomouDanoCaveira = millis();
          padreTomouDanoCaveira = true;
        }
      }

      if (padreTomouDanoCaveira) {
        image(padreCaveiraDano[1], padreX + 3, padreY - 47);

        if (millis() > tempoSpritePadreTomouDanoCaveira + 2000) {
          padreTomouDanoCaveira = false;
        }
      }
    } else {
      if (!padreMorreu) {
        if (!ataqueCruz && !novoAtaqueLevantem && !novoAtaqueCaveira && !caveiraApareceu && !padreCaveiraCaiuCabeca && !padreTomouDanoCaveira && !padreCarregandoNovoAtaqueRaio) {
          if (!somPadreIdleTocando) {
            if (isSoundActive) {
              indexRandomSomPadreIdle = int(random(0, sonsPadreRaivaIdle.length));
              sonsPadreRaivaIdle[indexRandomSomPadreIdle].rewind();
              sonsPadreRaivaIdle[indexRandomSomPadreIdle].play();
              somPadreIdleTocando = true;
            }
          }

          if (millis() > tempoSpritePadreRaivaMovimentoIdle + 150) { 
            spritePadreRaivaMovimentoIdle = padreRaivaMovimentoIdle.get(stepPadreRaivaMovimentoIdle, 0, 126, 156); 
            stepPadreRaivaMovimentoIdle = stepPadreRaivaMovimentoIdle % 378 + 126;
            image(spritePadreRaivaMovimentoIdle, padreX, padreY); 
            tempoSpritePadreRaivaMovimentoIdle = millis();
          } else {
            image(spritePadreRaivaMovimentoIdle, padreX, padreY);
          }

          if (stepPadreRaivaMovimentoIdle == padreRaivaMovimentoIdle.width) {
            stepPadreRaivaMovimentoIdle = 0;
          }
        }

        if (ataqueCruz && !novoAtaqueLevantem && !novoAtaqueCaveira && !caveiraApareceu && !padreCaveiraCaiuCabeca && !padreTomouDanoCaveira && !padreCarregandoNovoAtaqueRaio) {
          if (millis() > tempoSpritePadreRaivaCruz + 150) { 
            spritePadreRaivaCruz = padreRaivaCruz.get(stepPadreCruz, 0, 126, 156); 
            stepPadreRaivaCruz = stepPadreRaivaCruz % 378 + 126;
            image(spritePadreRaivaCruz, padreX, padreY); 
            tempoSpritePadreRaivaCruz = millis();
          } else {
            image(spritePadreRaivaCruz, padreX, padreY);
          }

          if (stepPadreRaivaCruz == padreRaivaCruz.width) {
            ataqueCruz = false;
            ataqueCruzAcontecendo = false;
            ataqueCruzLigado = false;
            stepPadreRaivaCruz = 0;
          }
        }

        if (novoAtaqueLevantem && !novoAtaqueCaveira && !caveiraApareceu && !padreCaveiraCaiuCabeca && !padreTomouDanoCaveira && !padreCarregandoNovoAtaqueRaio) {
          if (stepPadreRaivaLevantem == 0) {
            if (isSoundActive) {
              sonsPadreLevantem[0].rewind();
              sonsPadreLevantem[0].play();
            }
          }

          if (!padreRaivaCurou) {
            while (madPadreCurrentHP < 40 && amountRecoveredLevantem < 3) {
              amountRecoveredLevantem = amountRecoveredLevantem + 1;
              madPadreCurrentHP = madPadreCurrentHP + 1;
            }
            padreRaivaCurou = true;
          }
          if (millis() > tempoSpritePadreRaivaLevantem + 150) { 
            spritePadreRaivaLevantem = padreRaivaLevantem.get(stepPadreRaivaLevantem, 0, 126, 163); 
            stepPadreRaivaLevantem = stepPadreRaivaLevantem % 378 + 126;
            image(spritePadreRaivaLevantem, padreX, padreY); 
            tempoSpritePadreRaivaLevantem = millis();
          } else {
            image(spritePadreRaivaLevantem, padreX, padreY);
          }

          if (stepPadreRaivaLevantem == padreRaivaLevantem.width) {
            stepPadreRaivaLevantem = 0;
          }

          if (millis() > tempoDuracaoAtaqueLevantem + 5000) {
            novoAtaqueLevantem = false;
            ataqueLevantemAcontecendo = false;
          }
        }

        if (novoAtaqueCaveira && !caveiraApareceu && !padreCaveiraCaiuCabeca && !padreTomouDanoCaveira && !padreCarregandoNovoAtaqueRaio) {
          if (millis() > tempoSpritePadreRaivaCaveiraAparecendo + 150) { 
            spritePadreRaivaCaveiraAparecendo = padreRaivaCaveiraAparecendo.get(stepPadreRaivaCaveiraAparecendo, 0, 129, 203); 
            stepPadreRaivaCaveiraAparecendo = stepPadreRaivaCaveiraAparecendo % 774 + 129;
            image(spritePadreRaivaCaveiraAparecendo, padreX + 3, padreY - 47); 
            tempoSpritePadreRaivaCaveiraAparecendo = millis();
          } else {
            image(spritePadreRaivaCaveiraAparecendo, padreX + 3, padreY - 47);
          }

          if (stepPadreRaivaCaveiraAparecendo == padreRaivaCaveiraAparecendo.width) {
            stepPadreRaivaCaveiraAparecendo = 0;
            caveiraApareceu = true;
            novoAtaqueCaveira = false;
          }
        }

        if (caveiraApareceu && !padreCaveiraCaiuCabeca && !padreTomouDanoCaveira && !padreCarregandoNovoAtaqueRaio) {
          if (stepPadreRaivaCaveira == 0) {
            if (isSoundActive) {
              sonsPadreCaveira[1].rewind();
              sonsPadreCaveira[1].play();
            }
          }

          if (millis() > tempoSpritePadreRaivaCaveira + 150) { 
            spritePadreRaivaCaveira = padreRaivaCaveira.get(stepPadreRaivaCaveira, 0, 129, 203); 
            stepPadreRaivaCaveira = stepPadreRaivaCaveira % 774 + 129;
            image(spritePadreRaivaCaveira, padreX + 3, padreY - 47); 
            tempoSpritePadreRaivaCaveira = millis();
          } else {
            image(spritePadreRaivaCaveira, padreX + 3, padreY - 47);
          }

          if (stepPadreRaivaCaveira == padreRaivaCaveira.width) {
            stepPadreRaivaCaveira = 0;
          }
        }

        if (padreCaveiraCaiuCabeca && !padreTomouDanoCaveira && !padreCarregandoNovoAtaqueRaio) {
          if (millis() > tempoSpritePadreRaivaCaveiraDano + 150) { 
            spritePadreRaivaCaveiraDano = padreRaivaCaveiraDano[0].get(stepPadreRaivaCaveiraDano, 0, 129, 203); 
            stepPadreRaivaCaveiraDano = stepPadreRaivaCaveiraDano % 774 + 129;
            image(spritePadreRaivaCaveiraDano, padreX + 3, padreY - 47); 
            tempoSpritePadreRaivaCaveiraDano = millis();
          } else {
            image(spritePadreRaivaCaveiraDano, padreX + 3, padreY - 47);
          }

          if (stepPadreRaivaCaveiraDano == padreRaivaCaveiraDano[0].width) {
            stepPadreRaivaCaveiraDano = 0;
            padreCaveiraCaiuCabeca = false;
            padreTomouDanoCaveira = true;
            tempoSpritePadreTomouDanoCaveira = millis();
          }
        }

        if (padreTomouDanoCaveira && !padreCarregandoNovoAtaqueRaio) {
          if (millis() > tempoSpritePadreRaivaCaveiraDano2 + 150) { 
            spritePadreRaivaCaveiraDano2 = padreRaivaCaveiraDano[1].get(stepPadreRaivaCaveiraDano2, 0, 126, 156); 
            stepPadreRaivaCaveiraDano2 = stepPadreRaivaCaveiraDano2 % 378 + 126;
            image(spritePadreRaivaCaveiraDano2, padreX, padreY); 
            tempoSpritePadreRaivaCaveiraDano2 = millis();
          } else {
            image(spritePadreRaivaCaveiraDano2, padreX, padreY);
          }

          if (stepPadreRaivaCaveiraDano2 == padreRaivaCaveiraDano[1].width) {
            stepPadreRaivaCaveiraDano2 = 0;
          }

          if (millis() > tempoSpritePadreTomouDanoCaveira + 2000) {
            padreTomouDanoCaveira = false;
          }
        }

        if (padreCarregandoNovoAtaqueRaio) {
          if (millis() > tempoSpritePadreRaivaRaio + 150) { 
            spritePadreRaivaRaio = padreRaivaRaio.get(stepPadreRaivaRaio, 0, 126, 156); 
            stepPadreRaivaRaio = stepPadreRaivaRaio % 378 + 126;
            image(spritePadreRaivaRaio, padreX, padreY); 
            tempoSpritePadreRaivaRaio = millis();
          } else {
            image(spritePadreRaivaRaio, padreX, padreY);
          }

          if (stepPadreRaivaRaio == padreRaivaRaio.width) {
            stepPadreRaivaRaio = 0;
          }

          if (millis() > tempoSpritePadreCarregandoAtaqueRaio + 3000) {
            padreCarregandoNovoAtaqueRaio = false;
            padreParouCarregarRaio = true;
            gatilhoNovoAtaqueRaio = false;
            if (isSoundActive) {
              somPadreRaio.rewind();
              somPadreRaio.play();
            }
          }
        }
      } else {
        if (padreMorrendo) {
          if (millis() > tempoSpritePadreMorte + 100) {
            spritePadreMorte = padreMorte.get(stepPadreMorte, 0, 492, 531);
            stepPadreMorte = stepPadreMorte % 8364 + 492;
            image(spritePadreMorte, padreX, padreY);
            tempoSpritePadreMorte = millis();
          } else {
            image(spritePadreMorte, padreX - 168, padreY - 181);
          }

          if (stepPadreMorte == padreMorte.width) {
            stepPadreMorte = 0;
            padreMorrendo = false;
          }
        } else {
          spritePadreMorte = padreMorte.get(7872, 0, 8364, 531);
          image(spritePadreMorte, padreX - 168, padreY - 181);
        }
      }
    }
  }

  void update() {
    if (!padreMudouForma || padreMudouForma) {
      if (!novoAtaqueLevantem && !ataqueLevantemAcontecendo && !ataqueCaveiraAcontecendo && !padreCaveiraCaiuCabeca && !padreTomouDanoCaveira && !padreCarregandoNovoAtaqueRaio && !padreMorreu) {
        if (millis() > tempoNovoDestino + 8000) {
          destinoPadreX = valoresPadreDestinoX[int(random(0, valoresPadreDestinoX.length))];
          destinoPadreY = valoresPadreDestinoY[int(random(0, valoresPadreDestinoY.length))];
          tempoNovoDestino = millis();  
          gatilhoNovoAtaqueRaioAtivo = false;
          gatilhoNovoAtaqueCaveiraAtivo = false;
          gatilhoNovoAtaqueLevantem = false;
          gatilhoNovoAtaqueLevantemAtivo = false;
          somPadreIdleTocando = false;
        }

        if (padreX < destinoPadreX) {
          padreX = padreX + 3;
        }
        if (padreX > destinoPadreX) {
          padreX = padreX - 3;
        }

        if (padreY < destinoPadreY) {
          padreY = padreY + 3;
        }
        if (padreY > destinoPadreY) {      
          padreY = padreY - 3;
        }
      }
    }
  }

  void ataqueCruz() {
    if (!novoAtaqueLevantem && !ataqueLevantemAcontecendo && !ataqueCaveiraAcontecendo && !padreCaveiraCaiuCabeca && !padreTomouDanoCaveira && !padreCarregandoNovoAtaqueRaio && !padreMorreu) {
      if (dist(padreX, padreY, playerX, playerY) < 100 && !ataqueCruzLigado && millis() > tempoNovoAtaqueCruz + 1500) {
        tempoNovoAtaqueCruz = millis();
        tempoDanoCruz = millis();
        ataqueCruz = true;
        ataqueCruzLigado = true;
        ataqueCruzAcontecendo = true;
      }
    }
  }

  void colisaoCruz() {
    if (!novoAtaqueLevantem && !ataqueLevantemAcontecendo && !ataqueCaveiraAcontecendo && !padreCaveiraCaiuCabeca && !padreTomouDanoCaveira && !padreCarregandoNovoAtaqueRaio && !padreMorreu) {
      if (ataqueCruzAcontecendo) {
        if (!padreMudouForma) {
          if (millis() > tempoDanoCruz + 750) {
            if (!isPlayerImmune) {
              hitHitCruzMostrando = true;
              hitCruz(playerX - 30, playerY);
              playerCurrentHP -= 2;
              isPlayerImmune = true;
              timeImmune = millis();
            }
          }
        } else {
          if (millis() > tempoDanoCruz + 300) {
            if (!isPlayerImmune) {
              hitHitCruzMostrando = true;
              hitCruz(playerX - 30, playerY);
              playerCurrentHP -= 3;
              isPlayerImmune = true;
              timeImmune = millis();
            }
          }
        }
      }
    }
  }

  void ataqueLevantem() {
    if (!novoAtaqueLevantem && !ataqueLevantemAcontecendo && !ataqueCaveiraAcontecendo && !padreCaveiraCaiuCabeca && !padreTomouDanoCaveira && !padreCarregandoNovoAtaqueRaio && !padreMorreu) {
      if (padreX == destinoPadreX && padreY == destinoPadreY) {
        if (!gatilhoNovoAtaqueLevantem) {
          tempoNovoAtaqueLevantem = millis();
          gatilhoNovoAtaqueLevantem = true;
          amountRecoveredLevantem = 0;
          padreRaivaCurou = false;
        }
        if (millis() > tempoNovoAtaqueLevantem + 5000 && !gatilhoNovoAtaqueLevantemAtivo) {
          novoAtaqueLevantem = true;
          gatilhoNovoAtaqueLevantemAtivo = true;
          ataqueLevantemAcontecendo = true;
          tempoDuracaoAtaqueLevantem = millis();
        }
      }
    }
  }

  void ataqueCaveira() {
    if (!novoAtaqueLevantem && !ataqueLevantemAcontecendo && !ataqueCaveiraAcontecendo && !padreCaveiraCaiuCabeca && !padreTomouDanoCaveira && !padreCarregandoNovoAtaqueRaio && !padreMorreu) {
      if (!gatilhoNovoAtaqueCaveira) {
        tempoNovoAtaqueCaveira = millis();
        gatilhoNovoAtaqueCaveira = true;
      }
      if (millis() > tempoNovoAtaqueCaveira + 40000 && !gatilhoNovoAtaqueCaveiraAtivo) {
        ataqueCaveiraAcontecendo = true;
        novoAtaqueCaveira = true;
        tempoPrimeiraCaveiraAtaque = millis();
        gatilhoNovoAtaqueCaveiraAtivo = true;
        umOsso = true;
      }
    }
  }

  void padreMudarForma() {
    if ((padreCurrentHP <= 0 || indexVidaPadreOsso == 2) && !padreFormaMudada) {
      padreMudouForma = true;
      padreFormaMudada = true;
    }
  }

  void ataqueCarregandoRaio() {
    if (padreMudouForma) {
      if (!novoAtaqueLevantem && !ataqueLevantemAcontecendo && !ataqueCaveiraAcontecendo && !padreCaveiraCaiuCabeca && !padreTomouDanoCaveira && !padreCarregandoNovoAtaqueRaio && !padreMorreu) {
        if (!gatilhoNovoAtaqueRaio) {
          tempoGatilhoCarregarNovoAtaqueRaio = millis();
          gatilhoNovoAtaqueRaio = true;
        }
        if (millis() > tempoGatilhoCarregarNovoAtaqueRaio + 15000 && !gatilhoNovoAtaqueRaioAtivo) {
          tempoSpritePadreCarregandoAtaqueRaio = millis();
          padreCarregandoNovoAtaqueRaio = true;
          gatilhoNovoAtaqueRaioAtivo = true;
        }
      }
    }
  }

  void padreMorte() {
    if ((madPadreCurrentHP <= 0 || indexVidaPadreOsso == 0) && !padreMorreu) {
      padreMorreu = true;
      padreMorrendo = true;
      if (isSoundActive) {
        somPadreMorreu.rewind();
        somPadreMorreu.play();
      }
      tempoBossMorreu = millis();
    }
  }
}

Padre padre;

void padre() {
  inimigosTodos();
  vidaPadre();
  padre.display();
  padre.update();
  padre.ataqueCruz();
  padre.colisaoCruz();
  padre.ataqueLevantem();
  padre.ataqueCaveira();
  caveiraPadre();
  padre.padreMudarForma();
  padre.ataqueCarregandoRaio();
  padre.padreMorte();
  raio();
}

PImage caveiraPadreAparecendo;
PImage caveiraPadreFlutuando;
PImage caveiraPadreAtaque;
PImage caveiraPadreRaivaAparecendo;
PImage caveiraPadreRaivaFlutuando;
PImage caveiraPadreRaivaAtaque;

public class CaveiraPadre {
  private PImage spriteCaveiraPadreAparecendo;
  private PImage spriteCaveiraPadreFlutuando;
  private PImage spriteCaveiraPadreRaivaAparecendo;
  private PImage spriteCaveiraPadreRaivaFlutuando;

  private float caveiraPadreX;
  private float caveiraPadreY;

  private float destinoCaveiraPadreX;

  private int movimentoCaveiraPadreX;
  private int movimentoCaveiraPadreY;

  private int indexCaveiraPadre;

  private int stepCaveiraPadreAparecendo;
  private int tempoSpriteCaveiraPadreAparecendo;

  private int stepCaveiraPadreFlutuando;
  private int tempoSpriteCaveiraPadreFlutuando;

  private int stepCaveiraPadreRaivaAparecendo;
  private int tempoSpriteCaveiraPadreRaivaAparecendo;

  private int stepCaveiraPadreRaivaFlutuando;
  private int tempoSpriteCaveiraPadreRaivaFlutuando;

  private boolean caveiraAtaqueAtivo;
  private boolean novoDestinoCaveiraPadreX;

  private boolean caveiraPadreReta;

  public CaveiraPadre(float caveiraPadreX, float caveiraPadreY, int indexCaveiraPadre, int movimentoCaveiraPadreY) {
    this.caveiraPadreX = caveiraPadreX;
    this.caveiraPadreY = caveiraPadreY;
    this.indexCaveiraPadre = indexCaveiraPadre;
    this.movimentoCaveiraPadreY = movimentoCaveiraPadreY;
  }

  void display() {
    if (!padre.padreMudouForma) {
      if (!caveiraAtaqueAtivo) {
        if (padre.novoAtaqueCaveira && !padre.caveiraApareceu) {
          if (millis() > tempoSpriteCaveiraPadreAparecendo + 150) {
            spriteCaveiraPadreAparecendo = caveiraPadreAparecendo.get(stepCaveiraPadreAparecendo, 0, 52, 76);
            stepCaveiraPadreAparecendo = stepCaveiraPadreAparecendo % 312 + 52;
            image(spriteCaveiraPadreAparecendo, caveiraPadreX, caveiraPadreY);
            tempoSpriteCaveiraPadreAparecendo = millis();
          } else {
            image(spriteCaveiraPadreAparecendo, caveiraPadreX, caveiraPadreY);
          }

          if (stepCaveiraPadreAparecendo == caveiraPadreAparecendo.width) {
            stepCaveiraPadreAparecendo = 0;
          }
        }

        if (padre.caveiraApareceu) {
          if (millis() > tempoSpriteCaveiraPadreFlutuando + 150) {
            spriteCaveiraPadreFlutuando = caveiraPadreFlutuando.get(stepCaveiraPadreFlutuando, 0, 52, 76);
            stepCaveiraPadreFlutuando = stepCaveiraPadreFlutuando % 312 + 52;
            image(spriteCaveiraPadreFlutuando, caveiraPadreX, caveiraPadreY);
            tempoSpriteCaveiraPadreFlutuando = millis();
          } else {
            image(spriteCaveiraPadreFlutuando, caveiraPadreX, caveiraPadreY);
          }

          if (stepCaveiraPadreFlutuando == caveiraPadreFlutuando.width) {
            stepCaveiraPadreFlutuando = 0;
          }
        }
      } else {
        image(caveiraPadreAtaque, caveiraPadreX, caveiraPadreY);
      }
    } else {
      if (!caveiraAtaqueAtivo) {
        if (padre.novoAtaqueCaveira && !padre.caveiraApareceu) {
          if (millis() > tempoSpriteCaveiraPadreRaivaAparecendo + 150) {
            spriteCaveiraPadreRaivaAparecendo = caveiraPadreRaivaAparecendo.get(stepCaveiraPadreRaivaAparecendo, 0, 52, 76);
            stepCaveiraPadreRaivaAparecendo = stepCaveiraPadreRaivaAparecendo % 312 + 52;
            image(spriteCaveiraPadreRaivaAparecendo, caveiraPadreX, caveiraPadreY);
            tempoSpriteCaveiraPadreRaivaAparecendo = millis();
          } else {
            image(spriteCaveiraPadreRaivaAparecendo, caveiraPadreX, caveiraPadreY);
          }

          if (stepCaveiraPadreRaivaAparecendo == caveiraPadreRaivaAparecendo.width) {
            stepCaveiraPadreRaivaAparecendo = 0;
          }
        }

        if (padre.caveiraApareceu) {
          if (millis() > tempoSpriteCaveiraPadreRaivaFlutuando + 150) {
            spriteCaveiraPadreRaivaFlutuando = caveiraPadreRaivaFlutuando.get(stepCaveiraPadreRaivaFlutuando, 0, 52, 76);
            stepCaveiraPadreRaivaFlutuando = stepCaveiraPadreRaivaFlutuando % 312 + 52;
            image(spriteCaveiraPadreRaivaFlutuando, caveiraPadreX, caveiraPadreY);
            tempoSpriteCaveiraPadreRaivaFlutuando = millis();
          } else {
            image(spriteCaveiraPadreRaivaFlutuando, caveiraPadreX, caveiraPadreY);
          }

          if (stepCaveiraPadreRaivaFlutuando == caveiraPadreRaivaFlutuando.width) {
            stepCaveiraPadreRaivaFlutuando = 0;
          }
        }
      } else {
        image(caveiraPadreRaivaAtaque, caveiraPadreX, caveiraPadreY);
      }
    }
  }

  void update() {
    if (indexCaveiraPadre == randomIndexCaveiraPadre && padre.caveiraApareceu) {
      if (!novoDestinoCaveiraPadreX) {
        destinoCaveiraPadreX = playerX;
        novoDestinoCaveiraPadreX = true;
      }

      caveiraAtaqueAtivo = true;
      caveiraPadreX = caveiraPadreX + movimentoCaveiraPadreX;

      if (!caveiraPadreReta) {
        if (caveiraPadreX > destinoCaveiraPadreX) {
          movimentoCaveiraPadreX = -8;
        } else {
          movimentoCaveiraPadreX = 8;
        }
      } else {
        movimentoCaveiraPadreX = 0;
      }

      caveiraPadreY = caveiraPadreY + movimentoCaveiraPadreY;
    }
  }

  void checaCaveiraPadreReta() {
    if (caveiraPadreX < destinoCaveiraPadreX) {
      if (destinoCaveiraPadreX - caveiraPadreX < 10) {  
        caveiraPadreReta = true;
      } else {
        caveiraPadreReta = false;
      }
    } else {
      if (caveiraPadreX - destinoCaveiraPadreX < 10) {  
        caveiraPadreReta = true;
      } else {
        caveiraPadreReta = false;
      }
    }
  }

  boolean acertouJLeite() {
    if (caveiraPadreX + 48 > playerX && caveiraPadreX < playerX + 63 && caveiraPadreY + 70 > playerY && caveiraPadreY < playerY + 126) {
      return true;
    } else {
      return false;
    }
  }

  boolean saiuDaTela() {
    if (caveiraPadreY > height) {
      return true;
    } else {
      return false;
    }
  }
}

ArrayList<CaveiraPadre> caveirasPadre = new ArrayList<CaveiraPadre>();

int tempoPrimeiraCaveiraAtaque;
int randomIndexCaveiraPadre = 4;

int[] valoresIndexDeletados = new int [3];

boolean gatilhoNovaCaveiraAtacar;

void caveiraPadre() {   
  if (caveirasPadre.size() > 0 && millis() > tempoPrimeiraCaveiraAtaque + 1000 && !gatilhoNovaCaveiraAtacar) {
    randomIndexCaveiraPadre = int(random(0, 4));
    gatilhoNovaCaveiraAtacar = true;
  }

  for (int i = 0; i < valoresIndexDeletados.length; i = i + 1) {
    if (randomIndexCaveiraPadre == valoresIndexDeletados[i]) {
      gatilhoNovaCaveiraAtacar = false;
    }
  }

  if (caveirasPadre.size() == 0 && padre.novoAtaqueCaveira) {
    caveirasPadre.add(new CaveiraPadre(padreX + 005, padreY + 033, 0, int(random(9, 11))));  
    caveirasPadre.add(new CaveiraPadre(padreX + 015, padreY + 113, 1, int(random(4, 12))));
    caveirasPadre.add(new CaveiraPadre(padreX + 105, padreY + 033, 2, int(random(5, 13))));
    caveirasPadre.add(new CaveiraPadre(padreX + 110, padreY + 113, 3, int(random(8, 10))));
  }

  if (caveirasPadre.size() == 0) {
    ataqueCaveiraAcontecendo = false;
    padre.caveiraApareceu = false;
  }

  for (int i = caveirasPadre.size() - 1; i >= 0; i = i - 1) {
    CaveiraPadre c = caveirasPadre.get(i);
    c.display();
    c.update();
    c.checaCaveiraPadreReta();
    if (c.saiuDaTela()) {
      if (caveirasPadre.size() > 1) {
        valoresIndexDeletados[4 - caveirasPadre.size()] = c.indexCaveiraPadre;
      } else {
        padre.caveiraApareceu = false;
        padre.tempoNovoAtaqueCaveira = millis();
        padreCaveiraCaiuCabeca = true;
        if (indexVidaPadreOsso >= 1 && umOsso) {
          if (!padre.padreMudouForma) {
            if (isSoundActive) {
              sonsPadreImpossivel[0].rewind();
              sonsPadreImpossivel[0].play();
            }
          } else {
            if (isSoundActive) {
              sonsPadreImpossivel[1].rewind();
              sonsPadreImpossivel[1].play();
            }
          }
          indexVidaPadreOsso = indexVidaPadreOsso - 1;
          umOsso = false;
        }
      }
      gatilhoNovaCaveiraAtacar = false;
      caveirasPadre.remove(c);
    }

    if (c.acertouJLeite() && !isPlayerImmune) {
      playerCurrentHP -= 4;
      isPlayerImmune = true;
      timeImmune = millis();
      ataqueCaveiraAcontecendo = false;
      padre.caveiraApareceu = false;
    }

    if (!ataqueCaveiraAcontecendo) {
      caveirasPadre.remove(c);
    }
  }
}

PImage raioPadre;

public class Raio {
  private PImage spriteRaioPadre;

  private int raioX = 145;
  private int raioY = -120;

  private int stepRaioPadre;
  private int tempoSpriteRaioPadre;

  private boolean danoJLeite;
  private boolean deletarRaio;

  void display() {
    if (millis() > tempoSpriteRaioPadre + 150) {
      if (padre.padreCarregandoNovoAtaqueRaio) {
        spriteRaioPadre = raioPadre.get(0, 0, 509, 720);
      } else {
        if (padre.padreParouCarregarRaio) {
          spriteRaioPadre = raioPadre.get(stepRaioPadre, 0, 509, 720);
          stepRaioPadre = stepRaioPadre % 6108 + 509;
        }
      }
      image(spriteRaioPadre, raioX, raioY);
      tempoSpriteRaioPadre = millis();
    } else {
      image(spriteRaioPadre, raioX, raioY);
    }

    if (stepRaioPadre >= 2545) {
      danoJLeite = true;
    }

    if (stepRaioPadre == raioPadre.width) {
      stepRaioPadre = 0;
      deletarRaio = true;
    }
  }

  boolean acertouJLeite() {
    if (danoJLeite) {
      if (playerX + 63 > raioX && playerX < raioX + 509 && playerY + 126 > raioY + 550 && playerY < raioY + 720) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }
}

ArrayList<Raio> raios = new ArrayList<Raio>();

void raio() {
  if (raios.size() == 0 && padre.padreCarregandoNovoAtaqueRaio) {
    raios.add(new Raio());
  }

  for (int i = raios.size() - 1; i >= 0; i = i - 1) {
    Raio r = raios.get(i);
    r.display();
    if (r.acertouJLeite() && !imortalidade) {
      playerCurrentHP -= 9999999;
    }
    if (r.deletarRaio) {
      raios.remove(r);
    }
  }
}