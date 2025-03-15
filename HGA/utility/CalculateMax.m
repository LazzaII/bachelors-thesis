function max_nest_state = CalculateMax(population, idx, Algo) 
% utility function to compute the maximum in future states

    % select the next clusters with the best fitness
    next_clusters = TournamentSelection(idx, population);
                
    % identify the row of the current state
    num_states = size(Algo.current_Qtable, 1);
    next_state = -1;
    for s = 1:num_states
        if isequal(Algo.current_Qtable{s, 1}.state, next_clusters)
            next_state = s;
            break;
        end
    end

    % extract row and reward field
    cell_row = Algo.current_Qtable(next_state, :);
    values = cellfun(@(s) s.value, cell_row);
    
    % select the maximum at the next state
    max_nest_state = max(values);
end