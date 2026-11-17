# Módulo 9 — Campo e indústria

Objetivo: fazer eletrônica que sobrevive fora da bancada. Sinais de 24 V, 4–20 mA e RS-485, cabos longos, ruído, caixa fechada, falta de rede, e cargas ligadas na rede elétrica acionadas com segurança.

É a ponte entre a trilha e o modelo "automação para pequenos negócios" do [módulo 8](08-ganhar-dinheiro.md). Faça depois do módulo 6 e **antes de instalar qualquer coisa em um cliente**.

## A regra que organiza tudo

**Sua eletrônica fica em extra-baixa tensão (até 24 V). A rede elétrica fica em componentes comprados prontos e certificados.**

| Fica com você | Compra pronto |
|---|---|
| Sensores, lógica, comunicação, firmware | Fonte para trilho DIN, disjuntor, contatora, relé de interface, relé de estado sólido |
| Saída de 24 V que aciona a bobina de um relé | O contato do relé, que chaveia a carga em 127/220 V |

Assim, nenhuma trilha da sua placa carrega tensão de rede, e o que separa os dois mundos é um componente projetado e ensaiado para isso.

## Teoria mínima

### Entradas e saídas de campo

| Assunto | Regra de bolso |
|---|---|
| Isolação | Entre o campo e o microcontrolador, um optoacoplador ou relé. Os dois lados não compartilham GND. |
| Entrada digital de 24 V | Resistor em série com o LED do optoacoplador (PC817): `R = (24 − 1,2) / 5 mA ≈ 4,7 kΩ`. Saída do opto com pull-up para 3,3 V. |
| Saída para bobina de 24 V | Transistor ou ULN2003 (já tem os diodos internos) acionando relé de interface ou contatora. |
| Contatora x relé de estado sólido | Contatora para motores e cargas indutivas. Estado sólido para resistências e chaveamento frequente, e ele esquenta: cerca de 1 W por ampère, precisa de dissipador. |
| Categoria do contato | A corrente nominal vale para carga resistiva. Motor exige categoria própria (AC-3) e corrente de partida várias vezes maior. |

### Sinais analógicos industriais

| Assunto | Regra de bolso |
|---|---|
| 4–20 mA | Corrente não cai com o comprimento do cabo. Leia com resistor shunt: 150 Ω dá 0,6 a 3,0 V, bom para ADC de 3,3 V. |
| Zero vivo | 4 mA é o zero da medida. Abaixo de ~3,6 mA significa cabo rompido ou sensor morto: detecte e alarme. |
| Sensor a 2 fios | Alimentado pelo próprio laço: +24 V → sensor → shunt → GND. |
| 0–10 V | Divisor resistivo para a faixa do ADC, mais um diodo de grampeamento. Sofre com cabo longo; prefira 4–20 mA. |

### RS-485 e Modbus

| Assunto | Regra de bolso |
|---|---|
| RS-485 | Par diferencial A/B, par trançado, até centenas de metros. Vários dispositivos no mesmo par. |
| Topologia | Em linha (um após o outro), nunca em estrela. Terminação de 120 Ω nas duas pontas. |
| Conversor | Entre a UART do microcontrolador e o barramento. MAX485 é de 5 V; para ESP32 use versão de 3,3 V (MAX3485, SP3485). Um pino controla transmissão/recepção. |
| Referência | Leve também um fio de referência (GND) entre os equipamentos, ou use conversor isolado. |
| Modbus RTU | Um mestre pergunta, escravos respondem. Endereço de 1 a 247. Dados em registradores de 16 bits. Padrão comum: 9600 8N1. |
| Funções mais usadas | 03 lê registradores de retenção, 04 lê registradores de entrada, 06 escreve um, 16 escreve vários. |
| Armadilhas | Numeração do manual (40001) x endereço real (0); ordem dos bytes em valores de 32 bits; A e B trocados entre fabricantes. |

### Proteção e robustez

