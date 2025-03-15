function cluster_indices = AssignCluster(centroids, solutions)
% function to assign new solutions to their respective clusters
    num_sol = length(solutions);
    
    % preallocate the index vector
    cluster_indices = zeros(num_sol, 1);
    
    % for each solution, compute the distance from centroids and assign the cluster
    for i = 1:num_sol
        % extract decision variables
        sol_vector = solutions(i).dec;  
        
        % compute Euclidean distance 
        distances = sqrt(sum((centroids - sol_vector) .^ 2, 2));
        
        % find the index of the closest centroid
        [~, min_index] = min(distances);
        
        % assign the cluster index
        cluster_indices(i) = min_index;
    end
end