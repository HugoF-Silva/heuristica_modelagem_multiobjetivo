# Atividade 06 - Estratégias evolutivas e Algoritmos Genéticos 
- 202108075 – ANDRÉ LUIS ARAÚJO DE SOUZA<br>
- 202105848 – HUGO FERNANDES SILVA<br>
- 202105854 – LUCAS BRANDÃO RODRIGUES<br>
- 202105858 – MARCELO HENRIQUE LOPES FERREIRA<br>
- 202105865 – RAFAEL ALVES GOIAS<br>

O problema "Classificação de Cervejas" é um desafio complexo no campo da análise de dados, frequentemente enfrentado na indústria de bebidas e alimentos. Neste problema, supomos que um cientista de dados possui um conjunto de características extraídas de várias amostras de cerveja e deseja classificá-las de acordo com a marca da cerveja. O objetivo é construir um modelo preditivo eficaz que utilize o mínimo de características possível, sem comprometer a precisão do modelo.

As "Estratégias Evolutivas" se tornam ferramentas poderosas para resolver este problema. Estes algoritmos se baseiam nos princípios da evolução natural para evoluir uma população de soluções possíveis (neste caso, subconjuntos de características) através de processos de mutação e seleção. A mutação ajuda a explorar o espaço de busca e a descobrir novas soluções potenciais, enquanto a seleção direciona a busca para soluções de alta qualidade. Em nosso contexto, a solução de maior qualidade seria o subconjunto de características que oferece a maior acurácia de classificação com o menor número de características.

Os "Algoritmos Genéticos" são um tipo específico de estratégia evolutiva que também utiliza operações de cruzamento (ou recombinação) além de mutação e seleção. Os algoritmos genéticos operam em uma codificação genética das soluções - no caso do nosso problema, a representação genética poderia ser um vetor binário, onde cada gene indica a inclusão (ou não) de uma característica específica. O cruzamento permite combinar partes de diferentes soluções, potencialmente descobrindo combinações de características que são mais eficazes do que qualquer subconjunto encontrado anteriormente.
