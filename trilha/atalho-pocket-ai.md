# Atalho — Pocket AI funcionando em poucas semanas

A trilha completa leva o Pocket AI para depois do módulo 3. Este atalho pega só o que a **etapa 1** dele exige (conversa por voz na protoboard) e deixa o resto para depois.

Serve se o Pocket AI é o que te motiva. Você monta o gadget primeiro e volta à trilha sabendo para que serve cada módulo.

Tempo: dois ou três fins de semana depois que as peças chegarem (estimativa minha).

## O que você pula, e o que isso custa

| Pula por enquanto | Consequência |
|---|---|
| Módulo 1 (circuitos sem código) | Nenhuma para a etapa 1: você só interliga módulos prontos. |
| Módulo 2 (firmware) | Nenhuma: o firmware vem pronto. |
| Resto do módulo 3 e módulo 5 | Se algo não funcionar, você depura com menos ferramentas. Os testes abaixo compensam isso. |

As etapas 2 a 4 do Pocket AI continuam pedindo os módulos 5 e 6.

## Passo a passo

### 0. Compre
Pedido 1 de [compras.md](compras.md). Enquanto não chega, leia o [módulo 0](00-bancada.md) e simule um OLED em ESP32-S3 no [Wokwi](https://wokwi.com/).

### 1. Solde os pinos (1 a 2 h)
INMP441 e MAX98357A chegam com os pinos soltos. Siga a seção "Antes de começar" do [módulo 3](03-sensores-e-barramentos.md). Treine em sucata primeiro: o INMP441 é pequeno e não gosta de calor demorado.

**Pronto quando:** juntas brilhantes, sem ponte entre pinos vizinhos (confira com o bipe do multímetro).

### 2. Prove a placa (30 min)
"Preparação" e Lab 1 do [módulo 5](05-esp32-e-iot.md): instale o suporte ao ESP32 e grave um blink.

**Pronto quando:** o LED da placa pisca. Isso valida cabo, porta USB e gravação, antes de haver qualquer fio.

### 3. Prove a tela (1 h)
Ligue só a tela, nos pinos do Pocket AI: SDA no GPIO 41, SCL no GPIO 42, alimentação em 3V3.

1. Rode um scanner I2C com `Wire.begin(41, 42)`. Deve aparecer `0x3C`.
2. Escreva um texto na tela.

**Pronto quando:** o texto aparece. Se o scanner não achar nada, o problema é fio ou solda, e você descobriu isso com um sketch de 20 linhas.

### 4. Prove o áudio (2 a 3 h)
Lab 9 do [módulo 5](05-esp32-e-iot.md), itens 1 e 2, com os pinos do Pocket AI:

| Módulo | Pino | GPIO |
|---|---|---|
| INMP441 | WS | 4 |
| INMP441 | SCK | 5 |
| INMP441 | SD | 6 |
| INMP441 | L/R | GND |
| MAX98357A | DIN | 7 |
| MAX98357A | BCLK | 15 |
| MAX98357A | LRC | 16 |
| MAX98357A | VIN | 5V |

1. Microfone: imprima o nível do sinal na serial. Fale e bata palma; o número precisa reagir.
2. Amplificador: toque um tom de 440 Hz.

No core Arduino-ESP32 3.x a biblioteca de áudio é a `ESP_I2S`. Muitos tutoriais usam a interface antiga (`driver/i2s.h`); se o exemplo não compilar, é por isso.

**Pronto quando:** o nível reage à sua voz e o tom sai limpo. Agora todo o hardware está validado peça por peça.

### 5. Grave o firmware e converse
Siga a partir de "Firmware" no [README do Pocket AI](../pocket-ai/README.md). As ligações já estão feitas e testadas.

**Pronto quando:** você aperta BOOT, fala e ele responde.

## Se travar

Cada passo isola uma parte. O defeito está na última coisa que entrou:

| Travou no passo | Olhe |
|---|---|
| 2 | Cabo só de carga; porta USB errada na placa; segurar BOOT ao gravar. |
| 3 | SDA/SCL trocados; VCC e GND em ordem diferente da foto; tela SPI em vez de I2C. |
| 4, microfone | L/R sem ligar ao GND; solda fria; WS e SD trocados. |
| 4, alto-falante | VIN sem 5 V; DIN/BCLK/LRC trocados. |
| 5 | Tabela "Se algo não funcionar" do README do Pocket AI. |

## Depois

Volte ao [módulo 1](01-circuitos-sem-codigo.md) e siga a trilha. Quando chegar ao módulo 5 você vai reconhecer, no firmware do Pocket AI, o Wi-Fi, o portal de configuração e o I2S que já usou sem entender.
