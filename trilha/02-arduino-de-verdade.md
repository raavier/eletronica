# Módulo 2 — Arduino de verdade

Objetivo: sair do "copiei o exemplo" para firmware que faz várias coisas ao mesmo tempo sem travar. Você já gravou `teste_blink` e `sensor_estacionamento`; este módulo começa daí.

## Teoria mínima

| Assunto | Regra de bolso |
|---|---|
| Limites do Uno | Lógica de 5 V. Até 20 mA por pino (40 mA é o máximo absoluto), ~200 mA somando tudo. Pino aciona LED; qualquer coisa maior, transistor. |
| Entrada flutuando | Pino solto lê ruído. Use `INPUT_PULLUP` e botão para o GND (apertado = `LOW`). |
| Bounce | Botão mecânico "quica" por alguns ms. Sem tratamento, um aperto vira vários. |
| ADC | 10 bits: 0–1023 para 0–5 V (~4,9 mV por passo). Entradas A0–A5. |
| PWM | `analogWrite(pino, 0–255)` nos pinos 3, 5, 6, 9, 10, 11. ~490 Hz (5 e 6: ~980 Hz). É onda quadrada, não tensão analógica. |
| Tempo | `delay()` congela tudo. Padrão correto: `if (millis() - anterior >= intervalo)`. Use `unsigned long` e sempre subtração. |
| Máquina de estados | `enum` com os estados + `switch` no `loop()`. Cada passada do loop é rápida e nunca espera. |
| Interrupção | Pinos 2 e 3. ISR curta, sem `Serial` nem `delay`. Variável compartilhada é `volatile`. |
| Memória | 2 KB de RAM. Texto fixo em `F("...")`. EEPROM guarda dados sem energia, ~100 mil escritas por célula. |
| Conflitos de timer | `tone()` desativa PWM nos pinos 3 e 11. A biblioteca `Servo` desativa nos 9 e 10. |

## Estudo

