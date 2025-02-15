function mutated_child = ScrambleMutation(child)    
    % Numero di geni nel cromosoma
    n = length(child);

    % Seleziona casualmente due punti di taglio i e j
    i = randi([1, n]);
    j = randi([1, n]);

    % Assicuriamoci che i <= j, altrimenti si invertono
    if i > j
        temp = i;
        i = j;
        j = temp;
    end

    % Estrazione del segmento da i a j
    segment = child(i:j);

    % Scramble dei geni del segmento estratto
    scrambled_segment = segment(randperm(length(segment)));

    % Ricostruisci il cromosoma mutato
    mutated_child = child;
    mutated_child(i:j) = scrambled_segment;
end