function [Qtable] = QTableInizialization(type, Algo)
% initialization of the QTable with initial Q values
   
    if type(1) == 5 %permutation'
        crossover_types = 1:2; % PMX, OX    
    else 
        crossover_types = 1:3; % 1,2, uniforme           
    end
    
    % total number of actions (combinations of mutations and crossovers):
    num_actions = numel(crossover_types) * numel(Algo.crossover_rates) * numel(Algo.mutation_types) * numel(Algo.mutation_rates);
    % total number of states (combinations of clusters):
    num_states  = size(Algo.states, 1);
    
    % Generation of all combinations of genetic operators
    % For each combination, we create a 2×2 matrix:
    %   - First row (Crossover): [crossover_type, crossover_rate]
    %   - Second row (Mutation): [mutation_type, mutation_rate]
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
    
    % the Q-table is a cell array of size 6×54 or 6×36
    Qtable = cell(num_states, num_actions);
    
    % each cell stores a structure with:
    %   - reward: 
    %   - state: a 1×2 vector corresponding to the state (row of the Q-table)
    %   - gaOperators: the 2×2 matrix of the action combination
    for s = 1:num_states
        for a = 1:num_actions
            cellStruct.value = 0; 
            cellStruct.state = Algo.states(s, :);
            cellStruct.gaOperators = actions{a};
            Qtable{s, a} = cellStruct;
        end
    end
end

