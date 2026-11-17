# Lista de compras e orçamento

Tudo o que a trilha e o Pocket AI pedem, em 7 pedidos na ordem de compra. A mesma lista está em [`compras.csv`](compras.csv), com uma coluna `ja_tenho` para você preencher.

## Como ler os preços

- **pesquisado:** faixa que encontrei em lojas e marketplaces brasileiros em 16/11/2026. São anúncios, sem frete, e mudam.
- **estimativa:** não achei preço em reais na pesquisa; o valor é estimativa minha, para dar ordem de grandeza. Confira antes de contar com ele.
- O mínimo costuma ser marketplace ou importado; o máximo, loja nacional com nota e entrega rápida.
- Preço unitário. O subtotal já multiplica pela quantidade.

## Resumo

| Pedido | Para quê | Mínimo (R$) | Máximo (R$) |
|---|---|---|---|
| 1 | Agora: bancada, solda e Pocket AI etapa 1 | 628 | 1.650 |
| 2 | Kit base: módulos 1 e 2 | 114 | 250 |
| 3 | Módulo 3: sensores e barramentos | 162 | 436 |
| 4 | Módulo 4: potência e movimento | 279 | 630 |
| 5 | Módulo 5: ESP32 e IoT | 35 | 84 |
| 6 | Módulo 6 e Pocket AI etapa 4 | 286 | 819 |
| 7 | Módulo 9: campo e indústria | 278 | 644 |
| | **Total** | **1.782** | **4.513** |

Mais da metade do pedido 1 é ferramenta (multímetro e estação de solda), que você compra uma vez. Você já tem Arduino Uno, HC-SR04, LEDs, buzzer, uma protoboard e jumpers macho-macho; eles não estão na lista.

Para gastar menos: comece pelos pedidos 1 e 2, e só faça os seguintes quando chegar ao módulo anterior. Os pedidos 4 e 7 são os que mais dependem do rumo que você escolher.

## Pedido 1 — Agora: bancada, solda e Pocket AI etapa 1

Faça já. Cobre o módulo 0, o atalho do Pocket AI e os labs de ESP32.

| ☐ | Qtd | Item | Especificação | Unitário (R$) | Fonte | Observação |
|---|---|---|---|---|---|---|
| ☐ | 1 | Multímetro digital | Continuidade com bipe, mA/µA, teste de diodo | 35–280 | pesquisado | Básico sem autorange perto de R$ 35; autorange true RMS perto de R$ 280. |
| ☐ | 2 | Protoboard 830 pontos |  | 13–20 | pesquisado | Você já tem uma; com estas ficam três. |
| ☐ | 1 | Kit de jumpers | 40 macho-fêmea + 40 fêmea-fêmea | 10–25 | estimativa |  |
| ☐ | 1 | Fio rígido 22 AWG | Kit com várias cores | 15–35 | estimativa |  |
| ☐ | 1 | Alicate de corte rente + descascador |  | 25–70 | estimativa |  |
| ☐ | 1 | Pinça de ponta fina |  | 8–20 | estimativa |  |
| ☐ | 1 | Estação de solda com controle de temperatura | 60 W, 200–480 °C | 150–270 | pesquisado | Hikari HK-936A a R$ 265; o piso é estimativa para genéricas. |
| ☐ | 1 | Solda em fio | 0,5–0,8 mm, com fluxo, 60/40 | 20–45 | estimativa |  |
| ☐ | 1 | Fluxo de solda | Pasta ou caneta | 10–30 | estimativa |  |
| ☐ | 1 | Sugador + malha dessoldadora |  | 20–40 | estimativa |  |
| ☐ | 1 | Suporte, esponja metálica e terceira mão |  | 30–70 | estimativa |  |
| ☐ | 1 | Óculos de proteção |  | 10–25 | estimativa |  |
| ☐ | 2 | ESP32-S3-DevKitC-1 N16R8 | 16 MB flash, 8 MB PSRAM | 79–194 | pesquisado | Uma para o Pocket AI, outra para os labs e para ESP-NOW. |
| ☐ | 1 | Microfone INMP441 | I2S | 20–45 | estimativa |  |
| ☐ | 1 | Amplificador MAX98357A | I2S, 3 W | 20–45 | estimativa |  |
| ☐ | 1 | Alto-falante | 8 Ω, 2–3 W, 28–40 mm | 10–25 | estimativa |  |
| ☐ | 2 | Tela OLED SSD1306 0,96" | I2C, 4 pinos, 128x64 | 23–81 | pesquisado | Uma fica no Pocket AI, outra na trilha. |
| ☐ | 1 | Cabo USB-C de dados |  | 15–35 | estimativa | Cabo só de carga não grava. |

