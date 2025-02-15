function [crossover_op, mutation_op, state_idx, action_idx] = SelectOperators(clusters_state, Algo)
% Selezione Operatore

    % Individuiamo la riga dello stato attuale
    num_states = size(Algo.current_Qtable, 1);
    state_idx = -1;
    for s = 1:num_states
        if isequal(Algo.current_Qtable{s, 1}.state, clusters_state)
            state_idx = s;
            break;
        end
    end

    % Estrazione di tutti i values
    num_actions = size(Algo.current_Qtable, 2);
    values = zeros(1, num_actions);
    for i = 1:num_actions
        values(i) = Algo.current_Qtable{state_idx, i}.value;
    end

    % Selezione dell'operatore O tramite politica e-greedy
    if rand < Algo.e
        % Exploration: scegli un'azione casuale
        action_idx = randi(num_actions);
    else
        % Exploitation: scegli l'azione con il valore massimo
        max_value = max(values);
        best_actions = find(values == max_value);
        % Se ci sono più azioni con lo stesso max reward, sceglie una a caso fra queste
        if length(best_actions) > 1
            action_idx = best_actions(randi(length(best_actions)));
        else
            action_idx = best_actions;
        end
    end

    % Recupero dell'operatore O selezionata dalla Q-table
    selected_action = Algo.current_Qtable{state_idx, action_idx};
    
    % Estrazione degli operatori o_i, o_j di crossover e mutazione
    % La matrice selected_action.gaOperators è di dimensione 2x2:
    %   - Prima riga (Crossover o_i): [crossover_type, crossover_rate]
    %   - Seconda riga (Mutazione o_j): [mutation_type, mutation_rate]
    crossover_op = selected_action.gaOperators(1, :);
    mutation_op  = selected_action.gaOperators(2, :);
end