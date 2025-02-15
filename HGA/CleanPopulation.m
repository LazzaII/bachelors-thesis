function filtered_population = CleanPopulation(population)
% Funzione per ripulire gli outlier

    p = inputParser;
    addParameter(p, 'MinPopRatio', 0.8, @(x) isnumeric(x) && x>0 && x<=1);
    addParameter(p, 'Multiplier', 1.5, @(x) isnumeric(x) && x>0);
    parse(p);
    
    min_pop_ratio = p.Results.MinPopRatio;
    multiplier = p.Results.Multiplier;

    % Fitness dalla popolazione
    objectives = cat(1, population.obj);  
    
    % Norma euclidea per ottenere una fitness scalare
    scalar_fitness = vecnorm(objectives, 2, 2);  
    
    % Calcola i quartili e l'IQR
    Q1 = quantile(scalar_fitness, 0.25);
    Q3 = quantile(scalar_fitness, 0.75);
    IQR_val = Q3 - Q1;

    % Se la variabilità è quasi nulla, non esegue il filtraggio
    if IQR_val < eps
        filtered_population = population;
        return;
    end

    % Definisce le soglie per rimuovere gli outlier
    lower_bound = Q1 - multiplier * IQR_val;
    upper_bound = Q3 + multiplier * IQR_val;

    % Seleziona gli individui il cui fitness è compreso tra le soglie
    idx = find(scalar_fitness >= lower_bound & scalar_fitness <= upper_bound);
    filtered_population = population(idx);

    % Se il filtro elimina troppi individui, impone una dimensione minima
    min_pop_size = max(round(min_pop_ratio * length(population)), 1);
    if length(filtered_population) < min_pop_size
        % Ordina la popolazione in base al fitness (assumendo che fitness più basso sia migliore)
        [~, sorted_idx] = sort(scalar_fitness, 'ascend');
        filtered_population = population(sorted_idx(1:min_pop_size));
    end
end
