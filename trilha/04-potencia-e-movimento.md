# Módulo 4 — Potência e movimento

Objetivo: acionar cargas que um pino não aguenta (motores, relés, fitas de LED) e fechar uma malha de controle.

É o módulo em que mais se queima coisa. As regras abaixo existem por isso.

## Teoria mínima

| Assunto | Regra de bolso |
|---|---|
| Alimentação | Motor e servo **nunca** no pino 5V do Arduino. Fonte separada para a carga, **GND comum** com a lógica. |
| MOSFET N como chave | Carga entre +V e dreno, fonte no GND. Resistor de ~220 Ω no gate e pull-down de 10k–100k do gate ao GND. |
| "Nível lógico" | Vgs(th) **não** é a tensão de ligar. Olhe Rds(on) especificado em Vgs = 4,5 V (ou 2,5 V para 3,3 V). IRLZ44N serve em 5 V; IRFZ44N e IRF520, não. |
| Carga indutiva | Motor, relé e solenoide geram pico de tensão ao desligar. Diodo em antiparalelo com a carga (1N4007 em relé; Schottky ou rápido em PWM). |
| Ponte H | Inverte o sentido do motor. L298N é bipolar e perde ~2 V; TB6612FNG e DRV8833 são MOSFET e perdem quase nada. |
| Servo | Sinal de 50 Hz, pulso de 1 a 2 ms. Picos de centenas de mA: fonte própria. |
| Motor de passo | Driver com limite de corrente (A4988, DRV8825). Ajuste Vref antes de usar. **Nunca desconecte o motor com o driver energizado.** |
| Ruído e queda | Capacitor de 470–1000 µF na alimentação da carga, perto dela. Arduino resetando sozinho = queda de tensão. |
| Reguladores | Linear dissipa `(Vin − Vout) · I` em calor. Para mais de ~100 mA com queda grande, use buck. |
| PID | `u = Kp·e + Ki·∫e + Kd·de/dt`. Período de amostragem fixo. Limite a saída e pare de integrar quando saturar (anti-windup). |

## Estudo

