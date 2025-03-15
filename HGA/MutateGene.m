function [mutated_gene] = MutateGene(gene, Problem, mutation_type)
% switch function for mutation
    switch mutation_type
        case 1 % random mutation: assigns a new random value within the range [lower, upper]
            mutated_gene = Problem.lower(1) + (Problem.upper(1) - Problem.lower(1))*rand;
        case 2 % gaussiana mutation
            sigma = 0.1*(Problem.upper(1) - Problem.lower(1)); % deviazione standard
            mutated_gene = gene + sigma*randn;
            % check if the gene remains within the limits
            mutated_gene = max(min(mutated_gene, Problem.upper(1)), Problem.lower(1));
    end
end