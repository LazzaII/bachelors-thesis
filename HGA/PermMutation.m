function child = PermMutation(child, mutation_type)
% switch function for permutation mutation
    switch mutation_type
        case 1 % Mutazione Single: 
            child = SwapSingleMutation(child);
        case 2 % Mutazione Slight
           child = ScrambleMutation(child);
    end
end