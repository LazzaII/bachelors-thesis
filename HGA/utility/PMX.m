function [offspring1, offspring2] = PMX(parent1, parent2)
% PMX crossover
    n = length(parent1);
    
    % selection of two random and ordered crossover points
    crossover_points = sort(randperm(n, 2));
    c1 = crossover_points(1);
    c2 = crossover_points(2);
    
    % initialization of offspring
    offspring1 = -ones(1, n);
    offspring2 = -ones(1, n);
    
    % copy of the swapped section
    offspring1(c1:c2) = parent2(c1:c2);
    offspring2(c1:c2) = parent1(c1:c2);
    
    % Construction of maps for the swapped portion:
    % The mapping1 map associates genes from parent2 to their counterpart in parent1
    % The mapping2 map associates genes from parent1 to their counterpart in parent2
    mapping1 = containers.Map('KeyType','double','ValueType','double');
    mapping2 = containers.Map('KeyType','double','ValueType','double');
    for i = c1:c2
        mapping1(parent2(i)) = parent1(i);
        mapping2(parent1(i)) = parent2(i);
    end

    % completion of offspring
    offspring1 = FillOffspring(offspring1, parent1, mapping1, c1, c2);
    offspring2 = FillOffspring(offspring2, parent2, mapping2, c1, c2);
end

% utility function for offspring completion
function offspring = FillOffspring(offspring, parent, mapping, c1, c2)
    n = length(parent);
    for j = [1:c1-1, c2+1:n]  % for positions outside the swapped section
        value = parent(j);
        % resolve any conflicts by applying the mapping
        while isKey(mapping, value)
            value = mapping(value);
        end
        offspring(j) = value;
    end
end