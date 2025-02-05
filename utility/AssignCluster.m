function cluster_indices = AssignCluster(centroids, solutions)
% Funzione per assegnare alle nuove soluzioni il cluster di appartenenza

    num_sol = length(solutions);
    
    % Prealloca il vettore di indici
    cluster_indices = zeros(num_sol, 1);
    
    % Per ogni soluzione, calcola la distanza dai centroidi e assegna il cluster
    for i = 1:num_sol
        % Estrazione var decisione
        sol_vector = solutions(i).dec;  
        
        % Calcola la distanza euclidea 
        distances = sqrt(sum((centroids - sol_vector) .^ 2, 2));
        
        % Trova l'indice del centroide più vicino
        [~, min_index] = min(distances);
        
        % Assegna l'indice del cluster
        cluster_indices(i) = min_index;
    end
end