**Subtotal do pedido 1: R$ 628 a R$ 1.650**

## Pedido 2 — Kit base: módulos 1 e 2

Compre junto com o pedido 1 se quiser começar a trilha em paralelo ao Pocket AI.

| ☐ | Qtd | Item | Especificação | Unitário (R$) | Fonte | Observação |
|---|---|---|---|---|---|---|
| ☐ | 1 | Kit de componentes para Arduino, sem placa | Resistores, LEDs, botões, potenciômetros, LDR, buzzer | 60–120 | pesquisado | Confira o conteúdo; o que faltar, compre avulso abaixo. |
| ☐ | 1 | Kit de resistores 1/4 W | 10 Ω a 1 MΩ | 15–35 | estimativa |  |
| ☐ | 1 | Kit de capacitores | Cerâmicos (muitos de 100 nF) e eletrolíticos até 1000 µF | 20–45 | estimativa |  |
| ☐ | 1 | Transistores BC547 (10) e BC557 (5) |  | 5–12 | estimativa |  |
| ☐ | 1 | Diodos 1N4148 (10) e 1N4007 (10) |  | 4–10 | estimativa |  |
| ☐ | 2 | CI NE555 |  | 1,50–4 | estimativa |  |
| ☐ | 2 | CI LM358 |  | 1,50–4 | estimativa |  |
| ☐ | 2 | Trimpot 10k |  | 1–3 | estimativa |  |
| ☐ | 1 | CI 74HC595 |  | 2–6 | estimativa | Só para o chefão do módulo 2. |

**Subtotal do pedido 2: R$ 114 a R$ 250**

## Pedido 3 — Módulo 3: sensores e barramentos

Peça ao começar o módulo 2.

| ☐ | Qtd | Item | Especificação | Unitário (R$) | Fonte | Observação |
|---|---|---|---|---|---|---|
| ☐ | 1 | Analisador lógico USB | 8 canais, 24 MHz, compatível com sigrok | 50–120 | estimativa | Só achei preço em dólar (cerca de US$ 27 o da SparkFun). |
| ☐ | 1 | Sensor BME280 | I2C | 25–90 | pesquisado | Em loja nacional achei de R$ 76 a R$ 88; o piso é estimativa para importado. |
| ☐ | 1 | Sensor DS18B20 | Sonda à prova d'água | 13–30 | pesquisado |  |
| ☐ | 1 | MPU6050 (GY-521) |  | 16–45 | pesquisado |  |
| ☐ | 1 | RTC DS3231 | Com bateria | 20–52 | pesquisado |  |
| ☐ | 1 | Módulo micro SD | SPI | 8–33 | pesquisado |  |
| ☐ | 1 | Cartão micro SD | 8 a 32 GB | 20–40 | estimativa |  |
| ☐ | 1 | Encoder rotativo KY-040 |  | 8–18 | estimativa |  |
| ☐ | 2 | NTC 10k |  | 1–4 | estimativa |  |

**Subtotal do pedido 3: R$ 162 a R$ 436**

## Pedido 4 — Módulo 4: potência e movimento

Peça ao começar o módulo 3.

