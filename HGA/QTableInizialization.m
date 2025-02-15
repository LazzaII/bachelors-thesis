function [Qtable] = QTableInizialization(type, Algo)
% Inizializzazione della QTable con valori Q iniziali
   
    if type(1) == 5 %permutation'
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
    for s = 1:num_states
        for a = 1:num_actions
            cellStruct.value = 0; 
            cellStruct.state = Algo.states(s, :);
            cellStruct.gaOperators = actions{a};
            Qtable{s, a} = cellStruct;
        end
    end
end

