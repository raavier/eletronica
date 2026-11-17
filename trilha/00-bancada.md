# Módulo 0 — Bancada

Objetivo: ter as ferramentas certas, saber o que comprar e quando, e não queimar nada (nem você).

A lista consolidada, com quantidades, faixa de preço e ordem dos pedidos, está em [compras.md](compras.md) (e em `compras.csv`). As tabelas abaixo explicam para que serve cada item.

## Ferramentas

### Agora (módulos 1 a 3)

| Item | Especificação | Observação |
|---|---|---|
| Multímetro digital | Com continuidade (bipe), mA/µA e teste de diodo | A ferramenta mais usada da trilha. Autorange ajuda. |
| Protoboard 830 pontos | 2 unidades | |
| Jumpers | Macho-macho, macho-fêmea, fêmea-fêmea | |
| Fio rígido 22 AWG | Algumas cores | Deixa a protoboard legível; jumper comprido vira ninho. |
| Alicate de corte rente e descascador | | |
| Pinça | Ponta fina | |

### Módulo 3

| Item | Especificação | Observação |
|---|---|---|
| Analisador lógico USB | 8 canais, 24 MHz (clone genérico, compatível com sigrok) | Barato e muda o jogo: você passa a *ver* I2C, SPI e UART. Só sinais de 0 a 5 V. |

### Módulo 4

| Item | Especificação | Observação |
|---|---|---|
| Fonte para cargas | Suporte 2x18650 ou 4–6 pilhas AA, ou fonte 5 V / 12 V de 2 A | Motor nunca é alimentado pelo Arduino. |
| Conversor buck ajustável | LM2596 ou MP1584 | |
| Medidor USB (opcional) | Tensão/corrente em linha | Útil para ver consumo sem abrir o circuito. |

### Solda (compre antes do módulo 3)

Vários módulos dos módulos 3 a 5 (BME280, MPU6050, INMP441, TB6612 e outros) chegam com a barra de pinos solta. Você vai soldar pinos bem antes de chegar ao módulo 6.

| Item | Especificação | Observação |
|---|---|---|
| Ferro de solda com controle de temperatura | Estação simples ou ferro tipo TS101/Pinecil | Ferro sem controle estraga placa e paciência. |
| Solda | 0,5 a 0,8 mm, com fluxo, 60/40 ou 63/37 | Com chumbo é mais fácil para aprender. Ventile e lave as mãos. |
| Fluxo em pasta ou caneta | | Resolve 80% das soldas feias. |
| Sugador e malha dessoldadora | | |
| Suporte, esponja metálica, terceira mão | | |
| Óculos de proteção | | Respingo de solda e terminal cortado voam. |

### Mais tarde, se pegar gosto

- **Fonte de bancada** com limite de corrente (o limite salva componentes em primeiro teste).
- **Osciloscópio**. Até o módulo 5 o analisador lógico e o multímetro bastam. Vira necessário em analógico, fontes chaveadas e áudio.

## Componentes

### Kit base (módulos 1 e 2)

| Qtd | Item | Observação |
|---|---|---|
| 1 | Arduino Uno | Você já tem. |
| 1 | Kit de resistores 1/4 W | Faixa de 10 Ω a 1 MΩ. Os mais usados: 220, 330, 1k, 4,7k, 10k, 100k. |
| 1 | Kit de capacitores cerâmicos | Inclua bastante 100 nF. |
| 1 | Kit de eletrolíticos | 1, 10, 100, 470, 1000 µF, 16 V ou mais. |
| 20 | LEDs 5 mm | Vermelho, verde, amarelo, azul, branco. |
| 10 | Botões tácteis 6x6 mm | |
| 3 | Potenciômetros 10k | Lineares. Mais 2 trimpots 10k. |
| 2 | LDR | 5 mm. |
| 10 | Transistor NPN BC547 (ou 2N2222) | |
| 5 | Transistor PNP BC557 | |
| 10 | Diodo 1N4148 e 10 de 1N4007 | |
| 2 | CI 555 (NE555) | |
| 2 | CI LM358 | Amp-op duplo, funciona com 5 V. |
| 1 | Buzzer passivo e 1 ativo | |
| 1 | CI 74HC595 | Para o extra do módulo 2. |

Kits "Arduino iniciante" costumam cobrir boa parte disso. Confira a lista antes de comprar peças avulsas.

### Módulo 3

| Qtd | Item | Observação |
|---|---|---|
| 1 | OLED SSD1306 0,96" I2C (4 pinos) | Você vai comprar para o Pocket AI; compre 2. |
| 1 | BME280 (temperatura, umidade, pressão) | Muito vendedor entrega BMP280 (sem umidade) com o nome errado. O lab 3 ensina a conferir. |
| 1 | DS18B20 | Versão à prova d'água é útil. |
| 1 | MPU6050 (GY-521) | |
| 1 | RTC DS3231 | Com bateria. |
| 1 | Módulo micro SD (SPI) + cartão | |
| 1 | Encoder rotativo KY-040 | |
| 1 | NTC 10k | |

