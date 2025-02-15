function [idx, clusters] = ClusterPopulation(populationn, num_clusters)
% Creazione dei cluster data la popolazione e il numero di cluster
    Data = cat(1, populationn.dec);
    [idx, clusters] = kmeans(Data, num_clusters, 'MaxIter', 100);
end