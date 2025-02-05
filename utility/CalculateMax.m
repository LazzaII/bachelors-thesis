function max_nest_state = CalculateMax(population, idx, Algo) 
% Funzionde di utility per il calcolo del massimo negli stati succesivi

    % Prendiamo i prossimi cluster con la fitness migliore
    next_clusters = TournamentSelection(idx, population);
                
    % Individuiamo la riga dello stato attuale
    num_states = size(Algo.current_Qtable, 1);
    next_state = -1;
    for s = 1:num_states
        if isequal(Algo.current_Qtable{s, 1}.state, next_clusters)
            next_state = s;
            break;
        end
    end

    % Estrazione riga e campo reward
    cell_row = Algo.current_Qtable(next_state, :);
    rewards = cellfun(@(s) s.reward, cell_row);
    
    % Prendiamo il massimo al prossimo stato
    max_nest_state = max(rewards);
end