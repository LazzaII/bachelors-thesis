function mean_fitness = MeanFitness(population)
% function to compute the average fitness 
    % extract fitness values (objectives) from the population
    objectives = cat(1, population.obj);  
    % euclidean norm for each individual
    scalar_fitness = vecnorm(objectives, 2, 2);  
    % compute the mean fitness
    mean_fitness = mean(scalar_fitness);
end