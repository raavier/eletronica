# Pocket AI — assistente de voz de bolso

Guia de montagem: materiais, ligações, firmware e próximos passos.

Base do projeto: firmware open source **Xiaozhi** (`github.com/78/xiaozhi-esp32`), na montagem oficial de protoboard chamada `bread-compact-wifi`. Os pinos abaixo foram conferidos no `config.h` dessa placa em 16/11/2026 (release v2.6.0). Seguindo exatamente esses pinos, o firmware pronto funciona sem compilar nada.

## Visão geral

```
[Gadget ESP32-S3] ⇄ Wi-Fi ⇄ [Servidor]
  microfone                   ├─ fala → texto (pt-BR)
  alto-falante                ├─ LLM (Claude, Gemini...)
  tela com carinha            ├─ texto → fala (pt-BR)
  bateria + USB-C             └─ ferramentas: casa, PC, Spotify
```

O gadget só captura áudio, toca a resposta e desenha a carinha. Quem pensa é o servidor.

O projeto tem 4 etapas. Cada uma termina com algo funcionando:

| Etapa | O que você monta | Resultado |
|---|---|---|
| 1 | Eletrônica na protoboard + firmware pronto + servidor oficial xiaozhi.me | Conversa por voz funcionando |
| 2 | Servidor próprio no seu PC | Português bom, suas chaves de Claude/Gemini, personalidade bem-humorada |
| 3 | Integrações | Controle da casa, do PC e do Spotify por voz |
| 4 | Bateria + montagem final soldada | Aparelho de bolso |

---

## Materiais

### Eletrônica principal (etapa 1)

| Qtd | Item | Especificação | Observação |
|---|---|---|---|
| 1 | Placa ESP32-S3 | **ESP32-S3-DevKitC-1 N16R8** (16 MB flash, 8 MB PSRAM) | Não use ESP32-C3 como no vídeo: sem PSRAM não há palavra de ativação nem folga para áudio. |
| 1 | Microfone digital | **INMP441** (I2S) | |
| 1 | Amplificador | **MAX98357A** (I2S, 3 W) | |
| 1 | Alto-falante | 8 Ω, 2 a 3 W, ~28 a 40 mm | 4 Ω 3 W também serve. |
| 1 | Tela OLED | **SSD1306 0,96" 128x64, I2C, 4 pinos** | Confira que é I2C (4 pinos), não SPI (7 pinos). |
| 2 | Botão táctil 6x6 mm | Opcional: volume + e − | O botão BOOT da placa já serve para falar. |
| 1 | Jogo de jumpers | 20 macho-fêmea + 20 fêmea-fêmea | Você já tem macho-macho. |
| 1 | Protoboard 830 pontos | Segunda unidade | A placa S3 é larga e cobre quase toda a largura de uma protoboard; com duas lado a lado sobram furos dos dois lados. |
| 1 | Cabo USB-C de dados | | Cabo "só de carga" não grava firmware. |

### Alimentação (etapa 4)

| Qtd | Item | Especificação | Observação |
|---|---|---|---|
| 1 | Bateria LiPo | 3,7 V, 1000 a 1500 mAh, **com circuito de proteção** | Autonomia estimada: 6 a 10 h (estimativa, depende do uso). |
| 1 | Carregador | **TP4056 USB-C com proteção** (versão com pinos OUT+ / OUT−) | |
| 1 | Elevador de tensão | **MT3608** (step-up ajustável) | Ajustado para 5,0 V. |
| 1 | Chave liga/desliga | Deslizante SS12D00 ou similar | |
| 1 | Placa perfurada | ~5x7 cm | Para a versão final soldada. |
| — | Fio fino | 26 a 30 AWG, algumas cores | |

### Ferramentas

| Item | Para quê |
|---|---|
| Ferro de solda + estanho | INMP441 e MAX98357A costumam vir com os pinos soltos: precisa soldar antes de usar na protoboard. |
| Multímetro | Ajustar o MT3608 em 5,0 V **antes** de ligar na placa. Obrigatório na etapa 4. |
| Alicate de corte / desencapador | Montagem final. |

