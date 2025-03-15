function [offspring1, offspring2] = OX(parent1, parent2)
% OX crossover
    n = length(parent1);
    
    % selection of two random and ordered crossover points
    crossover_points = sort(randperm(n, 2));
    c1 = crossover_points(1);
    c2 = crossover_points(2);
    
    % initialization of offspring
    offspring1 = -ones(1, n);
    offspring2 = -ones(1, n);
    
    % copy of the fixed section
    offspring1(c1:c2) = parent1(c1:c2);
    offspring2(c1:c2) = parent2(c1:c2);

    % completion of offspring using the opposite parent
    offspring1 = FillRemaining(offspring1, parent2, c2);
    offspring2 = FillRemaining(offspring2, parent1, c2);
end

% function to complete the offspring in OX (Order Crossover)
function offspring = FillRemaining(offspring, donor, c2)
    n = length(donor);
    current_pos = mod(c2, n) + 1; % position to fill the offspring 
    donor_index = current_pos; % index to iterate through the donor
    while any(offspring == -1)
        gene = donor(donor_index);
        % if the gene is not already present in the offspring, insert it
        if ~ismember(gene, offspring)
            offspring(current_pos) = gene;
            current_pos = mod(current_pos, n) + 1;
        end
        donor_index = mod(donor_index, n) + 1;
    end
end