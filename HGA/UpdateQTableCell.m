function [value] = UpdateQTableCell(stato, azione, population, idx, pre_fitness, Algo)
% Funzione di aggiornamento della QTable

    post_fitness = MeanFitness(population);
    max_nest_state = CalculateMax(population, idx, Algo);    
    reward = (post_fitness - pre_fitness) / abs(pre_fitness + eps);

    value = Algo.current_Qtable{stato, azione}.value + Algo.alpha * (reward + Algo.gamma * max_nest_state - Algo.current_Qtable{stato, azione}.value);
end