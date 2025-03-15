function selected_clusters = TournamentSelection(idx, population)
% tournament selection overridden to obtain indices of two clusters instead of two solutions (classic GA).

    num_clusters = 3;
    selected_clusters = zeros(1, 2);
    
    % calculate the fitness of each cluster as the average of the Euclidean norms of the solutions.
    clusterFitness = zeros(num_clusters, 1);
    for i = 1:num_clusters
        selected_solutions = population(idx == i);
        objectives = cat(1, selected_solutions.obj);  
        
        % calculate the Euclidean norm for each row (each solution).
        scalar_objectives = vecnorm(objectives, 2, 2);  % 2 indica la norma euclidea, 2 indica la dimensione lungo le righe
        
        % calculate the average of the scalar values.
        clusterFitness(i) = mean(scalar_objectives);
    end
    
    % in this case, the tournament includes all clusters.
    tournament_indices = 1:num_clusters;            
    
    % tournament selection is performed twice to obtain two indices.
    for j = 1:2
        [~, best_idx] = min(clusterFitness(tournament_indices)); % lavoriamo su problemi di minimo
        selected_clusters(j) = tournament_indices(best_idx);
    end
end