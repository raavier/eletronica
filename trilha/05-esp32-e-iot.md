# Módulo 5 — ESP32 e IoT

Objetivo: dispositivos conectados, que publicam dados, recebem comandos, atualizam pelo ar e duram meses em bateria. É a base direta do [Pocket AI](../pocket-ai/README.md).

Placa de referência: **ESP32-S3-DevKitC-1 N16R8**, a mesma do Pocket AI.

## Preparação

```bash
make setup-esp32                               # instala o suporte ao ESP32 (download grande, uma vez)
make boards                                    # descubra a porta (ttyACM0 ou ttyUSB0)
make upload  BOARD=s3 SKETCH=m5_lab1_blink
make monitor BOARD=s3
make details BOARD=s3                          # opções da placa (PSRAM, flash, USB)
```

`BOARD=s3` troca placa, porta (`/dev/ttyACM0`) e velocidade da serial (115200). Se a sua porta for outra, acrescente `PORT=/dev/ttyUSB0`.

A placa tem duas portas USB-C. Use a marcada **UART** para gravar e ver a serial: funciona sem configuração extra. Se a gravação não iniciar, segure BOOT, aperte RESET, solte BOOT.

Senhas de Wi-Fi ficam em um `secrets.h` fora do controle de versão.

## Teoria mínima