| Assunto | Regra de bolso |
|---|---|
| Entrada de alimentação | Nesta ordem: fusível (ou PTC rearmável), proteção contra inversão (MOSFET P ou diodo), supressor TVS, capacitor. |
| Alimentação de 24 V | Fonte industrial varia e tem picos. Use conversor buck com folga de entrada (36 V ou mais). |
| Toda E/S que sai da caixa | Resistor em série e grampeamento (TVS ou zener). Cabo longo é antena e caminho de descarga. |
| Cabos | Sinal separado de potência. Blindagem aterrada em uma ponta só. Terminal ilhós em todo fio flexível que vai em borne. |
| Caixa | IP65 com prensa-cabos em ambiente úmido ou com lavagem. Entrada de cabos por baixo. Condensação existe: sensor de temperatura fora da caixa. |
| Firmware | Watchdog ligado. Motivo do último reset registrado. Todo laço de espera com tempo limite. |
| Sem rede | Guardar localmente e reenviar quando a conexão voltar. O alarme local nunca depende da rede. |
| Falta de energia | É o evento que o cliente mais quer saber. Precisa de reserva (bateria ou supercapacitor) para avisar. |

### Conectividade além do Wi-Fi

| Opção | Quando |
|---|---|
| Ethernet (módulo W5500 ou placa ESP32 com Ethernet) | Instalação fixa; a mais confiável. |
| Celular (LTE Cat-1, Cat-M, NB-IoT) | Sem internet no local. Evite módulos só 2G: confira com a operadora a situação da rede 2G na região antes de escolher. |
| LoRa ponto a ponto | Sítio, galpão distante, até um ponto com internet. |

### Hardware pronto

