function mutated_child = SwapSingleMutation(child)
% function for swap single mutation
    % single random swap in the chromosome
    n = length(child);
    mutated_child = child;
    idx1 = randi(n);
    idx2 = randi(n);
    % swap the two genes
    temp = mutated_child(idx1);
    mutated_child(idx1) = mutated_child(idx2);
    mutated_child(idx2) = temp;
end