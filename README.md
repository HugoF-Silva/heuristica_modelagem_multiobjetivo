# Atividade 01 
- 202108075 – ANDRÉ LUIS ARAÚJO DE SOUZA<br>
- 202105848 – HUGO FERNANDES SILVA<br>
- 202105865 – RAFAEL ALVES GOIAS<br>

## Objetivo
Aprender por meio da implementação as diferenças entre um agente reativo
simples e um agente com objetivo usando a busca em largura.

# 0. Criando Ambiente
Inspirado na notória franquia Grand Theft Auto, desenvolvemos um ambiente com um Agente "Carro" e Recursos estacionários "Pessoas" no estilo "sheep & wolves" (portanto são duas classes de agentes), estes quais iniciam distribuídos pelo grid de patches.
O agente único se move pelo ambiente em busca dos recursos. Assim que um recurso é alcançado, é somado ao +1 ao status quantitativo do agente único (carro).
Enquanto isso, ao longo dos ticks (fluxo de tempo discreto do netlogo), enquanto o Carro se move, é calculado seus km rodados.
Dessa forma, com o status quantitativo base e o tanto de km rodado (calculado sobre o tempo passado), é possível medir o desempenho a cada "rodada" (independente do tipo de agente que o carro é).

# 1. Agente Reativo Simples
O Carro se move aleatoriamente pelo grid de patches (pontos cardeais a ele -- Norte, Sul, Leste, Oeste) detectando se há pessoas num raio de 1 patch.
Caso detectada, o carro atravessa a pessoa contando +1 pro status e retirando a pessoa do ambiente.
O Carro continua até que ele alcance o limite settado.
Quando o carro alcança o limite, ele muda de cor para o vermelho, e volta para o (-40, -40).

# 2. Agente com Busca
O Carro se move com base em uma busca, a qual consiste em:
Sair do ponto de origem (raiz -- nesse caso é o centro do mapa),
Percorre toda a linha atual em uma direção buscando os recursos no caminho (o agente alterna de branch em branch à direita -- cada branch é um patch)
Quando o agente termina a linha, ele se desloca para a de cima. O agente continua até encontar a quantidade máxima de recursos settada.
Ao encontrar, muda a cor para vermelho e volta para a origem.

# 3. Comparação
Tendo como base as medições citadas (status quantitativo base e o tanto de km rodado -- calculado sobre o tempo passado), vemos que:
 
