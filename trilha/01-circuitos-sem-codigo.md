# Módulo 1 — Circuitos sem código

Objetivo: montar e medir circuitos sem microcontrolador. Tudo o que vem depois (ler sensor, acionar motor) é divisor de tensão, RC e transistor disfarçado.

Alimentação: use os pinos **5V** e **GND** do Arduino como fonte. Ele só fornece energia aqui.

## Teoria mínima

| Assunto | Regra de bolso |
|---|---|
| LED | `R = (Vfonte − Vf) / I`. Vf ≈ 2 V (vermelho, amarelo), ≈ 3 V (azul, branco). 5 mA já acende bem; 20 mA é o máximo usual. |
| Divisor de tensão | `Vout = Vin · R2 / (R1 + R2)`. Só vale se a carga for muito maior que R2 (10x ou mais). |
| Sensor resistivo (LDR, NTC) | Vira tensão em um divisor. Excursão máxima quando o resistor fixo ≈ `√(Rmín · Rmáx)`. |
| Capacitor | `τ = R · C`. Carrega 63% em 1τ, ~99% em 5τ. 100 nF entre VCC e GND de todo CI (desacoplamento). |
| Diodo | Conduz em um sentido, perde ~0,7 V (Schottky ~0,3 V). |
| Transistor NPN como chave | Base com ~0,7 V conduz. Dimensione `Ib ≈ Ic / 10` para saturar: `Rb = (Vcontrole − 0,7) / Ib`. Carga entre +V e coletor, emissor no GND. |
| Comparador | Saída alta se V+ > V−. Sem histerese, oscila no limiar. |
| 555 astável | `f ≈ 1,44 / ((Ra + 2·Rb) · C)`. |
| Potência | `P = V · I = I² · R`. Resistor comum aguenta 0,25 W. |

## Estudo

Leia só o necessário para o lab em que está. Cerca de 4 horas no total.

