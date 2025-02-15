 function mean_fitness = MeanFitness(population)
 % Funzione per calcolare la media della fitness 
    % Estrai i valori di fitness (obiettivi) dalla popolazione
    objectives = cat(1, population.obj);  
    % Norma euclidea per ogni individuo
    scalar_fitness = vecnorm(objectives, 2, 2);  
    % Media delle fitness
    mean_fitness = mean(scalar_fitness);
end