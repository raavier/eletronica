# Módulo 3 — Sensores e barramentos

Objetivo: ligar qualquer sensor ou módulo a partir do datasheet, e enxergar o que passa nos fios quando não funciona.

## Antes de começar: solde os pinos

Boa parte dos módulos deste módulo chega com a barra de pinos solta. Pino apenas encaixado, sem solda, dá mau contato intermitente e faz você caçar defeito que não existe.

1. Leia o [guia de solda da Adafruit](https://learn.adafruit.com/adafruit-guide-excellent-soldering) (30 min).
2. Espete a barra de pinos na protoboard, apoie o módulo em cima e solde. A protoboard serve de gabarito.
3. Treine antes em uma barra de pinos e uma placa perfurada de sucata.

O restante da prática de solda fica no [módulo 6](06-do-prototipo-ao-produto.md).

## Teoria mínima

| Assunto | Regra de bolso |
|---|---|
| UART | 2 fios cruzados (TX→RX), GND comum, mesmo baud nos dois lados. Ponto a ponto. |
| I2C | 2 fios (SDA, SCL) compartilhados por vários dispositivos, cada um com endereço de 7 bits. Precisa de pull-ups (4,7k típico; módulos costumam trazer). No Uno: A4 = SDA, A5 = SCL. |
| SPI | 4 fios: MOSI, MISO, SCK e um CS por dispositivo. Mais rápido que I2C. No Uno: 11, 12, 13 e CS livre (10 por padrão). |
| 1-Wire | 1 fio de dados com pull-up de 4,7k. Usado no DS18B20. |
| Níveis lógicos | Sensor de 3,3 V em barramento de 5 V pode queimar. Confira se o módulo tem regulador e conversor de nível; se não, use conversor. |
| Datasheet | Leia nesta ordem: máximos absolutos, tensão de operação, pinagem, endereço/interface, mapa de registradores. O resto, sob demanda. |
| Medida | Resolução não é exatidão. Ruído se trata com média ou mediana; erro sistemático, com calibração em 2 pontos. |
| Endereços | Dois dispositivos I2C com o mesmo endereço não convivem. Muitos têm um pino ou jumper para trocar. |

## Estudo

- [Comunicação serial](https://learn.sparkfun.com/tutorials/serial-communication), [I2C](https://learn.sparkfun.com/tutorials/i2c), [SPI](https://learn.sparkfun.com/tutorials/serial-peripheral-interface-spi), [níveis lógicos](https://learn.sparkfun.com/tutorials/logic-levels) — SparkFun. Cerca de 2 h, vale cada minuto.
- [I2C Bus Pullup Resistor Calculation](https://www.ti.com/lit/an/slva477b/slva477b.pdf) — TI, 5 páginas. Para quando o barramento falhar com fio comprido.
- [PulseView](https://sigrok.org/wiki/PulseView) — software do analisador lógico. `sudo apt install pulseview`.
- Tutoriais por componente (Last Minute Engineers): [OLED SSD1306](https://lastminuteengineers.com/oled-display-arduino-tutorial/), [BME280](https://lastminuteengineers.com/bme280-arduino-tutorial/), [MPU6050](https://lastminuteengineers.com/mpu6050-accel-gyro-arduino-tutorial/), [micro SD](https://lastminuteengineers.com/arduino-micro-sd-card-module-tutorial/), [DS3231](https://lastminuteengineers.com/ds3231-rtc-arduino-tutorial/), [encoder rotativo](https://lastminuteengineers.com/rotary-encoder-arduino-tutorial/), [DHT11/22](https://lastminuteengineers.com/dht11-dht22-arduino-tutorial/).
- [DS18B20](https://randomnerdtutorials.com/guide-for-ds18b20-temperature-sensor-with-arduino/) — Random Nerd Tutorials.
- [Termistor](https://learn.adafruit.com/thermistor) — Adafruit.

## Labs

### Lab 1 — Scanner I2C
1. Escreva (ou use o exemplo da `Wire`) um scanner que lista os endereços que respondem.
2. Ligue OLED, BME280, MPU6050 e DS3231 um por vez e anote os endereços.
3. Ligue todos juntos. Algum conflito? (Guarde a resposta para o desafio.)

### Lab 2 — OLED
1. Texto e a leitura de um potenciômetro em barra.
2. Gráfico rolante da leitura analógica (osciloscópio de pobre).
3. Veja quanta RAM a biblioteca usa (o compilador informa). Guarde esse número.

### Lab 3 — BME280 x DS18B20
1. Leia os dois e mostre lado a lado.
2. Leia o registrador de identificação do chip (`0xD0`). `0x60` é BME280; `0x58` é BMP280, sem umidade. Qual você recebeu?
3. As temperaturas diferem? Em quanto? Está dentro da exatidão dos datasheets? O BME280 esquenta sozinho?

### Lab 4 — MPU6050 sem biblioteca
Só com `Wire` e o mapa de registradores do datasheet:
1. Leia `WHO_AM_I` (`0x75`). Deve devolver `0x68`.
2. Tire o chip do sleep escrevendo `0` em `PWR_MGMT_1` (`0x6B`).
3. Leia os 6 bytes de aceleração a partir de `0x3B` e converta para g (±2 g → 16384 LSB/g).
4. Calcule o ângulo de inclinação com `atan2`.

Depois disso, nenhuma biblioteca de sensor é mágica.

### Lab 5 — Analisador lógico
1. Canais em SDA e SCL, GND comum. Capture a leitura do `WHO_AM_I` no PulseView com o decodificador I2C.
2. Identifique na captura: start, endereço, bit R/W, ACK, registrador, dado, stop.
3. Desconecte o sensor e capture de novo. Como aparece um NACK?
4. Repita com UART: capture `Serial.print("oi")` e decodifique.

### Lab 6 — SD e RTC
1. Acerte o DS3231 e imprima data e hora.
2. Grave uma linha CSV por segundo no cartão, com carimbo de tempo.
3. Tire o cartão com o sketch rodando. O que acontece? E ao recolocar?

### Lab 7 — NTC na unha
1. NTC 10k em divisor (módulo 1) lido pelo ADC.
2. Converta para °C com a equação beta.
3. Calibre em 2 pontos contra o DS18B20 (água com gelo e água morna).

### Lab 8 — Encoder rotativo
1. Leia o KY-040 por interrupção, sem perder passos girando rápido.
2. Trate o botão com o debounce do módulo 2.

## Projeto-desafio — Datalogger ambiental com menu

**Missão:** um registrador autônomo de temperatura, umidade, pressão e luminosidade, com tela, menu e cartão SD, que aguenta dias ligado e falhas de hardware.

### Requisitos
1. **Sensores:** BME280 (ou DHT22 + outro), LDR e DS18B20 como segunda temperatura.
2. **Registro:** uma linha CSV no SD a cada intervalo configurável (1 s a 10 min), com data e hora do DS3231. Um arquivo por dia.
3. **Tela OLED com 4 telas**, navegadas pelo encoder:
   - valores atuais;
   - mínimos e máximos desde o ligamento;
   - gráfico da última hora de uma grandeza selecionável;
   - estado do sistema (SD ok, espaço, última gravação, RAM livre).
4. **Menu de configuração** (aperto longo do encoder): intervalo de registro, grandeza do gráfico, acerto do relógio. Persistido em EEPROM.
5. **Tolerância a falhas:** sensor desconectado ou SD removido não trava o sistema. A tela indica o erro, o resto continua, e a recuperação ao reconectar é automática, sem reset.
6. **Tela apaga** após 30 s sem interação; qualquer giro acende.

### Restrições
- Arduino Uno. **2 KB de RAM.** Esta é a parte difícil do desafio: OLED com buffer completo, mais SD, mais histórico do gráfico não cabem do jeito ingênuo.
- Sem `delay()`. A interface responde em menos de 100 ms mesmo durante gravação.
- Nenhuma `String` (a classe). Só `char[]`.

### Critérios de aceite
- [ ] 24 h ligado sem travar, com CSV íntegro (número de linhas ≈ 86400 / intervalo).
- [ ] Puxar o fio SDA do BME280 por 10 s: tela mostra erro, registro marca a falha, tudo volta ao reconectar.
- [ ] Remover e recolocar o SD: idem.
- [ ] Girar o encoder rápido durante uma gravação não perde passos.
- [ ] RAM livre mostrada na tela de estado fica estável ao longo de horas.
- [ ] Todos os dispositivos I2C convivem no mesmo barramento.
- [ ] Gráfico de 24 h dos dados (planilha ou Python) no README, com um comentário sobre o que os dados mostram.

<details>
<summary>Dica 1 — RAM</summary>

A `Adafruit_SSD1306` aloca 1 KB de buffer para 128x64. A biblioteca `SD` precisa de mais de 512 bytes. Alternativas: `U8g2` em modo *page buffer*, ou `SSD1306Ascii` (só texto). Para o gráfico, pense em quantos pontos cabem na largura da tela e em quantos bits cada um realmente precisa.
</details>

<details>
<summary>Dica 2 — endereços</summary>

DS3231 e MPU6050 usam `0x68`. Você só precisa do MPU no chefão; quando chegar lá, o pino AD0 dele em nível alto muda o endereço para `0x69`.
</details>

<details>
<summary>Dica 3 — I2C travado</summary>

A `Wire` clássica pode bloquear para sempre se o barramento travar. Veja `Wire.setWireTimeout()`. E sempre confira o valor de retorno de `Wire.endTransmission()`.
</details>

<details>
<summary>Dica 4 — SD seguro</summary>

Abrir, escrever e fechar (ou `flush()`) a cada registro. Arquivo que fica aberto perde dados na remoção.
</details>

### Versão mínima para avançar
BME280 gravando CSV no SD com horário do DS3231, duas telas (valores atuais e estado do sistema) trocadas pelo encoder, e recuperação automática ao remover o SD ou soltar o sensor. Sem menu de configuração e sem gráfico. Teste de 2 h em vez de 24 h.

### Chefão (opcional)
- **Nível de bolha:** quinta tela com um nível digital usando o MPU6050 e filtro complementar (acelerômetro + giroscópio).
- **Protocolo próprio pela serial:** comandos de texto para listar arquivos, despejar um dia e mudar configuração. Escreva um script Python cliente.
- **Capture e documente** no PulseView uma transação SPI de escrita no SD.
- **Meça o consumo** e estime quanto tempo duraria em 4 pilhas AA. O que você mudaria para dobrar?

## Checkpoint

- [ ] Liga um sensor I2C desconhecido só com o datasheet.
- [ ] Usa o analisador lógico como primeira ferramenta quando um barramento falha.
- [ ] Sabe verificar níveis de tensão antes de conectar dois dispositivos.
- [ ] Escreve firmware que sobrevive a periférico ausente.
