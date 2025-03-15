function filtered_population = CleanPopulation(population)
% function to clean outliers

    p = inputParser;
    addParameter(p, 'MinPopRatio', 0.8, @(x) isnumeric(x) && x>0 && x<=1);
    addParameter(p, 'Multiplier', 1.5, @(x) isnumeric(x) && x>0);
    parse(p);
    
    min_pop_ratio = p.Results.MinPopRatio;
    multiplier = p.Results.Multiplier;

    % fitness from the population
    objectives = cat(1, population.obj);  
    
    % euclidean norm to obtain a scalar fitness
    scalar_fitness = vecnorm(objectives, 2, 2);  
    
    % compute quartiles and IQR (Interquartile Range)
    Q1 = quantile(scalar_fitness, 0.25);
    Q3 = quantile(scalar_fitness, 0.75);
    IQR_val = Q3 - Q1;

    % if variability is nearly zero, do not perform filtering
    if IQR_val < eps
        filtered_population = population;
        return;
    end

    % define thresholds to remove outliers
    lower_bound = Q1 - multiplier * IQR_val;
    upper_bound = Q3 + multiplier * IQR_val;

    % select individuals whose fitness is within the thresholds
    idx = find(scalar_fitness >= lower_bound & scalar_fitness <= upper_bound);
    filtered_population = population(idx);

    % if the filter removes too many individuals, enforce a minimum size
    min_pop_size = max(round(min_pop_ratio * length(population)), 1);
    if length(filtered_population) < min_pop_size
        % sort the population based on fitness (assuming lower fitness is better)
        [~, sorted_idx] = sort(scalar_fitness, 'ascend');
        filtered_population = population(sorted_idx(1:min_pop_size));
    end
end
