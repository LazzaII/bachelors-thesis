function offspring = GenerateOffspring(population, crossover_op, mutation_op, Problem, state, idx)
% function to apply crossover and mutation
    
    % extract data from the population
    data = cat(1, population.dec);

    % indices of individuals belonging to the two clusters
    idx_cluster1 = find(idx == state(1));
    idx_cluster2 = find(idx == state(2));

    % determine the maximum number of pairs to generate, equal to the minimum between the two clusters
    num_pairs = min(length(idx_cluster1), length(idx_cluster2));
    
    % number of decision variables
    num_var = Problem.D;
    
    % initialize the matrix to store the offspring solutions (decision variables).
    % we will generate 2*num_pairs offspring.
    offspring_matrix = zeros(2*num_pairs, num_var);
    
    % loop for each pair of parents
    for i = 1:num_pairs
        % random selection of one parent from each cluster
        random_idx1 = idx_cluster1(randperm(length(idx_cluster1), 1));
        random_idx2 = idx_cluster2(randperm(length(idx_cluster2), 1));
        
        % extract parents
        parent1 = data(random_idx1, :);
        parent2 = data(random_idx2, :);
        
        % crossover:
        % if the crossover condition is met, perform crossover;
        % otherwise, offspring are identical to the parents.
        if rand < crossover_op(2)  % if threshold is exceeded, no crossover
            if Problem.encoding(1) == 5 % permutation
                [child1, child2] = PermCrossover(parent1, parent2, crossover_op);
            else 
                [child1, child2] = BinRealCrossover(parent1, parent2, crossover_op, num_var);
            end
        else
            child1 = parent1;
            child2 = parent2;
        end

        if Problem.encoding(1) == 5 
            % mutation for permutations
            if rand < mutation_op(2)
                child1 = PermMutation(child1, mutation_op(1));
            end
            if rand < mutation_op(2)
                child2 = PermMutation(child2, mutation_op(1));
            end
        else 
            % mutation for real/binary: for each gene (variable) of the offspring
            for j = 1:num_var
                if rand < mutation_op(2)  % if threshold is exceeded, no mutation
                    child1(j) = MutateGene(child1(j), Problem, mutation_op(1));
                end
                if rand < mutation_op(2)
                    child2(j) = MutateGene(child2(j), Problem, mutation_op(1));
                end
            end
        end
        
        % store the two offspring in the matrix
        offspring_matrix(2*i-1, :) = child1;
        offspring_matrix(2*i, :)   = child2;
    end
    offspring = Problem.Evaluation(offspring_matrix);
end