- [Como usar o multímetro](https://learn.sparkfun.com/tutorials/how-to-use-a-multimeter) e [a protoboard](https://learn.sparkfun.com/tutorials/how-to-use-a-breadboard) — SparkFun. Passe rápido se já usa.
- [Como ler um esquema](https://learn.sparkfun.com/tutorials/how-to-read-a-schematic) — SparkFun.
- [LEDs](https://learn.sparkfun.com/tutorials/light-emitting-diodes-leds), [divisor de tensão](https://learn.sparkfun.com/tutorials/voltage-dividers), [capacitores](https://learn.sparkfun.com/tutorials/capacitors), [diodos](https://learn.sparkfun.com/tutorials/diodes) — SparkFun.
- [Transistores](https://learn.sparkfun.com/tutorials/transistors) — SparkFun. Foque na seção de aplicações como chave; pule a física.
- [Transistores e MOSFETs](https://dronebotworkshop.com/transistors-mosfets/) — DroneBot Workshop, com montagem.
- [Falstad](https://www.falstad.com/circuit/) — simulador. O menu *Circuits* tem exemplos prontos de 555, comparador e Schmitt trigger.

## Labs

Para cada um: desenhe o esquema, **anote a previsão**, monte, meça, compare.

### Lab 1 — Multímetro
1. Meça 10 resistores e compare com o código de cores. Estão dentro da tolerância?
2. Meça o 5V do Arduino sem carga.
3. Teste continuidade nas trilhas da protoboard. Descubra se as laterais são contínuas de ponta a ponta.

### Lab 2 — LED
1. Calcule R para 5 mA em um LED vermelho. Monte e meça a corrente (multímetro **em série**).
2. Meça Vf de cada cor a 5 mA e monte uma tabela.
3. Qual o menor valor de corrente em que o LED ainda é visível? (Importa para projeto a bateria.)

### Lab 3 — Divisor e carga
1. Divisor 10k/10k em 5 V. Meça Vout.
2. Pendure 1k como carga em Vout. Preveja e meça. Por que mudou?
3. Troque por um potenciômetro e varie de 0 a 5 V.

### Lab 4 — LDR
1. Meça a resistência do LDR no claro e tampado.
2. Calcule o resistor fixo ideal pela média geométrica. Monte o divisor e meça Vout nos dois extremos.
3. Repita com um resistor 10x maior e 10x menor. Compare a excursão.

### Lab 5 — RC
1. 10k em série com 1000 µF: τ previsto = 10 s.
2. Com o multímetro no capacitor, cronometre até 3,15 V (63% de 5 V).
3. Descarregue por um LED com resistor e veja o apagamento gradual.

### Lab 6 — Transistor como chave
1. BC547 acionando um LED a 20 mA, controlado por um fio que você encosta em 5 V ou GND. Calcule Rb.
2. Meça Vce com o transistor ligado. Deve estar abaixo de ~0,2 V; se não, não saturou.
3. Troque o LED por um buzzer ativo.
4. Monte um par Darlington (dois BC547) e acione o LED encostando o dedo entre 5 V e a base. Por que funciona?

### Lab 7 — 555
1. Astável piscando LED a ~1 Hz. Calcule Ra, Rb e C.
2. Troque Rb por potenciômetro. Depois reduza C até virar tom audível no buzzer passivo.

### Lab 8 — Comparador
1. LM358 comparando o divisor do LDR com um trimpot. Saída em um LED.
2. Ajuste bem no limiar e veja a saída instável.

## Projeto-desafio — Luz noturna automática analógica

**Missão:** uma luz que acende sozinha quando escurece, sem microcontrolador.

### Requisitos
1. LED branco acende no escuro e apaga no claro.
2. Limiar de luminosidade ajustável por trimpot.
3. **Sem cintilação:** no lusco-fusco, a luz não pode piscar nem ficar a meia intensidade. Está ligada ou desligada.
4. **Retardo de desligamento:** quando a luz ambiente volta, o LED fica aceso por 3 a 10 s antes de apagar. Um flash rápido (lanterna, farol) não deve apagá-lo.
5. Consumo com o LED apagado abaixo de 2 mA.

### Restrições
- Alimentação 5 V. Só componentes do kit base.
- Esquema desenhado **antes** de montar, e simulado no Falstad.

### Critérios de aceite
- [ ] Cobrindo o LDR lentamente com a mão, a transição é limpa, em um único ponto.
- [ ] Limiares de acender e apagar são diferentes (meça a tensão do divisor nos dois).
- [ ] Flash de 1 s no LDR não apaga o LED.
- [ ] Corrente medida com LED apagado < 2 mA.
- [ ] README com esquema, valores calculados e medidos lado a lado.

<details>
<summary>Dica 1 — cintilação</summary>

O que falta é **histerese**: dois limiares, um para subir e outro para descer. No comparador, um resistor da saída para a entrada não inversora (realimentação positiva) faz isso. Procure "Schmitt trigger" nos exemplos do Falstad.
</details>

<details>
<summary>Dica 2 — retardo</summary>

Um RC entre o sensor e o comparador atrasa tudo, nos dois sentidos. Para atrasar só um sentido, um diodo faz o capacitor carregar rápido por um caminho e descarregar devagar por outro.
</details>

<details>
<summary>Dica 3 — a saída do LM358 não chega a 5 V</summary>

Em 5 V, a saída alta fica por volta de 3,5 V. É suficiente para a base de um transistor, mas considere isso no cálculo da histerese.
</details>

### Versão mínima para avançar
Requisitos 1, 2 e 3: acende no escuro, limiar ajustável e transição limpa, com os dois limiares medidos. Retardo e consumo ficam para a versão completa.

### Chefão (opcional)
- Faça o LED apagar em **fade** de 2 s em vez de cortar.
- Versão só com transistores, sem CI.
- Alarme de "feixe cortado": LED apontado para o LDR; ao interromper o feixe, um 555 dispara o buzzer por 5 s (monoestável).

## Checkpoint

- [ ] Calcula resistor de LED e de base de transistor sem consultar.
- [ ] Explica por que um divisor "cai" com carga.
- [ ] Olha um RC e estima o tempo de cabeça.
- [ ] Sabe o que é histerese e quando falta.
