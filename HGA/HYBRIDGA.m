classdef HYBRIDGA < ALGORITHM
    % <2054> <multi> <real/binary/permutation> <large/none> <constrained/none>
    % Hybrid Genetic Algorithm

    properties
        current_Qtable;
        previous_Qtable = {};
        previous_cc = {}; % centroids of previous clusters, used for proximity calculation

        e = 0.9;  % initial exploration probability
        e_decay = 0.995;  % epsilon decay
        e_min = 0.01; % minimum exploration probability
        alpha = 0.5; % balanced
        gamma = 0.95; % future-oriented preference
            
        states = [1 1; 1 2; 1 3; 2 2; 2 3; 3 3];
        % the crossover type is defined in the function because it changes depending on permutation or binary/integer representation
        crossover_rates = [0.3, 0.5, 0.7];   
        mutation_types = 1:2;  
        mutation_rates = [0.03, 0.05, 0.07];    
    end

    methods
        function main(Algorithm, Problem)
            %% Initialization
            % population initialization
            population = Problem.Initialization(); 
            % initial clusters
            [idx, clusters] = ClusterPopulation(population, 3); 
            % Q-table initialization
            [Algorithm.current_Qtable] = QTableInizialization(Problem.encoding, Algorithm);
            
            %% Optimization
            while Algorithm.NotTerminated(population)
                % compute average fitness
                pre_fitness = MeanFitness(population);

                % tournament selection
                clusters_state = TournamentSelection(idx, population);

                % operator selection based on Q-Learning
                [crossover_op, mutation_op, stato, azione] = SelectOperators(clusters_state, Algorithm);

                % apply operators
                offspring = GenerateOffspring(population, crossover_op, mutation_op, Problem, Algorithm.states(stato,:), idx);

                % add new solutions to the total population
                population = [population, offspring];

                % update idx
                idx = [idx; AssignCluster(clusters, offspring)];

                % update Q-Table cell
                Algorithm.current_Qtable{stato, azione}.value = UpdateQTableCell(stato, azione, population, idx, pre_fitness, Algorithm);

                % update population using NSGA-II
                population = EnvironmentalSelection(population, min(size(population,2), Problem.N));

                % save previous data
                Algorithm.previous_cc{end+1} = clusters;
                Algorithm.previous_Qtable{end+1} = Algorithm.current_Qtable;

                % outlier cleaning
                population = CleanPopulation(population);

                % new clusters
                [idx, clusters] = ClusterPopulation(population, 3);

                % update new Q-Table matrix
                Algorithm.current_Qtable = UpdateQTable(Algorithm, clusters);

                % e-decay policy
                Algorithm.e = max(Algorithm.e * Algorithm.e_decay, Algorithm.e_min);
            end
        end
    end
end
