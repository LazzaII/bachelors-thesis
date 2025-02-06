function [offspring1, offspring2] = OX(parent1, parent2)
% OX Crossover
    n = length(parent1);
    
    % Selezione di due punti di crossover casuali e ordinati
    crossover_points = sort(randperm(n, 2));
    c1 = crossover_points(1);
    c2 = crossover_points(2);
    
    % Inizializzazione degli offspring
    offspring1 = -ones(1, n);
    offspring2 = -ones(1, n);
    
    % Copia della sezione fissa
    offspring1(c1:c2) = parent1(c1:c2);
    offspring2(c1:c2) = parent2(c1:c2);

    % Completamento degli offspring usando il genitore opposto
    offspring1 = FillRemaining(offspring1, parent2, c2);
    offspring2 = FillRemaining(offspring2, parent1, c2);
end

% Funzione per completare l'offspring in OX
function offspring = FillRemaining(offspring, donor, c2)
    n = length(donor);
    current_pos = mod(c2, n) + 1;  % posizione per riempire l'offspring (ricomincia da 1 dopo n)
    donor_index = current_pos;      % indice per scorrere il donor
    while any(offspring == -1)
        gene = donor(donor_index);
        % Se il gene non è già presente nell'offspring, lo inseriamo
        if ~ismember(gene, offspring)
            offspring(current_pos) = gene;
            current_pos = mod(current_pos, n) + 1;
        end
        donor_index = mod(donor_index, n) + 1;
    end
end