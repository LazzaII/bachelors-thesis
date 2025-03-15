function updatedQ = UpdateQTable(Algo, new_cc)
% function for update Q-Table
    tol = 1e-4; % tolleranza per considerare i centroidi vicini
    
    % matrix initialization
    updatedQ = Algo.current_Qtable;
    updatedQ = cellfun(@(s) setfield(s, 'value', 0), updatedQ, 'UniformOutput', false);
    
    % for every Q-Table in the history
    for i = 1:length(Algo.previous_Qtable)
        oldQ = Algo.previous_Qtable{i};
        old_centroids = Algo.previous_cc{i};  

        for r = 1:size(Algo.states, 1)
            r_state = Algo.states(r,:);  
            
            % for each cluster in the pair, the difference with the new centroids is evaluated, and if necessary, the value field is copied.
            for k = 1:size(new_cc, 1)
                if norm(new_cc(k,:) - old_centroids(r_state(1),:)) < tol && norm(new_cc(k,:) - old_centroids(r_state(2),:)) < tol
                    updatedQ(r,:) = cellfun(@(s_old, s_new) setfield(s_new, 'value', s_old.value), oldQ(r, :), updatedQ(r, :), 'UniformOutput', false);
                end
            end
        end
    end
end