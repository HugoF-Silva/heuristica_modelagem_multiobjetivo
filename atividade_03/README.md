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

### 1.2.1. Testes realizados com quantidades diferentes de agentes

*Teste o algoritmo com 2, 5, 10 e 15 agentes. Compare os resultados obtidos
considerando em quais casos foi obtida a solução ótima, quantidade de estados
necessários para obter o melhor resultado em média. Teste várias vezes o algoritmo
para cada uma das quantidades de agentes.*

### 1.2.2. Efeito da temperatura

*descrever e comparar experimentos rodando o código com temperatura = 1 e temperatura = 10*

# 2. Simulated Annealing

O Simulated Annealing é um algoritmo de otimização que se inspira no processo de recozimento de metais para resolver problemas complexos. Sua abordagem consiste em explorar diferentes soluções em um espaço de busca, fazendo pequenas alterações em uma solução inicial. O algoritmo permite, em estágios iniciais, aceitar movimentos para soluções piores, o que ajuda a evitar mínimos locais e explorar regiões do espaço de busca que poderiam levar a uma solução melhor. À medida que a temperatura diminui gradualmente, a probabilidade de aceitar soluções piores também diminui, o que permite ao algoritmo convergir para uma solução ótima ou próxima dela. Essa técnica flexível e eficaz tem sido amplamente aplicada em áreas como engenharia, ciência da computação e logística, para resolver problemas desafiadores de roteamento, escalonamento, planejamento e design, entre outros.

## 2.1. Alterações no código fornecido

.

## 2.2. Experimentos

### 2.2.1. Encontrando a temperatura ideal para o *stop*

*descrever testes feitos diminuindo o threshold que para o experimento até que o experimento comecasse a achar o mínimo global*;

### 2.2.2. Efeito da temperatura

*descrever e comparar experimentos rodando o código com temperatura = 1 e temperatura = 10*
