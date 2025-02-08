function mutated_child = SlightMutation(child)    
    n = length(child);
    mutated_child = child;
    
    % posizione casuale
    i = randi(n);
    
    % scelta se scambiare con il vicino a sinistra (-1) o a destra (+1)
    % direction sarà -1 o +1, ma dobbiamo evitare di uscire dai limiti
    if i == 1
        % Se i è il primo elemento, si può solo scambiare con il successivo
        direction = +1;
    elseif i == n
        % Se i è l'ultimo elemento, si può solo scambiare con il precedente
        direction = -1;
    else
        % Altrimenti scegli casualmente
        if rand < 0.5
            direction = -1;
        else
            direction = +1;
        end
    end
    
    % posizione j del vicino
    j = i + direction;
    
    % scambio dei due elementi
    temp = mutated_child(i);
    mutated_child(i) = mutated_child(j);
    mutated_child(j) = temp;
end