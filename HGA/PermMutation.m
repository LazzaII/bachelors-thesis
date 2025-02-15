function child = PermMutation(child, mutation_type)
% Funzione switch per mutazione di permutazioni
    switch mutation_type
        case 1 % Mutazione Single: 
            child = SwapSingleMutation(child);
        case 2 % Mutazione Slight
           child = ScrambleMutation(child);
    end
end