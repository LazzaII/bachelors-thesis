function rewards = InitializeQTableRewards(idx, population, Algo) 
    num_clusters = 3;
    num_pairs = size(Algo.states, 1);

    % Calcola la fitness media per ciascun cluster
    cluster_fitness = zeros(num_clusters, 1);
    for i = 1:num_clusters
        selected_solutions = population(idx == i);
        objectives = cat(1, selected_solutions.obj);  
        
        % Calcola la norma euclidea per ogni riga (ogni soluzione)
        scalar_objectives = vecnorm(objectives, 2, 2);  
        
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
        rewards = ones(num_pairs, 1); 
    else
        rewards = 2 * (combined_fitness - f_min) / (f_max - f_min) - 1;
    end
end