### Módulo 4

| Qtd | Item | Observação |
|---|---|---|
| 1 | Kit chassi 2WD | Com 2 motores "TT" amarelos, rodas e discos de encoder. |
| 2 | Sensor óptico de encoder tipo fenda (LM393) | |
| 1 | Driver TB6612FNG | Prefira ao L298N. Tenha um L298N só para comparar no lab. |
| 3 | MOSFET N nível lógico: IRLZ44N | Não confunda com IRFZ44N, que não é nível lógico. |
| 2 | Servo SG90 | |
| 1 | Motor de passo 28BYJ-48 + ULN2003 | Ou NEMA17 + A4988 se quiser algo sério. |
| 1 | Módulo relé 1 canal 5 V | Mais 1 relé 5 V avulso para o lab. |
| 1 | INA219 | Medidor de corrente I2C. |
| 1 | Módulo de sensores de linha (TCRT5000, 3 a 5 canais) | Para a fase B do desafio. |

### Módulo 5

| Qtd | Item | Observação |
|---|---|---|
| 2 | ESP32-S3-DevKitC-1 N16R8 | Um já está na lista do Pocket AI. O segundo permite ESP-NOW e nó + base. Para nó a bateria, um ESP32-C3 SuperMini é mais barato e gasta menos. |
| 1 | INMP441 e MAX98357A + alto-falante | Já na lista do Pocket AI. |
| 2 | Conversor de nível lógico bidirecional | Para sensores de 5 V. |

### Módulo 6

Lista do bloco "Alimentação" do [Pocket AI](../pocket-ai/README.md) (LiPo com proteção, TP4056, MT3608), mais placas perfuradas, barras de pinos e um regulador LDO de baixa queda (HT7333 ou MCP1700-3.3).

## Onde comprar

Lojas brasileiras de eletrônica maker (MakerHero, Eletrogate, Baú da Eletrônica, RoboCore, Curto Circuito) entregam rápido e ajudam quando a peça vem errada. Marketplaces e importação saem mais baratos para kits e módulos, com prazo maior; inclua imposto de importação na conta. Componentes avulsos de qualidade (MOSFET, CI) valem a compra em loja especializada, porque falsificação existe.

## Segurança

- **Rede elétrica (127/220 V) fica fora da protoboard.** Toda a trilha roda em 12 V ou menos. Se um projeto pedir rede, use módulo relé ou tomada inteligente fechados, e nunca mexa energizado.
- **Lítio:** só células com proteção, nunca em curto, nunca carregue sem supervisão no começo, nunca perfure. Carregue sobre superfície não inflamável.
- **Eletrolítico invertido estoura.** Confira a faixa do negativo.
- **Desligue antes de mudar o circuito.** O hábito evita a maioria das queimas.
- **GND comum** entre tudo que conversa. É a causa nº 1 de "não funciona".
- **5 V em pino de 3,3 V mata** ESP32 e muitos sensores. Confira antes de ligar.
- **Solda:** óculos, ventilação, ferro sempre no suporte.

## Fluxo de trabalho

Você já usa `arduino-cli` com o `Makefile` da raiz. Comandos úteis extras:

```bash
~/.local/bin/arduino-cli lib search ssd1306           # procurar biblioteca
~/.local/bin/arduino-cli lib install "Adafruit SSD1306"
~/.local/bin/arduino-cli board details -b arduino:avr:uno
```

Para gráficos em tempo real, o `make monitor` não desenha. Opções: Serial Plotter da IDE Arduino, ou imprimir CSV e plotar com Python.

Em cada projeto-desafio, deixe um `README.md` na pasta do sketch com: esquema, tabela de pinos, medidas, e o que deu errado. Esse último item é o que você vai reler.

## Método de depuração

Quando algo não funciona, nesta ordem:

1. **Alimentação.** Meça VCC e GND no próprio componente, não na fonte.
2. **Ligações.** Continuidade fio a fio contra o esquema. Protoboards velhas têm mau contato; trilhas laterais às vezes são divididas no meio.
3. **Divida ao meio.** Teste cada bloco isolado com o menor sketch possível.
4. **Sinal.** Multímetro para níveis lentos, analisador lógico para barramentos.
5. **Datasheet.** Tensão de alimentação, pinagem (vista de cima ou de baixo?), endereço.
6. **Só então, o código.**

## Checkpoint

- [ ] Mede tensão, corrente (em série) e continuidade com o multímetro sem pensar.
- [ ] `make upload SKETCH=teste_blink` funciona.
- [ ] Sabe onde está o datasheet de cada componente do kit.