Para instalar em cliente, considere controladores com ESP32 feitos para trilho DIN (com relés, entradas isoladas e RS-485) no lugar de placa de desenvolvimento, e relés inteligentes comerciais com firmware aberto ([Tasmota](https://tasmota.github.io/docs/), [ESPHome](https://esphome.io/)) para chavear carga na rede. Seu trabalho passa a ser sensor, integração e firmware, e é o que tem valor.

## Rede elétrica: as regras

- **Projeto e execução de instalação elétrica têm responsabilidade técnica e normas próprias** (NBR 5410 para instalações de baixa tensão; [NR-10](https://www.gov.br/trabalho-e-emprego/pt-br/acesso-a-informacao/participacao-social/conselhos-e-orgaos-colegiados/comissao-tripartite-partitaria-permanente/normas-regulamentadora/normas-regulamentadoras-vigentes/norma-regulamentadora-no-10-nr-10) para quem trabalha com eletricidade). Em cliente, a parte de rede é feita por eletricista habilitado, com você entregando os contatos de 24 V.
- **Nunca em protoboard, nunca em placa perfurada.**
- Desenergizado, com disjuntor desligado e verificação de ausência de tensão antes de tocar.
- Disjuntor e dispositivo DR no circuito. Condutor de proteção (terra) em toda carcaça metálica.
- Dentro do quadro, separação física entre a parte de rede e a de extra-baixa tensão.
- Nada disso é necessário para os labs deste módulo: todos rodam em 24 V ou menos.

## Estudo

- [Fundamentos do laço de 4–20 mA](https://www.predig.com/indicatorpage/back-basics-fundamentals-4-20-ma-current-loops) — Precision Digital.
- [Modbus: perguntas frequentes](https://www.simplymodbus.ca/FAQ.htm) — Simply Modbus. A melhor explicação curta do protocolo, quadro a quadro.
- [Modbus com Arduino](https://docs.arduino.cc/learn/communication/modbus/) — documentação oficial.
- [Especificações Modbus](https://www.modbus.org/) — para consulta.
- Bibliotecas: [ModbusMaster](https://github.com/4-20ma/ModbusMaster) (mestre RTU simples) e [eModbus](https://github.com/eModbus/eModbus) (ESP32, RTU e TCP, mestre e escravo).
- [Modbus no ESPHome](https://esphome.io/components/modbus_controller.html) — para comparar com o que você escreveu à mão.
- [Circuitos de proteção contra inversão de polaridade](https://www.ti.com/lit/an/slva139/slva139.pdf) — TI.
- [Relé e carga na rede com ESP32](https://randomnerdtutorials.com/esp32-relay-module-ac-web-server/) — Random Nerd Tutorials. Leia pelos avisos e pelo esquema; não monte em protoboard.
- [Watchdogs no ESP32](https://docs.espressif.com/projects/esp-idf/en/stable/esp32/api-reference/system/wdts.html) — Espressif.
- [ESP32 com LTE (LilyGO T-SIM7000G)](https://randomnerdtutorials.com/lilygo-t-sim7000g-esp32-lte-gprs-gps/) e [LoRa](https://randomnerdtutorials.com/esp32-lora-rfm95-transceiver-arduino-ide/) — Random Nerd Tutorials.

## Labs

Todos em 24 V ou menos.

### Lab 1 — Entrada isolada de 24 V
1. Botão ligado a 24 V → resistor → PC817 → GPIO do ESP32 com pull-up.
2. Com o multímetro, confirme que **não há continuidade** entre o GND de 24 V e o GND do ESP32.
3. Qual a menor tensão de entrada que ainda é lida como "ligado"? Isso é bom ou ruim contra ruído?

### Lab 2 — Saída para relé de interface
1. GPIO → ULN2003 → bobina do relé de interface de 24 V. Carga: sinaleiro ou lâmpada de 24 V no contato.
2. Meça a corrente da bobina. Quantos relés o ULN2003 aguenta ao mesmo tempo?
3. Ao ligar a placa, o relé dá um pulso? Corrija (estado dos pinos no boot, pull-down).

### Lab 3 — Laço de 4–20 mA
1. Monte uma fonte de corrente com LM317 (`I = 1,25 / R`) e um potenciômetro, para variar de 4 a 20 mA. Calcule os resistores.
2. Leia com shunt de 150 Ω no ADC. Converta para "0 a 100%".
3. Abra o laço. Seu firmware distingue "0%" de "cabo rompido"?
4. Estique o laço com 10 m de fio. A leitura muda? Compare com um sinal de tensão no mesmo fio.

### Lab 4 — Modbus pelo PC
1. Adaptador USB–RS-485 ligado ao sensor Modbus. Leia temperatura e umidade com `mbpoll` ou um script Python (`pymodbus`).
2. Ache no manual do sensor o registrador de endereço e mude-o.
3. Capture a troca de quadros no lado TTL com o analisador lógico e decodifique: endereço, função, dados, CRC.

### Lab 5 — ESP32 como mestre e como escravo
1. ESP32 + conversor de 3,3 V lendo o sensor a cada 5 s.
2. Desligue o sensor: seu código acusa tempo esgotado e segue rodando?
3. Inverta os papéis: o ESP32 vira **escravo** e expõe uma leitura sua em um registrador; o PC lê.

### Lab 6 — Proteção de entrada
1. Monte na placa perfurada: fusível → MOSFET P contra inversão → TVS → buck → 3,3 V.
2. Com fonte limitada em corrente, inverta a polaridade de propósito. Nada deve esquentar.
3. Meça a queda no MOSFET em corrente nominal e compare com a de um diodo.

### Lab 7 — Guardar e reenviar
1. Leituras gravadas em arquivo (LittleFS) quando o broker não responde.
2. Ao reconectar, envie as pendentes em ordem, com o horário original.
3. Desligue a alimentação no meio de uma gravação. O arquivo sobrevive?

### Lab 8 — Montagem de quadro
1. Caixa com trilho DIN: fonte, bornes, relé de interface, sua placa.
2. Todo fio com ilhós e identificação. Cabos entrando por prensa-cabos, por baixo.
3. Diagrama elétrico de uma página que outra pessoa consiga seguir.

## Projeto-desafio — Monitor de câmara fria instalável

**Missão:** um equipamento que você deixaria funcionando no negócio de outra pessoa. É o produto do modelo 2 do módulo 8.

### Requisitos
1. **Duas sondas de temperatura** DS18B20 com cabo de 5 m cada.
2. **Entrada isolada** para sensor de porta aberta.
3. **Saída a relé** para sirene ou sinaleiro de 24 V.
4. **Alarmes com retardo e histerese:** temperatura acima do limite por mais de N minutos; porta aberta por mais de M minutos. Degelo e abertura rápida não disparam.
5. **Alarme local independente:** a sirene funciona com Wi-Fi, broker e internet fora do ar.
6. **Aviso remoto** por MQTT, com guardar e reenviar: 24 h sem rede, nenhuma leitura perdida.
7. **Falta de energia:** detecta a queda e consegue enviar o aviso antes de desligar.
8. **RS-485/Modbus:** o equipamento responde como escravo, expondo temperaturas e estado de alarme. É o que permite integrá-lo a um sistema existente.
9. **Configuração sem regravar:** limites, tempos e rede pelo portal do módulo 5.
10. **Relatório mensal** em CSV com mínimas, máximas e eventos.
11. Montado em **caixa IP65**, com a entrada de alimentação protegida do lab 6.

### Restrições
- Nenhuma tensão de rede dentro da sua placa. Alimentação por fonte pronta.
- Watchdog ativo; motivo de reset publicado.
- Documentação de instalação de uma página e diagrama elétrico.

### Critérios de aceite
- [ ] 72 h ligado em teste, com uma sonda dentro de um freezer de verdade, sem reinício inesperado.
- [ ] Soltar uma sonda: alarme de falha de sensor, distinto do alarme de temperatura.
- [ ] Polaridade invertida na alimentação: nada queima.
- [ ] 50 ciclos de liga/desliga da alimentação: volta sozinho todas as vezes, sem perder configuração.
- [ ] Roteador desligado por 24 h: sirene funcionou no teste; ao voltar, todas as leituras chegaram.
- [ ] Puxar a tomada: a mensagem de falta de energia chega.
- [ ] O PC lê os registradores Modbus com o equipamento em operação normal.
- [ ] Uma pessoa que não participou do projeto instala seguindo só a sua página de instruções.

### Versão mínima para avançar
Requisitos 1, 3, 4, 5 e 6, na caixa, passando no teste de 72 h e no de 24 h sem rede.

<details>
<summary>Dica 1 — DS18B20 com cabo longo</summary>

Com 5 m, o pull-up de 4,7k pode ficar fraco. Reduza (2,2k), alimente as sondas com os três fios (não use alimentação parasita) e confira o CRC de cada leitura.
</details>

<details>
<summary>Dica 2 — avisar a falta de energia</summary>

Você precisa de alguns segundos de energia e de saber cedo que ela caiu. Monitore a tensão **antes** do regulador com um divisor em um pino de ADC ou comparador, e mantenha o ESP32 com um supercapacitor ou com a bateria do módulo 6. Faça a conta: corrente do Wi-Fi transmitindo vezes o tempo para conectar e publicar.
</details>

<details>
<summary>Dica 3 — o relé repica no boot</summary>

Vários pinos do ESP32 mudam de estado durante a inicialização. Escolha um pino que fique em nível baixo no boot e ponha pull-down externo.
</details>

<details>
<summary>Dica 4 — horário sem rede</summary>

Sem NTP, o relógio se perde após um reinício. Um DS3231 resolve e deixa o horário das leituras guardadas confiável.
</details>

### Chefão (opcional)
- **Sua própria placa** em formato para caixa de trilho DIN, juntando tudo.
- **Sem Wi-Fi:** versão com Ethernet ou LTE.
- **Primeiro cliente:** instale em um negócio real, com contrato de mensalidade. Fecha também o desafio do módulo 8.

## Checkpoint

- [ ] Isola qualquer sinal de campo antes de chegar ao microcontrolador.
- [ ] Lê 4–20 mA e conversa Modbus com um equipamento a partir do manual.
- [ ] Protege a entrada de alimentação e toda E/S que sai da caixa.
- [ ] Sabe onde termina o seu trabalho e começa o do eletricista.
- [ ] Entrega equipamento com documentação que permite instalar e manter.