| ☐ | Qtd | Item | Especificação | Unitário (R$) | Fonte | Observação |
|---|---|---|---|---|---|---|
| ☐ | 1 | Kit chassi 2WD | 2 motores TT, rodas, discos de encoder | 40–90 | pesquisado |  |
| ☐ | 2 | Sensor óptico de encoder | Tipo fenda, com LM393 | 8–18 | estimativa |  |
| ☐ | 1 | Driver TB6612FNG |  | 20–45 | estimativa |  |
| ☐ | 1 | Driver L298N |  | 15–30 | estimativa | Só para comparar no lab 3. |
| ☐ | 3 | MOSFET IRLZ44N | Nível lógico | 5–12 | estimativa | Não é o IRFZ44N. |
| ☐ | 2 | Servo SG90 |  | 12–25 | estimativa |  |
| ☐ | 1 | Motor de passo 28BYJ-48 + ULN2003 |  | 18–35 | estimativa |  |
| ☐ | 1 | Módulo relé 1 canal 5 V + relé 5 V avulso |  | 10–22 | estimativa |  |
| ☐ | 1 | INA219 | Medidor de corrente I2C | 15–35 | estimativa |  |
| ☐ | 1 | Módulo de sensores de linha | TCRT5000, 5 canais | 15–45 | estimativa | Fase C do desafio. |
| ☐ | 1 | Suporte 2x18650 + 2 células com proteção |  | 50–110 | estimativa |  |
| ☐ | 1 | Carregador de células 18650 |  | 25–60 | estimativa |  |
| ☐ | 2 | Conversor buck ajustável | LM2596 ou MP1584 | 8–18 | estimativa |  |

**Subtotal do pedido 4: R$ 279 a R$ 630**

## Pedido 5 — Módulo 5: ESP32 e IoT

Quase tudo já veio no pedido 1.

| ☐ | Qtd | Item | Especificação | Unitário (R$) | Fonte | Observação |
|---|---|---|---|---|---|---|
| ☐ | 2 | Conversor de nível lógico bidirecional | 4 canais | 5–12 | estimativa |  |
| ☐ | 1 | Medidor USB de tensão e corrente |  | 25–60 | estimativa | Opcional; o INA219 resolve. |

**Subtotal do pedido 5: R$ 35 a R$ 84**

## Pedido 6 — Módulo 6 e Pocket AI etapa 4

Peça ao começar o módulo 5.

| ☐ | Qtd | Item | Especificação | Unitário (R$) | Fonte | Observação |
|---|---|---|---|---|---|---|
| ☐ | 1 | Bateria LiPo com proteção | 3,7 V, 1000–1500 mAh | 30–70 | estimativa |  |
| ☐ | 2 | Carregador TP4056 USB-C com proteção | Com pinos OUT+ e OUT− | 5–12 | estimativa |  |
| ☐ | 2 | Elevador de tensão MT3608 |  | 6–14 | estimativa |  |
| ☐ | 3 | Regulador LDO 3,3 V de baixa queda | HT7333 ou MCP1700-3.3 | 2–6 | estimativa |  |
| ☐ | 3 | Chave deslizante | SS12D00 | 1–3 | estimativa |  |
| ☐ | 3 | Placa perfurada | 5x7 cm | 5–15 | estimativa |  |
| ☐ | 1 | Barras de pinos macho e fêmea | Sortidas | 10–25 | estimativa |  |
| ☐ | 1 | Paquímetro digital | 150 mm | 40–100 | estimativa | Para footprint e caixa. |
| ☐ | 1 | Pedido de PCB | 5 placas, 2 camadas, com frete e imposto | 80–250 | estimativa |  |
| ☐ | 1 | Componentes da sua PCB | Depende do projeto | 50–150 | estimativa |  |
| ☐ | 1 | Impressão 3D da caixa | Serviço ou espaço maker | 30–100 | estimativa | Zero se tiver acesso a uma impressora. |

