# Módulo 6 — Do protótipo ao produto

Objetivo: tirar o projeto da protoboard. Soldar, alimentar por bateria, desenhar e mandar fabricar uma placa, e colocar em uma caixa.

## Teoria mínima

### Solda
| Assunto | Regra de bolso |
|---|---|
| Temperatura | 320–350 °C para solda com chumbo. |
| Técnica | Aqueça ilha e terminal juntos por ~1 s, alimente a solda **na junta** (não no ferro), retire a solda, depois o ferro. 2–3 s no total. |
| Junta boa | Cone brilhante, molhando ilha e terminal. Bola fosca é solda fria. |
| Fluxo | Na dúvida, mais fluxo. |
| Ponta | Sempre estanhada; limpe na esponja metálica. |

### Alimentação por bateria
| Assunto | Regra de bolso |
|---|---|
| Célula de lítio | 4,2 V cheia, ~3,7 V nominal, 3,0 V vazia. Sempre com proteção. |
| TP4056 | Corrente de carga definida pelo resistor Rprog: 1,2k → 1 A (padrão do módulo), 2k → ~580 mA, 5k → ~250 mA, 10k → ~130 mA. Carregue a no máximo 1C: bateria de 500 mAh pede troca do resistor. |
| Usar enquanto carrega | Com a carga ligada direto na bateria, o TP4056 não distingue a corrente do circuito da corrente de carga e pode nunca encerrar o ciclo. Para aparelho que funciona carregando, use um circuito de divisão de carga (*load sharing*: MOSFET P + diodo Schottky) ou um CI carregador com *power path*. |
| LDO | Precisa de `Vin > Vout + queda`. O AMS1117 (queda de ~1,1 V) **não serve** para tirar 3,3 V de uma célula. Use HT7333, MCP1700 ou ME6211. |
| Elevador (boost) | Para ter 5 V a partir da célula (MT3608). Menos eficiente e mais ruidoso; ajuste a tensão **antes** de ligar a carga. |
| Corrente quiescente | Em projeto que dorme, o consumo do regulador parado define a autonomia. |

### PCB
| Assunto | Regra de bolso |
|---|---|
| Fluxo | Esquema → ERC → footprints → posicionamento → roteamento → DRC → Gerbers. |
| Posicionamento | É 80% do trabalho. Conectores nas bordas, desacoplamento colado nos pinos de alimentação. |
| Trilhas | Sinal: 0,25 mm. Alimentação: 0,5 a 1 mm. Curvas a 45°. |
| Terra | Plano de GND na camada de baixo, o mais inteiro possível. |
| Desacoplamento | 100 nF por pino de alimentação de CI, o mais perto possível. |
| Antena | Nada de cobre (nem plano) sob a antena do módulo ESP32; antena na borda da placa. |
| Footprint | A causa nº 1 de placa perdida. **Imprima em escala 1:1 e coloque os componentes sobre o papel** antes de encomendar. |
| Para depurar | Pontos de teste em cada trilha de alimentação e sinais críticos. Jumper ou resistor de 0 Ω para isolar blocos. Texto na serigrafia: polaridade, nomes de pinos, versão. |
| Fabricação | Use as regras de projeto do fabricante escolhido como regras do DRC. |

### Caixa e mecânica
| Assunto | Regra de bolso |
|---|---|
| Opções | Caixa pronta (plástica ou hermética) furada por você; impressão 3D; camadas de acrílico ou MDF cortadas a laser. Comece pela pronta se o prazo importa. |
| Ordem certa | Defina a caixa **antes** de fechar o contorno da placa. Furos de fixação, conectores e altura dos componentes saem da caixa. |
| Placa em 3D | Exporte a placa do KiCad em STEP e modele a caixa em volta dela. |
| Folga | Em impressão 3D, deixe 0,2 a 0,3 mm por lado em encaixes. Furos saem menores: some 0,2 mm ao diâmetro. |
| Parede | 1,6 a 2 mm no mínimo. |
| Fixação | Inserto metálico de latão colocado a quente dura muito mais que parafuso direto no plástico. Placa sobre pilares, nunca solta. |
| Material | PLA amolece perto de 55–60 °C (carro, sol). Para isso, PETG. |
| Teste barato | Antes da caixa inteira, imprima só o recorte do conector ou da tela e confira o encaixe. |
| Sensor de temperatura | Longe do regulador e do ESP32, com ventilação, ou fora da caixa. Dentro, ele mede o próprio aparelho. |
| Antena | Encostada na parede plástica, longe de metal e de bateria. |
| Bateria de lítio | Compartimento sem parafuso nem quina apontando para a célula; espaço para ela inchar. |
| Cabos | Alívio de tração em todo cabo que sai da caixa. |

## Estudo

