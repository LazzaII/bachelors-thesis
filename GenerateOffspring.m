function offspring = GenerateOffspring(population, crossover_op, mutation_op, Problem, state, idx)
% Funzione per applicare il crossover e la mutazione
    
    % Estrazione dei dati dalla popolazione
    data = cat(1, population.dec);

    % Indici degli individui appartenenti ai due cluster
    idx_cluster1 = find(idx == state(1));
    idx_cluster2 = find(idx == state(2));

    % Determina il numero massimo di coppie da generare, pari al minimo tra i due cluster
    num_pairs = min(length(idx_cluster1), length(idx_cluster2));
    
    % Numero di variabili decisionali
    num_var = Problem.D;
    
    % Inizializza la matrice per salvare le soluzioni (decision variables) degli offspring.
    % Genereremo 2*num_pairs offspring.
    offspring_matrix = zeros(2*num_pairs, num_var);
    
    % Loop per ogni coppia di genitori
    for i = 1:num_pairs
        % Selezione casuale di un genitore per ogni cluster
        random_idx1 = idx_cluster1(randperm(length(idx_cluster1), 1));
        random_idx2 = idx_cluster2(randperm(length(idx_cluster2), 1));
        
        % Estrazione dei genitori
        parent1 = data(random_idx1, :);
        parent2 = data(random_idx2, :);
        
        % Crossover:
        % Se la condizione di crossover viene soddisfatta, esegue il crossover,
        % altrimenti gli offspring sono uguali ai genitori.
        if rand < crossover_op(2)  % se supera la soglia non fa crossover
            if Problem.encoding(1) == 5 %permutation'
                [child1, child2] = PermCrossover(parent1, parent2, crossover_op);
            else 
                [child1, child2] = BinIntCrossover(parent1, parent2, crossover_op, num_var);
            end
        else
            child1 = parent1;
            child2 = parent2;
        end
        
        % Mutazione: per ogni gene (variabile) degli offspring
        for j = 1:num_var
            if rand < mutation_op(2)  % se supera la soglia non muta
                child1(j) = MutateGene(child1(j), Problem, mutation_op(1));
                child2(j) = MutateGene(child2(j), Problem, mutation_op(1));
            end
        end
        
        % Salva i due offspring nella matrice
        offspring_matrix(2*i-1, :) = child1;
        offspring_matrix(2*i, :)   = child2;
    end

    offspring = Problem.Evaluation(offspring_matrix);
end