- [Exemplos embutidos](https://docs.arduino.cc/built-in-examples/) — Arduino. Faça ao menos [BlinkWithoutDelay](https://docs.arduino.cc/built-in-examples/digital/BlinkWithoutDelay/) e [Debounce](https://docs.arduino.cc/built-in-examples/digital/Debounce/).
- [Multi-tasking the Arduino, parte 1](https://learn.adafruit.com/multi-tasking-the-arduino-part-1) e [parte 2](https://learn.adafruit.com/multi-tasking-the-arduino-part-2) — Adafruit. **A leitura mais importante do módulo.**
- [Pull-up](https://learn.sparkfun.com/tutorials/pull-up-resistors), [PWM](https://learn.sparkfun.com/tutorials/pulse-width-modulation), [ADC](https://learn.sparkfun.com/tutorials/analog-to-digital-conversion) — SparkFun.
- [Interrupções](https://www.gammon.com.au/interrupts) — Nick Gammon. Referência definitiva; leia a primeira metade.
- [Memories of an Arduino](https://learn.adafruit.com/memories-of-an-arduino) — Adafruit. Flash, RAM, EEPROM e como não estourar a RAM.
- [EEPROM](https://docs.arduino.cc/learn/programming/eeprom-guide/) — Arduino.
- [Referência da linguagem](https://docs.arduino.cc/language-reference/) — para consulta.
- Vídeo, se preferir: [Paul McWhorter, New Arduino Tutorials](https://www.youtube.com/playlist?list=PLGs0VKk2DiYw-L-RibttcvK-WBZm8WLEP) (inglês) ou [Brincando com Ideias](https://www.youtube.com/@BrincandoComIdeias) (português). Assista em 1,5x e pule o que já sabe.

## Labs

### Lab 1 — Botão e bounce
1. Botão com `INPUT_PULLUP` alternando um LED a cada aperto.
2. Conte os apertos na serial sem debounce. Quantas contagens falsas aparecem em 20 apertos?
3. Implemente debounce com `millis()`, sem biblioteca.

### Lab 2 — ADC e PWM
1. Potenciômetro em A0 controlando o brilho de um LED.
2. Imprima a leitura em volts. Confira com o multímetro.
3. Com o pino solto, o que `analogRead` devolve? Por quê?

### Lab 3 — Meça seu RC com o Arduino
1. Remonte o RC do módulo 1 (10k + 100 µF, τ = 1 s). Um pino digital carrega, A0 mede.
2. Amostre a cada 20 ms, imprima CSV e plote.
3. Extraia τ do gráfico e compare com o calculado. A diferença cabe na tolerância dos componentes?

### Lab 4 — Refatore o sensor de estacionamento
Seu `sensor_estacionamento.ino` usa `delay()` para o ritmo do bipe.
1. Reescreva sem nenhum `delay()`: medição e bipe em tempos independentes.
2. Faça o intervalo do bipe variar **continuamente** com a distância, em vez de 3 faixas.
3. Filtre as leituras com mediana de 5 amostras. Compare o ruído antes e depois na serial.

### Lab 5 — Interrupção
1. Conte bordas do botão no pino 2 com `attachInterrupt`.
2. Mantenha um `delay(1000)` proposital no loop e mostre que nenhuma borda se perde.
3. Leia o contador no loop de forma segura (o que acontece se a ISR dispara no meio da leitura de um `long`?).

### Lab 6 — EEPROM
1. Contador de quantas vezes a placa ligou, que sobrevive a desligar.
2. Grave uma `struct` de configuração com `EEPROM.put/get` e um número de versão para detectar memória não inicializada.

## Projeto-desafio — Console de 4 botões

**Missão:** um mini console com 4 LEDs, 4 botões e buzzer, com dois jogos e recorde persistente.

### Requisitos
1. **Jogo A — memória de sequência:** o console mostra uma sequência de luzes com tons; o jogador repete. A cada rodada certa, a sequência cresce um passo e fica mais rápida.
2. **Jogo B — tempo de reação:** após um tempo aleatório, um LED acende; mede o tempo até o botão correspondente, em ms. Apertar antes da hora é falta.
3. **Seleção de jogo** por aperto longo (> 1 s) em um botão, na tela de espera.
4. **Recorde** de cada jogo salvo em EEPROM. Bater o recorde toca uma melodia.
5. **Modo de espera:** animação nos LEDs enquanto ninguém joga, interrompida instantaneamente por qualquer botão.
6. **Tempo limite:** jogador parado por 5 s perde a rodada.
7. Tudo espelhado na serial (estado atual, pontuação) para depuração.

### Restrições
- **Zero `delay()`** no código. Nem um.
- **Máquina de estados explícita** (`enum` + `switch`). Desenhe o diagrama de estados antes de escrever código.
- Debounce próprio, sem biblioteca.
- A sequência não pode ser a mesma a cada vez que liga.

### Critérios de aceite
- [ ] `grep -c "delay(" m2_console.ino` devolve 0.
- [ ] Apertos rápidos e repetidos no mesmo botão são todos registrados, sem duplicatas.
- [ ] Durante a reprodução da sequência, o console continua respondendo (por exemplo, aperto longo cancela).
- [ ] Desligar e religar mantém os recordes.
- [ ] Sequências diferentes em duas partidas seguidas após reset.
- [ ] Diagrama de estados no README bate com o `enum` do código.

<details>
<summary>Dica 1 — aleatoriedade</summary>

`random()` repete a mesma série após cada reset. Você precisa de uma semente que varie: ruído de um pino analógico flutuando, ou o instante (`micros()`) do primeiro aperto de botão.
</details>

<details>
<summary>Dica 2 — organização</summary>

Separe em três camadas: (1) leitura de botões que produz *eventos* (apertou, soltou, aperto longo); (2) saídas com tempo próprio (LED aceso por N ms, tom por N ms); (3) a máquina de estados, que só consome eventos e dispara saídas.
</details>

<details>
<summary>Dica 3 — tons sem travar</summary>

`tone(pino, freq, duração)` não bloqueia. Para melodia, um índice de nota avançado por `millis()`.
</details>

### Versão mínima para avançar
Só o jogo A, com recorde em EEPROM, respeitando todas as restrições (zero `delay()`, máquina de estados, debounce próprio). As restrições são o que o módulo ensina; o segundo jogo é volume.

### Chefão (opcional)
- **74HC595:** acione os LEDs (ou um display de 7 segmentos para o placar) com um registrador de deslocamento, usando 3 pinos. [Tutorial](https://lastminuteengineers.com/74hc595-shift-register-arduino-tutorial/).
- **Sem `digitalWrite`:** reescreva a leitura dos botões com acesso direto aos registradores (`PIND`, `PORTB`). [Port manipulation](https://docs.arduino.cc/retired/hacking/software/PortManipulation/).
- **Economia de energia:** depois de 30 s parado, entre em sleep profundo e acorde por interrupção de botão. Meça a corrente antes e depois. [Guia de consumo](https://www.gammon.com.au/power) — Nick Gammon.
- **Jogo C** de sua invenção para 2 jogadores.

## Checkpoint

- [ ] Escreve o padrão `millis()` e debounce de memória.
- [ ] Modela qualquer comportamento como máquina de estados antes de codar.
- [ ] Sabe quando usar interrupção e quando não.
- [ ] Sabe quanta RAM seu sketch usa e onde ela vai.
