function [offspring1, offspring2] = PermCrossover(parent1, parent2, crossover_op)
% Funzione switch per crossover con permutazione
    switch crossover_op(1)
        case 1  % PMX
            [offspring1, offspring2] = PMX(parent1, parent2);
        case 2  % OX
            [offspring1, offspring2] = OX(parent1, parent2);
    end
end