classdef HYBRIDGA < ALGORITHM
    % <2024> <multi> <real/binary/permutation> <large/none> <constrained/none>
    % Hybrid Genetic Algorithm

    properties
        current_Qtable;
        previous_Qtable = {};
        previous_cc = {}; % Centroidi dei vecchi cluster, utilizzati per calcolo della vicinanza

        e = 0.9;  % probabilità di esplorazione iniziale
        e_decay = 0.995;  % decadimento di epsilon
        e_min = 0.01; % probabilità di esplorazione minima
        alpha = 0.5; % bilanciato
        gamma = 0.95; % privilegio sul futuro
            
        states = [1 1; 1 2; 1 3; 2 2; 2 3; 3 3];
        % il crossover type lo definiamo nella funzione perchè cambiano a
        % seconda di permutazione o binario/intero
        crossover_rates = [0.3, 0.5, 0.7];   
        mutation_types = 1:2;  
        mutation_rates = [0.03, 0.05, 0.07];    
    end

    methods
        function main(Algorithm, Problem)
            %% Inizializzazione
            % Inizializzazione della popolazione 
            population = Problem.Initialization(); 
            % Cluster iniziali
            [idx, clusters] = ClusterPopulation(population, 3); 
            % Inizializzazione Q
            [Algorithm.current_Qtable] = QTableInizialization(Problem.encoding, Algorithm);
            
            %% Ottimizzazione 
            while Algorithm.NotTerminated(population)
                % Calcolo della fitness media
                pre_fitness = MeanFitness(population);

                % Tournament selection
                clusters_state = TournamentSelection(idx, population);

                % Selezione degli operatori basata su Q-Learning
                [crossover_op, mutation_op, stato, azione] = SelectOperators(clusters_state, Algorithm);

                % Applicazione degli operatori
                offspring = GenerateOffspring(population, crossover_op, mutation_op, Problem, Algorithm.states(stato,:), idx);

                % Aggiunta delle nuove soluzioni alla popolazione totale
                population = [population, offspring];

                % Aggiornamento di idx
                idx = [idx; AssignCluster(clusters, offspring)];

                % Aggiornamento cella Q-Table 
                Algorithm.current_Qtable{stato, azione}.value = UpdateQTableCell(stato, azione, population, idx, pre_fitness, Algorithm);

                % Aggiornamento della popolazione usando quello del NSGAII
                population = EnvironmentalSelection(population, min(size(population,2), Problem.N));

                % Salvataggio vecchi dati
                Algorithm.previous_cc{end+1} = clusters;
                Algorithm.previous_Qtable{end+1} = Algorithm.current_Qtable;

                % Pulizia outlier
                population = CleanPopulation(population);

                % Nuovi cluster
                [idx, clusters] = ClusterPopulation(population, 3);

                % Aggiornamento nuova matrice Q-Table
                Algorithm.current_Qtable = UpdateQTable(Algorithm, clusters);

                % Politica e-decay
                Algorithm.e = max(Algorithm.e * Algorithm.e_decay, Algorithm.e_min);
            end
        end
    end
end