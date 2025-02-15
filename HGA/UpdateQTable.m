function updatedQ = UpdateQTable(Algo, new_cc)
% Funzione per aggiornare creare la nuova matrice Q
    tol = 1e-4; % tolleranza per considerare i centroidi vicini
    
    % Creazione matrice e assegnamento a 0 di tutti i campi value
    updatedQ = Algo.current_Qtable;
    updatedQ = cellfun(@(s) setfield(s, 'value', 0), updatedQ, 'UniformOutput', false);
    
    % Per ogni Q-Table nella cronologia
    for i = 1:length(Algo.previous_Qtable)
        oldQ = Algo.previous_Qtable{i};
        old_centroids = Algo.previous_cc{i};  

        for r = 1:size(Algo.states, 1)
            r_state = Algo.states(r,:);  
            
            % Per ogni cluster nella coppia si valuta la differenza con i
            % nuovi centroidi e nel caso si copia il campo value
            for k = 1:size(new_cc, 1)
                if norm(new_cc(k,:) - old_centroids(r_state(1),:)) < tol && norm(new_cc(k,:) - old_centroids(r_state(2),:)) < tol
                    updatedQ(r,:) = cellfun(@(s_old, s_new) setfield(s_new, 'value', s_old.value), oldQ(r, :), updatedQ(r, :), 'UniformOutput', false);
                end
            end
        end
    end
end