**Subtotal do pedido 6: R$ 286 a R$ 819**

## Pedido 7 — Módulo 9: campo e indústria

Peça ao começar o módulo 6.

| ☐ | Qtd | Item | Especificação | Unitário (R$) | Fonte | Observação |
|---|---|---|---|---|---|---|
| ☐ | 2 | Módulo conversor RS-485 | Um de 5 V (MAX485) e um de 3,3 V (MAX3485/SP3485) | 6–15 | estimativa |  |
| ☐ | 1 | Adaptador USB–RS-485 |  | 15–40 | estimativa |  |
| ☐ | 1 | Sensor de temperatura e umidade Modbus RTU | RS-485, tipo XY-MD02 | 40–90 | estimativa |  |
| ☐ | 1 | Optoacopladores PC817 | Pacote com 10 | 5–12 | estimativa |  |
| ☐ | 2 | CI ULN2003 |  | 2–5 | estimativa |  |
| ☐ | 2 | CI LM317 |  | 2–6 | estimativa | Fonte de corrente do lab de 4–20 mA. |
| ☐ | 1 | Fonte 24 V 1 A | De preferência para trilho DIN | 35–80 | estimativa |  |
| ☐ | 1 | Relé de interface 24 Vcc com base | Para trilho DIN | 30–70 | estimativa |  |
| ☐ | 1 | Kit de proteção | Fusíveis e porta-fusível, PTC, TVS SMBJ, MOSFET P | 20–40 | estimativa |  |
| ☐ | 1 | Sensor magnético de porta (reed) |  | 8–20 | estimativa |  |
| ☐ | 1 | Sinaleiro ou sirene 24 V |  | 25–60 | estimativa |  |
| ☐ | 1 | Caixa IP65 com trilho DIN, bornes, prensa-cabos e ilhós |  | 80–180 | estimativa |  |

**Subtotal do pedido 7: R$ 278 a R$ 644**

## Fontes dos preços pesquisados

- ESP32-S3 N16R8: [Saravati](https://www.saravati.com.br/placa-de-desenvolvimento-esp32-s3-uno-wroom-1-n16r8.html), [Eletrônica System](https://www.eletronicasystem.com.br/produto/modulo-placa-esp32-s3-n16r8-placa-de-desenvolvimento-esp32-s3), [Mercado Livre](https://lista.mercadolivre.com.br/esp32s3-n16r8).
- MPU6050: [Vida de Silício](https://vidadesilicio.com.br/produto/modulo-gy-521-acelerometro-giroscopio/), [Saravati](https://www.saravati.com.br/modulo-acelerometro-e-giroscopio-3-eixos-mpu-6050-gy-521.html), [Ryndack](https://www.ryndackcomponentes.com.br/modulo-acelerometro-e-giroscopio-mpu6050-gy-521.html).
- Chassi 2WD: [Eletrogate](https://www.eletrogate.com/kit-chassi-2wd-robo-para-arduino), [A2 Robotics](https://www.a2robotics.com.br/kit-chassi-2wd-robo-arduino), [RS Robótica](https://www.rsrobotica.com.br/kit-chassi-robo-2wd-para-arduino).
- Protoboard e multímetro: [Eletrogate](https://www.eletrogate.com/protoboard-830-pontos), [AutoCore](https://www.autocorerobotica.com.br/multimetro-digital-dt-830d), [KMA Brasil](https://www.kmabrasil.com.br/categoria/instrumentos/capacimetros).
- Estação de solda: [Loja do Mecânico](https://www.lojadomecanico.com.br/produto/104821/19/193/estacao-de-solda-analogica-60w-110v-hikari-hk936a).
- Kits de componentes: [RoboCore](https://www.robocore.net/loja/kits).
- OLED, BME280, DS3231, micro SD, DS18B20: páginas de busca do [Magazine Luiza](https://www.magazineluiza.com.br/), que misturam vendedores e variam muito.