---

## Ligações

Desligue o USB antes de mexer em qualquer fio.

### Microfone INMP441

| Pino do INMP441 | Liga em |
|---|---|
| VDD | 3V3 |
| GND | GND |
| L/R | GND |
| WS | GPIO 4 |
| SCK | GPIO 5 |
| SD | GPIO 6 |

### Amplificador MAX98357A

| Pino do MAX98357A | Liga em |
|---|---|
| VIN | 5V (pino 5V da placa) |
| GND | GND |
| DIN | GPIO 7 |
| BCLK | GPIO 15 |
| LRC | GPIO 16 |
| SD | não ligar |
| GAIN | não ligar |
| Bornes + e − | os dois fios do alto-falante |

### Tela OLED SSD1306

| Pino da tela | Liga em |
|---|---|
| VCC | 3V3 |
| GND | GND |
| SDA | GPIO 41 |
| SCL | GPIO 42 |

A ordem dos pinos VCC/GND muda entre fabricantes. Leia a serigrafia da sua tela, não copie a posição de uma foto.

### Botões (opcionais)

| Botão | Liga entre |
|---|---|
| Volume + | GPIO 40 e GND |
| Volume − | GPIO 39 e GND |
| Toque/falar extra | GPIO 47 e GND |

Não precisa de resistor: o firmware usa o pull-up interno.

### Alimentação com bateria (só na etapa 4)

```
Bateria +  → TP4056 B+
Bateria −  → TP4056 B−
TP4056 OUT+ → chave → MT3608 VIN+
TP4056 OUT− → MT3608 VIN−
MT3608 VOUT+ → pino 5V da placa
MT3608 VOUT− → GND da placa
```

Ordem obrigatória:

1. Ligue bateria, TP4056, chave e MT3608, **sem** conectar na placa.
2. Meça VOUT do MT3608 com o multímetro e gire o trimpot até dar 5,0 V. De fábrica ele pode sair com mais de 20 V, o que queima a placa.
3. Só então ligue VOUT no pino 5V.

Carregar: cabo USB-C no TP4056. O aparelho pode ficar ligado enquanto carrega.

Cuidados:

- Desligue a chave da bateria antes de plugar o USB da placa no PC para gravar firmware.
- LiPo não pode ser furada, amassada nem entrar em curto. Isole os terminais e nunca solde com os fios da bateria se tocando.

---

## Montagem, passo a passo

### Etapa 1 — protoboard

1. Solde as barras de pinos no INMP441 e no MAX98357A, e os fios no alto-falante.
2. Encaixe a ESP32-S3 na junção das duas protoboards.
3. Ligue **só a tela** (4 fios). Grave o firmware (seção abaixo). A tela deve acender. Se acender, a base está certa.
4. Desligue o USB. Ligue o amplificador e o alto-falante. Religue: deve tocar um som ao iniciar.
5. Desligue o USB. Ligue o microfone. Religue.
6. Configure o Wi-Fi e teste a conversa.

Ligar um módulo por vez facilita achar o erro: se algo parar, o problema está no último que entrou.

### Etapa 4 — versão de bolso

1. Com tudo funcionando na protoboard, transfira para a placa perfurada com fios curtos soldados.
2. Monte o bloco de alimentação e ajuste os 5,0 V como descrito acima.
3. Empilhe: bateria atrás, placa no meio, tela e microfone na frente, alto-falante voltado para fora.
4. O microfone tem um furo pequeno na placa: ele não pode ficar tampado nem encostado no alto-falante.
5. Caixa: impressão 3D, ou a moldura de fio de latão do vídeo (bem mais difícil, deixe para uma segunda versão).

---

## Firmware

1. Baixe na página de releases de `github.com/78/xiaozhi-esp32` o arquivo `v2.6.0_bread-compact-wifi-128x64.zip` (ou a versão mais nova com o mesmo nome) e descompacte.
2. Ligue a placa no PC pela porta USB marcada **UART** (ou **COM**).
3. Grave:

```bash
pip install esptool
ls /dev/ttyUSB* /dev/ttyACM*          # descobrir a porta
esptool.py --chip esp32s3 -p /dev/ttyUSB0 -b 460800 write_flash 0x0 merged-binary.bin
```

Use o nome do `.bin` que vier dentro do zip. Se a gravação não iniciar, segure BOOT, aperte RESET, solte BOOT e rode de novo.

O firmware pronto vem com interface em chinês. O repositório tem pt-BR (`main/assets/locales/pt-BR`), mas para tê-lo na tela e nos sons é preciso compilar com ESP-IDF escolhendo o idioma no `menuconfig`. Isso é só a interface: o idioma da conversa é definido pelo servidor. Fica para depois da etapa 1.

### Wi-Fi (casa e iPhone)

1. Na primeira vez o aparelho cria uma rede Wi-Fi própria (nome começando com `Xiaozhi`).
2. Conecte nela com o celular e abra `192.168.4.1`.
3. Escolha sua rede e digite a senha.

Para o hotspot do iPhone: ative **Ajustes → Acesso Pessoal → Maximizar Compatibilidade**. O ESP32 só enxerga Wi-Fi 2,4 GHz e sem essa opção ele não acha o iPhone. O firmware guarda mais de uma rede.

### Primeiro teste

Depois de conectar, a tela mostra um código de 6 dígitos. Crie uma conta em `xiaozhi.me`, adicione o dispositivo com esse código e escolha idioma e personalidade. Aperte BOOT e fale.

---

## Etapas 2 e 3 — resumo do que vem depois

Detalho estas quando a etapa 1 estiver funcionando; nada aqui muda a lista de compras.

**Etapa 2 — servidor próprio.** Roda no seu PC com Docker (`xiaozhi-esp32-server`). Nele você escolhe o reconhecimento de fala em pt-BR, a voz em pt-BR, o modelo (Claude, Gemini etc.) e escreve a personalidade.

- Precisa de **chaves de API** (cobrança por uso). Assinaturas tipo Claude Pro/Max ou Gemini Advanced não servem para isso.
- Fora de casa, pelo iPhone, o aparelho só alcança o servidor se ele estiver acessível pela internet (VPS ou túnel).

**Etapa 3 — integrações.**

| Quer controlar | Como |
|---|---|
| Casa | Home Assistant, que o servidor chama como ferramenta. Depende de quais dispositivos você tem. |
| PC | Um pequeno programa no PC que expõe comandos (volume, abrir apps, bloquear tela, scripts) como ferramentas MCP. |
| Spotify | Controle por voz (tocar, pausar, escolher playlist) em qualquer aparelho seu, via API do Spotify. Exige Premium. |

Sobre tocar Spotify **no próprio gadget**: é a parte mais difícil. Existe um projeto (cspot) que transforma o ESP32-S3 em caixa Spotify Connect, mas não convive facilmente com o firmware do assistente, e um alto-falante de 3 cm tem som de rádio de pilha. O caminho realista é o gadget comandar o Spotify que toca em outra caixa.

---

## Se algo não funcionar

| Sintoma | Verifique |
|---|---|
| Tela apagada | SDA/SCL trocados; VCC/GND invertidos; tela SPI em vez de I2C. |
| Imagem deslocada ou com lixo na borda | A tela é SH1106 (comum nas de 1,3"), não SSD1306. |
| Sem som | DIN/BCLK/LRC trocados; VIN do amplificador sem 5 V; fio do alto-falante solto. |
| Ele não te ouve | L/R do microfone sem ligar no GND; SD e WS trocados; solda fria nos pinos. |
| Não acha o Wi-Fi | Rede só em 5 GHz; no iPhone, falta "Maximizar Compatibilidade". |
| PC não vê a placa | Cabo só de carga; porta USB errada na placa. |
| Reinicia ao falar | Alimentação fraca: troque o cabo/porta USB ou confira os 5,0 V do MT3608. |
