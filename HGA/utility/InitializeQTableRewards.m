function rewards = InitializeQTableRewards(idx, population, Algo) 
%%% ------------
% NOT USED, NOT A LOT OF DIFFERENCE
%%% ------------

    num_clusters = 3;
    num_pairs = size(Algo.states, 1);

    % compute the average fitness for each cluster
    cluster_fitness = zeros(num_clusters, 1);
    for i = 1:num_clusters
        selected_solutions = population(idx == i);
        objectives = cat(1, selected_solutions.obj);  
        
        % compute the Euclidean norm for each row (each solution)
        scalar_objectives = vecnorm(objectives, 2, 2);  
        
        % compute the mean of the scalar values
        cluster_fitness(i) = mean(scalar_objectives);
    end
    
    % compute the combined value for each pair
    combined_fitness = zeros(num_pairs, 1);
    for i = 1:num_pairs
        c1 = Algo.states(i, 1);
        c2 = Algo.states(i, 2);
        combined_fitness(i) = (cluster_fitness(c1) + cluster_fitness(c2)) / 2;
    end
    
    % linearly map the combined values to the range [-1, 1]
    f_min = min(combined_fitness);
    f_max = max(combined_fitness);

    if f_max == f_min
        rewards = ones(num_pairs, 1); 
    else
        % Mappatura che fa corrispondere f_min -> +1 e f_max -> -1
        rewards = 1 - 2 * (combined_fitness - f_min) / (f_max - f_min);
    end
end