function [offspring1, offspring2] = PMX(parent1, parent2)
% PMX Crossover
    n = length(parent1);
    
    % Selezione di due punti di crossover casuali e ordinati
    crossover_points = sort(randperm(n, 2));
    c1 = crossover_points(1);
    c2 = crossover_points(2);
    
    % Inizializzazione degli offspring 
    offspring1 = -ones(1, n);
    offspring2 = -ones(1, n);
    
    % Copia della sezione intercambiata
    offspring1(c1:c2) = parent2(c1:c2);
    offspring2(c1:c2) = parent1(c1:c2);
    
    % Costruzione delle mappe per la porzione intercambiata:
    % La mappa mapping1 associa i geni di parent2 alla controparte in parent1
    % La mappa mapping2 associa i geni di parent1 alla controparte in parent2
    mapping1 = containers.Map('KeyType','double','ValueType','double');
    mapping2 = containers.Map('KeyType','double','ValueType','double');
    for i = c1:c2
        mapping1(parent2(i)) = parent1(i);
        mapping2(parent1(i)) = parent2(i);
    end

    % Completamento degli offspring
    offspring1 = FillOffspring(offspring1, parent1, mapping1, c1, c2);
    offspring2 = FillOffspring(offspring2, parent2, mapping2, c1, c2);
end

% Funzione di utily per completamento degli offspring
function offspring = FillOffspring(offspring, parent, mapping, c1, c2)
    n = length(parent);
    for j = [1:c1-1, c2+1:n]  % Per le posizioni fuori dalla sezione intercambiata
        value = parent(j);
        % Risolvi eventuali conflitti applicando la mappatura
        while isKey(mapping, value)
            value = mapping(value);
        end
        offspring(j) = value;
    end
end