- [Guia de solda](https://learn.adafruit.com/adafruit-guide-excellent-soldering) — Adafruit. Inclui galeria de erros comuns.
- [Solda de componentes PTH](https://learn.sparkfun.com/tutorials/how-to-solder-through-hole-soldering), [trabalhando com fios](https://learn.sparkfun.com/tutorials/working-with-wire), [conectores](https://learn.sparkfun.com/tutorials/connector-basics) — SparkFun.
- [Baterias de lítio](https://learn.adafruit.com/li-ion-and-lipoly-batteries) — Adafruit. Leia antes de ligar a primeira.
- [PCB: conceitos](https://learn.sparkfun.com/tutorials/pcb-basics) — SparkFun.
- [KiCad: Getting Started](https://docs.kicad.org/9.0/en/getting_started_in_kicad/getting_started_in_kicad.html) — tutorial oficial, uma placa simples do início ao fim. Instale por [kicad.org](https://www.kicad.org/download/); se sua versão for mais nova, use a documentação dela.
- [Intro to KiCad](https://www.youtube.com/playlist?list=PLEBQazB0HUyR24ckSZ5u05TZHV9khgA1O) — Shawn Hymel / DigiKey. Série em vídeo, do esquema aos Gerbers. As versões mudam os menus, o fluxo é o mesmo.
- [KiCad: sua primeira placa](https://www.build-electronic-circuits.com/kicad-tutorial/) — Build Electronic Circuits. Alternativa em texto.
- [Phil's Lab](https://www.youtube.com/@PhilsLab) — YouTube. O melhor conteúdo gratuito de projeto de PCB; veja os vídeos de placa com ESP32 e de revisão de projetos.
- Modelagem 3D: [FreeCAD](https://www.freecad.org/) ([primeiros passos](https://wiki.freecad.org/Getting_started), [tutoriais](https://wiki.freecad.org/Tutorials)), gratuito e completo; [OpenSCAD](https://openscad.org/documentation.html), em que a peça é código, bom para quem programa; [Onshape gratuito](https://www.onshape.com/en/products/free), no navegador, com projetos públicos.
- [YAPP Box](https://github.com/mrWheel/YAPP_Box) — gerador de caixa para placa em OpenSCAD: você informa as medidas e os recortes.
- [Como projetar peças para impressão 3D](https://www.hubs.com/knowledge-base/how-design-parts-fdm-3d-printing/) — Hubs. Tolerâncias, paredes, furos.
- [Insertos metálicos a quente](https://hackaday.com/2019/02/28/threading-3d-printed-parts-how-to-use-heat-set-inserts/) — Hackaday.
- [Base de conhecimento da Prusa](https://help.prusa3d.com/) — impressão 3D na prática.
- [Patola](https://www.patola.com.br/) — fabricante brasileira de caixas plásticas para eletrônica; o catálogo tem os desenhos com medidas.
- Fabricantes: [JLCPCB](https://jlcpcb.com/), [PCBWay](https://www.pcbway.com/). Protótipos de 2 camadas são baratos; some frete e imposto de importação. Há fabricantes nacionais, mais caros e mais rápidos.

## Labs

### Lab 1 — Solda
1. Barras de pinos você já soldou no módulo 3. Agora revise aquelas juntas com olho crítico e refaça as foscas.
2. Em uma placa perfurada de sucata: 20 resistores, depois dessolde 10 com sugador e malha.
3. Emende dois fios com termorretrátil. Estanhe pontas de fio flexível.

### Lab 2 — Placa perfurada
1. Passe a luz noturna do módulo 1 para placa perfurada.
2. Planeje o posicionamento no papel antes. Teste continuidade e curto entre VCC e GND **antes** de energizar.

### Lab 3 — Bateria
1. Célula + TP4056 + chave + regulador. Meça a tensão de saída sem carga antes de ligar qualquer coisa.
2. Com o INA219 e um Arduino, registre a curva de descarga (tensão x tempo) com uma carga fixa. A capacidade bate com a etiqueta?
3. Registre a curva de carga. Identifique as fases de corrente constante e tensão constante.

### Lab 4 — KiCad, placa de treino
1. Siga o Getting Started oficial até o fim.
2. Desenhe sozinho a luz noturna do módulo 1: esquema, ERC, PCB, DRC, visualização 3D.
3. Imprima 1:1 e confira os componentes sobre o papel. Não precisa fabricar.

### Lab 5 — Footprint próprio
1. Escolha um módulo que não tem footprint na biblioteca (o TP4056, por exemplo).
2. Meça com paquímetro ou pelo desenho do fabricante e crie o footprint.
3. Valide na impressão 1:1.

### Lab 6 — Primeira peça
1. Meça a tela OLED com paquímetro: placa, área visível, furos.
2. Modele uma moldura com o recorte da tela e pilares para os furos.
3. Imprima (impressora própria, espaço maker ou serviço) e confira o encaixe. Ajuste as folgas e anote os valores que funcionaram: você vai reutilizar.

### Lab 7 — Caixa em volta da placa
1. Exporte em STEP a placa do lab 4.
2. Modele base e tampa com pilares, recorte do USB e fechamento por parafuso com inserto.
3. Coloque os insertos com o ferro de solda.

## Projeto-desafio — Sua primeira PCB fabricada

**Missão:** projetar, fabricar, montar e colocar para funcionar uma placa sua, para um projeto da trilha.

### Escolha o projeto
- **A (recomendado):** nó sensor a bateria do módulo 5.
- **B:** placa do robô do módulo 4 (driver, encoders, sensores, alimentação).
- **C:** placa-base do Pocket AI (junta ESP32-S3, microfone, amplificador, tela, carga e bateria).

### Escolha o nível
- **Nível 1 — placa-mãe de módulos:** a placa de desenvolvimento e os módulos encaixam em barras de pinos fêmea. A placa faz as interligações, a alimentação e os conectores. Tudo PTH. Recomendado para a primeira.
- **Nível 2 — integrada:** módulo ESP32 (WROOM ou MINI) soldado direto, com USB-C, regulador, carregador e circuito de gravação. Componentes SMD (0805 é soldável à mão). Faça depois que a nível 1 funcionar.

### Requisitos
1. Esquema organizado em blocos nomeados (alimentação, MCU, sensores, interface), com valores e observações.
2. ERC e DRC sem erros, com as regras do fabricante.
3. Alimentação por bateria com carga por USB, chave liga/desliga e medição da tensão da bateria.
4. Proteção contra o erro mais provável (bateria invertida: conector polarizado, no mínimo).
5. Pontos de teste em todas as tensões e nos barramentos.
6. Um LED de estado e um botão do usuário.
7. Furos de fixação e dimensões pensadas para uma caixa.
8. Serigrafia com nome, versão, data, polaridades e função dos conectores.
9. Lista de materiais com fornecedor para cada item.

### Processo obrigatório
1. **Revisão antes de encomendar:** impressão 1:1 com componentes por cima; lista de verificação de pinagem de cada CI contra o datasheet; deixe 24 h e revise de novo.
2. **Primeira energização (*bring-up*) por etapas:** placa nua → continuidade e ausência de curto → só alimentação montada → meça as tensões → só então o microcontrolador → um periférico por vez.
3. **Errata:** documente todo erro encontrado e o remendo. Toda primeira placa tem erro; a meta é encontrá-los com método.

### Critérios de aceite
- [ ] Placa montada rodando o firmware do projeto escolhido, sem protoboard.
- [ ] Carrega pela USB e funciona na bateria.
- [ ] Consumo dormindo medido e comparado com a versão em placa de desenvolvimento.
- [ ] Dentro de uma caixa (impressa em 3D, caixa patola adaptada, ou estrutura de fio de latão no estilo do vídeo que inspirou o Pocket AI).
- [ ] Repositório com esquema em PDF, Gerbers, lista de materiais, fotos e errata.

<details>
<summary>Dica 1 — o que mais dá errado em primeira placa</summary>

Footprint espelhado ou com pinagem diferente (transistores e reguladores variam por fabricante); TX/RX não cruzados; faltar pull-up em I2C ou no pino de enable; conector de bateria com polaridade invertida em relação ao cabo comprado; furo menor que o terminal.
</details>

<details>
<summary>Dica 2 — nível 2: circuito mínimo do ESP32</summary>

A Espressif publica o esquema de referência das placas DevKitC e um guia de projeto de hardware para cada chip. Parta deles. O ESP32-S3 e o C3 têm USB nativo, o que dispensa o conversor USB-serial.
</details>

<details>
<summary>Dica 3 — encomenda</summary>

O pedido mínimo costuma ser de 5 placas. Aproveite: monte uma, guarde as outras para os erros de solda. Se couber, coloque um segundo projeto pequeno no mesmo painel.
</details>

### Versão mínima para avançar
Nível 1, requisitos 1 a 5, com o processo obrigatório inteiro: placa fabricada, montada e rodando o firmware na bateria. A caixa pode ser provisória.

### Chefão (opcional)
- **Revisão B:** corrija a errata e fabrique de novo. É aqui que se aprende projeto de verdade.
- **Montagem SMD com estêncil** e chapa quente ou soprador.
- **Pocket AI etapa 4** na sua própria placa em vez de placa perfurada.

## Checkpoint

- [ ] Solda PTH limpa e dessolda sem destruir a ilha.
- [ ] Vai do esquema aos Gerbers no KiCad sem tutorial aberto.
- [ ] Tem um roteiro de primeira energização e o segue.
- [ ] Sabe dimensionar carga, regulação e proteção de uma célula de lítio.
