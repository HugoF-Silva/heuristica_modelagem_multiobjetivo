# Atividade 03 - Hill Climbing e Simulated Annealing
- 202108075 – ANDRÉ LUIS ARAÚJO DE SOUZA<br>
- 202105848 – HUGO FERNANDES SILVA<br>
- 202105854 – LUCAS BRANDÃO RODRIGUES<br>
- 202105858 – MARCELO HENRIQUE LOPES FERREIRA<br>
- 202105865 – RAFAEL ALVES GOIAS<br>

## Objetivo
Aplicar os métodos estudados (Hill Climbing e Simulated Annealing) para solução de problemas.

# 1. Hill Climbing

O Hill Climbing é um algoritmo de busca local que tenta encontrar o máximo (ou mínimo) de uma função objetivo, considerando apenas movimentos locais. Ele começa com uma solução inicial e, em cada iteração, faz uma pequena alteração na solução atual e avalia se a nova solução é melhor ou pior que a solução atual. Se for melhor, a nova solução se torna a solução atual e o processo continua. Caso contrário, a busca é encerrada. A ideia é "subir a encosta" em direção à melhor solução possível. No entanto, o Hill Climbing pode ficar preso em ótimos locais, onde não há mais movimentos que levem a soluções melhores. Portanto, é uma técnica de busca local que não garante encontrar a melhor solução global.

## 1.1. Alterações no código fornecido

Foi desenvolvida para essa atividade o bloco de código responsável pela coleta de dados após a execução do algoritmo, na condicional da função go. Durante o loop principal, é feita uma checagem do estado de todos os agentes. Caso todos estejam em um vale (alcançaram um máximo local em que nenhum dos vizinhos próximos possui valores maiores), é registrada a maior altura alcançada pelos agentes (máximo local encontrado) e a altura máxima do ambiente (máximo global) através das variáveis globais adicionadas. É também registrado se os agentes encontraram o máximo global durante a iteração.

## 1.2. Experimentos

Foram feitos experimentos com diferentes números de agentes (2, 5, 10 e 15 agentes), realizando 200 iterações para cada número de agentes:

### 1.2.1 Número de estados explorados

![Gráfico de número de estados por número de agentes](https://github.com/HugoF-Silva/heuristica_modelagem_multiobjetivo/blob/main/atividade_03/images/01.png?raw=true)

Considerando os resultados do experimento, podemos observar que o número de estados explorados cresce de acordo com o número de agentes no ambiente. Isso faz com que a probabilidade de o algoritmo encontrar um ótimo global aumente, uma vez que ele vai explorar mais estados.

### 1.2.2 Altura máxima alcançada

![Gráfico de altura máxima encontrada por número de agentes](https://github.com/HugoF-Silva/heuristica_modelagem_multiobjetivo/blob/main/atividade_03/images/02.png?raw=true)

Assim como no experimento anterior, a altura máxima encontrada cresce de acordo com o número de agentes do ambiente. Isso acontece porque com mais agentes, é possível explorar mais estados, aumentando a chance de encontrar alturas maiores (máximos locais).

### 1.2.3 Altura máxima possível

![Gráfico de altura possível do ambiente por número de agentes](https://github.com/HugoF-Silva/heuristica_modelagem_multiobjetivo/blob/main/atividade_03/images/03.png?raw=true)

Nesse experimento, podemos observar uma distribuição semelhante de altura máxima. Isso porque a altura máxima do ambiente independe do número de agentes, sendo gerada randomicamente no início de cada iteração.

### 1.2.4 Porcentagem de casos em que o máximo global foi encontrado

![Gráfico de porcentagem de sucesso por número de agentes](https://github.com/HugoF-Silva/heuristica_modelagem_multiobjetivo/blob/main/atividade_03/images/04.png?raw=true)

Com mais agentes, a porcentagem de sucesso dos agentes aumentou de forma significativamente, triplicando de valor entre 2 e 5 agentes, e dobrando novamente entre 5 e 15 agentes. Ao final do experimento, foi alcançada uma taxa de sucesso de quase 60% com 15 agentes.

# 2. Simulated Annealing

O Simulated Annealing é um algoritmo de otimização que se inspira no processo de recozimento de metais para resolver problemas complexos. Sua abordagem consiste em explorar diferentes soluções em um espaço de busca, fazendo pequenas alterações em uma solução inicial. O algoritmo permite, em estágios iniciais, aceitar movimentos para soluções piores, o que ajuda a evitar mínimos locais e explorar regiões do espaço de busca que poderiam levar a uma solução melhor. À medida que a temperatura diminui gradualmente, a probabilidade de aceitar soluções piores também diminui, o que permite ao algoritmo convergir para uma solução ótima ou próxima dela. Essa técnica flexível e eficaz tem sido amplamente aplicada em áreas como engenharia, ciência da computação e logística, para resolver problemas desafiadores de roteamento, escalonamento, planejamento e design, entre outros.

## 2.1. Alterações no código fornecido

Na linha 71, foi implementado um sistema de resfriamento da temperatura em função da variável cooling-rate (definida pelo usuário). Também foi adicionado um critério de parada definitivo na linha 79, terminando a execução caso a temperatura alcance valores menores do que 1e-8 antes de a solução ótima ser encontrada. Além disso, o método accept-swap foi desenvolvido (linhas 142~152), aceitando uma mudança de estado caso a energia nova seja menor do que a anterior ou um critério dependente da temperatura seja alcançado (quanto maior a temperatura, mais facilmente a mudança será aceita).

## 2.2. Experimentos

### 2.2.1. Encontrando a temperatura ideal para o *stop*

*descrever testes feitos diminuindo o threshold que para o experimento até que o experimento comecasse a achar o mínimo global*;

### 2.2.2. Efeito da temperatura

*descrever e comparar experimentos rodando o código com temperatura = 1 e temperatura = 10*
