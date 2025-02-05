function selected_clusters = TournamentSelection(idx, population)
% Tournament selection sovrascritta per ottenere indici di due cluster invece che due soluzioni (classico GA)

    num_clusters = 3;
    selected_clusters = zeros(1, 2);
    
    % Calcola la fitness di ogni cluster: ad esempio, come media delle fitness
    clusterFitness = zeros(num_clusters, 1);
    for i = 1:num_clusters
        selected_solutions = population(idx == i);
        objectives = cat(1, selected_solutions.obj);  
        
        % Calcola la norma euclidea per ogni riga (ogni soluzione)
        scalar_objectives = vecnorm(objectives, 2, 2);  % 2 indica la norma euclidea, 2 indica la dimensione lungo le righe
        
        % Calcola la media dei valori scalari
        clusterFitness(i) = mean(scalar_objectives);
    end
    
    % In questo caso il torneo include tutti i cluster
    tournament_indices = 1:num_clusters;            
    
    % Tournament selection eseguita due volte per avere 2 indici
    for j = 1:2
        [~, best_idx] = min(clusterFitness(tournament_indices)); % lavoriamo su problemi di minimo
        selected_clusters(j) = tournament_indices(best_idx);
    end
end