| Assunto | Regra de bolso |
|---|---|
| Tensão | Lógica de **3,3 V. Nenhum pino tolera 5 V.** O ECHO do HC-SR04 precisa de divisor. |
| Pinos proibidos (S3 N16R8) | Evite 0, 3, 45, 46 (strapping), 19 e 20 (USB), 26–32 (flash), 35–37 (PSRAM). Tenha o [pinout](https://randomnerdtutorials.com/esp32-s3-devkitc-pinout-guide/) aberto. |
| ADC | 12 bits, não linear nas pontas. Use `analogReadMilliVolts()`. No S3, o ADC2 (GPIO 11–20) é disputado com o Wi-Fi; use ADC1 (GPIO 1–10). |
| PWM | API `ledc`. No core 3.x: `ledcAttach(pino, freq, bits)` e `ledcWrite(pino, duty)`. Tutoriais antigos usam `ledcSetup`/`ledcAttachPin`, que não existem mais. |
| Wi-Fi | Só 2,4 GHz. Picos de centenas de mA: cabo ruim ou fonte fraca causam reset (*brownout*). |
| Conexão | Vai cair. Código precisa reconectar sozinho, sem bloquear o resto. |
| MQTT | Publicar/assinar por tópicos via um broker. *Retained* guarda o último valor; *Last Will* avisa quando o dispositivo some. |
| Deep sleep | O chip consome µA; a placa de desenvolvimento, bem mais (regulador, LED, conversor USB). Ao acordar, o programa recomeça do `setup()`. |
| Autonomia | `I_média = (I_ativo · t_ativo + I_sleep · t_sleep) / t_total`. Autonomia ≈ capacidade / I_média. O tempo acordado domina. |
| Armazenamento | `Preferences` (NVS) no lugar da EEPROM. |
| FreeRTOS | Já roda por baixo. Tarefas com prioridade, filas para trocar dados, nunca variável global compartilhada sem proteção. |

### Segurança

| Risco | Regra |
|---|---|
| MQTT aberto na rede | Broker sempre com usuário e senha, um por dispositivo, com permissão só nos tópicos dele. |
| Tráfego legível | TLS com verificação de certificado. Exige hora certa (NTP) antes de conectar. |
| OTA sem proteção | Qualquer um na rede regrava seu dispositivo. Senha no mínimo; firmware assinado em produto. |
| Acesso de fora de casa | Nunca abra porta no roteador. Use VPN (WireGuard, Tailscale) ou um broker externo com TLS. |
| Mesma credencial em todos | Um aparelho aberto compromete a frota. Credencial única por unidade. |
| Segredo no repositório | `secrets.h` fora do git, desde o primeiro commit. |
| Dados de terceiros | Colete o mínimo; em produto, vale a LGPD. |

Exemplo de autonomia (ilustrativo): 2 s acordado a 100 mA a cada 5 min, com 0,05 mA dormindo, dá média de ~0,72 mA. Uma célula de 2500 mAh duraria ~145 dias, antes de perdas. Com 10 s acordado, cai para ~29 dias.

## Estudo

[Random Nerd Tutorials](https://randomnerdtutorials.com/projects-esp32/) cobre quase tudo, gratuito e atualizado. Siga na ordem dos labs:

- [Primeiros passos](https://randomnerdtutorials.com/getting-started-with-esp32/), [pinout do S3 DevKitC](https://randomnerdtutorials.com/esp32-s3-devkitc-pinout-guide/), [ADC](https://randomnerdtutorials.com/esp32-adc-analog-read-arduino-ide/), [PWM](https://randomnerdtutorials.com/esp32-pwm-arduino-ide/), [I2C](https://randomnerdtutorials.com/esp32-i2c-communication-arduino-ide/).
- [Funções úteis de Wi-Fi](https://randomnerdtutorials.com/esp32-useful-wi-fi-functions-arduino/), [servidor web](https://randomnerdtutorials.com/esp32-web-server-arduino-ide/), [WebSocket](https://randomnerdtutorials.com/esp32-websocket-server-arduino/), [HTTP GET/POST](https://randomnerdtutorials.com/esp32-http-get-post-arduino/), [NTP](https://randomnerdtutorials.com/esp32-ntp-client-date-time-arduino-ide/).
- [MQTT](https://randomnerdtutorials.com/esp32-mqtt-publish-subscribe-arduino-ide/) e [MQTT Essentials](https://www.hivemq.com/mqtt/) (HiveMQ) para os conceitos. Broker: [Mosquitto](https://mosquitto.org/).
- [Deep sleep](https://randomnerdtutorials.com/esp32-deep-sleep-arduino-ide-wake-up-sources/), [Preferences](https://randomnerdtutorials.com/esp32-save-data-permanently-preferences/), [OTA](https://randomnerdtutorials.com/esp32-ota-over-the-air-arduino/), [Wi-Fi Manager](https://randomnerdtutorials.com/esp32-wi-fi-manager-asyncwebserver/).
- [ESP-NOW](https://randomnerdtutorials.com/esp-now-esp32-arduino-ide/) e [ESP-NOW + Wi-Fi](https://randomnerdtutorials.com/esp32-esp-now-wi-fi-web-server/).
- [Bateria, painel solar e medição de nível](https://randomnerdtutorials.com/power-esp32-esp8266-solar-panels-battery-level-monitoring/).
- [Interrupções no ESP32](https://lastminuteengineers.com/handling-esp32-gpio-interrupts-tutorial/) — Last Minute Engineers.
- [Introduction to RTOS](https://www.youtube.com/playlist?list=PLEBQazB0HUyQ4hAPU1cJED6t3DU0h34bz) — Shawn Hymel / DigiKey. Série em vídeo com ESP32 e desafios. Faça ao menos as 5 primeiras partes.
- [I2S no ESP32](https://dronebotworkshop.com/esp32-i2s/) — DroneBot Workshop. Microfone INMP441 e amplificador MAX98357A.
- [Documentação do core Arduino-ESP32](https://docs.espressif.com/projects/arduino-esp32/en/latest/) — referência oficial das APIs.
- Segurança: [requisições HTTPS](https://randomnerdtutorials.com/esp32-https-requests/) (Random Nerd Tutorials), [autenticação](https://mosquitto.org/documentation/authentication-methods/) e [TLS](https://mosquitto.org/man/mosquitto-tls-7.html) no Mosquitto, [visão geral de segurança do ESP32-S3](https://docs.espressif.com/projects/esp-idf/en/stable/esp32s3/security/security.html) (Espressif), [projeto de IoT da OWASP](https://owasp.org/www-project-internet-of-things/).
- Canais: [Andreas Spiess](https://www.youtube.com/@AndreasSpiess) (medições sérias de consumo e rádio), [Fernando K](https://www.youtube.com/@fernandokoyanagi) (ESP32 em português).

## Labs

### Lab 1 — Primeira luz
1. Blink no LED RGB da placa (GPIO 48 ou 38, conforme a revisão; descubra a sua).
2. Refaça um lab do módulo 2 no ESP32. O que mudou por causa de 3,3 V?

### Lab 2 — Wi-Fi e servidor web
1. Conecte, imprima IP e RSSI.
2. Página que liga/desliga um LED e mostra a leitura de um sensor.
3. Desligue o roteador por 1 min. Seu código volta sozinho?

### Lab 3 — MQTT
1. Mosquitto no PC (`sudo apt install mosquitto mosquitto-clients`).
2. ESP32 publica temperatura a cada 10 s; veja com `mosquitto_sub -t '#' -v`.
3. ESP32 assina um tópico e liga o LED com `mosquitto_pub`.
4. Configure *Last Will*. Tire o ESP32 da tomada e veja o broker anunciar.

### Lab 4 — API externa
1. Busque a previsão em uma API aberta (por exemplo, Open-Meteo, que não exige chave), interprete o JSON com `ArduinoJson` e mostre no OLED.
2. Hora certa via NTP.

### Lab 5 — Deep sleep e consumo
1. Acorde a cada 30 s, leia o sensor, publique, durma.
2. Meça o tempo acordado (com `millis()` impresso antes de dormir).
3. Meça a corrente dormindo e acordado. Use o INA219 ou medidor USB: multímetro em série na escala de µA derruba a placa no pico do Wi-Fi.
4. Reduza o tempo acordado: IP fixo, canal e BSSID guardados em memória RTC. Quanto ganhou?

### Lab 6 — OTA
1. Atualize o firmware pela rede.
2. Grave um firmware que trava no `setup()`. Como você recupera? Como evitaria?

### Lab 7 — ESP-NOW (precisa de 2 placas)
1. Uma placa envia leitura, outra recebe e mostra.
2. Compare o tempo acordado com o do Lab 5.

### Lab 8 — FreeRTOS
1. Duas tarefas: uma lê sensor a 10 Hz, outra atualiza o OLED a 2 Hz. Comunicação por fila.
2. Tarefa de botão com semáforo liberado pela ISR.
3. Provoque de propósito um estouro de pilha de tarefa e leia a mensagem de erro.

### Lab 9 — Áudio I2S
1. INMP441: leia amostras e mostre um medidor de volume no OLED.
2. MAX98357A: toque um tom senoidal gerado no código.
3. Eco: do microfone para o alto-falante com 0,5 s de atraso.

Com o lab 9 feito, o hardware do Pocket AI deixa de ter mistério.

### Lab 10 — Segurança
Primeiro ataque o seu próprio dispositivo, depois feche cada porta.

1. **Senha na rede:** com MQTT sem TLS, capture o tráfego no PC (`sudo tcpdump -A -i any port 1883`). Ache usuário, senha e dados em texto puro.
2. **Senha na flash:** leia a memória da placa com `esptool.py read_flash` e procure a senha do Wi-Fi com `strings`. Quem tem o aparelho na mão tem a senha.
3. **Broker:** desative o acesso anônimo, crie um usuário por dispositivo e uma lista de permissões por tópico.
4. **TLS:** crie uma autoridade certificadora própria, sirva o Mosquitto na porta 8883 e conecte o ESP32 **verificando o certificado** (`setCACert`, nunca `setInsecure`). Repita a captura do item 1.
5. **OTA:** proteja com senha. Tente atualizar sem ela.
6. Leia (sem aplicar em placa que você não possa perder) como funcionam criptografia de flash e inicialização segura no ESP32. Elas gravam fusíveis irreversíveis.

## Projeto-desafio — Rede de sensores a bateria com painel

**Missão:** monitorar a casa com nós sem fio que duram meses na bateria, um nó atuador, e um painel no PC.

### Arquitetura mínima

```
[Nó sensor a bateria] ──┐
[Nó sensor a bateria] ──┼─ Wi-Fi/MQTT (ou ESP-NOW + gateway) ─→ [Mosquitto no PC] ─→ [Painel + histórico]
[Nó atuador na tomada] ─┘                                                ↑ regras
```

### Requisitos
1. **Nó sensor:** temperatura, umidade e tensão da bateria, a cada 5 min, em deep sleep entre leituras. Alimentado por célula de lítio.
2. **Nó atuador:** sempre ligado; controla uma carga (fita de LED por MOSFET ou módulo relé em baixa tensão) e tem um botão local que funciona mesmo sem rede.
3. **Servidor no PC:** Mosquitto mais histórico e painel. Escolha: Home Assistant, Node-RED com InfluxDB/Grafana, ou um script Python com SQLite e uma página simples.
4. **Uma regra automática:** por exemplo, umidade acima de X liga a carga; com histerese (lembra do módulo 1?).
5. **Provisionamento:** Wi-Fi e endereço do broker configurados por portal no primeiro uso. Nada de senha no código.
6. **OTA** no nó atuador.
7. **Presença:** o painel mostra cada nó como online/offline (*Last Will* no atuador; "sem mensagem há 15 min" nos sensores).
8. **Alerta** de bateria baixa.

### Restrições
- Tópicos MQTT e formato das mensagens documentados no README antes de codar.
- Orçamento de energia **calculado antes e medido depois**, com a autonomia prevista.
- O nó sensor nunca fica acordado mais de 10 s, mesmo se o Wi-Fi ou o broker estiverem fora.

### Critérios de aceite
- [ ] 7 dias rodando sem intervenção. Nenhuma lacuna maior que 15 min no histórico.
- [ ] Autonomia projetada do nó sensor ≥ 3 meses, com a medição de corrente que sustenta a conta.
- [ ] Derrubar o broker por 10 min: os nós voltam sozinhos; o botão local do atuador funcionou o tempo todo.
- [ ] Trocar a senha do Wi-Fi: reconfiguro pelo portal, sem regravar.
- [ ] Tensão de bateria reportada confere com o multímetro (± 0,05 V).
- [ ] Atualização OTA do atuador concluída com sucesso.

<details>
<summary>Dica 1 — medir a bateria</summary>

Divisor resistivo de valor alto (por exemplo, 2 × 220k) para o ADC, com 100 nF em paralelo ao resistor de baixo. O divisor consome corrente o tempo todo: calcule quanto. Calibre com o multímetro.
</details>

<details>
<summary>Dica 2 — a placa de desenvolvimento gasta demais dormindo</summary>

Regulador, LED de alimentação e conversor USB-serial ficam ligados. Caminhos: escolher uma placa feita para bateria; alimentar direto no pino 3V3 com um LDO de baixa corrente quiescente (HT7333, MCP1700); ou aceitar e dimensionar. Meça antes de decidir. No módulo 6 você resolve de vez com placa própria.
</details>

<details>
<summary>Dica 3 — Wi-Fi ou ESP-NOW no nó sensor</summary>

Associar ao Wi-Fi e ao broker leva segundos; ESP-NOW leva uma fração disso, mas pede um gateway sempre ligado (o nó atuador pode acumular essa função). Faça a conta de energia dos dois antes de escolher.
</details>

<details>
<summary>Dica 4 — robustez</summary>

Todo laço de espera tem tempo limite. Watchdog habilitado no nó atuador. Contador de reinícios e motivo do último reset (`esp_reset_reason()`) publicados em um tópico de diagnóstico.
</details>

### Versão mínima para avançar
Um nó sensor em deep sleep publicando por MQTT, Mosquitto no PC com um script que grava o histórico, e o orçamento de energia calculado e medido. Sem portal, OTA, nó atuador nem painel. Teste de 48 h em vez de 7 dias.

### Chefão (opcional)
- **Rede endurecida:** aplique o lab 10 à rede inteira: usuário, senha e permissões por nó, TLS com verificação de certificado, OTA protegido. Nenhuma porta aberta para a internet.
- **Refaça um nó em [ESPHome](https://esphome.io/)** (configuração em YAML). Compare: o que ficou mais fácil, o que você perdeu de controle?
- **Controle e telemetria sem fio do robô** do módulo 4, com painel web por WebSocket.
- **Pocket AI etapas 2 e 3:** servidor próprio e integrações. O nó atuador desta rede vira um dispositivo controlável por voz.

## Checkpoint

- [ ] Escolhe pinos do ESP32-S3 sem cair em strapping, flash ou PSRAM.
- [ ] Escreve firmware conectado que se recupera sozinho de qualquer queda.
- [ ] Faz e valida um orçamento de energia.
- [ ] Usa tarefas e filas do FreeRTOS sem medo.
