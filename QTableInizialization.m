function [Qtable] = QTableInizialization(type, idx, population, Algo)
% Inizializzazione della QTable

    if strcmpi(type, 'permutation')
        crossover_types = 1:2; % PMX, OX    
    else 
        crossover_types = 1:3; % 1,2, uniforme           
    end
    
    % Numero totale di azioni (combinazioni di mutazioni e crossover):
    num_actions = numel(crossover_types) * numel(Algo.crossover_rates) * numel(Algo.mutation_types) * numel(Algo.mutation_rates);
    % Numero totale di stati (combinazioni di cluster):
    num_states  = size(Algo.states, 1);
    
    % Generazione di tutte le combinazioni degli operatori genetici
    % Per ogni combinazione creiamo una matrice 2×2:
    %   - Prima riga (Crossover): [crossover_type, crossover_rate]
    %   - Seconda riga (Mutazione): [mutation_type, mutation_rate]
    actions = cell(1, num_actions);
    actionIndex = 1;
    for i = 1:length(crossover_types)
        for j = 1:length(Algo.crossover_rates)
            for k = 1:length(Algo.mutation_types)
                for l = 1:length(Algo.mutation_rates)
                    gaOperators = [ crossover_types(i), Algo.crossover_rates(j);
                                    Algo.mutation_types(k) , Algo.mutation_rates(l) ];
                    actions{actionIndex} = gaOperators;
                    actionIndex = actionIndex + 1;
                end
            end
        end
    end
    
    % La Q-table è una cell array di dimensione 6×54 o 6x36
    Qtable = cell(num_states, num_actions);
    
    % In ogni cella viene salvata una struttura con:
    %   - reward: 
    %   - state: vettore 1×2 corrispondente allo stato (riga della Q-table)
    %   - gaOperators: la matrice 2×2 della combinazione d'azione
    rewards = InitializeQTableRewards(idx, population, Algo);
    for s = 1:num_states
        for a = 1:num_actions
            cellStruct.reward = rewards(s);
            cellStruct.state = Algo.states(s, :);
            cellStruct.gaOperators = actions{a};
            Qtable{s, a} = cellStruct;
        end
    end
end

% Inizializzaione dei reward. Può variare da 1 a -1
function reward = InitializeQTableRewards(idx, population, Algo) 
    num_clusters = 3;
    num_pairs = size(Algo.states, 1);

    % Calcola la fitness media per ciascun cluster
    cluster_fitness = zeros(num_clusters, 1);
    for i = 1:num_clusters
        selected_solutions = population(idx == i);
        objectives = cat(1, selected_solutions.obj);  
        
        % Calcola la norma euclidea per ogni riga (ogni soluzione)
        scalar_objectives = vecnorm(objectives, 2, 2);  % 2 indica la norma euclidea, 2 indica la dimensione lungo le righe
        
        % Calcola la media dei valori scalari
        cluster_fitness(i) = mean(scalar_objectives);
    end
    
    % Calcola il valore combinato per ogni coppia.
    combined_fitness = zeros(num_pairs, 1);
    for i = 1:num_pairs
        c1 = Algo.states(i, 1);
        c2 = Algo.states(i, 2);
        combined_fitness(i) = (cluster_fitness(c1) + cluster_fitness(c2)) / 2;
    end
    
    % Mappatura lineare dei valori combinati nell'intervallo [-1, 1]
    f_min = min(combined_fitness);
    f_max = max(combined_fitness);
    
    if f_max == f_min
        reward = ones(num_pairs, 1);  % Se tutti i valori sono uguali, assegna ad ognuno 1 (oppure 0, se preferisci)
    else
        reward = 2 * (combined_fitness - f_min) / (f_max - f_min) - 1;
    end
end