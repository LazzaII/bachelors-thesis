function mutated_child = ScrambleMutation(child)    
% function for scramble mutation 
    % number of genes in the chromosome
    n = length(child);

    % randomly select two cut points i and j
    i = randi([1, n]);
    j = randi([1, n]);

    % ensure that i <= j, otherwise swap them
    if i > j
        temp = i;
        i = j;
        j = temp;
    end

    % extract the segment from i to j
    segment = child(i:j);

    % scramble the genes of the extracted segment
    scrambled_segment = segment(randperm(length(segment)));

    % reconstruct the mutated chromosome
    mutated_child = child;
    mutated_child(i:j) = scrambled_segment;
end