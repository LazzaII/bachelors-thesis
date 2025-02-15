function [mutated_gene] = MutateGene(gene, Problem, mutation_type)
% Funzione switch per mutazione
    switch mutation_type
        case 1 % Mutazione Random: assegna un nuovo valore random nell'intervallo [lower, upper]
            mutated_gene = Problem.lower(1) + (Problem.upper(1) - Problem.lower(1))*rand;
        case 2 % Mutazione Gaussiana
            sigma = 0.1*(Problem.upper(1) - Problem.lower(1)); % deviazione standard
            mutated_gene = gene + sigma*randn;
            % Assicura che il gene rimanga nei limiti
            mutated_gene = max(min(mutated_gene, Problem.upper(1)), Problem.lower(1));
    end
end