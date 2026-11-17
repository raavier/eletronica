# Trilha de eletrônica prática

Do LED na protoboard até uma placa própria fabricada, passando por Arduino, sensores, motores e ESP32. Feita para quem já sabe o básico de elétrica (Ohm, Kirchhoff, potência) e quer **construir**, com o mínimo de teoria.

## Como a trilha funciona

Cada módulo tem sempre as mesmas cinco partes:

1. **Teoria mínima** — as regras de bolso que você precisa. Cabe em uma tela.
2. **Estudo** — links gratuitos, com o que ler/assistir e o que pular.
3. **Labs** — experimentos curtos (20 a 60 min) para ganhar uma habilidade por vez.
4. **Projeto-desafio** — o que importa. É uma especificação com critérios de aceite, não um passo a passo. As dicas ficam recolhidas; abra só quando travar.
5. **Checkpoint** — o que você precisa saber fazer antes de avançar.

## Mapa

| # | Módulo | Você aprende | Projeto-desafio | Duração* |
|---|---|---|---|---|
| 0 | [Bancada](00-bancada.md) | Ferramentas, compras, segurança, fluxo de trabalho | — | 1 dia |
| 1 | [Circuitos sem código](01-circuitos-sem-codigo.md) | Multímetro, divisor, RC, transistor, 555, comparador | Luz noturna automática analógica | 1–2 sem |
| 2 | [Arduino de verdade](02-arduino-de-verdade.md) | E/S, ADC, PWM, `millis()`, máquina de estados, interrupções, EEPROM | Console de 4 botões com dois jogos | 2–3 sem |
| 3 | [Sensores e barramentos](03-sensores-e-barramentos.md) | I2C, SPI, UART, 1-Wire, datasheet, analisador lógico | Datalogger ambiental com menu | 3 sem |
| 4 | [Potência e movimento](04-potencia-e-movimento.md) | MOSFET, relé, ponte H, servo, passo, fontes, PID | Robô de 2 rodas com controle em malha fechada | 3–4 sem |
| 5 | [ESP32 e IoT](05-esp32-e-iot.md) | Wi-Fi, MQTT, HTTP, OTA, deep sleep, FreeRTOS, I2S | Rede de sensores a bateria com painel | 3–4 sem |
| 6 | [Do protótipo ao produto](06-do-prototipo-ao-produto.md) | Solda, placa perfurada, KiCad, PCB, bateria, caixa | Sua primeira PCB fabricada | 4–6 sem |
| 7 | [Avançado](07-avancado.md) | Especialização à escolha | Projeto final próprio | aberto |
| 8 | [Ganhar dinheiro](08-ganhar-dinheiro.md) | Modelos de negócio, precificação, o que e onde vender, regras brasileiras | Os primeiros R$ 1.000 | em paralelo, a partir do módulo 5 |
| 9 | [Campo e indústria](09-campo-e-industria.md) | 24 V, 4–20 mA, RS-485/Modbus, proteção, caixa, rede elétrica com segurança | Monitor de câmara fria instalável | 4–5 sem, depois do módulo 6 |

Os módulos 0 a 6 são a espinha e seguem em ordem. O 7 é especialização. O 8 e o 9 andam juntos: o 9 é a técnica que o modelo de automação do 8 exige.

Arquivos de apoio:

| Arquivo | Para quê |
|---|---|
| [compras.md](compras.md) e `compras.csv` | Lista única de compras, em 7 pedidos, com faixa de preço |
| [atalho-pocket-ai.md](atalho-pocket-ai.md) | Caminho curto para ter o Pocket AI conversando antes de fazer a trilha |
| [referencias.md](referencias.md) | Links por assunto, simuladores e canais |

Cada projeto-desafio tem uma **versão mínima para avançar**. Faça a mínima, siga em frente, e volte para a completa e o chefão quando quiser. Travar meses em um módulo é pior do que avançar com o essencial.

\* Estimativa minha, supondo 5 a 6 horas por semana. O prazo do módulo 6 inclui a espera pela fabricação da placa. A soma dá de 4 a 6 meses se nada atrasar; contando espera de peças, chefões e semanas paradas, conte com perto de um ano.

Para não ficar parado esperando entrega, **compre as peças de um módulo quando começar o anterior**.

## Regras do jogo

- **Preveja, meça, explique.** Antes de ligar, anote o valor que espera ver. Se a medida não bater, a diferença é a aula.
- **Projeto-desafio sem tutorial.** Nos labs, siga tutoriais à vontade. No desafio, parta da especificação, do datasheet e da documentação da biblioteca. Copiar o projeto pronto de alguém anula o módulo.
- **Simule quando ajudar.** [Falstad](https://www.falstad.com/circuit/) para analógico, [Wokwi](https://wokwi.com/) para Arduino/ESP32. Serve também para adiantar labs enquanto as peças não chegam.
- **Um esquema por projeto.** Papel fotografado serve no começo; a partir do módulo 6, KiCad.
- **Sempre algo funcionando.** Monte e teste um bloco por vez. Nunca ligue dez fios novos de uma vez.
- **Não pule o checkpoint.** Os módulos seguintes assumem aquelas habilidades.

## Onde colocar as coisas

O repositório já tem `sketches/` e um `Makefile` com `arduino-cli`. Continue assim:

```
sketches/
  m2_lab1_botao/m2_lab1_botao.ino      # labs: m<módulo>_lab<n>_<nome>
  m2_console/m2_console.ino            # projeto-desafio: m<módulo>_<nome>
  m2_console/README.md                 # esquema, medidas, o que deu errado
```

```bash
make upload SKETCH=m2_console            # Arduino Uno: compila e grava
make monitor                             # serial
make upload BOARD=s3 SKETCH=m5_lab1_blink   # ESP32-S3 (antes, uma vez: make setup-esp32)
```

O repositório está em git, com `secrets.h` no `.gitignore`. Faça um commit a cada lab que funcionar: é o seu "desfazer" quando uma mudança quebrar tudo.

## Onde entra o Pocket AI

O [`pocket-ai/`](../pocket-ai/README.md) usa exatamente o que os módulos 5 e 6 ensinam:

Se quiser o gadget funcionando logo, use o [atalho](atalho-pocket-ai.md) para a etapa 1 e volte à trilha depois.

O [`ha-voice-hub/`](../ha-voice-hub/) (computador para Home Assistant com voz) é um projeto de outro porte; ele entra como caso de estudo na trilha F do [módulo 7](07-avancado.md).

| Etapa do Pocket AI | Faça depois de | Por quê |
|---|---|---|
| 1 — protoboard + firmware pronto | Módulo 3 | Você já entende I2C (tela) e sabe depurar ligação. Pode até fazer antes, como motivação. |
| 2 e 3 — servidor próprio e integrações | Módulo 5 | Wi-Fi, MQTT e I2S deixam de ser caixa-preta. |
| 4 — bateria e montagem soldada | Módulo 6 | Solda, TP4056, elevador de tensão e montagem em placa. |

## Progresso

- [ ] 0 — Bancada montada, multímetro e fluxo de gravação funcionando
- [ ] 1 — Luz noturna analógica
- [ ] 2 — Console de 4 botões
- [ ] 3 — Datalogger ambiental
- [ ] 4 — Robô com malha fechada
- [ ] 5 — Rede de sensores a bateria
- [ ] 6 — Primeira PCB montada e funcionando
- [ ] 7 — Projeto final
- [ ] 8 — Os primeiros R$ 1.000
- [ ] 9 — Monitor de câmara fria instalável
