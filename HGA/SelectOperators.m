function [crossover_op, mutation_op, state_idx, action_idx] = SelectOperators(clusters_state, Algo)
% function for select operators

    % identify the row of the current state.
    num_states = size(Algo.current_Qtable, 1);
    state_idx = -1;
    for s = 1:num_states
        if isequal(Algo.current_Qtable{s, 1}.state, clusters_state)
            state_idx = s;
            break;
        end
    end

    % extract all values.
    num_actions = size(Algo.current_Qtable, 2);
    values = zeros(1, num_actions);
    for i = 1:num_actions
        values(i) = Algo.current_Qtable{state_idx, i}.value;
    end

    % selection of operator O using the e-greedy policy.
    if rand < Algo.e
        % exploration: choose a random action.
        action_idx = randi(num_actions);
    else
        % exploitation: choose the action with the maximum value.
        max_value = max(values);
        best_actions = find(values == max_value);
        % if there are multiple actions with the same maximum reward, choose one randomly among them.
        if length(best_actions) > 1
            action_idx = best_actions(randi(length(best_actions)));
        else
            action_idx = best_actions;
        end
    end

    % retrieve the selected operator O from the Q-table.
    selected_action = Algo.current_Qtable{state_idx, action_idx};
    
    % Extraction of crossover and mutation operators o_i, o_j
    % The matrix selected_action.gaOperators has dimensions 2x2:
    %   - First row (Crossover o_i): [crossover_type, crossover_rate]
    %   - Second row (Mutation o_j): [mutation_type, mutation_rate]
    crossover_op = selected_action.gaOperators(1, :);
    mutation_op  = selected_action.gaOperators(2, :);
end