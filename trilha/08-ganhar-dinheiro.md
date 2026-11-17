# Módulo 8 — Ganhar dinheiro com eletrônica no Brasil

Objetivo: transformar o que a trilha ensina em renda. Cobre os modelos de negócio que funcionam aqui, como precificar produto e serviço, o que vender e onde, como divulgar, e as regras brasileiras que derrubam quem não as conhece (Anatel, Inmetro, impostos, garantia).

> **Sobre os números.** Taxas, limites e alíquotas foram levantados em 16/11/2026, quase todos em fontes secundárias (blogs de contabilidade e de e-commerce), e mudam com frequência. Os valores dos exemplos são ilustrativos. Antes de decidir, confirme na fonte oficial indicada em [Onde conferir](#onde-conferir) e fale com um contador. Não sou contador nem advogado.

## A visão geral, sem ilusão

Minha avaliação, para calibrar expectativa:

- **Serviço paga primeiro.** Projeto sob encomenda e automação para empresas dão dinheiro em semanas, com investimento quase zero.
- **Produto paga depois, e menos do que parece.** A margem some em taxas, frete, imposto e no seu tempo de montagem. Produto físico só fica bom com nicho que paga bem, lote maior ou receita recorrente.
- **Empresa paga melhor que pessoa física.** Para uma empresa, R$ 3.000 que evitam perder uma câmara fria de mercadoria é barato. Para um hobbista, R$ 150 é caro.
- **O dinheiro está no problema, não na eletrônica.** Ninguém compra "ESP32 com sensor". Compram "sei pelo celular se o freezer da loja desligou".

## Os modelos

| # | Modelo | Como ganha | Começa depois do | Investimento | Tempo até o 1º real | Teto |
|---|---|---|---|---|---|---|
| 1 | Projeto sob encomenda | Protótipo, firmware ou placa para empresa ou inventor | Módulo 5 | Baixo | Semanas | Alto |
| 2 | Automação para pequenos negócios | Instala e mantém monitoramento ou controle | Módulo 5 | Baixo | Semanas | Alto, com recorrência |
| 3 | Produto próprio de nicho | Pequenos lotes vendidos online | Módulo 6 | Médio | Meses | Médio |
| 4 | Kits e educação | Kits para montar, oficinas, aulas, curso | Módulo 3 | Baixo | Semanas | Médio |
| 5 | Reparo | Conserto de placas e aparelhos | Módulo 6 + prática | Baixo | Dias | Médio, local |
| 6 | Instalações e eventos | Peças interativas, painéis de LED, cenografia | Módulo 5 | Médio | Meses | Alto, irregular |
| 7 | Conteúdo | Vídeos, blog, afiliados, patrocínio | Qualquer | Baixo | Muitos meses | Incerto |
| 8 | Arquivos e licenças | Projeto de placa, firmware, modelo 3D vendidos como arquivo | Módulo 6 | Baixo | Meses | Baixo a médio |
| 9 | Carreira | Emprego ou contrato em sistemas embarcados | Módulo 6 | Nenhum | Meses | Alto e estável |

### 1. Projeto sob encomenda
Quem compra: startups que precisam de prova de conceito, pequenas indústrias, inventores, agências, pesquisadores com verba de projeto. Entrega típica: protótipo funcional, firmware, esquema e placa.

O portfólio da trilha (datalogger, robô, rede de sensores, placa própria) é exatamente o que esse cliente quer ver. Documente bem cada projeto-desafio: eles são seu material de venda.

### 2. Automação para pequenos negócios
O melhor modelo para começar, na minha opinião. Exemplos de dores reais:

| Cliente | Dor | Solução com o que você aprendeu |
|---|---|---|
| Restaurante, açougue, sorveteria, farmácia | Câmara fria desliga de madrugada; fiscalização pede registro de temperatura | Sensor + alerta no celular + relatório mensal |
| Cervejaria artesanal, queijaria | Controle de fermentação e maturação | Controle de temperatura com histórico |
| Estufa, hidroponia, viveiro | Irrigação, pH, clima | Sensores + atuadores + painel |
| Pequena indústria | Máquina antiga sem contagem de produção nem aviso de parada | Contador de ciclos, tempo parado, painel |
| Condomínio, sítio | Nível de caixa d'água, bomba, portão | Monitoramento e acionamento remoto |
| Granja, aviário, piscicultura | Temperatura, oxigênio, falta de energia | Alarme com redundância |

A estrutura de preço que sustenta: **instalação + mensalidade**. A mensalidade cobre monitoramento, relatório e manutenção, e é o que dá previsibilidade. Dez clientes pagando mensalidade valem mais que cem vendas avulsas.

O lado técnico deste modelo (sinais de 24 V, 4–20 mA, Modbus, proteção, caixa, onde termina seu trabalho e começa o do eletricista) está no [módulo 9](09-campo-e-industria.md), cujo projeto-desafio é justamente um monitor de câmara fria instalável.

Cuidado: se o seu sistema falhar e o cliente perder mercadoria, a conversa é com você. Contrato com limite de responsabilidade, alarme redundante e nunca prometer "garantia de que não vai perder".

### 3. Produto próprio de nicho
Funciona quando o nicho tem dinheiro, tem comunidade e é pequeno demais para interessar a fábrica chinesa. Nichos com esse perfil:

- **Aquarismo e terrários:** controladores de temperatura, iluminação, reposição de água.
- **Cerveja e café:** controle de fermentação, de torra, balanças com temporizador.
- **Simuladores de corrida e voo:** caixas de botões, painéis, freio de mão.
- **Teclados e periféricos:** macropads, botões programáveis, controles de volume.
- **Música:** pedais de efeito, módulos de sintetizador, controladores MIDI.
- **Modelismo e ferromodelismo:** iluminação, sinalização, decodificadores.
- **Astronomia amadora:** aquecedores anti-orvalho, focalizadores motorizados.
- **Casa inteligente local** (Home Assistant): sensores e atuadores que não dependem de nuvem.
- **Impressão 3D:** sensores de filamento, iluminação, gabinetes com controle.
- **Fantasia e cosplay:** iluminação e efeitos para adereços.
- **Gadgets de mesa:** objetos de decoração com tela, como o próprio Pocket AI. O acabamento artesanal em latão do vídeo que inspirou o projeto é um diferencial vendável.

Regra de escolha: você precisa **ser** do nicho ou ter acesso fácil a quem é. Vender para um grupo que você não frequenta é muito mais difícil.

### 4. Kits e educação
- **Kits para montar** (com solda) para adultos hobbistas: placa, componentes, instruções boas. Margem razoável, porque o cliente faz a montagem.
- **Oficinas** em escolas, espaços maker, empresas (integração de equipe) e eventos. Cobra-se por turma.
- **Aulas e mentoria** individuais para estudantes de engenharia e técnicos com trabalho de conclusão.
- **Curso gravado**, depois que você tiver público.

Atenção ao item sobre brinquedos em [Regras](#regras-que-derrubam-iniciante): kit vendido para criança entra em outra categoria regulatória.

### 5. Reparo
Demanda local constante e pouca concorrência qualificada: placas de máquina de lavar, de ar-condicionado inverter, de portão, fontes, videogames, áudio antigo. A trilha dá a base (medir, soldar, ler esquema), mas diagnóstico é uma habilidade à parte, que se ganha consertando. Bom como renda complementar imediata e como escola.

### 6. Instalações e eventos
Agências de marketing e cenografia pagam bem por peças interativas: totens, painéis de LED reativos, jogos de estande, troféus e brindes eletrônicos personalizados. Trabalho irregular, com prazo apertado. Chega-se por indicação e portfólio em vídeo.

### 7. Conteúdo
Sozinho, demora e é incerto. Vale como **motor de vendas dos outros modelos**: o vídeo do projeto traz o cliente do serviço e o comprador do produto.

### 8. Arquivos e licenças
Vender o projeto em vez do objeto: arquivos de fabricação, firmware, modelo 3D da caixa, apostila de montagem. Sem estoque, sem frete, sem garantia de hardware. Preço baixo e pirataria fácil; funciona melhor como complemento.

### 9. Carreira
Sistemas embarcados têm vaga e pouca gente com projeto para mostrar. Uma placa própria funcionando, com repositório bem documentado, pesa mais em entrevista do que certificado.

---

## Precificação

### Produto: a conta completa

O erro clássico é multiplicar o custo dos componentes por dois. A conta certa separa três grupos.

**A. Custo por unidade (em reais)**
- Componentes **postos na sua bancada**: preço + frete + imposto de importação + perdas (reserve 5% a 10%).
- Placa, caixa, cabos, parafusos.
- Embalagem, manual, etiqueta.
- **Seu tempo** de montagem, gravação e teste, a um valor por hora. Sempre. Se você não cobra seu tempo, não tem negócio, tem um hobby subsidiado.
- Reserva para garantia e devolução (3% a 5% do custo).

**B. Custo fixo por venda (em reais)**
- Taxa fixa do marketplace, sua parte do frete, embalagem de envio.

**C. Percentuais sobre o preço**
- Comissão do canal, taxa de pagamento, imposto, anúncios, e a margem de lucro que você quer.

```
Preço = (A + B) / (1 − soma dos percentuais de C)
```

Nunca some os percentuais em cima do custo. Eles incidem sobre o **preço**, por isso a divisão.

#### Exemplo: monitor de temperatura Wi-Fi para aquário

| A. Custo por unidade | R$ |
|---|---|
| Componentes postos na bancada | 55 |
| Placa | 6 |
| Caixa impressa em 3D e cabo | 9 |
| Embalagem e manual | 5 |
| Montagem e teste: 25 min a R$ 60/h | 25 |
| Reserva de garantia (5%) | 5 |
| **Total A** | **105** |

| C. Percentuais sobre o preço | Marketplace | Venda direta (Pix) |
|---|---|---|
| Comissão / taxa de pagamento | 14% | 2% |
| Imposto | 6% | 6% |
| Anúncios / divulgação | 5% | 5% |
| Lucro desejado | 20% | 20% |
| **Soma** | **45%** | **33%** |

| | Marketplace | Venda direta |
|---|---|---|
| B. Taxa fixa por venda | R$ 26 | R$ 0 |
| Conta | (105 + 26) / 0,55 | 105 / 0,67 |
| **Preço** | **≈ R$ 239** | **≈ R$ 159** + frete |
| Lucro por unidade | ≈ R$ 48 | ≈ R$ 32 |

Leituras do exemplo:

- R$ 55 de componentes viraram R$ 239 de preço: **4,3 vezes**. A regra de bolso do mercado de hardware é preço final entre 2,5 e 4 vezes o custo dos materiais, e o exemplo mostra de onde ela vem.
- O marketplace levou cerca de R$ 60 por venda, mais que o seu lucro. Em troca, traz o comprador. A venda direta rende menos por unidade no exemplo porque o preço é menor; com o mesmo preço de R$ 239 direto, o lucro sobe para cerca de R$ 111.
- Se o mercado não paga o preço calculado, o problema não é a fórmula. Mude o produto, o nicho ou o canal.

#### O desenvolvimento também custa

Suponha 80 horas de projeto a R$ 60/h mais R$ 600 em protótipos: **R$ 5.400**.

```
Ponto de equilíbrio = custo de desenvolvimento / lucro por unidade = 5.400 / 48 ≈ 112 unidades
```

Até a unidade 112, você está pagando o desenvolvimento. Duas saídas honestas: tratar o primeiro produto como aprendizado (e saber disso), ou reaproveitar a mesma placa e firmware em vários produtos.

#### Produto barato apanha das taxas

Marketplaces cobram taxa fixa por item além do percentual. Pela tabela da Shopee que encontrei, um item de até R$ 79,99 paga 20% mais cerca de R$ 4,50: em um produto de R$ 30, isso dá R$ 10,50, ou **35% do preço**. No Mercado Livre, itens abaixo de R$ 79 também têm custo por unidade, e acima disso o vendedor arca com parte do frete.

Consequências práticas:
- Evite produto de menos de R$ 80 em marketplace. Monte **conjuntos** para subir o valor da venda.
- Itens baratos (adesivos, placas pequenas, kits simples) vendem melhor por canal direto, em feira, ou como complemento de um pedido maior.

#### Técnicas de preço que funcionam

- **Três versões:** kit para montar, montado, e montado com acabamento ou extras. A do meio vende mais, e a de cima faz a do meio parecer razoável.
- **Preço por valor no B2B:** se o sistema evita R$ 5.000 de perda por ano, cobrar R$ 1.500 de instalação e R$ 120 por mês é fácil de defender, não importa que o material custe R$ 200.
- **Pré-venda:** valide a demanda e financie o lote antes de comprar componentes. Só com prazo realista e protótipo funcionando.
- **Não concorra em preço com importado.** Você perde. Concorra em adequação ao nicho, suporte em português, garantia local e documentação.
- **Reajuste.** Dólar e frete mudam o custo; revise a planilha a cada lote.

### Serviço: quanto cobrar

#### Valor da hora

```
Hora = (retirada desejada + custos fixos mensais) / (1 − imposto) / horas faturáveis no mês
```

**Horas faturáveis não são horas trabalhadas.** Prospecção, proposta, estudo, compra de material e retrabalho não são cobrados de ninguém. Em trabalho autônomo, conte com 50% a 60% do tempo faturável.

Exemplo em tempo integral: retirada de R$ 10.000, custos de R$ 1.500 (contador, ferramentas, software, internet), imposto de 12%, 80 horas faturáveis:

```
(10.000 + 1.500) / 0,88 / 80 ≈ R$ 163 por hora
```

Para renda complementar, a conta é a mesma com sua meta e suas horas. Como referência de mercado, as fontes que encontrei citam de R$ 50 a R$ 260 por hora para desenvolvedores autônomos de software no Brasil. **Não achei dado específico de sistemas embarcados**; a especialidade é mais rara, o que em geral permite ficar da metade para cima da faixa, mas isso é inferência minha.

#### Projeto fechado

Clientes preferem preço fechado. Para não perder dinheiro:

1. **Divida em fases**, cada uma com entrega e pagamento: estudo de viabilidade → protótipo em protoboard → placa → lote piloto. O cliente pode parar ao fim de qualquer fase, e você nunca fica com meses de trabalho a receber.
2. **Estime as horas e multiplique por 1,3 a 1,5.** Hardware sempre tem uma revisão de placa a mais e um componente que não chega.
3. **Material é à parte.** Componentes, placas e frete são reembolsados ou pagos direto pelo cliente, com uma taxa de administração. Nunca embutidos no seu preço de serviço.
4. **Entrada de 30% a 50%** antes de começar.
5. **Escopo escrito:** o que está incluído, quantas rodadas de ajuste, o que conta como mudança (e quanto custa a hora extra).
6. **Critério de aceite mensurável**, como nos projetos-desafio da trilha. "Funciona" não é critério; "registra a temperatura a cada 5 min por 7 dias sem falha" é.

#### O que precisa estar no contrato

| Item | Por quê |
|---|---|
| Propriedade do projeto | O cliente recebe os arquivos-fonte ou só o produto funcionando? Cobre mais pela transferência total. |
| Reuso | Você pode reaproveitar blocos genéricos (drivers, bibliotecas próprias) em outros clientes. |
| Garantia do serviço | Prazo para corrigir defeito seu, sem custo. Mudança de requisito não é defeito. |
| Manutenção | Contrato mensal opcional para suporte e atualizações. É a sua recorrência. |
| Certificação | Homologação e ensaios são responsabilidade e custo do cliente, salvo combinado. |
| Limite de responsabilidade | Teto de indenização, normalmente o valor do contrato. |
| Prazo e dependências | Seu prazo conta a partir da entrada e da chegada do material. |

#### Sinais de cliente ruim
"É simples, coisa de uma tarde"; pede desconto antes de entender o escopo; quer participação nos lucros em vez de pagamento; não sabe dizer quem vai usar; some depois da proposta e volta com urgência.

---

## O que vender ("merch") e como apresentar

### Formatos de produto

| Formato | Vantagem | Cuidado |
|---|---|---|
| Kit para montar | Sem custo de montagem; cliente valoriza a experiência | Instrução precisa ser excelente; suporte a erro de solda |
| Produto montado | Maior valor percebido | Seu tempo, teste e garantia |
| Placa montada sem caixa | Simples de produzir; público técnico | Público pequeno |
| Conjunto (produto + acessórios) | Sobe o valor da venda e dilui taxa fixa | Estoque de mais itens |
| Edição limitada numerada | Preço maior, cria urgência | Só funciona com público formado |
| Personalizado (nome, cor, gravação) | Preço maior, difícil de comparar | Não aceita devolução simples; prazo |
| Hardware + assinatura | Receita recorrente | Você vira responsável por um serviço no ar |

### Merch no sentido estrito

Itens de marca para a comunidade: placas decorativas e chaveiros que acendem, crachás eletrônicos para eventos, adesivos, réguas de referência em placa de circuito, camisetas. A margem sozinha é pequena. O papel deles é outro:

- **Porta de entrada:** item de R$ 20 a R$ 40 que apresenta sua marca e completa o carrinho.
- **Encomenda corporativa:** crachá ou brinde eletrônico personalizado para evento, comunidade ou empresa, em lote de 50 a 500. É aqui que merch dá dinheiro de verdade, porque o preço é por projeto.
- **Placa como arte:** a serigrafia e o cobre exposto permitem desenho. Chaveiro com um LED e uma bateria de relógio é o produto mais simples que existe e ensina todo o ciclo de produção.

### Apresentação: o que faz vender

1. **Vídeo curto do objeto funcionando**, nos primeiros 3 segundos. Para eletrônica, nada substitui.
2. **Fotos limpas:** fundo neutro, luz de janela, uma foto com a mão ou um objeto para dar escala, uma foto em uso real.
3. **Título pelo problema**, com as palavras que o comprador digita: "Alarme de temperatura Wi-Fi para freezer", não "Módulo ESP32 DS18B20".
4. **O que vem na caixa** e o que **não** vem (fonte, cartão, bateria).
5. **Manual de verdade**, em português, com foto. Também reduz suporte e devolução.
6. **Embalagem cuidada.** Caixa simples com adesivo da marca, saco antiestático, um cartão com QR para o manual. Custa pouco e muda a percepção.
7. **Prova:** avaliações, fotos de clientes, o repositório público, vídeo de teste de bancada.

### Canais de venda

| Canal | Serve para | Observação |
|---|---|---|
| Mercado Livre | Produto com procura por busca | Comissão por categoria (encontrei de 10% a 14% no Clássico e 15% a 19% no Premium) mais custos de envio. |
| Shopee | Itens de valor mais baixo, público sensível a preço | Comissão por faixa de preço, com taxa fixa por item. |
| Loja própria (Nuvemshop, Loja Integrada e similares) | Marca e margem | Você traz o tráfego. |
| Instagram + WhatsApp + Pix | Começar, nicho, sob encomenda | Menor taxa; emita nota do mesmo jeito. |
| Elo7 | Peças artesanais e personalizadas | Combina com acabamento manual, como o latão. |
| Grupos e fóruns do nicho | Os primeiros 20 clientes | Participe antes de vender; respeite as regras do grupo. |
| Feiras e eventos maker | Vender, testar preço, conhecer cliente | Ótimo para kits e merch. |
| Tindie, Lectronz | Vender para fora, em dólar ou euro | Exige exportar: frete internacional, alfândega do destino. Confirme a situação atual da plataforma antes. |
| Catarse e pré-venda própria | Financiar o primeiro lote | Atraso em hardware é a regra; prometa com folga. |
| Workana, 99Freelas, Upwork | Primeiros serviços | Concorrência por preço; use para montar histórico e saia. |
| LinkedIn e indicação | Serviço para empresas | De onde vêm os melhores contratos. |

### Divulgação que funciona para hardware

- **Construa em público.** Poste o processo: o protótipo feio, o erro na placa, o teste. Gera audiência antes de existir produto.
- **Lista de espera** antes de produzir. Se 100 pessoas não deixam o e-mail, não vão deixar o cartão.
- **Código ou esquema aberto** como marketing: dá confiança ao público técnico. A cópia existe, mas quem copia raramente era seu cliente.
- **Um nicho, um canal, até saturar.** Espalhar-se por cinco redes com um produto não funciona.
- **Para B2B, estudo de caso:** uma página com o problema do cliente, a solução e o resultado em número.

---

## Regras que derrubam iniciante

### Anatel: tudo que tem rádio

Wi-Fi, Bluetooth, LoRa: produto com transmissor de radiofrequência vendido no Brasil está sujeito a homologação da Anatel. Como isso se aplica ao ESP32:

- **Não presuma isenção** por usar módulo homologado. Pelo que encontrei, o módulo homologado (ESP32-WROOM, ESP32-S3-WROOM e outros da Espressif têm certificado) reduz o escopo de ensaios do produto final, mas não elimina a homologação dele. Os próprios certificados dos módulos tratam o módulo como produto não acabado.
- Há previsão, citada no certificado do ESP32-S3-WROOM-1 (Ato Anatel 4088/2020), de produto **não sujeito a homologação** que incorpora módulo homologado informar no manual o número de homologação do módulo. Não consegui confirmar em que condições isso se aplica; esclareça com um organismo de certificação antes de contar com isso.
- **Placas de desenvolvimento genéricas** (clones baratos, com chip avulso em vez de módulo certificado) normalmente **não** têm homologação.
- Marketplaces vêm exigindo o código de homologação em categorias de produtos sem fio.

Na prática, para quem está começando:
1. Projete com **módulo homologado** e confira o número no sistema da Anatel.
2. Para um produto de série, orce a homologação com um organismo de certificação **antes** de definir o preço. É um custo de desenvolvimento, e entra no ponto de equilíbrio.
3. Enquanto isso, há caminhos que não dependem disso: serviço de projeto, kits e produtos **sem rádio**, e projetos sob encomenda em que a regularização do produto final é do cliente (escrito em contrato).

### Inmetro

Certificação obrigatória para categorias específicas. As que mais pegam eletrônica maker:

- **Brinquedos.** Certificação compulsória. Kit eletrônico vendido para criança, com embalagem e comunicação infantil, entra aqui. Posicione kits para adultos e hobbistas, e diga isso no anúncio.
- **Fontes, carregadores, plugues e tomadas.** Não fabrique nem revenda fonte sem certificação. Solução: produto alimentado por **USB 5 V, vendido sem fonte**; o cliente usa o carregador dele.
- **Qualquer coisa ligada na rede elétrica.** Mesmo sem certificação específica, o risco é seu (ver abaixo). Fique em baixa tensão enquanto puder.

### Código de Defesa do Consumidor

- **Arrependimento:** em compra online, o cliente pode devolver em 7 dias, sem justificar. Entra na sua reserva de custo.
- **Garantia legal:** 90 dias para produto durável, mesmo que você não ofereça nenhuma.
- **Responsabilidade pelo dano:** se o produto causar prejuízo ou acidente, o fabricante responde independentemente de culpa. É o argumento definitivo para baixa tensão, bateria com proteção e fusível.

### Baterias de lítio no frete

Os Correios restringem lítio: pelo que encontrei, bateria avulsa é proibida, bateria instalada no equipamento tem limites, e as regras variam por serviço e trecho. Declarar errado pode bloquear a conta. Alternativas: vender sem bateria (o cliente compra à parte), usar pilhas comuns, ou transportadora que aceite.

### Formalização e imposto

| Forma | Para quê | Pontos de atenção |
|---|---|---|
| **MEI** | Começar a vender produto | Limite de R$ 81.000 por ano em 2026 (há projeto para aumentar, ainda não aprovado pelo que vi). Imposto fixo mensal na faixa de R$ 82 a R$ 87. Só atividades da lista oficial. |
| **Microempresa no Simples** | Serviço de engenharia e desenvolvimento, ou quando passar do limite | Alíquota inicial de cerca de 4% (comércio), 4,5% (indústria) e 6% ou 15,5% (serviços, conforme o enquadramento). Precisa de contador. |

Pontos que geram problema:

- **Serviço de engenharia não cabe no MEI.** Profissão regulamentada por conselho fica fora. Sobre desenvolvimento de software as fontes se contradizem; confira a lista oficial de ocupações. Para prestar serviço como engenheiro, o caminho usual é microempresa, e pode haver exigência de registro no CREA e de ART conforme o serviço.
- **Importar para revender não é a mesma coisa que importar para uso.** O regime simplificado de compras internacionais (Remessa Conforme), com a isenção de imposto de importação até US$ 50 que as fontes dizem valer desde maio de 2026 (ICMS continua), é para **pessoa física**. Insumo de produto vendido por CNPJ precisa de origem com nota: fornecedor nacional ou importação formal. Alinhe com o contador antes do primeiro lote.
- **Emita nota fiscal** em toda venda. Marketplaces exigem, e é o que sustenta sua garantia e seu histórico.
- **Marca:** antes de investir em nome e embalagem, pesquise e registre no INPI.
- **Dados:** produto conectado que guarda dados do cliente em servidor seu entra na LGPD. Colete o mínimo.

---

## Operação: do protótipo ao lote

- **Lote piloto de 10 a 20** antes de qualquer lote maior. Os problemas de montagem aparecem na quinta unidade, não na primeira.
- **Gabarito de teste:** uma base com pinos de contato e um firmware de teste que aprova ou reprova cada placa em segundos. É o que separa produto de artesanato.
- **Projete para montar rápido:** menos fios soldados à mão, conectores, caixa que fecha sem cola. Cada minuto de montagem é custo em toda unidade.
- **Montagem terceirizada:** a partir de algumas dezenas de unidades, vale orçar a placa já montada pelo fabricante. Sobra para você gravar, testar e encaixar.
- **Estoque de componentes críticos:** tenha segunda opção para cada peça importante; componente some do mercado.
- **Atualização de firmware pelo ar** (módulo 5) reduz devolução: você corrige defeito sem a placa voltar.
- **Número de série e registro** de cada unidade: lote, data, versão de firmware. Indispensável quando aparecer o primeiro defeito em campo.
- **Suporte:** manual, página de perguntas frequentes e um canal só. Meça quanto tempo cada venda consome em suporte e ponha na planilha.

---

## Roteiro sugerido

| Fase | Quando | O que fazer | Meta |
|---|---|---|---|
| 0 | Durante os módulos 2 a 4 | Publique cada projeto-desafio com vídeo e documentação | Portfólio e primeiros seguidores |
| 1 | Após o módulo 5 | Um projeto de automação para um negócio conhecido (amigo, família), cobrando | Primeiro cliente e estudo de caso |
| 2 | Após o módulo 6 | Um produto pequeno em lote de 10 a 20, para um nicho que você frequenta | Ciclo completo de produto |
| 3 | Depois | Decida com dados: aprofundar serviço, produto, ou os dois | Renda recorrente |

## Projeto-desafio — Os primeiros R$ 1.000

**Missão:** receber R$ 1.000 de pessoas que você não conhece, com eletrônica feita por você.

### Requisitos
1. **Antes de construir:** converse com 5 pessoas do público-alvo. Pergunte como resolvem o problema hoje e quanto gastam. Não apresente sua solução.
2. **Planilha de preço** com os grupos A, B e C, para pelo menos dois canais.
3. **Página de venda** com vídeo, fotos, o que vem na caixa e manual.
4. **Lote de 10 unidades** (produto) ou **proposta em fases** com contrato (serviço).
5. **Tempo cronometrado** de montagem e teste por unidade, e de suporte por venda.
6. **Verificação regulatória** escrita: tem rádio? Liga na rede? É para criança? Tem lítio? Como cada ponto foi tratado.

### Critérios de aceite
- [ ] R$ 1.000 recebidos, com nota fiscal emitida.
- [ ] Pelo menos 3 compradores sem relação pessoal com você.
- [ ] Lucro real por unidade calculado **depois** das vendas, comparado com o planejado.
- [ ] Uma lista do que você mudaria no produto, no preço e no canal.

<details>
<summary>Dica 1 — o produto mais simples possível</summary>

O primeiro produto serve para aprender o ciclo de venda, não para ficar rico. Sem rádio, alimentado por USB, sem bateria, para adultos: assim nenhuma das regras pesadas se aplica. Um kit de solda bonito ou um gadget de mesa já ensinam tudo.
</details>

<details>
<summary>Dica 2 — ninguém comprou</summary>

Quase sempre é um destes: o público não tem o problema; tem, mas não paga por ele; ou paga, mas não ficou sabendo. As 5 conversas do requisito 1 distinguem os dois primeiros. O terceiro é canal: vá onde o nicho já está.
</details>

<details>
<summary>Dica 3 — serviço em vez de produto</summary>

Com um único projeto de automação para um pequeno negócio você passa de R$ 1.000 na instalação e ainda sai com uma mensalidade e um estudo de caso.
</details>

### Chefão (opcional)
- **R$ 1.000 por mês recorrentes** em mensalidades de monitoramento.
- **Segundo lote de 50** com montagem terceirizada e gabarito de teste.
- **Uma encomenda corporativa** de merch eletrônico personalizado.

## Checkpoint

- [ ] Monta a planilha de preço de um produto sem esquecer tempo, taxas e garantia.
- [ ] Calcula o valor da sua hora e defende um orçamento por fases.
- [ ] Sabe dizer, para qualquer ideia de produto, quais regras se aplicam.
- [ ] Já vendeu para alguém que não é seu amigo.

## Onde conferir

Fontes oficiais para confirmar o que muda:

| Assunto | Onde |
|---|---|
| MEI: limite, valor mensal, ocupações permitidas | [Portal do Empreendedor](https://www.gov.br/empresas-e-negocios/pt-br/empreendedor) |
| Homologação de produtos com rádio | [Anatel](https://www.gov.br/anatel/pt-br) |
| Certificação compulsória | [Inmetro](https://www.gov.br/inmetro/pt-br) |
| Importação e Remessa Conforme | [Receita Federal](https://www.gov.br/receitafederal/pt-br) |
| Registro de marca | [INPI](https://www.gov.br/inpi/pt-br) |
| Tarifas de venda | Central de vendedores do Mercado Livre e [política de comissão da Shopee](https://seller.shopee.com.br/edu/article/18483) |
| Orientação gratuita para abrir negócio | [Sebrae](https://sebrae.com.br/) |

Fontes que usei para os números deste módulo (secundárias, consultadas em 16/11/2026):

- MEI: [Contmatic](https://simplifique.contmatic.com.br/blogs/mei-2026-limite-faturamento-o-que-muda), [InfinitePay](https://infinitepay.io/blog/limite-faturamento-mei-2026), [AMDJUS](https://amdjus.com.br/valor-do-das-mei-para-2026-reajuste-acompanha-aumento-do-salario-minimo/), [Contabilidade Zen](https://www.contabilidadezen.com.br/blog/mei-prestador-servico-cnaes-2026/).
- Anatel: [certificado do ESP32-S3-WROOM-1](https://www.espressif.com/sites/default/files/ESP32-S3-WROOM-1%20ANATEL%20Certification.pdf), [certificado do ESP32-WROOM-32D](https://www.espressif.com/sites/default/files/ESP32-WROOM-32D%20ANATEL%20Certification.pdf), [ABCP Certificação](https://abcpcertificacao.com.br/blog/homologacao-anatel-modulos-iot-nbiot-ltem-lora-sigfox/).
- Importação: [Econet](https://blog.econeteditora.com.br/remessa-conforme-o-que-muda-com-a-portaria-mf-1-342-2026/), [Arq Finance](https://www.arqfinance.com/articles/imposto-compras-internacionais-brasileiros/), [CalculaCentro](https://calculacentro.com/calculadora/imposto-importacao).
- Marketplaces: [Bling](https://blog.bling.com.br/taxas-mercado-livre/), [HunterHub](https://hunterhub.com.br/blog/taxas-mercado-livre-2026-quanto-paga-por-venda/), [Irroba](https://blog.irroba.com.br/novas-taxas-shopee-2026-guia-de-comissoes-e-frete/), [Shopee](https://seller.shopee.com.br/edu/article/18483).
- Inmetro e frete: [Inmetro, kits](https://www.gov.br/inmetro/pt-br/acesso-a-informacao/perguntas-frequentes/avaliacao-da-conformidade/artigos-escolares/quando-e-formado-um-kit-exemplo-brinquedo-e-artigo-escolar-vendidos-em-mesma-embalagem-como-proceder-com-a-certificacao), [Portaria Inmetro 563/2016](https://www.legisweb.com.br/legislacao/?id=334763), [SuperFrete](https://superfrete.com/blog/proibicoes-restricoes-correios), [Tecnoblog](https://tecnoblog.net/noticias/correios-celulares-baterias-sedex/).
- Valor de hora: [Monitor do Mercado](https://monitordomercado.com.br/noticias/399275-quanto-um-programador-freelancer-cobra-por-hora-no-brasil-em-2026-e-o-que-define-o-nivel-junior-pleno-e-senior/), [Agilize](https://agilize.com.br/artigos/quanto-cobrar-como-desenvolvedor-pj), [Clockify](https://clockify.me/pt/average-hourly-rates).
