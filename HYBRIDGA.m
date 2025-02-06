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
        gamma = 0.95; % ci concentriamo molto sul futuro
            
        states = [1 1; 1 2; 1 3; 2 2; 2 3; 3 3];
        % il crossover type lo definiamo nella funzione perchè cambiano a
        % seconda di permutazione o binario/intero
        crossover_rates = [0.3, 0.5, 0.7];   
        mutation_types = 1:2; % Random, Gaussiana 
        mutation_rates = [0.03, 0.05, 0.07];    
    end

    methods
        function main(Algorithm, Problem)
            % Inizializzazione
            % Variabili utili
            iteration = 0;

            % Inizializzazione della popolazione 
            population = Problem.Initialization(); 

            % Cluster iniziali
            [idx, clusters] = ClusterPopulation(population, 3); 

            % Inizializzazione Q
            [Algorithm.current_Qtable] = QTableInizialization(Problem.encoding, idx, population, Algorithm);

            % Ottimizzazione 
            while Algorithm.NotTerminated(population)
                 % Tournament selection
                 clusters_state = TournamentSelection(idx, population);
                 
                 % Selezione degli operatori basata su Q-Learning
                 [crossover_op, mutation_op, stato, azione] = SelectOperators(clusters_state, Algorithm);

                 % Applicazione degli operatori
                 offspring = GenerateOffspring(population, crossover_op, mutation_op, Problem, Algorithm.states(stato,:), idx);

                 % Aggiunta delle nuove soluzioni alla popolazione totale
                 population = [population, offspring];

                 % Aggiornamento di idx senza rifare il clustering
                 idx = [idx; AssignCluster(clusters, offspring)];
                
                 % Aggiornamento Q-Table e valutazione max dei prossimi stati per aggiornamento Q-Table
                 max_nest_state = CalculateMax(population, idx, Algorithm);
                 Algorithm.current_Qtable{stato, azione}.reward = UpdateQTableCell(stato, azione, max_nest_state, Algorithm.current_Qtable{stato, azione}.reward, Algorithm);
                    
                 % Valutazione per calcolo nuovo fronte e cluster
                 if mod(iteration, 5) == 0
                     % Aggiornamento della popolazione usando quello del NSGAII
                     % Nuovo fronte di pareto
                     population = EnvironmentalSelection(population, Problem.N);

                     % Salvataggio vecchi dati (devono diventare delle
                     % celle)
                     Algorithm.previous_cc{end+1} = clusters;
                     Algorithm.previous_Qtable{end+1} = Algorithm.current_Qtable;
                 
                     % Nuovi cluster
                     [idx, clusters] = ClusterPopulation(population, 3);

                     % Aggiornamento nuova matrice Q
                     population = Problem.Evaluation(cat(1, population.dec)); 
                     Algorithm.current_Qtable = UpdateQTable(Algorithm, clusters, idx, population);
                 end

                 % Politica e-decay
                 Algorithm.e = max(Algorithm.e * Algorithm.e_decay, Algorithm.e_min);

                 iteration = iteration + 1;
            end
            % capire se ha senso
            % population = EnvironmentalSelection(population, Problem.N);
        end
    end
end
