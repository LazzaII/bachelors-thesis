function updatedQ = UpdateQTable(QHistory, centroidHistory, newCentroids, newFitness, Type, states)
% Funzione per aggiornare creare la nuova matrice Q
    %TODO DA RIVEDERE TUTTA, vedere la init per spunto

    tol = 1e-3; % tolleranza per considerare i centroidi vicini (da decidere)

    % Inizializzazione matrice
    if strcmpi(Type, 'permutation')
        updatedQ = cell(6, 36);
    else 
        updatedQ = cell(6, 54);
    end

    % Per ogni Q-Table nella cronologia
    for k = 1:length(QHistory)
        oldQ = QHistory{k};
        oldCentroids = centroidHistory{k};  % matrice dei centroidi storici

        % Per ogni riga della updatedQ che ha reward non ancora assegnati
        for r = 1:size(states, 1)

            newState = states(r,:);  
            mapping = nan(1, numel(newState));  % per salvare il mapping: new -> old

            % Per ogni cluster nella coppia 
            for i = 1:numel(newState)
                newClusterIdx = newState(i);  % indice del cluster nuovo (i-esimo nella coppia)
                % Scorri tutti i centroidi vecchi per trovare il primo "vicino"
                for j = 1:size(oldCentroids, 1)
                    if norm(newCentroids(newClusterIdx,:) - oldCentroids(j,:)) < tol
                        mapping(i) = j; % mappatura: il cluster nuovo corrisponde al j-esimo cluster vecchio
                        break; % esci dal ciclo appena trovato il primo match
                    end
                end
            end

            % Se non è stato trovato un mapping completo (cioè per entrambi i cluster) salta
            if any(isnan(mapping))
                continue;
            end

            % Cerca nella Q-Table storica la riga con lo stato uguale alla coppia mappata
            idx = find(ismember(oldQ.state, mapping, 'rows'), 1);
            if ~isempty(idx)
                % Copia l'intera riga dei reward nella nuova Q-Table
                updatedQ.reward(r,:) = oldQ.reward(idx,:);
            end
        end
    end

    % Calcola il reward per le righe della updatedQ che hanno ancora reward mancanti.
    nPairs = size(Algo.states, 1);

    % Calcola la fitness media per ciascun cluster
    clusterFitness = zeros(numClusters, 1);
    for i = 1:numClusters
        clusterFitness(i) = mean(Solutions(Idx == i));
    end
    
    % Calcola il valore combinato per ogni coppia.
    % In questo esempio, il valore combinato è la media delle fitness medie dei due cluster.
    combinedFitness = zeros(nPairs, 1);
    for i = 1:nPairs
        c1 = clusterPairs(i, 1);
        c2 = clusterPairs(i, 2);
        combinedFitness(i) = (clusterFitness(c1) + clusterFitness(c2)) / 2;
    end
    
    % Mappatura lineare dei valori combinati nell'intervallo [-1, 1]
    f_min = min(combinedFitness);
    f_max = max(combinedFitness);
    
    if f_max == f_min
        updatedQ.reward(r,:) = ones(nPairs, 1);  % Se tutti i valori sono uguali, assegna ad ognuno 1 (oppure 0, se preferisci)
    else
        updatedQ.reward(r,:) = 2 * (combinedFitness - f_min) / (f_max - f_min) - 1;
    end
end