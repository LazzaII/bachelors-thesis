function [offspring1, offspring2] = BinRealCrossover(parent1, parent2, crossover_op, num_var)
% Funzione di utility per crossover con binario/intero
    switch crossover_op(1)
        case 1  % One-point crossover
            cp = randi([1, num_var-1]); % punto di crossover
            offspring1 = [parent1(1:cp), parent2(cp+1:end)];
            offspring2 = [parent2(1:cp), parent1(cp+1:end)];
        case 2  % Two-point crossover
            cp = sort(randi([1, num_var-1],1,2));
            cp1 = cp(1);
            cp2 = cp(2);
            offspring1 = [parent1(1:cp1), parent2(cp1+1:cp2), parent1(cp2+1:end)];
            offspring2 = [parent2(1:cp1), parent1(cp1+1:cp2), parent2(cp2+1:end)];
        case 3  % Uniform crossover
            mask = rand(1, num_var) < 0.5;
            offspring1 = parent1;
            offspring2 = parent2;
            offspring1(mask) = parent2(mask);
            offspring2(mask) = parent1(mask);
    end
end