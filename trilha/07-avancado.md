# Módulo 7 — Avançado

A partir daqui não há sequência única. Escolha a trilha que combina com o que você quer construir, faça o projeto dela, e termine com um projeto final seu.

## Trilha A — Firmware a fundo

Para quem quer entender o que o Arduino esconde.

**Estudo**
- [Datasheet do ATmega328P](https://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-7810-Automotive-Microcontrollers-ATmega328P_Datasheet.pdf) — capítulos de portas de E/S, timers e ADC. Se o link mudar, procure "ATmega328P datasheet" no site da Microchip.
- [Timers](https://www.gammon.com.au/timers) e [consumo](https://www.gammon.com.au/power) — Nick Gammon.
- [ESP-IDF: primeiros passos](https://docs.espressif.com/projects/esp-idf/en/stable/esp32/get-started/index.html) e [FreeRTOS no ESP-IDF](https://docs.espressif.com/projects/esp-idf/en/stable/esp32s3/api-reference/system/freertos_idf.html) — Espressif.
- [Introduction to RTOS](https://www.youtube.com/playlist?list=PLEBQazB0HUyQ4hAPU1cJED6t3DU0h34bz) — termine a série.
- [PlatformIO](https://docs.platformio.org/en/latest/) — ambiente com depuração e testes.
- [Ben Eater](https://eater.net/8bit) — computador de 8 bits em protoboard. Não é firmware, mas ninguém explica melhor o que acontece abaixo dele.

**Projetos**
1. **Blink sem Arduino:** Uno programado em C puro, com registradores, timer por interrupção e `avr-gcc`. Sem `setup()` nem `loop()`.
2. **Gerador de sinais:** onda senoidal por PWM rápido + filtro RC, frequência ajustável por encoder, usando timers diretamente. Verifique o resultado com o osciloscópio ou com o ADC de outro Arduino.
3. **Desafio:** reescreva o nó sensor do módulo 5 em ESP-IDF puro, com depuração passo a passo pelo USB-JTAG embutido do ESP32-S3. Compare tempo acordado e consumo com a versão Arduino.

## Trilha B — Analógico e instrumentação

Para quem quer medir coisas pequenas e construir as próprias ferramentas de bancada.

**Estudo**
- [All About Circuits, livro-texto](https://www.allaboutcircuits.com/textbook/) — volume de semicondutores, capítulos de amplificadores operacionais.
- [Analog Engineer's Pocket Reference](https://www.ti.com/seclit/eb/slyw038c/slyw038c.pdf) — TI. Fórmulas e regras práticas em um PDF gratuito.
- [Como usar um osciloscópio](https://learn.sparkfun.com/tutorials/how-to-use-an-oscilloscope) — SparkFun.
- [EEVblog](https://www.youtube.com/@EEVblog) e [GreatScott!](https://www.youtube.com/@greatscottlab) — YouTube. Fundamentos e projetos "faça ou compre".
- Falstad para testar cada estágio antes de montar.

**Projetos**
1. **Amplificador de microfone de eletreto** com LM358 e filtro passa-faixa, lido pelo ADC. Mostre o espectro (FFT) no OLED.
2. **Fonte de bancada:** módulo buck ajustável com medição de tensão e corrente (INA219), OLED e limite de corrente por software. Você vai usar para sempre.
3. **Desafio — carga eletrônica de corrente constante:** amp-op + MOSFET + resistor shunt, corrente definida por DAC/PWM filtrado, com dissipador e proteção térmica. Use para levantar curvas de descarga de baterias e testar fontes. Envolve estabilidade de malha analógica, dissipação e medição de precisão.

## Trilha C — Áudio, voz e ML embarcado

A continuação natural do Pocket AI.

**Estudo**
- [I2S no ESP32](https://dronebotworkshop.com/esp32-i2s/) — DroneBot Workshop.
- [Edge Impulse](https://docs.edgeimpulse.com/) — documentação e tutoriais de reconhecimento de palavras-chave e de movimento em microcontroladores. Plano gratuito para uso pessoal.
- [Firmware Xiaozhi](https://github.com/78/xiaozhi-esp32) — o código do Pocket AI. Leia a camada de áudio e a definição da sua placa.

**Projetos**
1. **Analisador de espectro** com INMP441 e matriz ou fita de LEDs WS2812 ([guia NeoPixel](https://learn.adafruit.com/adafruit-neopixel-uberguide)).
2. **Palavra de ativação própria:** treine um modelo com sua voz e acenda um LED ao detectar, tudo no ESP32-S3, sem rede.
3. **Reconhecimento de gestos** com o MPU6050: classifique 3 movimentos.
4. **Desafio — Pocket AI completo e seu:** as 4 etapas do README, na PCB do módulo 6, com uma placa definida por você no firmware (seu próprio `config.h`) e uma funcionalidade que o original não tem.

## Trilha D — Robótica e controle

**Estudo**
- [Improving the Beginner's PID](http://brettbeauregard.com/blog/2011/04/improving-the-beginners-pid-introduction/) — releia.
- [A4988](https://lastminuteengineers.com/a4988-stepper-motor-driver-arduino-tutorial/) e microstepping.
- [Electronoobs](https://www.youtube.com/@Electronoobs) — YouTube. Drones, controladores e PID com explicação do código.

**Projetos**
1. **Robô equilibrista** (o chefão do módulo 4), com ajuste de ganhos e telemetria pelo celular.
2. **Plotter de caneta** com 2 motores de passo e firmware de movimento próprio (interpolação linear, rampas de aceleração). Depois compare com o GRBL.
3. **Desafio — pêndulo invertido** sobre carrinho ou roda de reação, com identificação do sistema a partir de dados e controle por realimentação de estados.

## Trilha E — Rádio e redes

**Estudo**
- [Andreas Spiess](https://www.youtube.com/@AndreasSpiess) — YouTube. LoRa, antenas, medições de alcance e consumo.
- [Random Nerd Tutorials](https://randomnerdtutorials.com/projects-esp32/) — procure LoRa, BLE e CAN.

**Projetos**
1. **Enlace LoRa** entre dois nós; mapeie o alcance no seu bairro e relacione com RSSI e SNR.
2. **Periférico BLE** com serviço próprio, lido por um aplicativo genérico no celular.
3. **Desafio — leitor CAN/OBD-II:** leia rotação, velocidade e temperatura do seu carro e mostre em um painel próprio. Só leitura; não envie quadros para o barramento do carro.

## Trilha F — Computador de placa única

Outra ordem de grandeza: processador com Linux, memória DDR, várias tensões de alimentação com sequência de partida, USB-C com negociação de potência, sinais de alta velocidade e placa de 4 camadas ou mais com componentes BGA.

O repositório tem um caso de estudo: [`ha-voice-hub/`](../ha-voice-hub/), um computador para Home Assistant com assistente de voz, com projeto de placa em KiCad, caixa e imagem de sistema. Ele também é o par natural do Pocket AI: o hub pode ser o servidor com que o gadget conversa.

**Como usar como estudo** (depois do módulo 6)
1. Abra o esquema e desenhe a **árvore de alimentação**: da entrada USB-C a cada tensão, com corrente e regulador.
2. Identifique os barramentos e classifique por velocidade. Quais exigem impedância controlada e comprimento casado?
3. Compare com a sua placa do módulo 6: o que existe lá que você nunca usou, e por quê?
4. Rode ERC e DRC você mesmo e leia cada aviso.

**Antes de fabricar qualquer coisa dali**
- Um projeto desse porte gerado de uma vez precisa de revisão humana cuidadosa, de preferência por quem já fez placa com processador. Erro em placa de 4 camadas com BGA não se remenda com fio.
- Custa caro: mais camadas, montagem por máquina, e uma ou duas revisões são o normal.
- Caminho mais curto para o mesmo resultado: um **módulo de computação** pronto (processador, memória e armazenamento já resolvidos) sobre uma placa-base sua. A placa-base tem só alimentação, conectores, áudio e rádios, e está ao alcance de quem terminou o módulo 6.

**Estudo**
- [Phil's Lab](https://www.youtube.com/@PhilsLab) — vídeos de projeto com DDR, USB e fontes chaveadas, e de placa-base para módulo de computação.

**Projetos**
1. **Placa-base para módulo de computação** com USB-C, áudio I2S (microfone e amplificador) e rádio Zigbee por USB.
2. **Desafio:** levar o `ha-voice-hub` (ou a sua versão com módulo) até ligar, com roteiro de primeira energização e errata.

## Projeto final

Um projeto seu, que resolva um problema seu. Antes de comprar qualquer peça, escreva uma página com:

1. **O que faz**, em duas frases, e para quem.
2. **Requisitos mensuráveis** (autonomia, precisão, tamanho, custo).
3. **Diagrama de blocos** com as interfaces entre eles.
4. **Orçamento de energia** e de custo.
5. **Os três maiores riscos** e o experimento mais barato que elimina cada um. Faça esses experimentos primeiro.
6. **Marcos:** cada um termina com algo funcionando e demonstrável.

Critérios de conclusão da trilha:
- [ ] Hardware próprio (PCB), firmware próprio, caixa.
- [ ] Usado de verdade por pelo menos um mês.
- [ ] Documentado a ponto de outra pessoa reproduzir.
