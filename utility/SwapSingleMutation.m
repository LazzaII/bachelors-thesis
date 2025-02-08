function mutated_child = SwapSingleMutation(child)
    % un solo swap casuale nel cromosoma
    n = length(child);
    mutated_child = child;
    idx1 = randi(n);
    idx2 = randi(n);
    % scambio dei due geni
    temp = mutated_child(idx1);
    mutated_child(idx1) = mutated_child(idx2);
    mutated_child(idx2) = temp;
end