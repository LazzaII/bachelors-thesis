function [idx, clusters] = ClusterPopulation(populationn, num_clusters)
% create clusters given the population and the number of clusters
    Data = cat(1, populationn.dec);
    [idx, clusters] = kmeans(Data, num_clusters, 'MaxIter', 100);
end