- [Transistores e MOSFETs](https://dronebotworkshop.com/transistors-mosfets/) — DroneBot Workshop. Reveja a parte de MOSFET.
- [Controle de motor com transistor](https://docs.arduino.cc/learn/electronics/transistor-motor-control/) — Arduino.
- [Motores: como escolher](https://learn.sparkfun.com/tutorials/motors-and-selecting-the-right-one) e [como alimentar um projeto](https://learn.sparkfun.com/tutorials/how-to-power-a-project) — SparkFun.
- Drivers: [TB6612FNG](https://learn.sparkfun.com/tutorials/tb6612fng-hookup-guide) (SparkFun), [L298N](https://lastminuteengineers.com/l298n-dc-stepper-driver-arduino-tutorial/), [relé](https://lastminuteengineers.com/one-channel-relay-module-arduino-tutorial/), [servo](https://lastminuteengineers.com/servo-motor-arduino-tutorial/), [28BYJ-48](https://lastminuteengineers.com/28byj48-stepper-motor-arduino-tutorial/), [A4988](https://lastminuteengineers.com/a4988-stepper-motor-driver-arduino-tutorial/) (Last Minute Engineers).
- [INA219](https://learn.adafruit.com/adafruit-ina219-current-sensor-breakout) — Adafruit.
- [Improving the Beginner's PID](http://brettbeauregard.com/blog/2011/04/improving-the-beginners-pid-introduction/) — Brett Beauregard. Série curta que constrói um PID de verdade, problema por problema. **Leia inteira antes do desafio.**
- [Implementing a PID Controller](https://ww1.microchip.com/downloads/en/Appnotes/00937a.pdf) — nota de aplicação da Microchip, para aprofundar.
- [Sensores QTR e seguidor de linha](https://www.pololu.com/docs/0J21) — Pololu. Mostra como transformar N sensores em uma posição contínua.

## Labs

### Lab 1 — MOSFET
1. IRLZ44N chaveando uma carga de 12 V (fita de LED, ventoinha ou motor) com PWM.
2. Meça Vds ligado e a corrente. Calcule Rds(on) e a potência dissipada. Compare com o datasheet.
3. Tire o pull-down do gate e desconecte o Arduino. O que a carga faz? Por quê?

### Lab 2 — Relé e diodo
1. Acione a bobina de um relé avulso com BC547 e diodo 1N4007 em antiparalelo. Calcule Rb pela corrente da bobina (meça a resistência dela).
2. Compare com o módulo relé pronto: identifique no módulo o transistor, o diodo e o optoacoplador.

### Lab 3 — Ponte H
1. Motor TT com TB6612FNG: sentido e velocidade por PWM.
2. Mesmo motor com L298N. Meça a tensão no motor em PWM máximo nos dois drivers.
3. Qual o menor PWM em que o motor parte? E o menor em que continua girando? (Zona morta: você vai precisar no desafio.)

### Lab 4 — Servo
1. Servo controlado por potenciômetro, alimentado por fonte separada.
2. De propósito, alimente pelo 5V do Arduino e meça a tensão durante um movimento brusco. Veja a queda.
3. Adicione 470 µF na alimentação do servo e meça de novo.

### Lab 5 — Motor de passo
1. 28BYJ-48 com ULN2003: gire exatamente uma volta. Quantos passos?
2. Com `AccelStepper`, faça movimento com aceleração. O que acontece sem rampa em velocidade alta?

### Lab 6 — Corrente
1. INA219 em série com o motor. Meça corrente livre, com carga e travado (por 1 s).
2. A corrente de travamento cabe no seu driver? E na sua fonte?

### Lab 7 — Encoder e velocidade
1. Disco de fenda + sensor óptico em uma roda, contando por interrupção.
2. Calcule RPM a cada 100 ms e plote.
3. Aplique um degrau de PWM e registre a resposta. Estime a constante de tempo do motor.

## Projeto-desafio — Robô de 2 rodas com malha fechada

**Missão:** um robô diferencial que anda reto de verdade, e depois segue uma linha. Em três fases; cada uma funciona antes da próxima.

### Fase A — Velocidade controlada
1. PID de velocidade **escrito por você** (sem biblioteca) em cada roda, com encoder.
2. Período de controle fixo. Anti-windup. Saída limitada.
3. Comando pela serial: velocidade de cada roda em RPM; telemetria em CSV (referência, medida, PWM).

**Aceite:**
- [ ] Resposta ao degrau plotada: tempo de subida, sobressinal < 15%, erro em regime ≈ 0.
- [ ] Segurando a roda com o dedo, o PWM sobe para compensar; soltando, a velocidade volta sem disparar.
- [ ] As duas rodas mantêm a mesma RPM com a mesma referência.

### Fase B — Andar reto e girar
1. Odometria: posição e orientação estimadas pelos encoders.
2. Comandos: "ande X cm" e "gire N graus".

**Aceite:**
- [ ] 2 m em linha reta com desvio lateral < 5 cm.
- [ ] Quadrado de 50 cm de lado terminando a menos de 10 cm da origem.
- [ ] Perfil de velocidade com rampa (não arranca nem para em tranco).

### Fase C — Seguidor de linha
1. Sensores de refletância lidos como posição contínua da linha (média ponderada), não como liga/desliga.
2. Malha externa (posição da linha) comandando as malhas internas de velocidade (controle em cascata).
3. Calibração automática dos sensores ao ligar.

**Aceite:**
- [ ] Completa um circuito de fita isolante com curvas de raio de 15 cm, 3 voltas seguidas sem sair.
- [ ] Tempo de volta registrado; depois reduza 20% só com ajuste de ganhos e velocidade.

### Restrições
- Bateria a bordo; lógica e motores com alimentação tratada (buck para a lógica, capacitor nos motores).
- Sem `delay()`. Malha de controle em período fixo.
- Esquema completo, com orçamento de corrente: quanto cada parte consome e quanto a bateria fornece.

<details>
<summary>Dica 1 — encoder de baixa resolução</summary>

O disco de 20 fendas dá poucos pulsos por amostra em baixa velocidade, e a medida fica "em degraus". Opções: medir o **período** entre pulsos em vez de contar pulsos por janela; contar as duas bordas; filtrar; ou diminuir a frequência da malha.

O sensor de fenda tem um canal só: ele conta pulsos, mas **não informa o sentido**. Na odometria, o sinal vem do comando que você deu ao motor, e isso erra quando a roda é empurrada ou inverte por inércia. Encoder de quadratura (dois canais) resolve; é o que os motores N20 com encoder trazem.
</details>

<details>
<summary>Dica 2 — sintonia</summary>

Comece só com Kp até oscilar, recue à metade, depois suba Ki até zerar o erro em regime. Em malha de velocidade com encoder ruidoso, Kd costuma atrapalhar. Um termo *feedforward* (PWM estimado a partir da referência, usando a curva do lab 3) alivia muito o PID.
</details>

<details>
<summary>Dica 3 — o robô reseta ao arrancar</summary>

Queda de tensão na partida dos motores. Capacitor grande junto ao driver, fios de bateria curtos e grossos, e lógica alimentada por regulador próprio.
</details>

<details>
<summary>Dica 4 — derivada</summary>

Derive a **medida**, não o erro. Assim uma mudança de referência não vira um pico na saída. Está na série do Brett Beauregard.
</details>

### Versão mínima para avançar
Fase A completa, mais o primeiro critério da fase B (2 m em linha reta com desvio menor que 5 cm). Odometria completa e seguidor de linha ficam para depois.

### Chefão (opcional)
- **Robô equilibrista:** duas rodas, MPU6050, filtro complementar e PID de ângulo. Os motores TT têm folga demais; N20 com encoder ou NEMA17 com A4988 funcionam melhor. É difícil e muito satisfatório.
- **Desvio de obstáculos** com o HC-SR04 que você já tem, montado em um servo fazendo varredura.
- **Controle remoto** e telemetria sem fio. Fica natural depois do módulo 5.

## Checkpoint

- [ ] Escolhe MOSFET, driver e fonte a partir de tensão e corrente da carga.
- [ ] Nunca esquece diodo em carga indutiva nem GND comum.
- [ ] Faz orçamento de corrente antes de montar.
- [ ] Implementa e sintoniza um PID, e sabe ler uma resposta ao degrau.
