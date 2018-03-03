PImage[] imagensCenarios = new PImage [6];
PImage[] imagensCenariosBoss =  new PImage [3];

PImage porta;
PImage cerca;

float movimentoCenario = 42;

int indexCenario;

int totalCenariosCriados;

final int totalCenariosPossiveis = 21;

boolean portaAberta, cercaAberta;

public class Cenario {
  private PImage spritePorta;
  private PImage spriteCerca;

  private float cenarioY;
  private float cenarioX;

  private int indexCenarioCriado;
  private int indexCenarioFinal;

  private int stepPorta;
  private int tempoSpritePorta;

  private int stepCerca;
  private int tempoSpriteCerca;

  public Cenario(float cenarioX, float cenarioY, int indexCenarioCriado) {
    this.cenarioX = cenarioX;
    this.cenarioY = cenarioY;
    this.indexCenarioCriado = indexCenarioCriado;
  }

  public Cenario(int indexCenarioCriado, int indexCenarioFinal) {
    cenarioY = -imagensCenarios[0].height;
    this.indexCenarioCriado = indexCenarioCriado;
    this.indexCenarioFinal = indexCenarioFinal;
  }

  void display() {
    image (imagensCenarios[indexCenarioFinal], 0, cenarioY);
    
    if (indexCenarioCriado == totalCenariosPossiveis) {
      if (estadoJogo == "PrimeiroMapa") {
        if (millis() > tempoSpritePorta + 350 && !portaAberta) { 
          if (!finalMapa) {
            spritePorta = porta.get(0, 0, 334, 256);
          } else {
            if (jLeiteX == 380) {
              spritePorta = porta.get(stepPorta, 0, 334, 256);
              stepPorta = stepPorta % 1338 + 334;
            }
          }
          image(spritePorta, 230, cenarioY); 
          tempoSpritePorta = millis();
        } else {
          image(spritePorta, 230, cenarioY);
        }

        if (stepPorta == porta.width) {
          portaAberta = true;
        }
      }

      if (estadoJogo == "SegundoMapa") {
        if (millis() > tempoSpriteCerca + 350 && !cercaAberta) { 
          if (!finalMapa) {
            spriteCerca = cerca.get(0, 0, 426, 146);
          } else {
            if (jLeiteX == 380) {
              spriteCerca = cerca.get(stepCerca, 0, 426, 146);
              stepCerca = stepCerca % 1704 + 426;
            }
          }
          image(spriteCerca, 188, cenarioY + 20); 
          tempoSpriteCerca = millis();
        } else {
          image(spriteCerca, 188, cenarioY + 20);
        }

        if (stepCerca == cerca.width) {
          cercaAberta = true;
        }
      }
    }
  }

  void update() {
    if (indexCenarioCriado != totalCenariosPossiveis) {
      cenarioY = cenarioY + movimentoCenario;
    } else {
      if (cenarioY <= 0) {
        cenarioY = cenarioY + movimentoCenario;
      }
    }
  }

  boolean saiuDaTela() {
    if (cenarioY > height) {
      return true;
    } else {
      return false;
    }
  }
}

Cenario cenario;
ArrayList<Cenario> cenarios;

double tempoCenario;

void cenario() {
  if (!jLeiteMorreu) {
    movimentoCenario = 2;
  } else {
    movimentoCenario = 0;
  }

  cenario.display();
  cenario.update();

  if (totalCenariosCriados < totalCenariosPossiveis && !jLeiteMorreu) {
    if (cenarios.size() < 1) {
      if (estadoJogo == "PrimeiroMapa") {
        cenarios.add(new Cenario(58008, 0));
      }
      if (estadoJogo == "SegundoMapa") {
        cenarios.add(new Cenario(58008, 2));
      }
      if (estadoJogo == "TerceiroMapa") {
        cenarios.add(new Cenario(58008, 4));
      }
      tempoCenario = millisAvancadaMapa;
    }

    if (cenarios.size() < 2 && millisAvancadaMapa + 200 > tempoCenario + ((imagensCenarios[2].height / (60 * movimentoCenario)) * 1000)) {
      totalCenariosCriados = totalCenariosCriados + 1;
      if (estadoJogo == "PrimeiroMapa") {
        if (totalCenariosCriados != totalCenariosPossiveis) {
          cenarios.add(new Cenario(totalCenariosCriados, 0));
        } else {      
          cenarios.add(new Cenario(totalCenariosCriados, 1));
        }
      }
      if (estadoJogo == "SegundoMapa") {
        if (totalCenariosCriados != totalCenariosPossiveis) {
          cenarios.add(new Cenario(totalCenariosCriados, 2));
        } else {      
          cenarios.add(new Cenario(totalCenariosCriados, 3));
        }
      }
      if (estadoJogo == "TerceiroMapa") {
        if (totalCenariosCriados != totalCenariosPossiveis) {
          cenarios.add(new Cenario(totalCenariosCriados, 4));
        } else {      
          cenarios.add(new Cenario(totalCenariosCriados, 5));
        }
      }
      tempoCenario = millisAvancadaMapa;
    }
  }

  for (int i = cenarios.size() - 1; i >= 0; i = i - 1) {
    Cenario c = cenarios.get(i);
    c.display();
    c.update();
    if (c.saiuDaTela()) {
      cenarios.remove(c);
    }
  }
}