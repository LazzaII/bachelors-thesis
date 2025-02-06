function updatedQ = UpdateQTable(Algo, new_cc, idx, population)
% Funzione per aggiornare creare la nuova matrice Q
    tol = 1e-3; % tolleranza per considerare i centroidi vicini (da decidere)
    
    % Creazione matrice e assegnamento a 0 di tutti i campi reward
    updatedQ = Algo.current_Qtable;
    updatedQ = cellfun(@(s) setfield(s, 'reward', 0), updatedQ, 'UniformOutput', false);
    
    % Per ogni Q-Table nella cronologia
    for i = 1:length(Algo.previous_Qtable)
        oldQ = Algo.previous_Qtable{i};
        old_centroids = Algo.previous_cc{i};  

        % Per ogni riga della updatedQ che ha reward non ancora assegnati
        for r = 1:size(Algo.states, 1)
            r_state = Algo.states(r,:);  
            
            % Per ogni cluster nella coppia si valuta la differenza con i
            % nuovi centroidi e nel caso si copia il campo reward
            for k = 1:size(new_cc, 1)
                if norm(new_cc(k,:) - old_centroids(r_state(1),:)) < tol && norm(new_cc(k,:) - old_centroids(r_state(2),:)) < tol
                    updatedQ(r,:) = cellfun(@(s_old, s_new) setfield(s_new, 'reward', s_old.reward), oldQ(r, :), updatedQ(r, :), 'UniformOutput', false);
                end
            end
        end
    end

    % Verifica se nella riga 'riga' esiste almeno un reward pari a 0
    for r = 1:size(Algo.states, 1)
        mask = cellfun(@(s) s.reward == 0, updatedQ(r, :));
        if any(mask)
            % Calcola il nuovo reward per questa riga
            rewards = InitializeQTableRewards(idx, population, Algo);
            
            % Aggiorna ogni cella della riga con il nuovo reward
            for j = 1:size(updatedQ, 2)
                updatedQ{r, j}.reward = rewards(r);
            end
        end
    end
end